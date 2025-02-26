`timescale 1ns/1ps
`default_nettype none

module main (
	input  wire [4:0]   okUH,
	output wire [2:0]   okHU,
	inout  wire [31:0]  okUHU,
	inout  wire         okAA,

	input  wire         sys_clk_p,
	input  wire         sys_clk_n,
	
	output wire [7:0]   led
	
	);

// OK RAMTest Parameters
localparam BLOCK_SIZE = 128; // 512 bytes / 4 bytes per word, 
localparam FIFO_SIZE = 1023; // note that Xilinx does not allow use of the full 1024 words
localparam BUFFER_HEADROOM = 20; // headroom for the FIFO count to account for latency

// Capability bitfield, used to indicate features supported by this bitfile:
// [0] - Supports passing calibration status through FrontPanel
localparam CAPABILITY = 16'h0001;



wire          clk;
wire          rst;




// Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

wire [31:0]  ep00wire;

wire [31:0] ep41trigin, ep20wireout,ep21wireout,ep00wirein;
wire  write_enable;
wire  reset;
wire  [6:0] data;
wire  [6:0] wr_addr;
wire  [6:0] in;
wire  [6:0] out;
wire  [6:0] out_debug;
reg spite;


function [7:0] xem7310_led;
input [7:0] a;
integer i;
begin
	for(i=0; i<8; i=i+1) begin: u
		xem7310_led[i] = (a[i]==1'b1) ? (1'b0) : (1'bz);
	end
end
endfunction

assign led = xem7310_led({spite,out_debug[2:0], ep00wirein[3:0]});

initial begin 
spite <=0;
end
always @(posedge okClk) begin 
if (ep41trigin[7]) begin 
    spite <= ~spite;
end 
end

parameter N_i = 2;


wire [65*N_i-1:0]  okEHx;

okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE),
	.okEH(okEH)
	);

okWireOR # (.N(N_i)) wireOR (okEH, okEHx);
okWireIn       wi00 (.okHE(okHE),                             .ep_addr(8'h00), .ep_dataout(ep00wirein));
okTriggerIn    ti41 (.okHE(okHE),                             .ep_addr(8'h41), .ep_clk(okClk), .ep_trigger(ep41trigin));

okWireOut      wo00 (.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h20), .ep_datain(ep20wireout));
okWireOut      wo01 (.okHE(okHE), .okEH(okEHx[ 1*65 +: 65 ]), .ep_addr(8'h3e), .ep_datain(ep21wireout));




// okBTPipeIn     pi0  (.okHE(okHE), .okEH(okEHx[ 2*65 +: 65 ]), .ep_addr(8'h80), .ep_write(pi0_ep_write), .ep_blockstrobe(), .ep_dataout(pi0_ep_dataout), .ep_ready(pipe_in_ready));
// okBTPipeOut    po0  (.okHE(okHE), .okEH(okEHx[ 3*65 +: 65 ]), .ep_addr(8'ha0), .ep_read(po0_ep_read),   .ep_blockstrobe(), .ep_datain(po0_ep_datain),   .ep_ready(pipe_out_ready))
    
    
    // assign clk = okClk;

    // assign led[3:0] =  out_debug[3:0];
    // assign led[7:4] =  ep00wirein[3:0];



	assign ep20wireout = { 16'b0 ,1'b0,out, 1'b0, out_debug};
	assign 	data  			= ep41trigin[6:0];
	assign 	reset 			= ep41trigin[7];
	assign 	wr_addr 		= ep41trigin[14:8] | ep00wirein[7:0];
	assign 	write_enable 	= ep41trigin[15];
	assign 	in 				= ep41trigin[22:16];

    remap_7bit_regfile uut (
        .clk(			okClk),
        .write_enable(	write_enable),
		.reset(			reset),
        .data(			data),
        .wr_addr(		wr_addr),
        .in(			in),
        .out(			out),
		.out_debug(out_debug)
    );

endmodule


module remap_7bit_regfile (

	input wire clk,
	input wire write_enable,
	input wire reset,
	input wire  [6:0] data,
	input wire  [6:0] wr_addr,
    input wire  [6:0] in,       
    output wire [6:0] out,            
    output wire [6:0] out_debug       
);

    reg [6:0] out_r, out_debug_r;
	reg [31:0] reg_128x7bit_map [0:127];

	assign out 		 = out_r;
	assign out_debug = out_debug_r;	

integer j,k;

	initial begin
		for (j=0; j<128; j=j+1) begin
			reg_128x7bit_map[j] <= 0;
		end
	end

	always @(posedge clk) begin
		if (reset)begin 
			for (k=0; k<128; k=k+1) begin
				reg_128x7bit_map[k] <= 0;
			end
		end else if (write_enable) begin
			reg_128x7bit_map[wr_addr] <= data;
		end
		
	end
    always @(*) begin
        out_debug_r <= reg_128x7bit_map[wr_addr]; // Direct lookup using input as an index
        out_r 		<= reg_128x7bit_map[in]; // Direct lookup using input as an index
    end
    // end
    // always @(*) begin

endmodule
