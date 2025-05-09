
`timescale 1ns / 1ps
//`include "params.vh"

module mainTB//;
#(
    parameter   N_param = 32 
)
();
//     glbl glbl ();
    parameter mem_size = 4096;

    reg clk;
    reg reset;
    wire MOSI_to_sensor, MISO_from_sensor, SCLK_wire, CS_b_wire, sample_CLK_out;
    reg [63:0] Single_Instruction;
    reg [31:0] address;
    reg [31:0] storeData;
    wire [31:0] loadData_w;
    reg [15:0] data_to_send;
    reg CS, MOSI;
    //wire CS, MOSI;

    reg [31:0] ep00wirein;
    reg [31:0] ep01wirein;
    reg [31:0] ep02wirein;
    reg [31:0] ep03wirein;
    reg [31:0] ep04wirein;
    reg [31:0] ep05wirein;
    reg [31:0] ep40trigin;
    reg [31:0] ep41trigin;
    wire  [31:0] ep22wireout;
    wire  [31:0] ep24wireout,ep24wireout_readout;



	
	// wire pipeout_rdy;
	// assign pipeout_rdy = ( FIFO_out_rdy | pipeout_override_en);
	
	// // Flip the 16-bit words in the fifo for compatibility with the USB2 read methods
	// okBTPipeOut    poa0 (.okHE(okHE), .okEH(okEHx[ 32*65 +: 65 ]), .ep_addr(8'ha0), .ep_read(FIFO_read_from), 
	// 	.ep_blockstrobe(), .ep_datain({FIFO_data_out[15:0], FIFO_data_out[31:16]}), .ep_ready(pipeout_rdy));

initial begin 
 ep00wirein <= 0;
 ep01wirein <= 0;
 ep02wirein <= 0;
 ep03wirein <= 0;
 ep04wirein <= 0;
 ep05wirein <= 0;
 ep40trigin <= 0;
 ep41trigin <= 0;

end 

wire [31:0] FIFO_data_out;
wire pipeout_rdy;
wire FIFO_read_from;
assign FIFO_read_from = 0;

  wire [7:0]led;
  wire okAA;
  wire [2:0]okHU;
  wire [4:0]okUH;
  wire [31:0]okUHU;
  wire sys_clk_n;
  wire sys_clk_p;

  design_1 design_1_i
       (.FIFO_data_out(FIFO_data_out),
        .FIFO_read_from(FIFO_read_from),
        .clk(clk),
        .ep00wirein(ep00wirein),
        .ep01wirein(ep01wirein),
        .ep02wirein(ep02wirein),
        .ep03wirein(ep03wirein),
        .ep04wirein(ep04wirein),
        .ep05wirein(ep05wirein),
        .ep22wireout(ep22wireout),
        .ep24wireout(ep24wireout),
        .ep24wireout_readout(ep24wireout_readout),
        .ep40trigin(ep40trigin),
        .ep41trigin(ep41trigin),
        .led(led),
        .okAA(okAA),
        .okHU(okHU),
        .okUH(okUH),
        .okUHU(okUHU),
        .pipeout_rdy(pipeout_rdy)
        .sys_clk_n(sys_clk_n),
        .sys_clk_p(sys_clk_p)
        );

//   main_wrapper_EP #(.mem_size(4096)) u_main_wrapper_EP (
//     .clk                           (okClk),
//     .ep00wirein                    (ep00wirein),
//     .ep01wirein                    (ep01wirein),
//     .ep02wirein                    (ep02wirein),
//     .ep03wirein                    (ep03wirein),
//     .ep04wirein                    (ep04wirein),
//     .ep05wirein                    (ep05wirein),
//     .ep40trigin                    (ep40trigin),
//     .ep41trigin                    (ep41trigin),
//     .ep22wireout                   (ep22wireout),
//     .ep24wireout                   (ep24wireout),

