`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Intan Technologies, LLC
// 
// Design Name:    RHD2000 7310 Rhythm USB3 Interface
// Module Name:    ddr3_state_machine
// Project Name:   RHDInterfaceXEM7310
// Target Devices: 
// Tool versions: 
// Description: 	 SDRAM memory controller read/write state machine
//                 Adapted from ddr3_test.v from Opal Kelly's XEM7310 RAMTester example
//
// Dependencies: 
//
// Revision:       3.0 (10 January 2023)
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module ddr3_state_machine
	(
	input  wire          clk,
	(* KEEP = "TRUE" *)input  wire          reset,
	(* KEEP = "TRUE" *)input  wire          writes_en,
	(* KEEP = "TRUE" *)input  wire          reads_en,
	(* KEEP = "TRUE" *)input  wire          calib_done, 
	//DDR Input Buffer (ib_)
	(* KEEP = "TRUE" *)output reg           ib_re,
	(* KEEP = "TRUE" *)input  wire [255:0]   ib_data,
	(* KEEP = "TRUE" *)input  wire [8:0]    ib_count,
	(* KEEP = "TRUE" *)input  wire          ib_valid,
	(* KEEP = "TRUE" *)input  wire          ib_empty,
	//DDR Output Buffer (ob_)
	(* KEEP = "TRUE" *)output reg           ob_we,
	(* KEEP = "TRUE" *)output reg  [255:0]   ob_data,
	(* KEEP = "TRUE" *)input wire [12:0]    ob_count,
	(* KEEP = "TRUE" *)input  wire          ob_full,
	
	(* KEEP = "TRUE" *)input wire             app_rdy,
	(* KEEP = "TRUE" *)output reg             app_en,
	(* KEEP = "TRUE" *)output reg [2:0]       app_cmd,
	(* KEEP = "TRUE" *)output reg [29:0]      app_addr,
	
	(* KEEP = "TRUE" *)input wire [255:0]     app_rd_data,
	(* KEEP = "TRUE" *)input wire             app_rd_data_end,
	(* KEEP = "TRUE" *)input wire             app_rd_data_valid,
	
	(* KEEP = "TRUE" *)input wire             app_wdf_rdy,
	(* KEEP = "TRUE" *)output reg             app_wdf_wren,
	(* KEEP = "TRUE" *)output reg [255:0]     app_wdf_data,
	(* KEEP = "TRUE" *)output reg             app_wdf_end,
	(* KEEP = "TRUE" *)output wire [31:0]     app_wdf_mask,
	
	(* KEEP = "TRUE" *)output reg [29:0]      cmd_byte_addr_wr,
	(* KEEP = "TRUE" *)output reg [29:0]      cmd_byte_addr_rd
	);
	
localparam FIFO_SIZE = 8192;
localparam BURST_UI_WORD_COUNT = 2'd1; // (WORD_SIZE * BURST_MODE/UI_SIZE) = BURST_UI_WORD_COUNT : 32*8/256 = 1
localparam ADDRESS_INCREMENT = 5'd8; // UI Address is a word address. BL8 Burst Mode = 8.

(* KEEP = "TRUE" *)reg [1:0] burst_count;

(* KEEP = "TRUE" *)reg write_mode;
(* KEEP = "TRUE" *)reg read_mode;
(* KEEP = "TRUE" *)reg reset_d;

assign app_wdf_mask = 16'h0000;

always @(posedge clk) write_mode <= writes_en;
always @(posedge clk) read_mode <= reads_en;
always @(posedge clk) reset_d <= reset;

(* KEEP = "TRUE" *)integer state;

localparam s_idle_0 = 0,
    s_idle_1 = 1,
    s_write_0 = 10,
    s_write_1 = 11,
    s_write_2 = 12,
    s_write_3 = 13,
    s_write_4 = 14,
    s_read_0 = 20,
    s_read_1 = 21,
    s_read_2 = 22,
    s_read_3 = 23,
    s_read_4 = 24;
always @(posedge clk) begin
    if (reset_d) begin
        state               <= s_idle_0;
        burst_count         <= 2'b00;
        cmd_byte_addr_wr    <= 0;
        cmd_byte_addr_rd    <= 0;
        app_en              <= 1'b0;
        app_cmd             <= 3'b0;
        app_addr            <= 28'b0;
        app_wdf_wren        <= 1'b0;
        app_wdf_end         <= 1'b0;
    end else begin
        app_en              <= 1'b0;
        app_wdf_wren        <= 1'b0;
        app_wdf_end         <= 1'b0;
        ib_re               <= 1'b0;
        ob_we               <= 1'b0;
        
        case (state)
            s_idle_0: begin
                burst_count <= BURST_UI_WORD_COUNT-1;
                
                // Only start writing when initialization done
                // Check to ensure that the input buffer has enough data for a burst
                // Input mini-FIFO should never contain more than a single 256-bit word if RAM is fast
                if (calib_done==1 && write_mode==1 && (ib_count >= BURST_UI_WORD_COUNT)) begin
                    app_addr <= cmd_byte_addr_wr;
                    state <= s_write_0;
                end else begin
                    state <= s_idle_1;
                end
            end
            
            s_write_0: begin
                state <= s_write_1;
                ib_re <= 1'b1;
            end
            
            s_write_1: begin
                if (ib_valid==1) begin
                    app_wdf_data <= ib_data;
                    state <= s_write_2;
                end
            end
            
            s_write_2: begin
                if (app_wdf_rdy == 1'b1) begin
                    state <= s_write_3;
                end
            end
            
            s_write_3: begin
                app_wdf_wren <= 1'b1;
                if (burst_count == 2'd0) begin
                    app_wdf_end <= 1'b1;
                end
                if ( (app_wdf_rdy == 1'b1) && (burst_count == 2'd0) ) begin
                    app_en <= 1'b1;
                    app_cmd <= 3'b000;
                    state <= s_write_4;
                end else if (app_wdf_rdy == 1'b1) begin
                    burst_count <= burst_count - 1'b1;
                    state <= s_write_0;
                end
            end
            
            s_write_4: begin
                if (app_rdy == 1'b1) begin
                    cmd_byte_addr_wr <= cmd_byte_addr_wr + ADDRESS_INCREMENT;
                    state <= s_idle_1;
                end else begin
                    app_en <= 1'b1;
                    app_cmd <= 3'b000;
                end
            end
            
            s_idle_1: begin
                burst_count <= BURST_UI_WORD_COUNT-1;
                
                // Only start reading when initialization done, there is room in the output FIFO buffer,
                // and (IMPORTANT, added this to ramtest code!) we are not reading past the point where data has been written!
                if (calib_done==1 && read_mode==1 && (ob_count<(FIFO_SIZE-2-BURST_UI_WORD_COUNT)) && (cmd_byte_addr_wr != cmd_byte_addr_rd)) begin
                    app_addr <= cmd_byte_addr_rd;
                    state <= s_read_0;
                end else begin
                    state <= s_idle_0;
                end 
            end
            
            s_read_0: begin
                app_en <= 1'b1;
                app_cmd <= 3'b001;
                state <= s_read_1;
            end
            
            s_read_1: begin
                if (app_rdy == 1'b1) begin
                    cmd_byte_addr_rd <= cmd_byte_addr_rd + ADDRESS_INCREMENT;
                    state <= s_read_2;
                end else begin
                    app_en <= 1'b1;
                    app_cmd <= 3'b001;
                end
            end
            
            s_read_2: begin
                if (app_rd_data_valid == 1'b1) begin
                    ob_data <= app_rd_data;
                    ob_we <= 1'b1;
                    if (burst_count == 2'd0) begin
                        state <= s_idle_0;
                    end else begin
                        burst_count <= burst_count - 1'b1;
                    end
                end
            end
        endcase
    end
end

endmodule
