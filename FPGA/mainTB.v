
`timescale 1ps / 1ps
`include "params.vh"

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
    wire [31:0] ep24wireout;



	
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

// main
// `ifndef GATESIM
// #(    .mem_size(mem_size)
//       ) 
// `endif
    // dut (
      main design_1_i (

    // dataMem #(mem_size) dut (
    .clk(clk),
    // .reset(reset),
    // .MOSI_to_sensor(MOSI_to_sensor),
    // .MISO_from_sensor(MISO_from_sensor),
    // .SCLK_wire(SCLK_wire),
    // .CS_b_wire(CS_b_wire),
    // .sample_CLK_out(sample_CLK_out),

    .ep00wirein(ep00wirein),
    .ep01wirein(ep01wirein),
    .ep02wirein(ep02wirein),
    .ep03wirein(ep03wirein),
    .ep04wirein(ep04wirein),
    .ep05wirein(ep05wirein),
    .ep40trigin(ep40trigin),
    .ep41trigin(ep41trigin),
    .ep22wireout(ep22wireout),
    .ep24wireout(ep24wireout)
    );

  // design_1 design_1_i
  //      (
		
	// 	.CS_b_A(CS_b_A),
  //       .MISO1_A(MISO1_A),
  //       .MISO2_A(MISO2_A),
  //       .MOSI1_A(MOSI1_A),
  //       .MOSI2_A(MOSI2_A),
  //       .SCLK_A(SCLK_A),
  //       .clk(clk),
  //       .ep00wirein(ep00wirein),
  //       .ep01wirein(ep01wirein),
  //       .ep02wirein(ep02wirein),
  //       .ep03wirein(ep03wirein),
  //       .ep04wirein(ep04wirein),
  //       .ep05wirein(ep05wirein),
  //       .ep22wireout(ep22wireout),
  //       .ep24wireout(ep24wireout),
  //       .ep40trigin(ep40trigin),
  //       .ep41trigin(ep41trigin),
  //       .fpgaout_fifoin_din(fpgaout_fifoin_din),
  //       .fpgaout_fifoin_wr_en(fpgaout_fifoin_wr_en),
  //       .led(led),
  //       .okUH(okUH),
  //       .reset(reset),
  //       .sys_clk_n(sys_clk_n),
  //       .sys_clk_p(sys_clk_p)
  //       );








    always #50000 clk = ~clk; // 100 MHz clock

    initial begin : init
        //logic [32*8-1:0] vcdfile;
        string vcdfile;
        int vcdlevel;
        if ($value$plusargs("VCDFILE=%s",vcdfile))
            $dumpfile(vcdfile);
        if ($value$plusargs("VCDLEVEL=%d",vcdlevel))
            $dumpvars(vcdlevel);
            end

    parameter transmission_cycles = 150;

    initial begin
        clk = 0;         
        // reset = 1;
        repeat ( 50) @(posedge clk);
        modify_ep00wirein(32'h00000001);/// reset
        modify_ep00wirein(32'h00000000);/// reset
        modify_ep05wirein(32'd05);/// reset
        repeat ( 50) @(posedge clk);
        modify_ep00wirein(32'h00000000);
        modify_ep41trigin(32'h00000001);
        repeat (81*transmission_cycles*2) @(posedge clk);
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

  task modify_epPIPEtrigin(input [31:0] new_value);
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


