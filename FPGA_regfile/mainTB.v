
`timescale 1ns / 1ps
`include "params.vh"

module mainTB 
// #(    parameter   N_param = 32  )
();
//     glbl glbl ();
    parameter mem_size = 4096;

    reg clk;
    reg reset;
    reg write_enable;
    reg [6:0] data;
    reg [6:0] wr_addr;
    reg [6:0] in;
    wire [6:0] out;
    wire [6:0] out_debug;


    wire [31:0] ep41trigin; 
    wire [31:0] ep20wireout;

	assign out_debug    =   ep20wireout[6:0]  ;
	assign out          =   ep20wireout[14:8] ;

	assign ep41trigin[6:0]   =  data;	
	assign ep41trigin[7]     =  reset;	
	assign ep41trigin[14:8]  =  wr_addr[6:0];
	assign ep41trigin[15]    =  write_enable;	
	assign ep41trigin[22:16] =  in;
	assign ep41trigin[31:23] =  0;


main
`ifndef GATESIM
#(    .mem_size(mem_size)
      ) 
`endif
    dut (
        .clk(			clk),
        .ep20wireout(   ep20wireout),  
        .ep41trigin(    ep41trigin)
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

    initial begin
        clk             = 0;         
        reset           = 1;
        write_enable    = 0;
        data            = 0;
        wr_addr         = 0;
        in              = 0;
        repeat ( 8) @(posedge clk);
        reset = 0;

        repeat (2) @(posedge clk);

        @(posedge clk); write_enable = 1; wr_addr = 7'd1; data = 7'd1;  
        @(posedge clk); write_enable = 0; wr_addr = 7'd0; data = 7'd0;  

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        // @(posedge clk); write_enable = 1; wr_addr = 7'd5; data = 7'd42;  
        @(posedge clk); write_enable = 0; wr_addr = 7'd0; data = 7'd0;  
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); 

        write_enable = 0; wr_addr = 7'd1; data = 7'd0;
        @(posedge clk); 

        $display("Read @ wr_addr 5: Expected 42, Got %d", out_debug);
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 
        @(posedge clk); 

        // @(posedge clk);
        // wr_addr = 7'd10;
        // data = 7'd84;  
        // @(posedge clk);
        // wr_addr = 7'd20;
        // data = 7'd21;  

        // @(posedge clk);
        // write_enable = 0;

        // @(posedge clk);
        // in = 7'd5;
        // @(posedge clk);
        // $display("Read @ wr_addr 5: Expected 42, Got %d", out);

        // @(posedge clk);
        // in = 7'd10;
        // @(posedge clk);
        // $display("Read @ wr_addr 10: Expected 84, Got %d", out);

        // @(posedge clk);
        // in = 7'd20;
        // @(posedge clk);
        // $display("Read @ wr_addr 20: Expected 21, Got %d", out);

        // // End simulation
        // @(posedge clk);
        $finish;
    end
















    reg [31:0] Cycle_count;

always @(posedge clk) begin
//     $display("Time: %3d\thalt: %d\tisTakenBranch: %d\tnextPC: %d\tpc_po: %d",$time, halt_pi, isTakenBranch_pi, PC, pc_po);
  	 if (reset)
	    Cycle_count  <= 32'h0;
      //Starting memory wr_address, this logic must be changed later
	 else 
 	    // if (change_PC_condition | ~halt_i)  begin
            Cycle_count <= Cycle_count + 1;
	// end
  end




endmodule


