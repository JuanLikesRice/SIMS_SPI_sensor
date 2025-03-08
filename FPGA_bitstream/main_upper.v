
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



//wire          clk;
wire          rst;




// Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

// wire [31:0]  ep00wire;

// wire [31:0] ep41trigin, ep20wireout,ep21wireout,ep00wirein, TrigIn40, TrigIn41;


wire [31:0] ep00wirein;
wire [31:0] ep01wirein;
wire [31:0] ep02wirein;
wire [31:0] ep03wirein;
wire [31:0] ep04wirein;
wire [31:0] ep05wirein;
wire [31:0] ep40trigin;
wire [31:0] ep41trigin;
wire [31:0] ep20wireout;
wire [31:0] ep21wireout;
wire [31:0] ep22wireout;
wire [31:0] ep24wireout;
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

assign led = xem7310_led({spite,6'b0});

initial begin 
spite <=0;
end
always @(posedge okClk) begin 
if (ep41trigin[0]) begin 
    spite <= ~spite;
end 
end
wire fpgain_fifoout_ready_refile, fpgaout_fifoin_wr_en;
wire [31:0] fpgaout_fifoin_din;

wire [31:0] ep24wireout_readout;
wire [15 : 0] rd_data_count;
wire [15 : 0] wr_data_count;
parameter N_i = 5;


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
okWireIn       wi01 (.okHE(okHE),                             .ep_addr(8'h01), .ep_dataout(ep01wirein)); 
okWireIn       wi02 (.okHE(okHE),                             .ep_addr(8'h02), .ep_dataout(ep02wirein)); 
okWireIn       wi03 (.okHE(okHE),                             .ep_addr(8'h03), .ep_dataout(ep03wirein));
okWireIn       wi04 (.okHE(okHE),                             .ep_addr(8'h04), .ep_dataout(ep04wirein));
okWireIn       wi05 (.okHE(okHE),                             .ep_addr(8'h05), .ep_dataout(ep05wirein));
//okTriggerIn    ti41 (.okHE(okHE),                             .ep_addr(8'h41), .ep_clk(okClk), .ep_trigger(ep41trigin));
//okTriggerIn    ti41 (.okHE(okHE),                             .ep_addr(8'h41), .ep_clk(okClk), .ep_trigger(ep41trigin));
okTriggerIn  ep40 (.okHE(okHE),                             .ep_addr(8'h40), .ep_clk(okClk),  .ep_trigger(ep40trigin));
okTriggerIn  ep41 (.okHE(okHE),                             .ep_addr(8'h41), .ep_clk(okClk),  .ep_trigger(ep41trigin));

okWireOut      wo00 (.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]), .ep_addr(8'h14), .ep_datain(ep20wireout));
okWireOut      wo01 (.okHE(okHE), .okEH(okEHx[ 1*65 +: 65 ]), .ep_addr(8'h15), .ep_datain(ep21wireout));
okWireOut      wo02 (.okHE(okHE), .okEH(okEHx[ 2*65 +: 65 ]), .ep_addr(8'h16), .ep_datain(ep22wireout));
okWireOut      wo03 (.okHE(okHE), .okEH(okEHx[ 3*65 +: 65 ]), .ep_addr(8'h18), .ep_datain(ep24wireout_readout));
okBTPipeOut    poa0 (.okHE(okHE), .okEH(okEHx[ 4*65 +: 65 ]), .ep_addr(8'ha0), .ep_read(FIFO_read_from), .ep_blockstrobe(), .ep_datain(FIFO_data_out), .ep_ready(pipeout_rdy));
// okBTPipeIn     pi0  (.okHE(okHE), .okEH(okEHx[ 2*65 +: 65 ]), .ep_addr(8'h80), .ep_write(pi0_ep_write), .ep_blockstrobe(), .ep_dataout(pi0_ep_dataout), .ep_ready(pipe_in_ready));
// okBTPipeOut    po0  (.okHE(okHE), .okEH(okEHx[ 3*65 +: 65 ]), .ep_addr(8'ha0), .ep_read(po0_ep_read),   .ep_blockstrobe(), .ep_datain(po0_ep_datain),   .ep_ready(pipe_out_ready))

wire pipeout_rdy, FIFO_read_from;
wire [31:0] FIFO_data_out;





  main_wrapper_EP #(.mem_size(4096)) u_main_wrapper_EP (
    .clk                           (okClk),
    .ep00wirein                    (ep00wirein),
    .ep01wirein                    (ep01wirein),
    .ep02wirein                    (ep02wirein),
    .ep03wirein                    (ep03wirein),
    .ep04wirein                    (ep04wirein),
    .ep05wirein                    (ep05wirein),
    .ep40trigin                    (ep40trigin),
    .ep41trigin                    (ep41trigin),
    .ep22wireout                   (ep22wireout),
    .ep24wireout                   (ep24wireout),

    .ep24wireout_readout           (ep24wireout_readout),
    .pipeout_rdy                   (pipeout_rdy),
    .FIFO_data_out                 (FIFO_data_out),
    .FIFO_read_from                (FIFO_read_from)
    // .fpgain_fifoout_ready_refile   (fpgain_fifoout_ready_refile),
    // .fpgaout_fifoin_din            (fpgaout_fifoin_din),
    // .fpgaout_fifoin_wr_en          (fpgaout_fifoin_wr_en)

  );



endmodule

