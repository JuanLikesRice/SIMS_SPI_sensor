`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 		 Intan Technologies, LLC
// 
// Design Name:    RHD2000 7310 Rhythm USB3 Interface
// Module Name:    SDRAM_FIFO 
// Project Name:   RHDInterfaceXEM7310
// Target Devices: 
// Tool versions: 
// Description:    SDRAM FIFO module
//						 This module uses the 128 MiByte SDRAM along with two small
//                 on-FPGA FIFOs to construct a large FIFO to buffer data collected
//                 from RHD2000 chips and sent over the USB interface to a computer.
//                 Adapted from Opal Kelly's RAMTester example
//
// Dependencies: 
//
// Revision:        3.0 (10 January 2023)
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// This FIFO module allows continuously-streaming data (e.g., from multiple RHD2000
// chips to be transferred smoothly over a USB interface to a computer that will grab
// the data in bursts, and may be unresponsive for a brief time due to multitasking or
// other OS overhead.
//
// The FIFO is constructed from an off-FPGA 128-MiByte SDRAM with circular read/write
// operations.  This is sandwiched between two on-FPGA 4-kiByte "mini-FIFOs" that regulate
// the flow of data into and out of the SDRAM.  The output of the FIFO should be connected
// to an okPipeOut module for transfer across the USB port to a computer host.
//
// There is no mechanism in this FIFO to protect against underflow.  That is, if the
// computer tries to read more data than the FIFO is currently holding, the FIFO will
// just repeat the last word after it runs out of data.  To prevent underflow, it is
// essential for the host to monitor the value of num_words_in_FIFO (which should be
// attached to two okWireOut modules) and never attempt to read more words than the
// FIFO contains.
//
// Neither is there a mechanism in this FIFO to protect against overflow.  If the FIFO
// fills up, it will "lap" the unread data and begin writing over old data in the SDRAM.
// So the host must monitor num_words_in_FIFO and make sure it doesn't get too full.
// The capacity of the FIFO is dominated by the 128-MiByte SDRAM.  This can hold 2^27 =
// 134,217,728 bytes, or 67,108,864 16-bit words.  The on-FPGA "mini-FIFOs" add a couple
// of thousand more words to this total, but it is good practice never to allow the FIFO
// to get more than 75% full in case the computer OS hangs for a moment.
//
// In order to completely "clean out" the FIFO after pausing or stopping the flow of data
// into it, it is necessary to write an integer multiple of 4 16-bit words to the FIFO.
// The SDRAM reads data only in 64-bit chunks, so if there is a remaining 1, 2, or 3 words
// of data in the input mini-FIFO, this will not be read into the SDRAM (and passed to the
// output mini-FIFO) after the flow of data from the source has stopped.  See
// ddr_state_machine.v for details on this.


// Note: Adapted from the Spartan-6 series to the Artix-7 series, resulting in some
// changes. These include:

// The SDRAM accepts data in 256-bit words, not 32-bit words. The PipeIn FIFO must translate
// data from 16-bit words to 256-bit words, but the maximum ratio is 1:8, not 1:16.
// This means there must be two PipeIn FIFOs (Stage 1 and Stage 2), translating data from
// 16-bit words to 32-bit words, and then from 32-bit words to 256-bit words. PipeOuts need
// to be 32-bit words, so a single stage is fine to go from 256-bit words to 32-bit words.

// The SDRAM is no longer truly 128-MiBytes, but 1 GiByte. However, the software intentionally
// still considers 128-MiBytes to be 100% of the SDRAM capacity, so that the behavior from
// the 6-series to the 7-series is minimally different.

module SDRAM_FIFO
	(
	
	// Clocks
	input wire         okClk,			// 100.8 MHz clock from Opal Kelly Host
	input wire         data_in_clk, 	    // clock domain for FIFO input; variable
	input wire         sys_clk,          // buffered 200 MHz clock
	
	// FIFO interface
	input wire         reset,
	input wire         FIFO_write_to,
	input wire  [15:0] FIFO_data_in,
	input wire         FIFO_read_from,
	output wire [31:0] FIFO_data_out,
	
	output reg         FIFO_out_rdy,
	input wire  [31:0] usb3_blocksize,
	input wire  [31:0] ddr_blocksize,

	// FIFO capacity monitor
	output wire [31:0] num_words_in_FIFO,

	// I/O connections from Xilinx FPGA to 128-MiByte SDRAM
    inout  wire [31:0] ddr3_dq,
	output wire [14:0] ddr3_addr,
	output wire [2 :0] ddr3_ba,
	output wire [0 :0] ddr3_ck_p,
	output wire [0 :0] ddr3_ck_n,
	output wire [0 :0] ddr3_cke,
	output wire        ddr3_cas_n,
	output wire        ddr3_ras_n,
	output wire        ddr3_we_n,
	output wire [0 :0] ddr3_odt,
	output wire [3 :0] ddr3_dm,
	inout  wire [3 :0] ddr3_dqs_p,
	inout  wire [3 :0] ddr3_dqs_n,
	output wire        ddr3_reset_n
   );
   
   // Capability bitfield, used to indicate features supported by this bitfile:
    // [0] - Supports passing calibration status through FrontPanel
    localparam CAPABILITY = 16'h0001;
    
    // State machine / ddr3 communication signals
    wire                init_calib_complete;
    reg                 sys_rst;
    
    wire [29 :0]        app_addr;
    wire [2  :0]        app_cmd;
    wire                app_en;
    wire                app_rdy;
    wire [255:0]        app_rd_data;
    wire                app_rd_data_end;
    wire                app_rd_data_valid;
    wire [255:0]        app_wdf_data;
    wire                app_wdf_end;
    wire [31 :0]        app_wdf_mask;
    wire                app_wdf_rdy;
    wire                app_wdf_wren;
    
    wire                clk;
    wire                rst;
	
	// Stage 1 Input FIFO signals
    wire               in_stage_1_empty, in_stage_1_valid;
	wire [7  :0]       in_wr_count_stage1;
	wire [31 :0]       in_stage_1_dout;
	reg                in_stage_1_rd_en = 0;
	reg  [7  :0]       in_wr_count_stage1_ti = 0;
	
	// Stage 2 Input FIFO signals
	wire               in_stage_2_full, in_stage_2_wr_ack, in_read, in_valid, in_empty;
	wire [11 :0]       in_wr_count_stage2;
	wire [255:0]       in_data;
	wire [8  :0]       in_rd_count_stage2;
	reg                in_stage_2_wr_en = 0;
	reg  [31 :0]       in_stage_2_din = 0;
	reg  [11 :0]       in_wr_count_stage2_ti = 0;
	
	// SDRAM capacity monitor signals
	wire [29 :0]       buffer_byte_addr_wr, buffer_byte_addr_rd;
	wire [31 :0]       buffer_word_addr_rd_ti, buffer_word_addr_wr_ti, buffer_word_addr_diff_ti;
	reg  [29 :0]       buffer_byte_addr_wr_ti = 0, buffer_byte_addr_rd_ti = 0;
	
	// Output FIFO signals
	wire               out_write, out_full;
	wire [12 :0]       out_wr_count;
	wire [255:0]       out_data;
	wire [15 :0]       out_rd_count;
	reg  [15 :0]       out_rd_count_ti = 0;
	
   
    ddr3_state_machine ddr3_state_machine_inst
    (
    .clk        (clk),
    .reset      (reset | rst),
    .reads_en   (~reset),
    .writes_en  (~reset),
    .calib_done (init_calib_complete),
    
    .ib_re      (in_read),
    .ib_data    (in_data),
    .ib_count   (in_rd_count_stage2),
    .ib_valid   (in_valid),
    .ib_empty   (in_empty),
    
    .ob_we      (out_write),
    .ob_data    (out_data),
    .ob_count   (out_wr_count),
    .ob_full    (out_full),
    
    .app_rdy    (app_rdy),
    .app_en     (app_en),
    .app_cmd    (app_cmd),
    .app_addr   (app_addr),
    
    .app_rd_data(app_rd_data),
    .app_rd_data_end(app_rd_data_end),
    .app_rd_data_valid(app_rd_data_valid),
    
    .app_wdf_rdy(app_wdf_rdy),
    .app_wdf_wren(app_wdf_wren),
    .app_wdf_data(app_wdf_data),
    .app_wdf_end(app_wdf_end),
    .app_wdf_mask(app_wdf_mask),
    
    .cmd_byte_addr_wr(buffer_byte_addr_wr),
    .cmd_byte_addr_rd(buffer_byte_addr_rd)
    );
   
   
	//MIG Infrastructure Reset
    reg [31:0] rst_cnt;
    initial rst_cnt = 32'b0;
    always @(posedge okClk) begin
        if (rst_cnt < 32'h0000_0010) begin
            rst_cnt <= rst_cnt + 1;
            sys_rst <= 1'b1;
        end
        else begin
            sys_rst <= 1'b0;
        end
    end
   
   // MIG User Interface instantiation
ddr3_256_32 u_ddr3_256_32 (
	// Memory interface ports
	.ddr3_addr                      (ddr3_addr),
	.ddr3_ba                        (ddr3_ba),
	.ddr3_cas_n                     (ddr3_cas_n),
	.ddr3_ck_n                      (ddr3_ck_n),
	.ddr3_ck_p                      (ddr3_ck_p),
	.ddr3_cke                       (ddr3_cke),
	.ddr3_ras_n                     (ddr3_ras_n),
	.ddr3_reset_n                   (ddr3_reset_n),
	.ddr3_we_n                      (ddr3_we_n),
	.ddr3_dq                        (ddr3_dq),
	.ddr3_dqs_n                     (ddr3_dqs_n),
	.ddr3_dqs_p                     (ddr3_dqs_p),
	.init_calib_complete            (init_calib_complete),
	
	.ddr3_dm                        (ddr3_dm),
	.ddr3_odt                       (ddr3_odt),
	// Application interface ports
	.app_addr                       (app_addr),
	.app_cmd                        (app_cmd),
	.app_en                         (app_en),
	.app_wdf_data                   (app_wdf_data),
	.app_wdf_end                    (app_wdf_end),
	.app_wdf_wren                   (app_wdf_wren),
	.app_rd_data                    (app_rd_data),
	.app_rd_data_end                (app_rd_data_end),
	.app_rd_data_valid              (app_rd_data_valid),
	.app_rdy                        (app_rdy),
	.app_wdf_rdy                    (app_wdf_rdy),
	.app_sr_req                     (1'b0),
	.app_sr_active                  (),
	.app_ref_req                    (1'b0),
	.app_ref_ack                    (),
	.app_zq_req                     (1'b0),
	.app_zq_ack                     (),
	.ui_clk                         (clk),
	.ui_clk_sync_rst                (rst),
	
	.app_wdf_mask                   (app_wdf_mask),
	
	// System Clock Ports
	.sys_clk_i                     (sys_clk),
	
	.sys_rst                        (sys_rst)
	);
		
		
	// General flow: 16-bit data from Intan chips ---Stage 1 FIFO (16 to 32)--->
	//               32-bit data                  ---Stage 2 FIFO (32 to 256)--->
	//               256-bit data out to SDRAM    ---  ddr3  --->
	//               256-bit data in from SDRAM   ---PipeOut FIFO (256 to 32)---> PipeOut endpoint
	
	// According to pg. 114 of pg057-fifo-generator.pdf:
	// "For example, assuming a full FIFO, if the write width is 8 bits and read width is 2 bits,
	// you would have to complete four valid read operations before full deasserts and a write
	// operation accepted."
	// This implies, assuming an empty FIFO, if the write width is 16 bits and read width is 32 bits,
	// you would have to complete 2 valid write operations before empty deasserts and a read
	// operation accepted.
	
	// State machine governing transfer of data from Stage 1 FIFO to Stage 2 FIFO
    integer transfer_state = 0;
    localparam s_wait = 0,
                s_idle = 1,
                s_write = 2,
                s_confirm = 3;       
                 
    always @(posedge clk) begin
        if (reset) begin
            transfer_state <= s_wait;
        end else begin
            in_stage_1_rd_en <= 1'b0;
            in_stage_2_wr_en <= 1'b0;
            case (transfer_state)
            
                // Wait 1 cycle after reset to make sure FIFOs are ready
                s_wait: begin
                    transfer_state <= s_idle;
                end
                
                // Wait until stage 1 has data and stage 2 has room before reading from stage 1
                s_idle: begin    
                    if (~in_stage_1_empty && ~in_stage_2_full) begin
                        in_stage_1_rd_en <= 1'b1;
                        transfer_state <= s_write;
                    end
                end
                
                // Write data into stage 2
                s_write: begin
                    if (in_stage_1_valid==1) begin
                        in_stage_2_din <= in_stage_1_dout;
                        in_stage_2_wr_en <= 1'b1;
                        transfer_state <= s_confirm;
                    end
                end
                
                // Sometimes-skippable cycle to wait for wr_ack
                s_confirm: begin
                    if (in_stage_2_wr_ack==1) begin
                        transfer_state <= s_idle;
                    end
                end
            
            endcase
        end
    end
    
    
//     ALTERNATIVE - State machine governing transfer of data from Stage 1 FIFO to Stage 2 FIFO
//     This approach runs the transfer off data_in_clk (max of 84 MHz) instead of clk (200 MHz).
    
//     When running at the same clock as FIFO_write_to, with all 32 data streams enabled,
//     data can be added to FIFO pipeline faster than this Stage 1 to Stage 2 transfer occurs.
//     This leads to data back-up and Stage 1 filling up, eventually overflowing.
    
//     This seems to be avoidable by using this modified state machine, which is more efficient by minimizing unnecessary
//     down-time by eliminating mandatory wait states. Probably less reliable than the above state-machine,
//     which just runs at a faster clock speed and doesn't need to be as efficient as possible.
    
//    reg expect_ack = 0;
	
//    integer transfer_state = 0;
//    localparam s_wait = 0,
//                s_idle = 1,
//                s_write = 2;
    
//    always @(posedge data_in_clk) begin
//        if (reset) begin
//            transfer_state <= s_wait;
//        end else begin
//            in_stage_1_rd_en <= 1'b0;
//            in_stage_2_wr_en <= 1'b0;
//            case (transfer_state)
            
//                // Wait 1 cycle after reset to make sure FIFOs are ready
//                s_wait: begin
//                    transfer_state <= s_idle;
//                end
                
//                // Wait until stage 1 has data and stage 2 has room before reading from stage 1
//                s_idle: begin
                
                    // If wr_ack is expected but hasn't occurred, wait
//                    if (expect_ack && ~in_stage_2_wr_ack) begin
//                        transfer_state <= s_idle;
//                  // Otherwise, read from stage 1
//                    end else begin
//                        if (~in_stage_1_empty && ~in_stage_2_full) begin
//                            in_stage_1_rd_en <= 1'b1;
//                            transfer_state <= s_write;
//                        end
//                        expect_ack <= 1'b0;
//                    end
                    
//                end
                
//                // Write data into stage 2, and return to idle (expecting wr_ack)
//                s_write: begin
//                    if (in_stage_1_valid==1) begin
//                        in_stage_2_din <= in_stage_1_dout;
//                        in_stage_2_wr_en <= 1'b1;
//                        transfer_state <= s_idle;
//                        expect_ack <= 1'b1;
//                    end
//                end
//            endcase
//        end
//    end
	
	// Input mini-Fifo Stage 1 (256 x 16 bits in from Intan chips; 128 x 32 bits out to Stage 2)
	fifo_w16_256_r32_128 in_fifo_stage1 (
      .rst(reset),
      .wr_clk(data_in_clk),
      .rd_clk(clk),
      .din(FIFO_data_in),                   // Bus [15:0]
      .wr_en(FIFO_write_to),
      .rd_en(in_stage_1_rd_en),
      .dout(in_stage_1_dout),               // Bus [31:0]
      .empty(in_stage_1_empty),
      .valid(in_stage_1_valid),
      .wr_data_count(in_wr_count_stage1),   // Bus [8 : 0]
      .wr_rst_busy(),
      .rd_rst_busy()
    );
	
	// Input mini-Fifo Stage 2 (2048 x 32 bits in from Stage 1; 256 x 256 bits out to SDRAM)
    fifo_w32_2048_r256_256 in_fifo_stage2 (    
      .clk(clk),
      .srst(reset),          
      .din(in_stage_2_din),                 // Bus [31 : 0]
      .wr_en(in_stage_2_wr_en),
      .rd_en(in_read),                  
      .dout(in_data),                       // Bus [255 : 0]
      .full(in_stage_2_full),    
      .empty(in_empty),                  
      .valid(in_valid),     
      .wr_data_count(in_wr_count_stage2),   // Bus [10 : 0]
      .rd_data_count(in_rd_count_stage2),   // Bus [7 : 0]
      .wr_ack(in_stage_2_wr_ack)
    );
	
	// Output mini-Fifo (8192 x 256 bits in from SDRAM; 65536 x 32 bits out to Opal Kelly interface)
	// Note - increased capacity from original 256x256 bit size for improved USB transfer speed
	fifo_w256_8192_r32_65536 okPipeOut_fifo (
	   .rst(reset),
	   .wr_clk(clk),
	   .rd_clk(okClk),
	   .din(out_data),                      // Bus [255 : 0]
	   .wr_en(out_write),
	   .rd_en(FIFO_read_from),
	   .dout(FIFO_data_out),                // Bus [31 : 0]
	   .full(out_full),
	   .empty(),
	   .wr_data_count(out_wr_count),        // Bus [12 : 0]
	   .rd_data_count(out_rd_count),        // Bus [15 : 0]
	   .wr_rst_busy(),
	   .rd_rst_busy()
	);
		
	// FIFO capacity calculation: how many 32-bit words are in the entire FIFO?
	// (Including the contents of the SDRAM and the two mini-FIFOs.)
	
	always @(posedge okClk) begin
	   
	   buffer_byte_addr_rd_ti <= buffer_byte_addr_rd;
	   buffer_byte_addr_wr_ti <= buffer_byte_addr_wr;
	   in_wr_count_stage1_ti <= in_wr_count_stage1; // number of 16-bit words currently in Stage1 input FIFO
	   in_wr_count_stage2_ti <= in_wr_count_stage2; // number of 32-bit words currently in Stage2 input FIFO
	   out_rd_count_ti <= out_rd_count;             // number of 32-bit words currently in output FIFO
	   
	   if ({21'b0, out_rd_count} >= usb3_blocksize ) begin
	       FIFO_out_rdy <= 1'b1;
	   end else begin
	       FIFO_out_rdy <= 1'b0;
	   end
	end
	
	assign buffer_word_addr_rd_ti = { 1'b0, buffer_byte_addr_rd_ti, 1'b0 }; // multiply by two to convert 32-bit word address to 16-bit word address
	assign buffer_word_addr_wr_ti = { 1'b0, buffer_byte_addr_wr_ti, 1'b0 }; // multiply by two to convert 32-bit word address to 16-bit word address
	
	assign buffer_word_addr_diff_ti = buffer_word_addr_wr_ti - buffer_word_addr_rd_ti;
	assign num_words_in_FIFO = { buffer_word_addr_diff_ti + // data currently in RAM chip
	   { 23'b0, in_wr_count_stage1_ti } +          // data currently in Stage1 input FIFO
	   { 20'b0, in_wr_count_stage2_ti, 1'b0 } +    // data currently in Stage2 input FIFO (multiplied by 2, because the word count refers to 32-bit words, not 16-bit words)
       { 23'b0, out_rd_count_ti, 1'b0 }};          // data currently in output FIFO (multiplied by 2, because the word count refers to 32-bit words, not 16-bit words)
 endmodule
   
