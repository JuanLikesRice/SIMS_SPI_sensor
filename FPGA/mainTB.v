
`timescale 1ns / 1ps
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


main
`ifndef GATESIM
#(    .mem_size(mem_size)
      ) 
`endif
    dut (
    // dataMem #(mem_size) dut (
    .clk(clk),
    .reset(reset),
    .MOSI_to_sensor(MOSI_to_sensor),
    .MISO_from_sensor(MISO_from_sensor),
    .SCLK_wire(SCLK_wire),
    .CS_b_wire(CS_b_wire),
    .sample_CLK_out(sample_CLK_out)
    );

    always #5 clk = ~clk; // 100 MHz clock

    initial begin : init
        //logic [32*8-1:0] vcdfile;
        string vcdfile;
        int vcdlevel;
        if ($value$plusargs("VCDFILE=%s",vcdfile))
            $dumpfile(vcdfile);
        if ($value$plusargs("VCDLEVEL=%d",vcdlevel))
            $dumpvars(vcdlevel);
            end

    parameter transmission_cycles = 5;

    initial begin
        clk = 0;         
        reset = 1;
        repeat ( 8) @(posedge clk);
        reset = 0;
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




endmodule


