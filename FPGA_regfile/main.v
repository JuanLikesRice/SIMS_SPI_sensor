 module main 
 #(  parameter mem_size = 4096 ) 
 (
	input clk,
	input wire  [31:0]  ep10wirein, 
	output wire [31:0] 	ep26wireout,
	input wire  [6:0]  	Index_number, 
	output wire [6:0]  	Index_number_remapped
);

	wire  write_enable;
	wire  reset;
	wire  [6:0] data;
	wire  [6:0] wr_addr;
    wire  [6:0] in;
    wire  [6:0] out;
    wire  [6:0] out_debug;

	assign ep26wireout = { 16'b0 ,1'b0,out, 1'b0, out_debug};

	assign 	data  			= ep10wirein[6:0];
	assign 	reset 			= ep10wirein[7];
	assign 	wr_addr 		= ep10wirein[14:8];
	assign 	write_enable 	= ep10wirein[15];
	assign 	in 				= Index_number;
	assign 	Index_number_remapped = out; // Direct lookup using input as an index

    remap_7bit_regfile uut (
        .clk(			clk),
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

	input clk,
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
        out_r 		<= reg_128x7bit_map[in];      // Direct lookup using input as an index
    end
    // end
    // always @(*) begin

endmodule
    