//     .ep24wireout_readout           (ep24wireout_readout),
//     .pipeout_rdy                   (pipeout_rdy),
//     .FIFO_data_out                 (FIFO_data_out),
//     .FIFO_read_from                (FIFO_read_from)
//     // .fpgain_fifoout_ready_refile   (fpgain_fifoout_ready_refile),
//     // .fpgaout_fifoin_din            (fpgaout_fifoin_din),
//     // .fpgaout_fifoin_wr_en          (fpgaout_fifoin_wr_en)

//   );





    always #5 clk = ~clk; // 100 MHz clock

//    initial begin : init
//        //logic [32*8-1:0] vcdfile;
//        if ($value$plusargs("VCDFILE=%s",vcdfile))
//            $dumpfile(vcdfile);
//        if ($value$plusargs("VCDLEVEL=%d",vcdlevel))
//            $dumpvars(vcdlevel);
//            end

    parameter transmission_cycles = 150;

    initial begin
        clk = 0;         
        // reset = 1;
        repeat ( 50) @(posedge clk);
        modify_ep00wirein(32'h00000001);/// reset
        modify_ep00wirein(32'h00000000);/// reset
        modify_ep05wirein(32'd31);/// reset
        repeat ( 50) @(posedge clk);
        modify_ep00wirein(32'h00000000);
        modify_ep41trigin(32'h00000001);
        repeat (81*transmission_cycles) @(posedge clk);
        modify_ep41trigin(32'h00000004);
        repeat (2*transmission_cycles) @(posedge clk);

        modify_ep05wirein(32'd5);/// reset
        modify_ep41trigin(32'h00000001);
        repeat (81*transmission_cycles) @(posedge clk);

        $finish;
    end

    reg [31:0] Cycle_count;

always @(posedge clk) begin
//     $display("Time: %3d\thalt: %d\tisTakenBranch: %d\tnextPC: %d\tpc_po: %d",$time, halt_pi, isTakenBranch_pi, PC, pc_po);
  	 if (reset)
	    Cycle_count  <= 32'h0;
      //Starting memory address, this logic must be changed later
	 else 
 	    // if (change_PC_condition | ~halt_i)  begin
            Cycle_count <= Cycle_count + 1;
	// end
  end


  task modify_ep00wirein(input [31:0] new_value);
    begin
        @(posedge clk); 
        @(posedge clk); 
        ep00wirein <= new_value;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
    end
  endtask



  task modify_ep01wirein(input [31:0] new_value);
    begin
        @(posedge clk); 
        @(posedge clk); 
        ep01wirein <= new_value;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
    end
  endtask


  task modify_ep02wirein(input [31:0] new_value);
    begin
        @(posedge clk); 
        @(posedge clk); 
        ep02wirein <= new_value;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk);
    end
  endtask


  
  task modify_ep03wirein(input [31:0] new_value);
    begin
        @(posedge clk); 
        @(posedge clk); 
        ep03wirein <= new_value;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
    end
  endtask



  task modify_ep04wirein(input [31:0] new_value);
    begin
        @(posedge clk); 
        @(posedge clk); 
        ep04wirein <= new_value;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk);
    end
  endtask


    task modify_ep05wirein(input [31:0] new_value);
    begin
        @(posedge clk); 
        @(posedge clk); 
        ep05wirein <= new_value;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk);
    end
  endtask

  task modify_ep40trigin(input [31:0] new_value);
    begin
        ep40trigin <= 0;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        ep40trigin <= 0;
        @(posedge clk); 
        ep40trigin <= new_value;
        @(posedge clk); 
        ep40trigin <= 0;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        ep40trigin <= 0;
    end
  endtask

  task modify_ep41trigin(input [31:0] new_value);
    begin
        ep41trigin <= 0;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        ep41trigin <= 0;
        @(posedge clk); 
        ep41trigin <= new_value;
        @(posedge clk); 
        ep41trigin <= 0;
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        ep41trigin <= 0;
    end
  endtask




endmodule


