`timescale 1ns/1ps

module main
    (
    input  wire [4:0]   okUH,
    output wire [2:0]   okHU,
    inout  wire [31:0]  okUHU,
    inout  wire         okAA,

    input  wire         sys_clk_p,
    input  wire         sys_clk_n,
    
    // RAM
    inout  wire [31:0]  ddr3_dq,
	output wire [14:0]  ddr3_addr,
	output wire [2 :0]  ddr3_ba,
	output wire [0 :0]  ddr3_ck_p,
	output wire [0 :0]  ddr3_ck_n,
	output wire [0 :0]  ddr3_cke,
	output wire         ddr3_cas_n,
	output wire         ddr3_ras_n,
	output wire         ddr3_we_n,
	output wire [0 :0]  ddr3_odt,
	output wire [3 :0]  ddr3_dm,
	inout  wire [3 :0]  ddr3_dqs_p,
	inout  wire [3 :0]  ddr3_dqs_n,
	output wire         ddr3_reset_n,
    
    // SPI
    output wire                              CS_b_A,
    output wire                              SCLK_A,
    output wire                              MOSI1_A,
	 output wire							 MOSI2_A,
    input  wire                              MISO1_A,
    input  wire                              MISO2_A,
	
	input	wire                            external_CS_b_A ,
	input	wire                            external_SCLK_A ,
	input	wire                            external_MOSI1_A,
	input	wire							external_MOSI2_A,
    output wire                             external_MISO1_A,
    output wire                             external_MISO2_A,

    // output wire                              CS_b_B,
    // output wire                              SCLK_B,
    // output wire                              MOSI1_B,
	//  output wire										MOSI2_B,
    // input  wire                              MISO1_B,
    // input  wire                              MISO2_B,

    // output wire                              CS_b_C,
    // output wire                              SCLK_C,
    // output wire                              MOSI1_C,
	//  output wire										MOSI2_C,
    // input  wire                              MISO1_C,
    // input  wire                              MISO2_C,

    // output wire                              CS_b_D,
    // output wire                              SCLK_D,
    // output wire                              MOSI1_D,
	//  output wire										MOSI2_D,
    // input  wire                              MISO1_D,
    // input  wire                              MISO2_D,

    // output wire                              CS_b_E,
    // output wire                              SCLK_E,
    // output wire                              MOSI1_E,
	//  output wire										MOSI2_E,
    // input  wire                              MISO1_E,
    // input  wire                              MISO2_E,

    // output wire                              CS_b_F,
    // output wire                              SCLK_F,
    // output wire                              MOSI1_F,
	//  output wire										MOSI2_F,
    // input  wire                              MISO1_F,
    // input  wire                              MISO2_F,

    // output wire                              CS_b_G,
    // output wire                              SCLK_G,
    // output wire                              MOSI1_G,
	//  output wire										MOSI2_G,
    // input  wire                              MISO1_G,
    // input  wire                              MISO2_G,

    // output wire                              CS_b_H,
    // output wire                              SCLK_H,
    // output wire                              MOSI1_H,
	//  output wire										MOSI2_H,
    // input  wire                              MISO1_H,
    // input  wire                              MISO2_H,
	
	 output reg [7:0]									SPI_port_LEDs,
    
    output wire [7:0]   led,
    
	 // DACs
	//  output wire										DAC_SYNC,
	//  output wire										DAC_SCLK,
	//  output wire										DAC_DIN_1,
	//  output wire										DAC_DIN_2,
	//  output wire										DAC_DIN_3,
	//  output wire										DAC_DIN_4,
	//  output wire										DAC_DIN_5,
	//  output wire										DAC_DIN_6,
	//  output wire										DAC_DIN_7,
	//  output wire										DAC_DIN_8,

    // // ADCs
    // output wire                              ADC_CS,
    // output wire                              ADC_SCLK,
    // input  wire                              ADC_DOUT_1,
    // input  wire                              ADC_DOUT_2,
    // input  wire                              ADC_DOUT_3,
    // input  wire                              ADC_DOUT_4,
    // input  wire                              ADC_DOUT_5,
    // input  wire                              ADC_DOUT_6,
    // input  wire                              ADC_DOUT_7,
    // input  wire                              ADC_DOUT_8,

    // Digital IO
    // input  wire                              TTL_in_direct_1,
	//  input  wire                              TTL_in_direct_2,
	//  output wire										serial_LOAD,
	//  output wire										serial_CLK,
	//  input wire											TTL_in_serial,
	//  input wire											TTL_in_serial_exp,
	 input wire											expander_detect,
	 input wire											expander_ID_1,
    // output wire [15:0]                       TTL_out_direct,
	 output reg 										sample_CLK_out,
	 output wire										mark_out,
	 output wire [2:0]								status_LEDs,
	 
	 // configuration bits
	 input  wire [3:0]								board_mode
    );
    






/**?*****************************************************************************

JG code here _A
  *?*****************************************************************************/


	// wire                              CS_b_A;
	// wire                              SCLK_A;
	// wire                              MOSI1_A;
	//   wire										MOSI2_A;
	// wire                              MISO1_A;
	// wire                              MISO2_A;

	wire                              CS_b_B;
	wire                              SCLK_B;
	wire                              MOSI1_B;
	  wire										MOSI2_B;
	wire                              MISO1_B;
	wire                              MISO2_B;
	wire                              CS_b_C;
	wire                              SCLK_C;
	wire                              MOSI1_C;
	  wire										MOSI2_C;
	wire                              MISO1_C;
	wire                              MISO2_C;
	wire                              CS_b_D;
	wire                              SCLK_D;
	wire                              MOSI1_D;
	  wire										MOSI2_D;
	wire                              MISO1_D;
	wire                              MISO2_D;
	wire                              CS_b_E;
	wire                              SCLK_E;
	wire                              MOSI1_E;
	  wire										MOSI2_E;
	wire                              MISO1_E;
	wire                              MISO2_E;
	wire                              CS_b_F;
	wire                              SCLK_F;
	wire                              MOSI1_F;
	  wire										MOSI2_F;
	wire                              MISO1_F;
	wire                              MISO2_F;
	wire                              CS_b_G;
	wire                              SCLK_G;
	wire                              MOSI1_G;
	  wire										MOSI2_G;
	wire                              MISO1_G;
	wire                              MISO2_G;
	wire                              CS_b_H;
	wire                              SCLK_H;
	wire                              MOSI1_H;
	  wire										MOSI2_H;
	wire                              MISO1_H;
	wire                              MISO2_H;
	// reg [7:0]									SPI_port_LEDs;
	// wire [7:0]   led;
    
	 // DACs
	wire										DAC_SYNC;
	wire										DAC_SCLK;
	wire										DAC_DIN_1;
	wire										DAC_DIN_2;
	wire										DAC_DIN_3;
	wire										DAC_DIN_4;
	wire										DAC_DIN_5;
	wire										DAC_DIN_6;
	wire										DAC_DIN_7;
	wire										DAC_DIN_8;

    // // ADCs
	wire                              ADC_CS;
	wire                              ADC_SCLK;
	wire                              ADC_DOUT_1;
	wire                              ADC_DOUT_2;
	wire                              ADC_DOUT_3;
	wire                              ADC_DOUT_4;
	wire                              ADC_DOUT_5;
	wire                              ADC_DOUT_6;
	wire                              ADC_DOUT_7;
	wire                              ADC_DOUT_8;

    // Digital IO
	wire                              TTL_in_direct_1;
	wire                              TTL_in_direct_2;
	wire										serial_LOAD;
	wire										serial_CLK;
	 wire											TTL_in_serial;
	 wire											TTL_in_serial_exp;
	wire [15:0]                       TTL_out_direct;
// #################################################################################
// Assignments Below
// #################################################################################

// assign 	CS_b_A = 0;
// assign 	SCLK_A = 0;
// assign 	MOSI1_A = 0;
// assign 	MOSI2_A = 0;
// assign 	MISO1_A = 0;
// assign 	MISO2_A = 0;
assign 	CS_b_B = 0;
assign 	SCLK_B = 0;
assign 	MOSI1_B = 0;
assign 	MOSI2_B = 0;
assign 	MISO1_B = 0;
assign 	MISO2_B = 0;
assign 	CS_b_C = 0;
assign 	SCLK_C = 0;
assign 	MOSI1_C = 0;
assign 	MOSI2_C = 0;
assign 	MISO1_C = 0;
assign 	MISO2_C = 0;
assign 	CS_b_D = 0;
assign 	SCLK_D = 0;
assign 	MOSI1_D = 0;
assign 	MOSI2_D = 0;
assign 	MISO1_D = 0;
assign 	MISO2_D = 0;
assign 	CS_b_E = 0;
assign 	SCLK_E = 0;
assign 	MOSI1_E = 0;
assign 	MOSI2_E = 0;
assign 	MISO1_E = 0;
assign 	MISO2_E = 0;
assign 	CS_b_F = 0;
assign 	SCLK_F = 0;
assign 	MOSI1_F = 0;
assign 	MOSI2_F = 0;
assign 	MISO1_F = 0;
assign 	MISO2_F = 0;
assign 	CS_b_G = 0;
assign 	SCLK_G = 0;
assign 	MOSI1_G = 0;
assign 	MOSI2_G = 0;
assign 	MISO1_G = 0;
assign 	MISO2_G = 0;
assign 	CS_b_H = 0;
assign 	SCLK_H = 0;
assign 	MOSI1_H = 0;
assign 	MOSI2_H = 0;
assign 	MISO1_H = 0;
assign 	MISO2_H = 0;
assign 	DAC_SYNC = 0;
assign 	DAC_SCLK = 0;
assign 	DAC_DIN_1 = 0;
assign 	DAC_DIN_2 = 0;
assign 	DAC_DIN_3 = 0;
assign 	DAC_DIN_4 = 0;
assign 	DAC_DIN_5 = 0;
assign 	DAC_DIN_6 = 0;
assign 	DAC_DIN_7 = 0;
assign 	DAC_DIN_8 = 0;
assign 	ADC_CS = 0;
assign 	ADC_SCLK = 0;
assign 	ADC_DOUT_1 = 0;
assign 	ADC_DOUT_2 = 0;
assign 	ADC_DOUT_3 = 0;
assign 	ADC_DOUT_4 = 0;
assign 	ADC_DOUT_5 = 0;
assign 	ADC_DOUT_6 = 0;
assign 	ADC_DOUT_7 = 0;
assign 	ADC_DOUT_8 = 0;
assign 	TTL_in_direct_1 = 0;
assign 	TTL_in_direct_2 = 0;
assign 	serial_LOAD = 0;
assign 	serial_CLK = 0;
assign 	TTL_in_serial = 0;
assign 	TTL_in_serial_exp = 0;
assign 	TTL_out_direct = 0;






/**?*****************************************************************************

JG code here _B
  *?*****************************************************************************/













	// SPI I/O
	reg 			CS_b, SCLK;
	reg			MOSI_A, MOSI_B, MOSI_C, MOSI_D, MOSI_E, MOSI_F, MOSI_G, MOSI_H;
	wire        MISO_A1, MISO_A2;
	wire        MISO_B1, MISO_B2;
	wire        MISO_C1, MISO_C2;
	wire        MISO_D1, MISO_D2;
	wire        MISO_E1, MISO_E2;
	wire        MISO_F1, MISO_F2;
	wire        MISO_G1, MISO_G2;
	wire        MISO_H1, MISO_H2;
	
	// TESTING
	//reg [7:0] main_led = 8'b0000_0000;
	
	// Board ID number and verison
	
	localparam BOARD_ID = 16'd700;
	localparam BOARD_VERSION = 16'd1;
	
	// Wires and registers

	wire 				sys_clk;				// buffered 200 MHz clock
	wire				dataclk;			// programmable frequency clock (f = 2800 * per-channel amplifier sampling rate)
	wire				dataclk_locked, MMCM_prog_done;
	
	reg [15:0]		FIFO_data_in;
	reg				FIFO_write_to;
	wire [31:0] 	FIFO_data_out;
	wire				FIFO_read_from;
	wire [31:0] 	num_words_in_FIFO;

	wire [9:0]		RAM_addr_wr;
	reg [9:0]		RAM_addr_rd;
	wire [3:0]		RAM_bank_sel_wr;
	reg [3:0]		RAM_bank_sel_rd;
	wire [15:0]		RAM_data_in;
	wire [15:0]		RAM_data_out_1_pre, RAM_data_out_2_pre, RAM_data_out_3_pre;
	reg [15:0]		RAM_data_out_1, RAM_data_out_2, RAM_data_out_3;
	wire				RAM_we_1, RAM_we_2, RAM_we_3;
		
	reg [5:0] 		channel, channel_MISO;  // varies from 0-34 (amplfier channels 0-31, plus 3 auxiliary commands)
	reg [15:0] 		MOSI_cmd_A, MOSI_cmd_B, MOSI_cmd_C, MOSI_cmd_D, MOSI_cmd_E, MOSI_cmd_F, MOSI_cmd_G, MOSI_cmd_H;
	
	reg [73:0] 		in4x_A1, in4x_A2;
	reg [73:0] 		in4x_B1, in4x_B2;
	reg [73:0] 		in4x_C1, in4x_C2;
	reg [73:0] 		in4x_D1, in4x_D2;
	reg [73:0] 		in4x_E1, in4x_E2;
	reg [73:0] 		in4x_F1, in4x_F2;
	reg [73:0] 		in4x_G1, in4x_G2;
	reg [73:0] 		in4x_H1, in4x_H2;
	wire [15:0] 	in_A1, in_A2;
	wire [15:0] 	in_B1, in_B2;
	wire [15:0] 	in_C1, in_C2;
	wire [15:0] 	in_D1, in_D2;
	wire [15:0] 	in_E1, in_E2;
	wire [15:0] 	in_F1, in_F2;
	wire [15:0] 	in_G1, in_G2;
	wire [15:0] 	in_H1, in_H2;
	wire [15:0] 	in_DDR_A1, in_DDR_A2;
	wire [15:0] 	in_DDR_B1, in_DDR_B2;
	wire [15:0] 	in_DDR_C1, in_DDR_C2;
	wire [15:0] 	in_DDR_D1, in_DDR_D2;
	wire [15:0] 	in_DDR_E1, in_DDR_E2;
	wire [15:0] 	in_DDR_F1, in_DDR_F2;
	wire [15:0] 	in_DDR_G1, in_DDR_G2;
	wire [15:0] 	in_DDR_H1, in_DDR_H2;
	
	wire [3:0] 		delay_A, delay_B, delay_C, delay_D, delay_E, delay_F, delay_G, delay_H;
	
	reg [15:0] 		result_A1, result_A2;
	reg [15:0] 		result_B1, result_B2;
	reg [15:0] 		result_C1, result_C2;
	reg [15:0] 		result_D1, result_D2;
	reg [15:0] 		result_E1, result_E2;
	reg [15:0] 		result_F1, result_F2;
	reg [15:0] 		result_G1, result_G2;
	reg [15:0] 		result_H1, result_H2;
	reg [15:0] 		result_DDR_A1, result_DDR_A2;
	reg [15:0] 		result_DDR_B1, result_DDR_B2;
	reg [15:0] 		result_DDR_C1, result_DDR_C2;
	reg [15:0] 		result_DDR_D1, result_DDR_D2;
	reg [15:0] 		result_DDR_E1, result_DDR_E2;
	reg [15:0] 		result_DDR_F1, result_DDR_F2;
	reg [15:0] 		result_DDR_G1, result_DDR_G2;
	reg [15:0] 		result_DDR_H1, result_DDR_H2;
	
	reg [31:0] 		timestamp;			 
	reg [31:0]		max_timestep;
	wire [31:0]		max_timestep_in;
	wire [31:0] 	data_stream_timestamp;
	wire [63:0]		header_magic_number;
	wire [15:0]		data_stream_filler;
	wire				pipeout_override_en;
	
	wire [15:0]		data_stream_1, data_stream_2, data_stream_3, data_stream_4;
	wire [15:0]		data_stream_5, data_stream_6, data_stream_7, data_stream_8;
	wire [15:0]		data_stream_9, data_stream_10, data_stream_11, data_stream_12;
	wire [15:0]		data_stream_13, data_stream_14, data_stream_15, data_stream_16;
	wire [15:0]		data_stream_17, data_stream_18, data_stream_19, data_stream_20;
	wire [15:0]		data_stream_21, data_stream_22, data_stream_23, data_stream_24;
	wire [15:0]		data_stream_25, data_stream_26, data_stream_27, data_stream_28;
	wire [15:0]		data_stream_29, data_stream_30, data_stream_31, data_stream_32;
	
	reg				data_stream_1_en, data_stream_2_en, data_stream_3_en, data_stream_4_en;
	reg				data_stream_5_en, data_stream_6_en, data_stream_7_en, data_stream_8_en;
	reg				data_stream_9_en, data_stream_10_en, data_stream_11_en, data_stream_12_en;
	reg				data_stream_13_en, data_stream_14_en, data_stream_15_en, data_stream_16_en;
	reg				data_stream_17_en, data_stream_18_en, data_stream_19_en, data_stream_20_en;
	reg				data_stream_21_en, data_stream_22_en, data_stream_23_en, data_stream_24_en;
	reg				data_stream_25_en, data_stream_26_en, data_stream_27_en, data_stream_28_en;
	reg				data_stream_29_en, data_stream_30_en, data_stream_31_en, data_stream_32_en;
	wire				data_stream_1_en_in, data_stream_2_en_in, data_stream_3_en_in, data_stream_4_en_in;
	wire				data_stream_5_en_in, data_stream_6_en_in, data_stream_7_en_in, data_stream_8_en_in;
	wire				data_stream_9_en_in, data_stream_10_en_in, data_stream_11_en_in, data_stream_12_en_in;
	wire				data_stream_13_en_in, data_stream_14_en_in, data_stream_15_en_in, data_stream_16_en_in;
	wire				data_stream_17_en_in, data_stream_18_en_in, data_stream_19_en_in, data_stream_20_en_in;
	wire				data_stream_21_en_in, data_stream_22_en_in, data_stream_23_en_in, data_stream_24_en_in;
	wire				data_stream_25_en_in, data_stream_26_en_in, data_stream_27_en_in, data_stream_28_en_in;
	wire				data_stream_29_en_in, data_stream_30_en_in, data_stream_31_en_in, data_stream_32_en_in;
	
	reg [15:0]		data_stream_TTL_in, data_stream_TTL_out;
	
	// wire [15:0]		data_stream_ADC_1, data_stream_ADC_2, data_stream_ADC_3, data_stream_ADC_4;
	// wire [15:0]		data_stream_ADC_5, data_stream_ADC_6, data_stream_ADC_7, data_stream_ADC_8;

	wire [15:0]		stubbed_data_stream_ADC_1, 
					stubbed_data_stream_ADC_2, 
					stubbed_data_stream_ADC_3,
					stubbed_data_stream_ADC_4,
					stubbed_data_stream_ADC_5,
					stubbed_data_stream_ADC_6,
					stubbed_data_stream_ADC_7,
					stubbed_data_stream_ADC_8;

	assign stubbed_data_stream_ADC_1 = 16'b0000_0000_0000_0000; 
	assign stubbed_data_stream_ADC_2 = 16'b0000_0000_0000_0000; 
	assign stubbed_data_stream_ADC_3 = 16'b0000_0000_0000_0000;
	assign stubbed_data_stream_ADC_4 = 16'b0000_0000_0000_0000;
	assign stubbed_data_stream_ADC_5 = 16'b0000_0000_0000_0000;
	assign stubbed_data_stream_ADC_6 = 16'b0000_0000_0000_0000;
	assign stubbed_data_stream_ADC_7 = 16'b0000_0000_0000_0000;
	assign stubbed_data_stream_ADC_8 = 16'b0000_0000_0000_0000;


	wire				TTL_out_mode;
	reg [15:0]		TTL_out_user;
	
	wire				reset, SPI_start, SPI_run_continuous;
	reg				SPI_running;

    wire [7:0]      dataclk_M, dataclk_D;
	wire				MMCM_prog_trigger;
	wire           DSP_settle;

	wire [15:0] 	MOSI_cmd_selected_A, MOSI_cmd_selected_B, MOSI_cmd_selected_C, MOSI_cmd_selected_D;
	wire [15:0] 	MOSI_cmd_selected_E, MOSI_cmd_selected_F, MOSI_cmd_selected_G, MOSI_cmd_selected_H;
	
	reg [15:0] 		aux_cmd_A, aux_cmd_B, aux_cmd_C, aux_cmd_D, aux_cmd_E, aux_cmd_F, aux_cmd_G, aux_cmd_H;
	reg [9:0] 		aux_cmd_index_1, aux_cmd_index_2, aux_cmd_index_3;
	wire [9:0] 		max_aux_cmd_index_1_in, max_aux_cmd_index_2_in, max_aux_cmd_index_3_in;
	reg [9:0] 		max_aux_cmd_index_1, max_aux_cmd_index_2, max_aux_cmd_index_3;
	reg [9:0]		loop_aux_cmd_index_1, loop_aux_cmd_index_2, loop_aux_cmd_index_3;

	wire [3:0] 		aux_cmd_bank_1_A_in, aux_cmd_bank_1_B_in, aux_cmd_bank_1_C_in, aux_cmd_bank_1_D_in;
	wire [3:0] 		aux_cmd_bank_2_A_in, aux_cmd_bank_2_B_in, aux_cmd_bank_2_C_in, aux_cmd_bank_2_D_in;
	wire [3:0] 		aux_cmd_bank_3_A_in, aux_cmd_bank_3_B_in, aux_cmd_bank_3_C_in, aux_cmd_bank_3_D_in;
	wire [3:0] 		aux_cmd_bank_1_E_in, aux_cmd_bank_1_F_in, aux_cmd_bank_1_G_in, aux_cmd_bank_1_H_in;
	wire [3:0] 		aux_cmd_bank_2_E_in, aux_cmd_bank_2_F_in, aux_cmd_bank_2_G_in, aux_cmd_bank_2_H_in;
	wire [3:0] 		aux_cmd_bank_3_E_in, aux_cmd_bank_3_F_in, aux_cmd_bank_3_G_in, aux_cmd_bank_3_H_in;
	reg [3:0] 		aux_cmd_bank_1_A, aux_cmd_bank_1_B, aux_cmd_bank_1_C, aux_cmd_bank_1_D;
	reg [3:0] 		aux_cmd_bank_2_A, aux_cmd_bank_2_B, aux_cmd_bank_2_C, aux_cmd_bank_2_D;
	reg [3:0] 		aux_cmd_bank_3_A, aux_cmd_bank_3_B, aux_cmd_bank_3_C, aux_cmd_bank_3_D;
	reg [3:0] 		aux_cmd_bank_1_E, aux_cmd_bank_1_F, aux_cmd_bank_1_G, aux_cmd_bank_1_H;
	reg [3:0] 		aux_cmd_bank_2_E, aux_cmd_bank_2_F, aux_cmd_bank_2_G, aux_cmd_bank_2_H;
	reg [3:0] 		aux_cmd_bank_3_E, aux_cmd_bank_3_F, aux_cmd_bank_3_G, aux_cmd_bank_3_H;
	
	wire [4:0] 		DAC_channel_sel_1, DAC_channel_sel_2, DAC_channel_sel_3, DAC_channel_sel_4;
	wire [4:0] 		DAC_channel_sel_5, DAC_channel_sel_6, DAC_channel_sel_7, DAC_channel_sel_8;
	wire [5:0] 		DAC_stream_sel_1, DAC_stream_sel_2, DAC_stream_sel_3, DAC_stream_sel_4;
	wire [5:0] 		DAC_stream_sel_5, DAC_stream_sel_6, DAC_stream_sel_7, DAC_stream_sel_8;
	wire 				DAC_en_1, DAC_en_2, DAC_en_3, DAC_en_4;
	wire 				DAC_en_5, DAC_en_6, DAC_en_7, DAC_en_8;
	reg [15:0]		DAC_pre_register_1, DAC_pre_register_2, DAC_pre_register_3, DAC_pre_register_4;
	reg [15:0]		DAC_pre_register_5, DAC_pre_register_6, DAC_pre_register_7, DAC_pre_register_8;
	reg [15:0]		DAC_register_1, DAC_register_2, DAC_register_3, DAC_register_4;
	reg [15:0]		DAC_register_5, DAC_register_6, DAC_register_7, DAC_register_8;

	reg [15:0]		DAC_manual;
	wire [6:0]     DAC_noise_suppress;
	wire [2:0]		DAC_gain;
	
	reg [15:0]		DAC_thresh_1, DAC_thresh_2, DAC_thresh_3, DAC_thresh_4;
	reg [15:0]		DAC_thresh_5, DAC_thresh_6, DAC_thresh_7, DAC_thresh_8;
	reg				DAC_thresh_pol_1, DAC_thresh_pol_2, DAC_thresh_pol_3, DAC_thresh_pol_4;
	reg				DAC_thresh_pol_5, DAC_thresh_pol_6, DAC_thresh_pol_7, DAC_thresh_pol_8;
	wire [7:0]		DAC_thresh_out;
	
	reg				HPF_en;
	reg [15:0]		HPF_coefficient;
	
	reg				external_fast_settle_enable;
	reg [3:0]		external_fast_settle_channel;
	reg				external_fast_settle, external_fast_settle_prev;

	reg				external_digout_enable_A, external_digout_enable_B, external_digout_enable_C, external_digout_enable_D;
	reg				external_digout_enable_E, external_digout_enable_F, external_digout_enable_G, external_digout_enable_H;
	reg [3:0]		external_digout_channel_A, external_digout_channel_B, external_digout_channel_C, external_digout_channel_D;
	reg [3:0]		external_digout_channel_E, external_digout_channel_F, external_digout_channel_G, external_digout_channel_H;
	reg				external_digout_A, external_digout_B, external_digout_C, external_digout_D;
	reg				external_digout_E, external_digout_F, external_digout_G, external_digout_H;
	
	wire [7:0]		led_in;
	wire 				serial_CLK_manual, serial_LOAD_manual;
	
	wire 				FIFO_out_rdy;
	reg [31:0]          usb3_blocksize;
	reg [31:0]		ddr_blocksize;
	
	wire				DAC_reref_mode;
	wire [4:0]		DAC_reref_stream_sel;
	wire [4:0]		DAC_reref_channel_sel;
	reg [15:0]		DAC_reref_register, DAC_reref_pre_register;
	wire				DAC_1_input_is_ref, DAC_2_input_is_ref,  DAC_3_input_is_ref,  DAC_4_input_is_ref;
	wire				DAC_5_input_is_ref, DAC_6_input_is_ref,  DAC_7_input_is_ref,  DAC_8_input_is_ref;

    
    /* Opal Kelly */
    // Target interface bus - Standard Opal Kelly interface
    wire         okClk;
    wire [112:0] okHE;
    wire [64:0]  okEH;
    // WireIns
	wire [31:0] ep00wirein, ep01wirein, ep02wirein, ep03wirein, ep04wirein, ep05wirein, ep06wirein, ep07wirein;
	wire [31:0] ep08wirein, ep09wirein, ep0awirein, ep0bwirein, ep0cwirein, ep0dwirein, ep0ewirein, ep0fwirein;
	wire [31:0] ep10wirein, ep11wirein, ep12wirein, ep13wirein, ep14wirein, ep15wirein, ep16wirein, ep17wirein;
	wire [31:0] ep18wirein, ep19wirein, ep1awirein, ep1bwirein, ep1cwirein, ep1dwirein, ep1ewirein, ep1fwirein;
	
    // WireOuts
	wire [31:0] ep20wireout, ep21wireout, ep22wireout, ep23wireout, ep24wireout, ep25wireout, ep26wireout, ep27wireout;
	wire [31:0] ep28wireout, ep29wireout, ep2awireout, ep2bwireout, ep2cwireout, ep2dwireout, ep2ewireout, ep2fwireout;
	wire [31:0] ep30wireout, ep31wireout, ep32wireout, ep33wireout, ep34wireout, ep35wireout, ep36wireout, ep37wireout;
	wire [31:0] ep38wireout, ep39wireout, ep3awireout, ep3bwireout, ep3cwireout, ep3dwireout, ep3ewireout, ep3fwireout;
    
    // TriggerIns
	wire [31:0] ep40trigin, ep41trigin, ep42trigin;
    
    // Moved up from input deserializer
	wire [15:0] TTL_in, TTL_parallel;
	wire serial_CLK_auto, serial_LOAD_auto;
    
    
    // assign CS_b_A  = 1'b0;
	// assign SCLK_A  = 1'b0;
	// assign MOSI1_A = 1'b0;
	// assign MOSI2_A = 1'b0;

	// assign MISO_A1 = 1'b1;
	// assign MISO_A2 = 1'b1;

// ep0fwirein
wire   spi_signal_control,reset_sensor;	
assign spi_signal_control = ep0fwirein[1];
assign reset_sensor = 0;

wire	muxed_CS_b_A ,	    muxed_SCLK_A,	   muxed_MOSI1_A,	   muxed_MOSI2_A,  	 muxed_MISO1_A,		muxed_MISO2_A;
wire	internal_CS_b_A ,internal_SCLK_A,	internal_MOSI1_A,	internal_MOSI2_A, internal_MISO1_A,	 internal_MISO2_A;
// wire	external_CS_b_A ,external_SCLK_A,	external_MOSI1_A,	external_MOSI2_A, external_MISO1_A,	 external_MISO2_A;

//Outputs to sensor_Mosi_External module, external to FPGA
assign CS_b_A  = CS_b;
assign SCLK_A  = SCLK;
assign MOSI1_A = MOSI_A;
assign MOSI2_A = 1'b0;

//Outputs to sensor_Mosi_Internal module, Internal to FPGA
assign internal_CS_b_A  = CS_b;
assign internal_SCLK_A  = SCLK;
assign internal_MOSI1_A = MOSI_A;
assign internal_MOSI2_A = 1'b0;

// inputs to FPGA
assign MISO_A1 = spi_signal_control ? MISO1_A	:	internal_MISO1_A;
assign MISO_A2 = spi_signal_control ? MISO2_A	:	internal_MISO2_A;
	
// spi_signal_control
sensor_Mosi_I sensor_Mosi_Internal_A ( 
.clk_i(     internal_SCLK_A),
.reset_i(   reset_sensor),
.CS_i(      internal_CS_b_A),
.MOSI_i(    internal_MOSI1_A),
.MISO_1(    internal_MISO1_A),
.MISO_2(    internal_MISO2_A)
);


wire   reset_sensor_signal_control;	
assign reset_sensor_signal_control = ep0fwirein[2];

sensor_Mosi_I sensor_Mosi_external_A ( 
.clk_i(     external_SCLK_A),
.reset_i(   reset_sensor_signal_control),
.CS_i(      external_CS_b_A),
.MOSI_i(    external_MOSI1_A),
.MISO_1(    external_MISO1_A),
.MISO_2(    external_MISO2_A)
);



    // assign CS_b_A  = 1'b0;
	// assign SCLK_A  = 1'b0;
	// assign MOSI1_A = 1'b0;
	// assign MOSI2_A = 1'b0;
	// assign MISO_A1 = 1'b1;
	// assign MISO_A2 = 1'b1;
	// assign CS_b_B  = CS_b;
	// assign SCLK_B  = SCLK;
	// assign MOSI1_B = MOSI_B;
	// assign MOSI2_B = 1'b0;
	// assign MISO_B1 = MISO1_B;
	// assign MISO_B2 = MISO2_B;
	
	// assign CS_b_C = CS_b;
	// assign SCLK_C = SCLK;
	// assign MOSI1_C = MOSI_C;
	// assign MOSI2_C = 1'b0;
	// assign MISO_C1 = MISO1_C;
	// assign MISO_C2 = MISO2_C;
	
	// assign CS_b_D = CS_b;
	// assign SCLK_D = SCLK;
	// assign MOSI1_D = MOSI_D;
	// assign MOSI2_D = 1'b0;
	// assign MISO_D1 = MISO1_D;
	// assign MISO_D2 = MISO2_D;
	
	// assign CS_b_E = CS_b;
	// assign SCLK_E = SCLK;
	// assign MOSI1_E = MOSI_E;
	// assign MOSI2_E = 1'b0;
	// assign MISO_E1 = MISO1_E;
	// assign MISO_E2 = MISO2_E;
	
	// assign CS_b_F = CS_b;
	// assign SCLK_F = SCLK;
	// assign MOSI1_F = MOSI_F;
	// assign MOSI2_F = 1'b0;
	// assign MISO_F1 = MISO1_F;
	// assign MISO_F2 = MISO2_F;
	
	// assign CS_b_G = CS_b;
	// assign SCLK_G = SCLK;
	// assign MOSI1_G = MOSI_G;
	// assign MOSI2_G = 1'b0;
	// assign MISO_G1 = MISO1_G;
	// assign MISO_G2 = MISO2_G;
	
	// assign CS_b_H = CS_b;
	// assign SCLK_H = SCLK;
	// assign MOSI1_H = MOSI_H;
	// assign MOSI2_H = 1'b0;
	// assign MISO_H1 = MISO1_H;
	// assign MISO_H2 = MISO2_H;
	
	// Other I/O
	assign mark_out = SPI_running;
    
    
	// USB WireIn inputs

	assign reset = 						ep00wirein[0];
	assign SPI_run_continuous = 		ep00wirein[1];
	assign DSP_settle =     			ep00wirein[2];
	assign TTL_out_mode = 				ep00wirein[3];
	assign DAC_noise_suppress = 		ep00wirein[12:6];
	assign DAC_gain = 					ep00wirein[15:13];
	assign pipeout_override_en =        ep00wirein[16];

	assign max_timestep_in =			ep01wirein;
	assign serial_CLK_manual =			ep02wirein[0];
	assign serial_LOAD_manual =		ep02wirein[1];

	always @(posedge dataclk) begin
		max_timestep <= max_timestep_in;
	end
	
	assign dataclk_M =                     ep03wirein[15:8];
	assign dataclk_D =                     ep03wirein[7:0];

	assign delay_A = 						ep04wirein[3:0];
	assign delay_B = 						ep04wirein[7:4];
	assign delay_C = 						ep04wirein[11:8];
	assign delay_D = 						ep04wirein[15:12];
	assign delay_E = 						ep04wirein[19:16];
	assign delay_F = 						ep04wirein[23:20];
	assign delay_G = 						ep04wirein[27:24];
	assign delay_H = 						ep04wirein[31:28];
	
	assign RAM_addr_wr = 				ep05wirein[9:0];
	assign RAM_bank_sel_wr = 			ep06wirein[3:0];	
	assign RAM_data_in = 				ep07wirein[15:0];

	assign aux_cmd_bank_1_A_in = 		ep08wirein[3:0];
	assign aux_cmd_bank_1_B_in = 		ep08wirein[7:4];
	assign aux_cmd_bank_1_C_in = 		ep08wirein[11:8];
	assign aux_cmd_bank_1_D_in = 		ep08wirein[15:12];
	assign aux_cmd_bank_1_E_in = 		ep08wirein[19:16];
	assign aux_cmd_bank_1_F_in = 		ep08wirein[23:20];
	assign aux_cmd_bank_1_G_in = 		ep08wirein[27:24];
	assign aux_cmd_bank_1_H_in = 		ep08wirein[31:28];
	
	assign aux_cmd_bank_2_A_in = 		ep09wirein[3:0];
	assign aux_cmd_bank_2_B_in = 		ep09wirein[7:4];
	assign aux_cmd_bank_2_C_in = 		ep09wirein[11:8];
	assign aux_cmd_bank_2_D_in = 		ep09wirein[15:12];
	assign aux_cmd_bank_2_E_in = 		ep09wirein[19:16];
	assign aux_cmd_bank_2_F_in = 		ep09wirein[23:20];
	assign aux_cmd_bank_2_G_in = 		ep09wirein[27:24];
	assign aux_cmd_bank_2_H_in = 		ep09wirein[31:28];
	
	assign aux_cmd_bank_3_A_in = 		ep0awirein[3:0];
	assign aux_cmd_bank_3_B_in = 		ep0awirein[7:4];
	assign aux_cmd_bank_3_C_in = 		ep0awirein[11:8];
	assign aux_cmd_bank_3_D_in = 		ep0awirein[15:12];
	assign aux_cmd_bank_3_E_in = 		ep0awirein[19:16];
	assign aux_cmd_bank_3_F_in = 		ep0awirein[23:20];
	assign aux_cmd_bank_3_G_in = 		ep0awirein[27:24];
	assign aux_cmd_bank_3_H_in = 		ep0awirein[31:28];
	
	assign max_aux_cmd_index_1_in = 	ep0bwirein[9:0];
	assign max_aux_cmd_index_2_in = 	ep0bwirein[19:10];
	assign max_aux_cmd_index_3_in = 	ep0bwirein[29:20];

	always @(posedge dataclk) begin
		loop_aux_cmd_index_1 <=			ep0cwirein[9:0];
		loop_aux_cmd_index_2 <=			ep0cwirein[19:10];
		loop_aux_cmd_index_3 <=			ep0cwirein[29:20];
	end

	assign led_in =  		   			{data_stream_1_en,data_stream_2_en,data_stream_3_en,data_stream_4_en,delay_A[3:0]};//num_words_in_FIFO[7:0]; //ep0dwirein[7:0];

	assign DAC_reref_channel_sel =	    ep0ewirein[4:0];
	assign DAC_reref_stream_sel =		ep0ewirein[9:5];
	assign DAC_reref_mode =				ep0ewirein[10];
	
	// Note: WireIns 0f, 10, 11, 12, and 13 are currently unused.

   assign data_stream_1_en_in = 		ep14wirein[0];
   assign data_stream_2_en_in = 		ep14wirein[1];
   assign data_stream_3_en_in = 		ep14wirein[2];
   assign data_stream_4_en_in = 		ep14wirein[3];
   assign data_stream_5_en_in = 		ep14wirein[4];
   assign data_stream_6_en_in = 		ep14wirein[5];
   assign data_stream_7_en_in = 		ep14wirein[6];
   assign data_stream_8_en_in = 		ep14wirein[7];
	assign data_stream_9_en_in = 		ep14wirein[8];
   assign data_stream_10_en_in = 	ep14wirein[9];
   assign data_stream_11_en_in = 	ep14wirein[10];
   assign data_stream_12_en_in = 	ep14wirein[11];
   assign data_stream_13_en_in = 	ep14wirein[12];
   assign data_stream_14_en_in = 	ep14wirein[13];
   assign data_stream_15_en_in = 	ep14wirein[14];
   assign data_stream_16_en_in = 	ep14wirein[15];
   assign data_stream_17_en_in = 	ep14wirein[16];
   assign data_stream_18_en_in = 	ep14wirein[17];
   assign data_stream_19_en_in = 	ep14wirein[18];
   assign data_stream_20_en_in = 	ep14wirein[19];
   assign data_stream_21_en_in = 	ep14wirein[20];
   assign data_stream_22_en_in = 	ep14wirein[21];
   assign data_stream_23_en_in = 	ep14wirein[22];
   assign data_stream_24_en_in = 	ep14wirein[23];
	assign data_stream_25_en_in = 	ep14wirein[24];
   assign data_stream_26_en_in = 	ep14wirein[25];
   assign data_stream_27_en_in = 	ep14wirein[26];
   assign data_stream_28_en_in = 	ep14wirein[27];
   assign data_stream_29_en_in = 	ep14wirein[28];
   assign data_stream_30_en_in = 	ep14wirein[29];
   assign data_stream_31_en_in = 	ep14wirein[30];
   assign data_stream_32_en_in = 	ep14wirein[31];
	
	always @(posedge dataclk) begin
		TTL_out_user <= 					ep15wirein[15:0];
	end
		
	assign TTL_out_direct = TTL_out_mode ? {TTL_out_user[15:8], DAC_thresh_out} : TTL_out_user;
		
	assign DAC_channel_sel_1 = 		ep16wirein[4:0];
	assign DAC_stream_sel_1 = 			ep16wirein[10:5];
	assign DAC_en_1 = 					ep16wirein[11];
	
	assign DAC_channel_sel_2 = 		ep17wirein[4:0];
	assign DAC_stream_sel_2 = 			ep17wirein[10:5];
	assign DAC_en_2 = 					ep17wirein[11];
	
	assign DAC_channel_sel_3 = 		ep18wirein[4:0];
	assign DAC_stream_sel_3 = 			ep18wirein[10:5];
	assign DAC_en_3 = 					ep18wirein[11];
	
	assign DAC_channel_sel_4 = 		ep19wirein[4:0];
	assign DAC_stream_sel_4 = 			ep19wirein[10:5];
	assign DAC_en_4 = 					ep19wirein[11];
	
	assign DAC_channel_sel_5 = 		ep1awirein[4:0];
	assign DAC_stream_sel_5 = 			ep1awirein[10:5];
	assign DAC_en_5 = 					ep1awirein[11];
	
	assign DAC_channel_sel_6 = 		ep1bwirein[4:0];
	assign DAC_stream_sel_6 = 			ep1bwirein[10:5];
	assign DAC_en_6 = 					ep1bwirein[11];
	
	assign DAC_channel_sel_7 = 		ep1cwirein[4:0];
	assign DAC_stream_sel_7 = 			ep1cwirein[10:5];
	assign DAC_en_7 = 					ep1cwirein[11];
	
	assign DAC_channel_sel_8 = 		ep1dwirein[4:0];
	assign DAC_stream_sel_8 = 			ep1dwirein[10:5];
	assign DAC_en_8 = 					ep1dwirein[11];
	
	always @(posedge dataclk) begin
		DAC_manual <= 						ep1ewirein[15:0];
	end

	// USB TriggerIn inputs

	assign MMCM_prog_trigger = 			ep40trigin[0];
	assign RAM_we_1 = 					ep40trigin[1];
	assign RAM_we_2 = 					ep40trigin[2];
	assign RAM_we_3 = 					ep40trigin[3];

	always @(posedge ep40trigin[4]) begin
		HPF_en <=							ep1fwirein[0];
	end
	always @(posedge ep40trigin[5]) begin
		HPF_coefficient <=				ep1fwirein[15:0];
	end

	always @(posedge ep40trigin[6]) begin
		external_fast_settle_enable <=	ep1fwirein[0];
	end
	always @(posedge ep40trigin[7]) begin
		external_fast_settle_channel <=	ep1fwirein[3:0];
	end

	always @(posedge ep40trigin[8] or posedge reset) begin
		if (reset) begin
			SPI_port_LEDs <= 8'b0;
		end else begin
			SPI_port_LEDs <= ep1fwirein[7:0];
		end
	end

	always @(posedge ep40trigin[9] or posedge reset) begin
		if (reset) begin
			usb3_blocksize <= 32'd128;
		end else begin
			if (~SPI_running) begin
				usb3_blocksize <= ep1fwirein[31:0];
			end
		end
	end

	always @(posedge ep40trigin[10] or posedge reset) begin
		if (reset) begin
			ddr_blocksize <= 32'd2;
		end else begin
			if (~SPI_running) begin
				ddr_blocksize <= ep1fwirein[31:0];
			end
		end
	end
	
	
	assign SPI_start = 					    ep41trigin[0];


	always @(posedge ep42trigin[0]) begin
		DAC_thresh_1 <= 					ep1fwirein[15:0];
	end
	always @(posedge ep42trigin[1]) begin
		DAC_thresh_2 <= 					ep1fwirein[15:0];
	end
	always @(posedge ep42trigin[2]) begin
		DAC_thresh_3 <= 					ep1fwirein[15:0];
	end
	always @(posedge ep42trigin[3]) begin
		DAC_thresh_4 <= 					ep1fwirein[15:0];
	end
	always @(posedge ep42trigin[4]) begin
		DAC_thresh_5 <= 					ep1fwirein[15:0];
	end
	always @(posedge ep42trigin[5]) begin
		DAC_thresh_6 <= 					ep1fwirein[15:0];
	end
	always @(posedge ep42trigin[6]) begin
		DAC_thresh_7 <= 					ep1fwirein[15:0];
	end
	always @(posedge ep42trigin[7]) begin
		DAC_thresh_8 <= 					ep1fwirein[15:0];
	end
	always @(posedge ep42trigin[8]) begin
		DAC_thresh_pol_1 <= 				ep1fwirein[0];
	end
	always @(posedge ep42trigin[9]) begin
		DAC_thresh_pol_2 <= 				ep1fwirein[0];
	end
	always @(posedge ep42trigin[10]) begin
		DAC_thresh_pol_3 <= 				ep1fwirein[0];
	end
	always @(posedge ep42trigin[11]) begin
		DAC_thresh_pol_4 <= 				ep1fwirein[0];
	end
	always @(posedge ep42trigin[12]) begin
		DAC_thresh_pol_5 <= 				ep1fwirein[0];
	end
	always @(posedge ep42trigin[13]) begin
		DAC_thresh_pol_6 <= 				ep1fwirein[0];
	end
	always @(posedge ep42trigin[14]) begin
		DAC_thresh_pol_7 <= 				ep1fwirein[0];
	end
	always @(posedge ep42trigin[15]) begin
		DAC_thresh_pol_8 <= 				ep1fwirein[0];
	end
	
	always @(posedge ep42trigin[16]) begin
		external_digout_enable_A <=	        ep1fwirein[0];
	end
	always @(posedge ep42trigin[17]) begin
		external_digout_enable_B <=	        ep1fwirein[0];
	end
	always @(posedge ep42trigin[18]) begin
		external_digout_enable_C <=	        ep1fwirein[0];
	end
	always @(posedge ep42trigin[19]) begin
		external_digout_enable_D <=	        ep1fwirein[0];
	end
	always @(posedge ep42trigin[20]) begin
		external_digout_enable_E <=	        ep1fwirein[0];
	end
	always @(posedge ep42trigin[21]) begin
		external_digout_enable_F <=	        ep1fwirein[0];
	end
	always @(posedge ep42trigin[22]) begin
		external_digout_enable_G <=	        ep1fwirein[0];
	end
	always @(posedge ep42trigin[23]) begin
		external_digout_enable_H <=	        ep1fwirein[0];
	end
	
	always @(posedge ep42trigin[24]) begin
		external_digout_channel_A <=	    ep1fwirein[3:0];
	end
	always @(posedge ep42trigin[25]) begin
		external_digout_channel_B <=	    ep1fwirein[3:0];
	end
	always @(posedge ep42trigin[26]) begin
		external_digout_channel_C <=	    ep1fwirein[3:0];
	end
	always @(posedge ep42trigin[27]) begin
		external_digout_channel_D <=	    ep1fwirein[3:0];
	end
	always @(posedge ep42trigin[28]) begin
		external_digout_channel_E <=	    ep1fwirein[3:0];
	end
	always @(posedge ep42trigin[29]) begin
		external_digout_channel_F <=	    ep1fwirein[3:0];
	end
	always @(posedge ep42trigin[30]) begin
		external_digout_channel_G <=	    ep1fwirein[3:0];
	end
	always @(posedge ep42trigin[31]) begin
		external_digout_channel_H <=	    ep1fwirein[3:0];
	end

	// USB WireOut outputs

	assign ep20wireout =				   num_words_in_FIFO;
	assign ep21wireout =				   { 16'b0, 12'b0, expander_ID_1, expander_detect, TTL_in_serial_exp, TTL_in_serial };
	
	assign ep22wireout = 				   { 16'b0, 15'b0, SPI_running };
		
	assign ep23wireout = 				   { 16'b0, TTL_in };
	
	assign ep24wireout = 				   { 16'b0, 14'b0, MMCM_prog_done, dataclk_locked };
	
	assign ep25wireout = 				   { 16'b0, 12'b0, board_mode };

	// Unused; future expansion
	// assign ep26wireout = 				  32'h00000000;
	// assign ep27wireout = 				  32'h00000000;
	// assign ep29wireout = 				  32'h00000000;
	// assign ep2awireout = 				  32'h00000000;
	// assign ep2bwireout = 				  readout_condition_1_counter;
	// assign ep2cwireout = 				  readout_condition_2_counter;
	// assign ep2dwireout = 				  32'h00000000;
	// assign ep2ewireout = 				  32'h00000000;
	// assign ep2fwireout = 				  32'h00000000;
	assign ep30wireout = 				  32'h00000000;
	assign ep31wireout = 				  32'h00000000;
	assign ep32wireout = 				  32'h00000000;
	assign ep33wireout = 				  32'h00000000;
	assign ep34wireout = 				  32'h00000000;
	assign ep35wireout = 				  32'h00000000;
	assign ep36wireout = 				  32'h00000000;
	assign ep37wireout = 				  32'h00000000;
	assign ep38wireout = 				  32'h00000000;
	assign ep39wireout = 				  32'h00000000;
	assign ep3awireout = 				  32'h00000000;
	assign ep3bwireout = 				  32'h00000000;
	assign ep3cwireout = 				  32'h00000000;
	assign ep3dwireout = 				  32'h00000000;
	
	assign ep3ewireout = 				  { 16'b0, BOARD_ID };
	assign ep3fwireout = 				  { 16'b0, BOARD_VERSION };
	
	
	// 8-LED Display on Opal Kelly board
	// FOR TESTING - set LEDs to any desired value
	function [7:0] xem7310_led;
        input [7:0] a;
        integer i;
        begin
            for(i=0; i<8; i=i+1) begin: u
                xem7310_led[i] = (a[i]==1'b1) ? (1'b0) : (1'bz);
            end
        end
    endfunction

    //assign led = xem7310_led(main_led);
    assign led = xem7310_led(led_in);
	
	// 3-LED front panel status display
	
	assign status_LEDs = { TTL_in_direct_2, TTL_in_direct_1, SPI_running };
    
    // Generate variable frequency 'dataclk', dependent on desired sample rate
    variable_freq_clk_generator variable_freq_clk_generator_inst
        (
        .sys_clk            (sys_clk),
        .okClk              (okClk),
        .reset              (reset), // WireIn00[0]
        .M                  (dataclk_M),
        .D                  (dataclk_D),
        .MMCM_prog_trigger  (MMCM_prog_trigger), // TriggerIn40[0]
        .clkout             (dataclk),
        .MMCM_prog_done     (MMCM_prog_done), // WireOut24[1]
        .locked             (dataclk_locked)  // WireOut24[0]
        );
        
    // Buffer for 'sys_clk' from differential input
    IBUFGDS osc_clk
        (
        .O                  (sys_clk),
        .I                  (sys_clk_p),
        .IB                 (sys_clk_n)
        );
        
    // Transfer data from SPI communication to RAM (and supporting FIFOs), ultimately to block-throttled PipeOut
    SDRAM_FIFO SDRAM_FIFO_inst
        (
        .okClk              (okClk),
        .data_in_clk        (dataclk),
        .sys_clk            (sys_clk),
        .reset              (reset),
        .FIFO_write_to      (FIFO_write_to),
        .FIFO_data_in       (FIFO_data_in),
        .FIFO_read_from     (FIFO_read_from),
        .FIFO_data_out      (FIFO_data_out),
        .FIFO_out_rdy       (FIFO_out_rdy),
        .usb3_blocksize     (usb3_blocksize),
        .ddr_blocksize      (ddr_blocksize),
        .num_words_in_FIFO  (num_words_in_FIFO),
        .ddr3_dq            (ddr3_dq),
        .ddr3_addr          (ddr3_addr),
        .ddr3_ba            (ddr3_ba),
        .ddr3_ck_p          (ddr3_ck_p),
        .ddr3_ck_n          (ddr3_ck_n),
        .ddr3_cke           (ddr3_cke),
        .ddr3_cas_n         (ddr3_cas_n),
        .ddr3_ras_n         (ddr3_ras_n),
        .ddr3_we_n          (ddr3_we_n),
        .ddr3_odt           (ddr3_odt),
        .ddr3_dm            (ddr3_dm),
        .ddr3_dqs_p         (ddr3_dqs_p),
        .ddr3_dqs_n         (ddr3_dqs_n),
        .ddr3_reset_n       (ddr3_reset_n)
    );

	// MOSI auxiliary command sequence RAM banks

	RAM_bank RAM_bank_1
        (
        .clk_A              (okClk),
		.clk_B              (dataclk),
		.RAM_bank_sel_A     (RAM_bank_sel_wr),
		.RAM_bank_sel_B     (RAM_bank_sel_rd),
		.RAM_addr_A         (RAM_addr_wr),
		.RAM_addr_B         (RAM_addr_rd),
		.RAM_data_in        (RAM_data_in),
		.RAM_data_out_A     (),
		.RAM_data_out_B     (RAM_data_out_1_pre),
		.RAM_we             (RAM_we_1),
		.reset              (reset)
	);

	wire external_fast_settle_rising_edge, external_fast_settle_falling_edge;
	assign external_fast_settle_rising_edge = external_fast_settle_prev == 1'b0 && external_fast_settle == 1'b1;
	assign external_fast_settle_falling_edge = external_fast_settle_prev == 1'b1 && external_fast_settle == 1'b0;
	
	// If the user has enabled external fast settling of amplifiers, inject commands to set fast settle
	// (bit D[5] in RAM Register 0) on a rising edge and reset fast settle on a falling edge of the control
	// signal.  We only inject commands in the auxcmd1 slot, since this is typically used only for setting
	// impedance test waveforms.
	always @(*) begin
		if (external_fast_settle_enable == 1'b0)
			RAM_data_out_1 <= RAM_data_out_1_pre; // If external fast settle is disabled, pass command from RAM
		else if (external_fast_settle_rising_edge)
			RAM_data_out_1 <= 16'h80fe; // Send WRITE(0, 254) command to set fast settle when rising edge detected.
		else if (external_fast_settle_falling_edge)
			RAM_data_out_1 <= 16'h80de; // Send WRITE(0, 222) command to reset fast settle when falling edge detected.
		else if (RAM_data_out_1_pre[15:8] == 8'h80)
			// If the user tries to write to Register 0, override it with the external fast settle value.
			RAM_data_out_1 <= { RAM_data_out_1_pre[15:6], external_fast_settle, RAM_data_out_1_pre[4:0] };
		else RAM_data_out_1 <= RAM_data_out_1_pre; // Otherwise pass command from RAM.
	end

	RAM_bank RAM_bank_2
        (
		.clk_A              (okClk),
		.clk_B              (dataclk),
		.RAM_bank_sel_A     (RAM_bank_sel_wr),
		.RAM_bank_sel_B     (RAM_bank_sel_rd),
		.RAM_addr_A         (RAM_addr_wr),
		.RAM_addr_B         (RAM_addr_rd),
		.RAM_data_in        (RAM_data_in),
		.RAM_data_out_A     (),
		.RAM_data_out_B     (RAM_data_out_2_pre),
		.RAM_we             (RAM_we_2),
		.reset              (reset)
	);
	
	always @(*) begin
		if (external_fast_settle_enable == 1'b1 && RAM_data_out_2_pre[15:8] == 8'h80)
			// If the user tries to write to Register 0 when external fast settle is enabled, override it
			// with the external fast settle value.
			RAM_data_out_2 <= { RAM_data_out_2_pre[15:6], external_fast_settle, RAM_data_out_2_pre[4:0] };
		else RAM_data_out_2 <= RAM_data_out_2_pre;
	end
	
	RAM_bank RAM_bank_3
        (
		.clk_A              (okClk),
		.clk_B              (dataclk),
		.RAM_bank_sel_A     (RAM_bank_sel_wr),
		.RAM_bank_sel_B     (RAM_bank_sel_rd),
		.RAM_addr_A         (RAM_addr_wr),
		.RAM_addr_B         (RAM_addr_rd),
		.RAM_data_in        (RAM_data_in),
		.RAM_data_out_A     (),
		.RAM_data_out_B     (RAM_data_out_3_pre),
		.RAM_we             (RAM_we_3),
		.reset              (reset)
	);
	
	always @(*) begin
		if (external_fast_settle_enable == 1'b1 && RAM_data_out_3_pre[15:8] == 8'h80)
			// If the user tries to write to Register 0 when external fast settle is enabled, override it
			// with the external fast settle value.
			RAM_data_out_3 <= { RAM_data_out_3_pre[15:6], external_fast_settle, RAM_data_out_3_pre[4:0] };
		else RAM_data_out_3 <= RAM_data_out_3_pre;
	end
	
	
	command_selector command_selector_A (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_A), .digout_override(external_digout_A), .MOSI_cmd(MOSI_cmd_selected_A));

	command_selector command_selector_B (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_B), .digout_override(external_digout_B), .MOSI_cmd(MOSI_cmd_selected_B));

	command_selector command_selector_C (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_C), .digout_override(external_digout_C), .MOSI_cmd(MOSI_cmd_selected_C));

	command_selector command_selector_D (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_D), .digout_override(external_digout_D), .MOSI_cmd(MOSI_cmd_selected_D));

	command_selector command_selector_E (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_E), .digout_override(external_digout_E), .MOSI_cmd(MOSI_cmd_selected_E));

	command_selector command_selector_F (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_F), .digout_override(external_digout_F), .MOSI_cmd(MOSI_cmd_selected_F));

	command_selector command_selector_G (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_G), .digout_override(external_digout_G), .MOSI_cmd(MOSI_cmd_selected_G));

	command_selector command_selector_H (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_H), .digout_override(external_digout_H), .MOSI_cmd(MOSI_cmd_selected_H));
		
	wire [5:0] num_data_streams_enabled;
	assign num_data_streams_enabled =
		data_stream_1_en + data_stream_2_en + data_stream_3_en + data_stream_4_en + 
		data_stream_5_en + data_stream_6_en + data_stream_7_en + data_stream_8_en + 
		data_stream_9_en + data_stream_10_en + data_stream_11_en + data_stream_12_en + 
		data_stream_13_en + data_stream_14_en + data_stream_15_en + data_stream_16_en + 
		data_stream_17_en + data_stream_18_en + data_stream_19_en + data_stream_20_en + 
		data_stream_21_en + data_stream_22_en + data_stream_23_en + data_stream_24_en + 
		data_stream_25_en + data_stream_26_en + data_stream_27_en + data_stream_28_en + 
		data_stream_29_en + data_stream_30_en + data_stream_31_en + data_stream_32_en;
	
		
	assign header_magic_number = 64'hD7A22AAA38132A53;  // Fixed 64-bit "magic number" that begins each data frame
																		 // to aid in synchronization.
	assign data_stream_filler = 16'd0;
	
	reg [3:0] word_counter_16bit = 0;
    reg [2:0] reg_value;
	reg 	  reg_file_enable;


	reg [15:0] data_in_dual_bank_reg_file;

	integer main_state;
	localparam
                ms_wait    = 99,
                
	            ms_clk1_a  = 100,
			    ms_clk1_b  = 101,
                ms_clk1_c  = 102,
                ms_clk1_d  = 103,
                
				ms_clk2_a  = 104,
			    ms_clk2_b  = 105,
                ms_clk2_c  = 106,
                ms_clk2_d  = 107,
                
				ms_clk3_a  = 108,
			    ms_clk3_b  = 109,
                ms_clk3_c  = 110,
                ms_clk3_d  = 111,
                
				ms_clk4_a  = 112,
			    ms_clk4_b  = 113,
                ms_clk4_c  = 114,
                ms_clk4_d  = 115,
                
				ms_clk5_a  = 116,
			    ms_clk5_b  = 117,
                ms_clk5_c  = 118,
                ms_clk5_d  = 119,
                
				ms_clk6_a  = 120,
			    ms_clk6_b  = 121,
                ms_clk6_c  = 122,
                ms_clk6_d  = 123,
                
				ms_clk7_a  = 124,
			    ms_clk7_b  = 125,
                ms_clk7_c  = 126,
                ms_clk7_d  = 127,
                
				ms_clk8_a  = 128,
			    ms_clk8_b  = 129,
                ms_clk8_c  = 130,
                ms_clk8_d  = 131,
                
				ms_clk9_a  = 132,
			    ms_clk9_b  = 133,
                ms_clk9_c  = 134,
                ms_clk9_d  = 135,
                
				ms_clk10_a = 136,
			    ms_clk10_b = 137,
                ms_clk10_c = 138,
                ms_clk10_d = 139,
                
				ms_clk11_a = 140,
			    ms_clk11_b = 141,
                ms_clk11_c = 142,
                ms_clk11_d = 143,
                
				ms_clk12_a = 144,
			    ms_clk12_b = 145,
                ms_clk12_c = 146,
                ms_clk12_d = 147,
                
				ms_clk13_a = 148,
			    ms_clk13_b = 149,
                ms_clk13_c = 150,
                ms_clk13_d = 151,
                
				ms_clk14_a = 152,
			    ms_clk14_b = 153,
                ms_clk14_c = 154,
                ms_clk14_d = 155,
                
				ms_clk15_a = 156,
			    ms_clk15_b = 157,
                ms_clk15_c = 158,
                ms_clk15_d = 159,
                
				ms_clk16_a = 160,
			    ms_clk16_b = 161,
                ms_clk16_c = 162,
                ms_clk16_d = 163,
				  
                ms_clk17_a = 164,
                ms_clk17_b = 165,
				  
				ms_cs_a    = 166,
				ms_cs_b    = 167,
				ms_cs_c    = 168,
				ms_cs_d    = 169,
				ms_cs_e    = 170,
				ms_cs_f    = 171,
				ms_cs_g    = 172,
				ms_cs_h    = 173,
				ms_cs_i    = 174,
				ms_cs_j    = 175,
				ms_cs_k    = 176,
				ms_cs_l    = 177,
				ms_cs_m    = 178,
				ms_cs_n    = 179,
				ms_finish_256bit_word_0 = 180,
				ms_finish_256bit_word_1 = 181;
				  
	always @(posedge dataclk) begin
		if (reset) begin
            reg_file_enable <= 1'b0;
            reg_value       <= 3'd5;
			main_state <= ms_wait;
			timestamp <= 0;
			sample_CLK_out <= 0;
			channel <= 0;
			CS_b <= 1'b1;
			SCLK <= 1'b0;
			MOSI_A <= 1'b0;
			MOSI_B <= 1'b0;
			MOSI_C <= 1'b0;
			MOSI_D <= 1'b0;
			MOSI_E <= 1'b0;
			MOSI_F <= 1'b0;
			MOSI_G <= 1'b0;
			MOSI_H <= 1'b0;
			FIFO_data_in <= 16'b0;
			FIFO_write_to <= 1'b0;
		end else begin
			CS_b <= 1'b0;
			SCLK <= 1'b0;
			FIFO_data_in <= 16'b0;
			FIFO_write_to <= 1'b0;
            reg_file_enable <= 1'b0;
            reg_value       <= 3'd5;

			case (main_state)
			
				ms_wait: begin
					timestamp <= 0;
					sample_CLK_out <= 0;
					channel <= 0;
					channel_MISO <= 33;	// channel of MISO output, accounting for 2-cycle pipeline in RHD2000 SPI interface (Bug fix: changed 2 to 33, 1/26/13)
					CS_b <= 1'b1;
					SCLK <= 1'b0;
					MOSI_A <= 1'b0;
					MOSI_B <= 1'b0;
					MOSI_C <= 1'b0;
					MOSI_D <= 1'b0;
					MOSI_E <= 1'b0;
					MOSI_F <= 1'b0;
					MOSI_G <= 1'b0;
					MOSI_H <= 1'b0;
					FIFO_data_in <= 16'b0;
					FIFO_write_to <= 1'b0;
					aux_cmd_index_1 <= 0;
					aux_cmd_index_2 <= 0;
					aux_cmd_index_3 <= 0;
					max_aux_cmd_index_1 <= max_aux_cmd_index_1_in;
					max_aux_cmd_index_2 <= max_aux_cmd_index_2_in;
					max_aux_cmd_index_3 <= max_aux_cmd_index_3_in;
					aux_cmd_bank_1_A <= aux_cmd_bank_1_A_in;
					aux_cmd_bank_1_B <= aux_cmd_bank_1_B_in;
					aux_cmd_bank_1_C <= aux_cmd_bank_1_C_in;
					aux_cmd_bank_1_D <= aux_cmd_bank_1_D_in;
					aux_cmd_bank_1_E <= aux_cmd_bank_1_E_in;
					aux_cmd_bank_1_F <= aux_cmd_bank_1_F_in;
					aux_cmd_bank_1_G <= aux_cmd_bank_1_G_in;
					aux_cmd_bank_1_H <= aux_cmd_bank_1_H_in;
					aux_cmd_bank_2_A <= aux_cmd_bank_2_A_in;
					aux_cmd_bank_2_B <= aux_cmd_bank_2_B_in;
					aux_cmd_bank_2_C <= aux_cmd_bank_2_C_in;
					aux_cmd_bank_2_D <= aux_cmd_bank_2_D_in;
					aux_cmd_bank_2_E <= aux_cmd_bank_2_E_in;
					aux_cmd_bank_2_F <= aux_cmd_bank_2_F_in;
					aux_cmd_bank_2_G <= aux_cmd_bank_2_G_in;
					aux_cmd_bank_2_H <= aux_cmd_bank_2_H_in;
					aux_cmd_bank_3_A <= aux_cmd_bank_3_A_in;
					aux_cmd_bank_3_B <= aux_cmd_bank_3_B_in;
					aux_cmd_bank_3_C <= aux_cmd_bank_3_C_in;
					aux_cmd_bank_3_D <= aux_cmd_bank_3_D_in;
					aux_cmd_bank_3_E <= aux_cmd_bank_3_E_in;
					aux_cmd_bank_3_F <= aux_cmd_bank_3_F_in;
					aux_cmd_bank_3_G <= aux_cmd_bank_3_G_in;
					aux_cmd_bank_3_H <= aux_cmd_bank_3_H_in;
					
					data_stream_1_en <= data_stream_1_en_in;		// can only change USB streams after stopping SPI
					data_stream_2_en <= data_stream_2_en_in;
					data_stream_3_en <= data_stream_3_en_in;
					data_stream_4_en <= data_stream_4_en_in;
					data_stream_5_en <= data_stream_5_en_in;
					data_stream_6_en <= data_stream_6_en_in;
					data_stream_7_en <= data_stream_7_en_in;
					data_stream_8_en <= data_stream_8_en_in;
					data_stream_9_en <= data_stream_9_en_in;		
					data_stream_10_en <= data_stream_10_en_in;
					data_stream_11_en <= data_stream_11_en_in;
					data_stream_12_en <= data_stream_12_en_in;
					data_stream_13_en <= data_stream_13_en_in;
					data_stream_14_en <= data_stream_14_en_in;
					data_stream_15_en <= data_stream_15_en_in;
					data_stream_16_en <= data_stream_16_en_in;
					data_stream_17_en <= data_stream_17_en_in;
					data_stream_18_en <= data_stream_18_en_in;
					data_stream_19_en <= data_stream_19_en_in;
					data_stream_20_en <= data_stream_20_en_in;
					data_stream_21_en <= data_stream_21_en_in;
					data_stream_22_en <= data_stream_22_en_in;
					data_stream_23_en <= data_stream_23_en_in;
					data_stream_24_en <= data_stream_24_en_in;
					data_stream_25_en <= data_stream_25_en_in;		
					data_stream_26_en <= data_stream_26_en_in;
					data_stream_27_en <= data_stream_27_en_in;
					data_stream_28_en <= data_stream_28_en_in;
					data_stream_29_en <= data_stream_29_en_in;
					data_stream_30_en <= data_stream_30_en_in;
					data_stream_31_en <= data_stream_31_en_in;
					data_stream_32_en <= data_stream_32_en_in;

					DAC_pre_register_1 <= 16'h8000;		// set DACs to midrange, initially, to avoid loud 'pop' in audio at start
					DAC_pre_register_2 <= 16'h8000;
					DAC_pre_register_3 <= 16'h8000;
					DAC_pre_register_4 <= 16'h8000;
					DAC_pre_register_5 <= 16'h8000;
					DAC_pre_register_6 <= 16'h8000;
					DAC_pre_register_7 <= 16'h8000;
					DAC_pre_register_8 <= 16'h8000;
					DAC_reref_pre_register <= 16'h8000;
					
					SPI_running <= 1'b0;

					if (SPI_start) begin
						main_state <= ms_cs_n;
					end
				end

				ms_cs_n: begin
					SPI_running <= 1'b1;
					MOSI_cmd_A <= MOSI_cmd_selected_A;
					MOSI_cmd_B <= MOSI_cmd_selected_B;
					MOSI_cmd_C <= MOSI_cmd_selected_C;
					MOSI_cmd_D <= MOSI_cmd_selected_D;
					MOSI_cmd_E <= MOSI_cmd_selected_E;
					MOSI_cmd_F <= MOSI_cmd_selected_F;
					MOSI_cmd_G <= MOSI_cmd_selected_G;
					MOSI_cmd_H <= MOSI_cmd_selected_H;
					CS_b <= 1'b1;
					main_state <= ms_clk1_a;
				end

				ms_clk1_a: begin
					if (channel == 0) begin				// sample clock goes high during channel 0 SPI command
						sample_CLK_out <= 1'b1;
					end else begin
						sample_CLK_out <= 1'b0;
					end

					if (channel == 0) begin				// grab TTL inputs, and grab current state of TTL outputs and manual DAC outputs
						data_stream_TTL_in <= TTL_in;
						data_stream_TTL_out <= TTL_out_direct;
						
						// Route selected TTL input to external fast settle signal
						external_fast_settle_prev <= external_fast_settle;	// save previous value so we can detecting rising/falling edges
						external_fast_settle <= TTL_in[external_fast_settle_channel];
						
						// Route selected TLL inputs to external digout signal
						external_digout_A <= external_digout_enable_A ? TTL_in[external_digout_channel_A] : 0;
						external_digout_B <= external_digout_enable_B ? TTL_in[external_digout_channel_B] : 0;
						external_digout_C <= external_digout_enable_C ? TTL_in[external_digout_channel_C] : 0;
						external_digout_D <= external_digout_enable_D ? TTL_in[external_digout_channel_D] : 0;		
						external_digout_E <= external_digout_enable_E ? TTL_in[external_digout_channel_E] : 0;
						external_digout_F <= external_digout_enable_F ? TTL_in[external_digout_channel_F] : 0;
						external_digout_G <= external_digout_enable_G ? TTL_in[external_digout_channel_G] : 0;
						external_digout_H <= external_digout_enable_H ? TTL_in[external_digout_channel_H] : 0;						
					end

					if (channel == 0) begin				// update all DAC registers simultaneously
						DAC_register_1 <= DAC_pre_register_1;
						DAC_register_2 <= DAC_pre_register_2;
						DAC_register_3 <= DAC_pre_register_3;
						DAC_register_4 <= DAC_pre_register_4;
						DAC_register_5 <= DAC_pre_register_5;
						DAC_register_6 <= DAC_pre_register_6;
						DAC_register_7 <= DAC_pre_register_7;
						DAC_register_8 <= DAC_pre_register_8;
						DAC_reref_register <= DAC_reref_pre_register;
					end

					MOSI_A <= MOSI_cmd_A[15];
					MOSI_B <= MOSI_cmd_B[15];
					MOSI_C <= MOSI_cmd_C[15];
					MOSI_D <= MOSI_cmd_D[15];
					MOSI_E <= MOSI_cmd_E[15];
					MOSI_F <= MOSI_cmd_F[15];
					MOSI_G <= MOSI_cmd_G[15];
					MOSI_H <= MOSI_cmd_H[15];
					main_state <= ms_clk1_b;
				end

				ms_clk1_b: begin
					// Note: After selecting a new RAM_addr_rd, we must wait two clock cycles before reading from the RAM
					if (channel == 31) begin
						RAM_addr_rd <= aux_cmd_index_1;
					end else if (channel == 32) begin
						RAM_addr_rd <= aux_cmd_index_2;
					end else if (channel == 33) begin
						RAM_addr_rd <= aux_cmd_index_3;
					end

					if (channel == 0) begin
						FIFO_data_in <= header_magic_number[15:0];
						FIFO_write_to <= 1'b1;
					end

					main_state <= ms_clk1_c;
				end

				ms_clk1_c: begin
					// Note: We only need to wait one clock cycle after selecting a new RAM_bank_sel_rd
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_A;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_A;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_A;
					end

					if (channel == 0) begin
						FIFO_data_in <= header_magic_number[31:16];
						FIFO_write_to <= 1'b1;
					end

					SCLK <= 1'b1;
					in4x_A1[0] <= MISO_A1; in4x_A2[0] <= MISO_A2;
					in4x_B1[0] <= MISO_B1; in4x_B2[0] <= MISO_B2;
					in4x_C1[0] <= MISO_C1; in4x_C2[0] <= MISO_C2;
					in4x_D1[0] <= MISO_D1; in4x_D2[0] <= MISO_D2;
					in4x_E1[0] <= MISO_E1; in4x_E2[0] <= MISO_E2;
					in4x_F1[0] <= MISO_F1; in4x_F2[0] <= MISO_F2;
					in4x_G1[0] <= MISO_G1; in4x_G2[0] <= MISO_G2;
					in4x_H1[0] <= MISO_H1; in4x_H2[0] <= MISO_H2;					
					main_state <= ms_clk1_d;
				end
				
				ms_clk1_d: begin
					if (channel == 31) begin
						aux_cmd_A <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_A <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_A <= RAM_data_out_3;
					end

					if (channel == 0) begin
						FIFO_data_in <= header_magic_number[47:32];
						FIFO_write_to <= 1'b1;
					end

					SCLK <= 1'b1;
					in4x_A1[1] <= MISO_A1; in4x_A2[1] <= MISO_A2;
					in4x_B1[1] <= MISO_B1; in4x_B2[1] <= MISO_B2;
					in4x_C1[1] <= MISO_C1; in4x_C2[1] <= MISO_C2;
					in4x_D1[1] <= MISO_D1; in4x_D2[1] <= MISO_D2;
					in4x_E1[1] <= MISO_E1; in4x_E2[1] <= MISO_E2;
					in4x_F1[1] <= MISO_F1; in4x_F2[1] <= MISO_F2;
					in4x_G1[1] <= MISO_G1; in4x_G2[1] <= MISO_G2;
					in4x_H1[1] <= MISO_H1; in4x_H2[1] <= MISO_H2;					
					main_state <= ms_clk2_a;
				end

				ms_clk2_a: begin
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_B;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_B;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_B;
					end

					if (channel == 0) begin
						FIFO_data_in <= header_magic_number[63:48];
						FIFO_write_to <= 1'b1;
					end

					MOSI_A <= MOSI_cmd_A[14];
					MOSI_B <= MOSI_cmd_B[14];
					MOSI_C <= MOSI_cmd_C[14];
					MOSI_D <= MOSI_cmd_D[14];
					MOSI_E <= MOSI_cmd_E[14];
					MOSI_F <= MOSI_cmd_F[14];
					MOSI_G <= MOSI_cmd_G[14];
					MOSI_H <= MOSI_cmd_H[14];
					in4x_A1[2] <= MISO_A1; in4x_A2[2] <= MISO_A2;
					in4x_B1[2] <= MISO_B1; in4x_B2[2] <= MISO_B2;
					in4x_C1[2] <= MISO_C1; in4x_C2[2] <= MISO_C2;
					in4x_D1[2] <= MISO_D1; in4x_D2[2] <= MISO_D2;				
					in4x_E1[2] <= MISO_E1; in4x_E2[2] <= MISO_E2;
					in4x_F1[2] <= MISO_F1; in4x_F2[2] <= MISO_F2;
					in4x_G1[2] <= MISO_G1; in4x_G2[2] <= MISO_G2;
					in4x_H1[2] <= MISO_H1; in4x_H2[2] <= MISO_H2;
					main_state <= ms_clk2_b;
				end

				ms_clk2_b: begin
					if (channel == 31) begin
						aux_cmd_B <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_B <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_B <= RAM_data_out_3;
					end

					if (channel == 0) begin
						FIFO_data_in <= timestamp[15:0];
						FIFO_write_to <= 1'b1;
					end

					in4x_A1[3] <= MISO_A1; in4x_A2[3] <= MISO_A2;
					in4x_B1[3] <= MISO_B1; in4x_B2[3] <= MISO_B2;
					in4x_C1[3] <= MISO_C1; in4x_C2[3] <= MISO_C2;
					in4x_D1[3] <= MISO_D1; in4x_D2[3] <= MISO_D2;				
					in4x_E1[3] <= MISO_E1; in4x_E2[3] <= MISO_E2;
					in4x_F1[3] <= MISO_F1; in4x_F2[3] <= MISO_F2;
					in4x_G1[3] <= MISO_G1; in4x_G2[3] <= MISO_G2;
					in4x_H1[3] <= MISO_H1; in4x_H2[3] <= MISO_H2;
					main_state <= ms_clk2_c;
				end

				ms_clk2_c: begin
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_C;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_C;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_C;
					end

					if (channel == 0) begin
						FIFO_data_in <= timestamp[31:16];
						FIFO_write_to <= 1'b1;
					end

					SCLK <= 1'b1;
					in4x_A1[4] <= MISO_A1; in4x_A2[4] <= MISO_A2;
					in4x_B1[4] <= MISO_B1; in4x_B2[4] <= MISO_B2;
					in4x_C1[4] <= MISO_C1; in4x_C2[4] <= MISO_C2;
					in4x_D1[4] <= MISO_D1; in4x_D2[4] <= MISO_D2;					
					in4x_E1[4] <= MISO_E1; in4x_E2[4] <= MISO_E2;
					in4x_F1[4] <= MISO_F1; in4x_F2[4] <= MISO_F2;
					in4x_G1[4] <= MISO_G1; in4x_G2[4] <= MISO_G2;
					in4x_H1[4] <= MISO_H1; in4x_H2[4] <= MISO_H2;
					main_state <= ms_clk2_d;
				end
				
				ms_clk2_d: begin
					if (channel == 31) begin
						aux_cmd_C <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_C <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_C <= RAM_data_out_3;
					end

					if (data_stream_1_en == 1'b1) begin
						FIFO_data_in <= data_stream_1;
						data_in_dual_bank_reg_file <= data_stream_1;

						FIFO_write_to <= 1'b1;
                        reg_file_enable <= 1'b1;
                        reg_value       <= 3'd0;
            			end

					SCLK <= 1'b1;
					in4x_A1[5] <= MISO_A1; in4x_A2[5] <= MISO_A2;
					in4x_B1[5] <= MISO_B1; in4x_B2[5] <= MISO_B2;
					in4x_C1[5] <= MISO_C1; in4x_C2[5] <= MISO_C2;
					in4x_D1[5] <= MISO_D1; in4x_D2[5] <= MISO_D2;				
					in4x_E1[5] <= MISO_E1; in4x_E2[5] <= MISO_E2;
					in4x_F1[5] <= MISO_F1; in4x_F2[5] <= MISO_F2;
					in4x_G1[5] <= MISO_G1; in4x_G2[5] <= MISO_G2;
					in4x_H1[5] <= MISO_H1; in4x_H2[5] <= MISO_H2;
					main_state <= ms_clk3_a;
				end
				
				ms_clk3_a: begin
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_D;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_D;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_D;
					end

					if (data_stream_2_en == 1'b1) begin
						FIFO_data_in <= data_stream_2;
						FIFO_write_to <= 1'b1;
                        reg_file_enable <= 1'b1;
                        reg_value       <= 3'd1;
						data_in_dual_bank_reg_file <= data_stream_2;

					end

					MOSI_A <= MOSI_cmd_A[13];
					MOSI_B <= MOSI_cmd_B[13];
					MOSI_C <= MOSI_cmd_C[13];
					MOSI_D <= MOSI_cmd_D[13];
					MOSI_E <= MOSI_cmd_E[13];
					MOSI_F <= MOSI_cmd_F[13];
					MOSI_G <= MOSI_cmd_G[13];
					MOSI_H <= MOSI_cmd_H[13];
					in4x_A1[6] <= MISO_A1; in4x_A2[6] <= MISO_A2;
					in4x_B1[6] <= MISO_B1; in4x_B2[6] <= MISO_B2;
					in4x_C1[6] <= MISO_C1; in4x_C2[6] <= MISO_C2;
					in4x_D1[6] <= MISO_D1; in4x_D2[6] <= MISO_D2;				
					in4x_E1[6] <= MISO_E1; in4x_E2[6] <= MISO_E2;
					in4x_F1[6] <= MISO_F1; in4x_F2[6] <= MISO_F2;
					in4x_G1[6] <= MISO_G1; in4x_G2[6] <= MISO_G2;
					in4x_H1[6] <= MISO_H1; in4x_H2[6] <= MISO_H2;
					main_state <= ms_clk3_b;
				end

				ms_clk3_b: begin
					if (channel == 31) begin
						aux_cmd_D <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_D <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_D <= RAM_data_out_3;
					end
					if (data_stream_3_en == 1'b1) begin
						FIFO_data_in <= data_stream_3;
						FIFO_write_to <= 1'b1;
                        reg_file_enable <= 1'b1;
                        reg_value       <= 3'd2;
						data_in_dual_bank_reg_file <= data_stream_3;
					end

					in4x_A1[7] <= MISO_A1; in4x_A2[7] <= MISO_A2;
					in4x_B1[7] <= MISO_B1; in4x_B2[7] <= MISO_B2;
					in4x_C1[7] <= MISO_C1; in4x_C2[7] <= MISO_C2;
					in4x_D1[7] <= MISO_D1; in4x_D2[7] <= MISO_D2;	
					in4x_E1[7] <= MISO_E1; in4x_E2[7] <= MISO_E2;
					in4x_F1[7] <= MISO_F1; in4x_F2[7] <= MISO_F2;
					in4x_G1[7] <= MISO_G1; in4x_G2[7] <= MISO_G2;
					in4x_H1[7] <= MISO_H1; in4x_H2[7] <= MISO_H2;					
					main_state <= ms_clk3_c;
				end

				ms_clk3_c: begin
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_E;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_E;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_E;
					end
					if (data_stream_4_en == 1'b1) begin
						FIFO_data_in <= data_stream_4;
						FIFO_write_to <= 1'b1;
                        reg_file_enable <= 1'b1;
                        reg_value       <= 3'd2;
						data_in_dual_bank_reg_file <= data_stream_4;
						
					end

					SCLK <= 1'b1;
					in4x_A1[8] <= MISO_A1; in4x_A2[8] <= MISO_A2;
					in4x_B1[8] <= MISO_B1; in4x_B2[8] <= MISO_B2;
					in4x_C1[8] <= MISO_C1; in4x_C2[8] <= MISO_C2;
					in4x_D1[8] <= MISO_D1; in4x_D2[8] <= MISO_D2;					
					in4x_E1[8] <= MISO_E1; in4x_E2[8] <= MISO_E2;
					in4x_F1[8] <= MISO_F1; in4x_F2[8] <= MISO_F2;
					in4x_G1[8] <= MISO_G1; in4x_G2[8] <= MISO_G2;
					in4x_H1[8] <= MISO_H1; in4x_H2[8] <= MISO_H2;
					main_state <= ms_clk3_d;
				end
				
				ms_clk3_d: begin
					if (channel == 31) begin
						aux_cmd_E <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_E <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_E <= RAM_data_out_3;
					end
					if (data_stream_5_en == 1'b1) begin
						FIFO_data_in <= data_stream_5;
						FIFO_write_to <= 1'b1;
					end

					SCLK <= 1'b1;
					in4x_A1[9] <= MISO_A1; in4x_A2[9] <= MISO_A2;
					in4x_B1[9] <= MISO_B1; in4x_B2[9] <= MISO_B2;
					in4x_C1[9] <= MISO_C1; in4x_C2[9] <= MISO_C2;
					in4x_D1[9] <= MISO_D1; in4x_D2[9] <= MISO_D2;				
					in4x_E1[9] <= MISO_E1; in4x_E2[9] <= MISO_E2;
					in4x_F1[9] <= MISO_F1; in4x_F2[9] <= MISO_F2;
					in4x_G1[9] <= MISO_G1; in4x_G2[9] <= MISO_G2;
					in4x_H1[9] <= MISO_H1; in4x_H2[9] <= MISO_H2;
					main_state <= ms_clk4_a;
				end

				ms_clk4_a: begin
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_F;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_F;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_F;
					end
					if (data_stream_6_en == 1'b1) begin
						FIFO_data_in <= data_stream_6;
						FIFO_write_to <= 1'b1;
					end

					MOSI_A <= MOSI_cmd_A[12];
					MOSI_B <= MOSI_cmd_B[12];
					MOSI_C <= MOSI_cmd_C[12];
					MOSI_D <= MOSI_cmd_D[12];
					MOSI_E <= MOSI_cmd_E[12];
					MOSI_F <= MOSI_cmd_F[12];
					MOSI_G <= MOSI_cmd_G[12];
					MOSI_H <= MOSI_cmd_H[12];
					in4x_A1[10] <= MISO_A1; in4x_A2[10] <= MISO_A2;
					in4x_B1[10] <= MISO_B1; in4x_B2[10] <= MISO_B2;
					in4x_C1[10] <= MISO_C1; in4x_C2[10] <= MISO_C2;
					in4x_D1[10] <= MISO_D1; in4x_D2[10] <= MISO_D2;				
					in4x_E1[10] <= MISO_E1; in4x_E2[10] <= MISO_E2;
					in4x_F1[10] <= MISO_F1; in4x_F2[10] <= MISO_F2;
					in4x_G1[10] <= MISO_G1; in4x_G2[10] <= MISO_G2;
					in4x_H1[10] <= MISO_H1; in4x_H2[10] <= MISO_H2;	
					main_state <= ms_clk4_b;
				end

				ms_clk4_b: begin
					if (channel == 31) begin
						aux_cmd_F <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_F <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_F <= RAM_data_out_3;
					end
					if (data_stream_7_en == 1'b1) begin
						FIFO_data_in <= data_stream_7;
						FIFO_write_to <= 1'b1;
					end

					in4x_A1[11] <= MISO_A1; in4x_A2[11] <= MISO_A2;
					in4x_B1[11] <= MISO_B1; in4x_B2[11] <= MISO_B2;
					in4x_C1[11] <= MISO_C1; in4x_C2[11] <= MISO_C2;
					in4x_D1[11] <= MISO_D1; in4x_D2[11] <= MISO_D2;				
					in4x_E1[11] <= MISO_E1; in4x_E2[11] <= MISO_E2;
					in4x_F1[11] <= MISO_F1; in4x_F2[11] <= MISO_F2;
					in4x_G1[11] <= MISO_G1; in4x_G2[11] <= MISO_G2;
					in4x_H1[11] <= MISO_H1; in4x_H2[11] <= MISO_H2;
					main_state <= ms_clk4_c;
				end

				ms_clk4_c: begin
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_G;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_G;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_G;
					end
					if (data_stream_8_en == 1'b1) begin
						FIFO_data_in <= data_stream_8;
						FIFO_write_to <= 1'b1;
					end

					SCLK <= 1'b1;
					in4x_A1[12] <= MISO_A1; in4x_A2[12] <= MISO_A2;
					in4x_B1[12] <= MISO_B1; in4x_B2[12] <= MISO_B2;
					in4x_C1[12] <= MISO_C1; in4x_C2[12] <= MISO_C2;
					in4x_D1[12] <= MISO_D1; in4x_D2[12] <= MISO_D2;					
					in4x_E1[12] <= MISO_E1; in4x_E2[12] <= MISO_E2;
					in4x_F1[12] <= MISO_F1; in4x_F2[12] <= MISO_F2;
					in4x_G1[12] <= MISO_G1; in4x_G2[12] <= MISO_G2;
					in4x_H1[12] <= MISO_H1; in4x_H2[12] <= MISO_H2;
					main_state <= ms_clk4_d;
				end
				
				ms_clk4_d: begin
					if (channel == 31) begin
						aux_cmd_G <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_G <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_G <= RAM_data_out_3;
					end
					if (data_stream_9_en == 1'b1) begin
						FIFO_data_in <= data_stream_9;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[13] <= MISO_A1; in4x_A2[13] <= MISO_A2;
					in4x_B1[13] <= MISO_B1; in4x_B2[13] <= MISO_B2;
					in4x_C1[13] <= MISO_C1; in4x_C2[13] <= MISO_C2;
					in4x_D1[13] <= MISO_D1; in4x_D2[13] <= MISO_D2;				
					in4x_E1[13] <= MISO_E1; in4x_E2[13] <= MISO_E2;
					in4x_F1[13] <= MISO_F1; in4x_F2[13] <= MISO_F2;
					in4x_G1[13] <= MISO_G1; in4x_G2[13] <= MISO_G2;
					in4x_H1[13] <= MISO_H1; in4x_H2[13] <= MISO_H2;	
					main_state <= ms_clk5_a;
				end
				
				ms_clk5_a: begin
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_H;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_H;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_H;
					end
					if (data_stream_10_en == 1'b1) begin
						FIFO_data_in <= data_stream_10;
						FIFO_write_to <= 1'b1;
					end
					
					MOSI_A <= MOSI_cmd_A[11];
					MOSI_B <= MOSI_cmd_B[11];
					MOSI_C <= MOSI_cmd_C[11];
					MOSI_D <= MOSI_cmd_D[11];
					MOSI_E <= MOSI_cmd_E[11];
					MOSI_F <= MOSI_cmd_F[11];
					MOSI_G <= MOSI_cmd_G[11];
					MOSI_H <= MOSI_cmd_H[11];
					in4x_A1[14] <= MISO_A1; in4x_A2[14] <= MISO_A2;
					in4x_B1[14] <= MISO_B1; in4x_B2[14] <= MISO_B2;
					in4x_C1[14] <= MISO_C1; in4x_C2[14] <= MISO_C2;
					in4x_D1[14] <= MISO_D1; in4x_D2[14] <= MISO_D2;				
					in4x_E1[14] <= MISO_E1; in4x_E2[14] <= MISO_E2;
					in4x_F1[14] <= MISO_F1; in4x_F2[14] <= MISO_F2;
					in4x_G1[14] <= MISO_G1; in4x_G2[14] <= MISO_G2;
					in4x_H1[14] <= MISO_H1; in4x_H2[14] <= MISO_H2;
					main_state <= ms_clk5_b;
				end

				ms_clk5_b: begin
					if (channel == 31) begin
						aux_cmd_H <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_H <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_H <= RAM_data_out_3;
					end
					if (data_stream_11_en == 1'b1) begin
						FIFO_data_in <= data_stream_11;
						FIFO_write_to <= 1'b1;
					end
					
					in4x_A1[15] <= MISO_A1; in4x_A2[15] <= MISO_A2;
					in4x_B1[15] <= MISO_B1; in4x_B2[15] <= MISO_B2;
					in4x_C1[15] <= MISO_C1; in4x_C2[15] <= MISO_C2;
					in4x_D1[15] <= MISO_D1; in4x_D2[15] <= MISO_D2;				
					in4x_E1[15] <= MISO_E1; in4x_E2[15] <= MISO_E2;
					in4x_F1[15] <= MISO_F1; in4x_F2[15] <= MISO_F2;
					in4x_G1[15] <= MISO_G1; in4x_G2[15] <= MISO_G2;
					in4x_H1[15] <= MISO_H1; in4x_H2[15] <= MISO_H2;
					main_state <= ms_clk5_c;
				end

				ms_clk5_c: begin
					if (data_stream_12_en == 1'b1) begin
						FIFO_data_in <= data_stream_12;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[16] <= MISO_A1; in4x_A2[16] <= MISO_A2;
					in4x_B1[16] <= MISO_B1; in4x_B2[16] <= MISO_B2;
					in4x_C1[16] <= MISO_C1; in4x_C2[16] <= MISO_C2;
					in4x_D1[16] <= MISO_D1; in4x_D2[16] <= MISO_D2;					
					in4x_E1[16] <= MISO_E1; in4x_E2[16] <= MISO_E2;
					in4x_F1[16] <= MISO_F1; in4x_F2[16] <= MISO_F2;
					in4x_G1[16] <= MISO_G1; in4x_G2[16] <= MISO_G2;
					in4x_H1[16] <= MISO_H1; in4x_H2[16] <= MISO_H2;
					main_state <= ms_clk5_d;
				end
				
				ms_clk5_d: begin
					if (data_stream_13_en == 1'b1) begin
						FIFO_data_in <= data_stream_13;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[17] <= MISO_A1; in4x_A2[17] <= MISO_A2;
					in4x_B1[17] <= MISO_B1; in4x_B2[17] <= MISO_B2;
					in4x_C1[17] <= MISO_C1; in4x_C2[17] <= MISO_C2;
					in4x_D1[17] <= MISO_D1; in4x_D2[17] <= MISO_D2;				
					in4x_E1[17] <= MISO_E1; in4x_E2[17] <= MISO_E2;
					in4x_F1[17] <= MISO_F1; in4x_F2[17] <= MISO_F2;
					in4x_G1[17] <= MISO_G1; in4x_G2[17] <= MISO_G2;
					in4x_H1[17] <= MISO_H1; in4x_H2[17] <= MISO_H2;
					main_state <= ms_clk6_a;
				end
				
				ms_clk6_a: begin
					if (data_stream_14_en == 1'b1) begin
						FIFO_data_in <= data_stream_14;
						FIFO_write_to <= 1'b1;
					end
					
					MOSI_A <= MOSI_cmd_A[10];
					MOSI_B <= MOSI_cmd_B[10];
					MOSI_C <= MOSI_cmd_C[10];
					MOSI_D <= MOSI_cmd_D[10];
					MOSI_E <= MOSI_cmd_E[10];
					MOSI_F <= MOSI_cmd_F[10];
					MOSI_G <= MOSI_cmd_G[10];
					MOSI_H <= MOSI_cmd_H[10];
					in4x_A1[18] <= MISO_A1; in4x_A2[18] <= MISO_A2;
					in4x_B1[18] <= MISO_B1; in4x_B2[18] <= MISO_B2;
					in4x_C1[18] <= MISO_C1; in4x_C2[18] <= MISO_C2;
					in4x_D1[18] <= MISO_D1; in4x_D2[18] <= MISO_D2;
					in4x_E1[18] <= MISO_E1; in4x_E2[18] <= MISO_E2;
					in4x_F1[18] <= MISO_F1; in4x_F2[18] <= MISO_F2;
					in4x_G1[18] <= MISO_G1; in4x_G2[18] <= MISO_G2;
					in4x_H1[18] <= MISO_H1; in4x_H2[18] <= MISO_H2;					
					main_state <= ms_clk6_b;
				end

				ms_clk6_b: begin
					if (data_stream_15_en == 1'b1) begin
						FIFO_data_in <= data_stream_15;
						FIFO_write_to <= 1'b1;
					end
					
					in4x_A1[19] <= MISO_A1; in4x_A2[19] <= MISO_A2;
					in4x_B1[19] <= MISO_B1; in4x_B2[19] <= MISO_B2;
					in4x_C1[19] <= MISO_C1; in4x_C2[19] <= MISO_C2;
					in4x_D1[19] <= MISO_D1; in4x_D2[19] <= MISO_D2;	
					in4x_E1[19] <= MISO_E1; in4x_E2[19] <= MISO_E2;
					in4x_F1[19] <= MISO_F1; in4x_F2[19] <= MISO_F2;
					in4x_G1[19] <= MISO_G1; in4x_G2[19] <= MISO_G2;
					in4x_H1[19] <= MISO_H1; in4x_H2[19] <= MISO_H2;						
					main_state <= ms_clk6_c;
				end

				ms_clk6_c: begin
					if (data_stream_16_en == 1'b1) begin
						FIFO_data_in <= data_stream_16;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[20] <= MISO_A1; in4x_A2[20] <= MISO_A2;
					in4x_B1[20] <= MISO_B1; in4x_B2[20] <= MISO_B2;
					in4x_C1[20] <= MISO_C1; in4x_C2[20] <= MISO_C2;
					in4x_D1[20] <= MISO_D1; in4x_D2[20] <= MISO_D2;	
					in4x_E1[20] <= MISO_E1; in4x_E2[20] <= MISO_E2;
					in4x_F1[20] <= MISO_F1; in4x_F2[20] <= MISO_F2;
					in4x_G1[20] <= MISO_G1; in4x_G2[20] <= MISO_G2;
					in4x_H1[20] <= MISO_H1; in4x_H2[20] <= MISO_H2;					
					main_state <= ms_clk6_d;
				end
				
				ms_clk6_d: begin
					if (data_stream_17_en == 1'b1) begin
						FIFO_data_in <= data_stream_17;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[21] <= MISO_A1; in4x_A2[21] <= MISO_A2;
					in4x_B1[21] <= MISO_B1; in4x_B2[21] <= MISO_B2;
					in4x_C1[21] <= MISO_C1; in4x_C2[21] <= MISO_C2;
					in4x_D1[21] <= MISO_D1; in4x_D2[21] <= MISO_D2;	
					in4x_E1[21] <= MISO_E1; in4x_E2[21] <= MISO_E2;
					in4x_F1[21] <= MISO_F1; in4x_F2[21] <= MISO_F2;
					in4x_G1[21] <= MISO_G1; in4x_G2[21] <= MISO_G2;
					in4x_H1[21] <= MISO_H1; in4x_H2[21] <= MISO_H2;					
					main_state <= ms_clk7_a;
				end
				
				ms_clk7_a: begin
					if (data_stream_18_en == 1'b1) begin
						FIFO_data_in <= data_stream_18;
						FIFO_write_to <= 1'b1;
					end
					
					MOSI_A <= MOSI_cmd_A[9];
					MOSI_B <= MOSI_cmd_B[9];
					MOSI_C <= MOSI_cmd_C[9];
					MOSI_D <= MOSI_cmd_D[9];
					MOSI_E <= MOSI_cmd_E[9];
					MOSI_F <= MOSI_cmd_F[9];
					MOSI_G <= MOSI_cmd_G[9];
					MOSI_H <= MOSI_cmd_H[9];
					in4x_A1[22] <= MISO_A1; in4x_A2[22] <= MISO_A2;
					in4x_B1[22] <= MISO_B1; in4x_B2[22] <= MISO_B2;
					in4x_C1[22] <= MISO_C1; in4x_C2[22] <= MISO_C2;
					in4x_D1[22] <= MISO_D1; in4x_D2[22] <= MISO_D2;	
					in4x_E1[22] <= MISO_E1; in4x_E2[22] <= MISO_E2;
					in4x_F1[22] <= MISO_F1; in4x_F2[22] <= MISO_F2;
					in4x_G1[22] <= MISO_G1; in4x_G2[22] <= MISO_G2;
					in4x_H1[22] <= MISO_H1; in4x_H2[22] <= MISO_H2;					
					main_state <= ms_clk7_b;
				end

				ms_clk7_b: begin
					if (data_stream_19_en == 1'b1) begin
						FIFO_data_in <= data_stream_19;
						FIFO_write_to <= 1'b1;
					end
					
					in4x_A1[23] <= MISO_A1; in4x_A2[23] <= MISO_A2;
					in4x_B1[23] <= MISO_B1; in4x_B2[23] <= MISO_B2;
					in4x_C1[23] <= MISO_C1; in4x_C2[23] <= MISO_C2;
					in4x_D1[23] <= MISO_D1; in4x_D2[23] <= MISO_D2;
					in4x_E1[23] <= MISO_E1; in4x_E2[23] <= MISO_E2;
					in4x_F1[23] <= MISO_F1; in4x_F2[23] <= MISO_F2;
					in4x_G1[23] <= MISO_G1; in4x_G2[23] <= MISO_G2;
					in4x_H1[23] <= MISO_H1; in4x_H2[23] <= MISO_H2;					
					main_state <= ms_clk7_c;
				end

				ms_clk7_c: begin
					if (data_stream_20_en == 1'b1) begin
						FIFO_data_in <= data_stream_20;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[24] <= MISO_A1; in4x_A2[24] <= MISO_A2;
					in4x_B1[24] <= MISO_B1; in4x_B2[24] <= MISO_B2;
					in4x_C1[24] <= MISO_C1; in4x_C2[24] <= MISO_C2;
					in4x_D1[24] <= MISO_D1; in4x_D2[24] <= MISO_D2;
					in4x_E1[24] <= MISO_E1; in4x_E2[24] <= MISO_E2;
					in4x_F1[24] <= MISO_F1; in4x_F2[24] <= MISO_F2;
					in4x_G1[24] <= MISO_G1; in4x_G2[24] <= MISO_G2;
					in4x_H1[24] <= MISO_H1; in4x_H2[24] <= MISO_H2;					
					main_state <= ms_clk7_d;
				end
				
				ms_clk7_d: begin
					if (data_stream_21_en == 1'b1) begin
						FIFO_data_in <= data_stream_21;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[25] <= MISO_A1; in4x_A2[25] <= MISO_A2;
					in4x_B1[25] <= MISO_B1; in4x_B2[25] <= MISO_B2;
					in4x_C1[25] <= MISO_C1; in4x_C2[25] <= MISO_C2;
					in4x_D1[25] <= MISO_D1; in4x_D2[25] <= MISO_D2;	
					in4x_E1[25] <= MISO_E1; in4x_E2[25] <= MISO_E2;
					in4x_F1[25] <= MISO_F1; in4x_F2[25] <= MISO_F2;
					in4x_G1[25] <= MISO_G1; in4x_G2[25] <= MISO_G2;
					in4x_H1[25] <= MISO_H1; in4x_H2[25] <= MISO_H2;					
					main_state <= ms_clk8_a;
				end

				ms_clk8_a: begin
					if (data_stream_22_en == 1'b1) begin
						FIFO_data_in <= data_stream_22;
						FIFO_write_to <= 1'b1;
					end
					
					MOSI_A <= MOSI_cmd_A[8];
					MOSI_B <= MOSI_cmd_B[8];
					MOSI_C <= MOSI_cmd_C[8];
					MOSI_D <= MOSI_cmd_D[8];
					MOSI_E <= MOSI_cmd_E[8];
					MOSI_F <= MOSI_cmd_F[8];
					MOSI_G <= MOSI_cmd_G[8];
					MOSI_H <= MOSI_cmd_H[8];
					in4x_A1[26] <= MISO_A1; in4x_A2[26] <= MISO_A2;
					in4x_B1[26] <= MISO_B1; in4x_B2[26] <= MISO_B2;
					in4x_C1[26] <= MISO_C1; in4x_C2[26] <= MISO_C2;
					in4x_D1[26] <= MISO_D1; in4x_D2[26] <= MISO_D2;	
					in4x_E1[26] <= MISO_E1; in4x_E2[26] <= MISO_E2;
					in4x_F1[26] <= MISO_F1; in4x_F2[26] <= MISO_F2;
					in4x_G1[26] <= MISO_G1; in4x_G2[26] <= MISO_G2;
					in4x_H1[26] <= MISO_H1; in4x_H2[26] <= MISO_H2;					
					main_state <= ms_clk8_b;
				end

				ms_clk8_b: begin
					if (data_stream_23_en == 1'b1) begin
						FIFO_data_in <= data_stream_23;
						FIFO_write_to <= 1'b1;
					end
					
					in4x_A1[27] <= MISO_A1; in4x_A2[27] <= MISO_A2;
					in4x_B1[27] <= MISO_B1; in4x_B2[27] <= MISO_B2;
					in4x_C1[27] <= MISO_C1; in4x_C2[27] <= MISO_C2;
					in4x_D1[27] <= MISO_D1; in4x_D2[27] <= MISO_D2;	
					in4x_E1[27] <= MISO_E1; in4x_E2[27] <= MISO_E2;
					in4x_F1[27] <= MISO_F1; in4x_F2[27] <= MISO_F2;
					in4x_G1[27] <= MISO_G1; in4x_G2[27] <= MISO_G2;
					in4x_H1[27] <= MISO_H1; in4x_H2[27] <= MISO_H2;					
					main_state <= ms_clk8_c;
				end

				ms_clk8_c: begin
					if (data_stream_24_en == 1'b1) begin
						FIFO_data_in <= data_stream_24;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[28] <= MISO_A1; in4x_A2[28] <= MISO_A2;
					in4x_B1[28] <= MISO_B1; in4x_B2[28] <= MISO_B2;
					in4x_C1[28] <= MISO_C1; in4x_C2[28] <= MISO_C2;
					in4x_D1[28] <= MISO_D1; in4x_D2[28] <= MISO_D2;	
					in4x_E1[28] <= MISO_E1; in4x_E2[28] <= MISO_E2;
					in4x_F1[28] <= MISO_F1; in4x_F2[28] <= MISO_F2;
					in4x_G1[28] <= MISO_G1; in4x_G2[28] <= MISO_G2;
					in4x_H1[28] <= MISO_H1; in4x_H2[28] <= MISO_H2;						
					main_state <= ms_clk8_d;
				end
				
				ms_clk8_d: begin
					if (data_stream_25_en == 1'b1) begin
						FIFO_data_in <= data_stream_25;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[29] <= MISO_A1; in4x_A2[29] <= MISO_A2;
					in4x_B1[29] <= MISO_B1; in4x_B2[29] <= MISO_B2;
					in4x_C1[29] <= MISO_C1; in4x_C2[29] <= MISO_C2;
					in4x_D1[29] <= MISO_D1; in4x_D2[29] <= MISO_D2;	
					in4x_E1[29] <= MISO_E1; in4x_E2[29] <= MISO_E2;
					in4x_F1[29] <= MISO_F1; in4x_F2[29] <= MISO_F2;
					in4x_G1[29] <= MISO_G1; in4x_G2[29] <= MISO_G2;
					in4x_H1[29] <= MISO_H1; in4x_H2[29] <= MISO_H2;						
					main_state <= ms_clk9_a;
				end

				ms_clk9_a: begin
					if (data_stream_26_en == 1'b1) begin
						FIFO_data_in <= data_stream_26;
						FIFO_write_to <= 1'b1;
					end
					
					MOSI_A <= MOSI_cmd_A[7];
					MOSI_B <= MOSI_cmd_B[7];
					MOSI_C <= MOSI_cmd_C[7];
					MOSI_D <= MOSI_cmd_D[7];
					MOSI_E <= MOSI_cmd_E[7];
					MOSI_F <= MOSI_cmd_F[7];
					MOSI_G <= MOSI_cmd_G[7];
					MOSI_H <= MOSI_cmd_H[7];
					in4x_A1[30] <= MISO_A1; in4x_A2[30] <= MISO_A2;
					in4x_B1[30] <= MISO_B1; in4x_B2[30] <= MISO_B2;
					in4x_C1[30] <= MISO_C1; in4x_C2[30] <= MISO_C2;
					in4x_D1[30] <= MISO_D1; in4x_D2[30] <= MISO_D2;	
					in4x_E1[30] <= MISO_E1; in4x_E2[30] <= MISO_E2;
					in4x_F1[30] <= MISO_F1; in4x_F2[30] <= MISO_F2;
					in4x_G1[30] <= MISO_G1; in4x_G2[30] <= MISO_G2;
					in4x_H1[30] <= MISO_H1; in4x_H2[30] <= MISO_H2;						
					main_state <= ms_clk9_b;
				end

				ms_clk9_b: begin
					if (data_stream_27_en == 1'b1) begin
						FIFO_data_in <= data_stream_27;
						FIFO_write_to <= 1'b1;
					end
					
					in4x_A1[31] <= MISO_A1; in4x_A2[31] <= MISO_A2;
					in4x_B1[31] <= MISO_B1; in4x_B2[31] <= MISO_B2;
					in4x_C1[31] <= MISO_C1; in4x_C2[31] <= MISO_C2;
					in4x_D1[31] <= MISO_D1; in4x_D2[31] <= MISO_D2;	
					in4x_E1[31] <= MISO_E1; in4x_E2[31] <= MISO_E2;
					in4x_F1[31] <= MISO_F1; in4x_F2[31] <= MISO_F2;
					in4x_G1[31] <= MISO_G1; in4x_G2[31] <= MISO_G2;
					in4x_H1[31] <= MISO_H1; in4x_H2[31] <= MISO_H2;					
					main_state <= ms_clk9_c;
				end

				ms_clk9_c: begin
					if (data_stream_28_en == 1'b1) begin
						FIFO_data_in <= data_stream_28;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[32] <= MISO_A1; in4x_A2[32] <= MISO_A2;
					in4x_B1[32] <= MISO_B1; in4x_B2[32] <= MISO_B2;
					in4x_C1[32] <= MISO_C1; in4x_C2[32] <= MISO_C2;
					in4x_D1[32] <= MISO_D1; in4x_D2[32] <= MISO_D2;					
					in4x_E1[32] <= MISO_E1; in4x_E2[32] <= MISO_E2;
					in4x_F1[32] <= MISO_F1; in4x_F2[32] <= MISO_F2;
					in4x_G1[32] <= MISO_G1; in4x_G2[32] <= MISO_G2;
					in4x_H1[32] <= MISO_H1; in4x_H2[32] <= MISO_H2;
					main_state <= ms_clk9_d;
				end
				
				ms_clk9_d: begin
					if (data_stream_29_en == 1'b1) begin
						FIFO_data_in <= data_stream_29;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[33] <= MISO_A1; in4x_A2[33] <= MISO_A2;
					in4x_B1[33] <= MISO_B1; in4x_B2[33] <= MISO_B2;
					in4x_C1[33] <= MISO_C1; in4x_C2[33] <= MISO_C2;
					in4x_D1[33] <= MISO_D1; in4x_D2[33] <= MISO_D2;	
					in4x_E1[33] <= MISO_E1; in4x_E2[33] <= MISO_E2;
					in4x_F1[33] <= MISO_F1; in4x_F2[33] <= MISO_F2;
					in4x_G1[33] <= MISO_G1; in4x_G2[33] <= MISO_G2;
					in4x_H1[33] <= MISO_H1; in4x_H2[33] <= MISO_H2;						
					main_state <= ms_clk10_a;
				end

				ms_clk10_a: begin
					if (data_stream_30_en == 1'b1) begin
						FIFO_data_in <= data_stream_30;
						FIFO_write_to <= 1'b1;
					end
					
					MOSI_A <= MOSI_cmd_A[6];
					MOSI_B <= MOSI_cmd_B[6];
					MOSI_C <= MOSI_cmd_C[6];
					MOSI_D <= MOSI_cmd_D[6];
					MOSI_E <= MOSI_cmd_E[6];
					MOSI_F <= MOSI_cmd_F[6];
					MOSI_G <= MOSI_cmd_G[6];
					MOSI_H <= MOSI_cmd_H[6];
					in4x_A1[34] <= MISO_A1; in4x_A2[34] <= MISO_A2;
					in4x_B1[34] <= MISO_B1; in4x_B2[34] <= MISO_B2;
					in4x_C1[34] <= MISO_C1; in4x_C2[34] <= MISO_C2;
					in4x_D1[34] <= MISO_D1; in4x_D2[34] <= MISO_D2;			
					in4x_E1[34] <= MISO_E1; in4x_E2[34] <= MISO_E2;
					in4x_F1[34] <= MISO_F1; in4x_F2[34] <= MISO_F2;
					in4x_G1[34] <= MISO_G1; in4x_G2[34] <= MISO_G2;
					in4x_H1[34] <= MISO_H1; in4x_H2[34] <= MISO_H2;					
					main_state <= ms_clk10_b;
				end

				ms_clk10_b: begin
					if (data_stream_31_en == 1'b1) begin
						FIFO_data_in <= data_stream_31;
						FIFO_write_to <= 1'b1;
					end
					
					in4x_A1[35] <= MISO_A1; in4x_A2[35] <= MISO_A2;
					in4x_B1[35] <= MISO_B1; in4x_B2[35] <= MISO_B2;
					in4x_C1[35] <= MISO_C1; in4x_C2[35] <= MISO_C2;
					in4x_D1[35] <= MISO_D1; in4x_D2[35] <= MISO_D2;		
					in4x_E1[35] <= MISO_E1; in4x_E2[35] <= MISO_E2;
					in4x_F1[35] <= MISO_F1; in4x_F2[35] <= MISO_F2;
					in4x_G1[35] <= MISO_G1; in4x_G2[35] <= MISO_G2;
					in4x_H1[35] <= MISO_H1; in4x_H2[35] <= MISO_H2;						
					main_state <= ms_clk10_c;
				end

				ms_clk10_c: begin
					if (data_stream_32_en == 1'b1) begin
						FIFO_data_in <= data_stream_32;
						FIFO_write_to <= 1'b1;
					end
					
					SCLK <= 1'b1;
					in4x_A1[36] <= MISO_A1; in4x_A2[36] <= MISO_A2;
					in4x_B1[36] <= MISO_B1; in4x_B2[36] <= MISO_B2;
					in4x_C1[36] <= MISO_C1; in4x_C2[36] <= MISO_C2;
					in4x_D1[36] <= MISO_D1; in4x_D2[36] <= MISO_D2;					
					in4x_E1[36] <= MISO_E1; in4x_E2[36] <= MISO_E2;
					in4x_F1[36] <= MISO_F1; in4x_F2[36] <= MISO_F2;
					in4x_G1[36] <= MISO_G1; in4x_G2[36] <= MISO_G2;
					in4x_H1[36] <= MISO_H1; in4x_H2[36] <= MISO_H2;
					main_state <= ms_clk10_d;
				end
				
				ms_clk10_d: begin
					SCLK <= 1'b1;
					in4x_A1[37] <= MISO_A1; in4x_A2[37] <= MISO_A2;
					in4x_B1[37] <= MISO_B1; in4x_B2[37] <= MISO_B2;
					in4x_C1[37] <= MISO_C1; in4x_C2[37] <= MISO_C2;
					in4x_D1[37] <= MISO_D1; in4x_D2[37] <= MISO_D2;				
					in4x_E1[37] <= MISO_E1; in4x_E2[37] <= MISO_E2;
					in4x_F1[37] <= MISO_F1; in4x_F2[37] <= MISO_F2;
					in4x_G1[37] <= MISO_G1; in4x_G2[37] <= MISO_G2;
					in4x_H1[37] <= MISO_H1; in4x_H2[37] <= MISO_H2;
					main_state <= ms_clk11_a;
				end

				ms_clk11_a: begin
					MOSI_A <= MOSI_cmd_A[5];
					MOSI_B <= MOSI_cmd_B[5];
					MOSI_C <= MOSI_cmd_C[5];
					MOSI_D <= MOSI_cmd_D[5];
					MOSI_E <= MOSI_cmd_E[5];
					MOSI_F <= MOSI_cmd_F[5];
					MOSI_G <= MOSI_cmd_G[5];
					MOSI_H <= MOSI_cmd_H[5];
					in4x_A1[38] <= MISO_A1; in4x_A2[38] <= MISO_A2;
					in4x_B1[38] <= MISO_B1; in4x_B2[38] <= MISO_B2;
					in4x_C1[38] <= MISO_C1; in4x_C2[38] <= MISO_C2;
					in4x_D1[38] <= MISO_D1; in4x_D2[38] <= MISO_D2;				
					in4x_E1[38] <= MISO_E1; in4x_E2[38] <= MISO_E2;
					in4x_F1[38] <= MISO_F1; in4x_F2[38] <= MISO_F2;
					in4x_G1[38] <= MISO_G1; in4x_G2[38] <= MISO_G2;
					in4x_H1[38] <= MISO_H1; in4x_H2[38] <= MISO_H2;
					main_state <= ms_clk11_b;
				end

				ms_clk11_b: begin
					in4x_A1[39] <= MISO_A1; in4x_A2[39] <= MISO_A2;
					in4x_B1[39] <= MISO_B1; in4x_B2[39] <= MISO_B2;
					in4x_C1[39] <= MISO_C1; in4x_C2[39] <= MISO_C2;
					in4x_D1[39] <= MISO_D1; in4x_D2[39] <= MISO_D2;				
					in4x_E1[39] <= MISO_E1; in4x_E2[39] <= MISO_E2;
					in4x_F1[39] <= MISO_F1; in4x_F2[39] <= MISO_F2;
					in4x_G1[39] <= MISO_G1; in4x_G2[39] <= MISO_G2;
					in4x_H1[39] <= MISO_H1; in4x_H2[39] <= MISO_H2;
					main_state <= ms_clk11_c;
				end

				ms_clk11_c: begin
					SCLK <= 1'b1;
					in4x_A1[40] <= MISO_A1; in4x_A2[40] <= MISO_A2;
					in4x_B1[40] <= MISO_B1; in4x_B2[40] <= MISO_B2;
					in4x_C1[40] <= MISO_C1; in4x_C2[40] <= MISO_C2;
					in4x_D1[40] <= MISO_D1; in4x_D2[40] <= MISO_D2;					
					in4x_E1[40] <= MISO_E1; in4x_E2[40] <= MISO_E2;
					in4x_F1[40] <= MISO_F1; in4x_F2[40] <= MISO_F2;
					in4x_G1[40] <= MISO_G1; in4x_G2[40] <= MISO_G2;
					in4x_H1[40] <= MISO_H1; in4x_H2[40] <= MISO_H2;	
					main_state <= ms_clk11_d;
				end
				
				ms_clk11_d: begin
					SCLK <= 1'b1;
					in4x_A1[41] <= MISO_A1; in4x_A2[41] <= MISO_A2;
					in4x_B1[41] <= MISO_B1; in4x_B2[41] <= MISO_B2;
					in4x_C1[41] <= MISO_C1; in4x_C2[41] <= MISO_C2;
					in4x_D1[41] <= MISO_D1; in4x_D2[41] <= MISO_D2;	
					in4x_E1[41] <= MISO_E1; in4x_E2[41] <= MISO_E2;
					in4x_F1[41] <= MISO_F1; in4x_F2[41] <= MISO_F2;
					in4x_G1[41] <= MISO_G1; in4x_G2[41] <= MISO_G2;
					in4x_H1[41] <= MISO_H1; in4x_H2[41] <= MISO_H2;					
					main_state <= ms_clk12_a;
				end

				ms_clk12_a: begin
					MOSI_A <= MOSI_cmd_A[4];
					MOSI_B <= MOSI_cmd_B[4];
					MOSI_C <= MOSI_cmd_C[4];
					MOSI_D <= MOSI_cmd_D[4];
					MOSI_E <= MOSI_cmd_E[4];
					MOSI_F <= MOSI_cmd_F[4];
					MOSI_G <= MOSI_cmd_G[4];
					MOSI_H <= MOSI_cmd_H[4];
					in4x_A1[42] <= MISO_A1; in4x_A2[42] <= MISO_A2;
					in4x_B1[42] <= MISO_B1; in4x_B2[42] <= MISO_B2;
					in4x_C1[42] <= MISO_C1; in4x_C2[42] <= MISO_C2;
					in4x_D1[42] <= MISO_D1; in4x_D2[42] <= MISO_D2;				
					in4x_E1[42] <= MISO_E1; in4x_E2[42] <= MISO_E2;
					in4x_F1[42] <= MISO_F1; in4x_F2[42] <= MISO_F2;
					in4x_G1[42] <= MISO_G1; in4x_G2[42] <= MISO_G2;
					in4x_H1[42] <= MISO_H1; in4x_H2[42] <= MISO_H2;
					main_state <= ms_clk12_b;
				end

				ms_clk12_b: begin
					in4x_A1[43] <= MISO_A1; in4x_A2[43] <= MISO_A2;
					in4x_B1[43] <= MISO_B1; in4x_B2[43] <= MISO_B2;
					in4x_C1[43] <= MISO_C1; in4x_C2[43] <= MISO_C2;
					in4x_D1[43] <= MISO_D1; in4x_D2[43] <= MISO_D2;	
					in4x_E1[43] <= MISO_E1; in4x_E2[43] <= MISO_E2;
					in4x_F1[43] <= MISO_F1; in4x_F2[43] <= MISO_F2;
					in4x_G1[43] <= MISO_G1; in4x_G2[43] <= MISO_G2;
					in4x_H1[43] <= MISO_H1; in4x_H2[43] <= MISO_H2;						
					main_state <= ms_clk12_c;
				end

				ms_clk12_c: begin
					SCLK <= 1'b1;
					in4x_A1[44] <= MISO_A1; in4x_A2[44] <= MISO_A2;
					in4x_B1[44] <= MISO_B1; in4x_B2[44] <= MISO_B2;
					in4x_C1[44] <= MISO_C1; in4x_C2[44] <= MISO_C2;
					in4x_D1[44] <= MISO_D1; in4x_D2[44] <= MISO_D2;	
					in4x_E1[44] <= MISO_E1; in4x_E2[44] <= MISO_E2;
					in4x_F1[44] <= MISO_F1; in4x_F2[44] <= MISO_F2;
					in4x_G1[44] <= MISO_G1; in4x_G2[44] <= MISO_G2;
					in4x_H1[44] <= MISO_H1; in4x_H2[44] <= MISO_H2;					
					main_state <= ms_clk12_d;
				end
				
				ms_clk12_d: begin
					SCLK <= 1'b1;
					in4x_A1[45] <= MISO_A1; in4x_A2[45] <= MISO_A2;
					in4x_B1[45] <= MISO_B1; in4x_B2[45] <= MISO_B2;
					in4x_C1[45] <= MISO_C1; in4x_C2[45] <= MISO_C2;
					in4x_D1[45] <= MISO_D1; in4x_D2[45] <= MISO_D2;				
					in4x_E1[45] <= MISO_E1; in4x_E2[45] <= MISO_E2;
					in4x_F1[45] <= MISO_F1; in4x_F2[45] <= MISO_F2;
					in4x_G1[45] <= MISO_G1; in4x_G2[45] <= MISO_G2;
					in4x_H1[45] <= MISO_H1; in4x_H2[45] <= MISO_H2;
					main_state <= ms_clk13_a;
				end

				ms_clk13_a: begin
					MOSI_A <= MOSI_cmd_A[3];
					MOSI_B <= MOSI_cmd_B[3];
					MOSI_C <= MOSI_cmd_C[3];
					MOSI_D <= MOSI_cmd_D[3];
					MOSI_E <= MOSI_cmd_E[3];
					MOSI_F <= MOSI_cmd_F[3];
					MOSI_G <= MOSI_cmd_G[3];
					MOSI_H <= MOSI_cmd_H[3];
					in4x_A1[46] <= MISO_A1; in4x_A2[46] <= MISO_A2;
					in4x_B1[46] <= MISO_B1; in4x_B2[46] <= MISO_B2;
					in4x_C1[46] <= MISO_C1; in4x_C2[46] <= MISO_C2;
					in4x_D1[46] <= MISO_D1; in4x_D2[46] <= MISO_D2;	
					in4x_E1[46] <= MISO_E1; in4x_E2[46] <= MISO_E2;
					in4x_F1[46] <= MISO_F1; in4x_F2[46] <= MISO_F2;
					in4x_G1[46] <= MISO_G1; in4x_G2[46] <= MISO_G2;
					in4x_H1[46] <= MISO_H1; in4x_H2[46] <= MISO_H2;					
					main_state <= ms_clk13_b;
				end

				ms_clk13_b: begin
					in4x_A1[47] <= MISO_A1; in4x_A2[47] <= MISO_A2;
					in4x_B1[47] <= MISO_B1; in4x_B2[47] <= MISO_B2;
					in4x_C1[47] <= MISO_C1; in4x_C2[47] <= MISO_C2;
					in4x_D1[47] <= MISO_D1; in4x_D2[47] <= MISO_D2;				
					in4x_E1[47] <= MISO_E1; in4x_E2[47] <= MISO_E2;
					in4x_F1[47] <= MISO_F1; in4x_F2[47] <= MISO_F2;
					in4x_G1[47] <= MISO_G1; in4x_G2[47] <= MISO_G2;
					in4x_H1[47] <= MISO_H1; in4x_H2[47] <= MISO_H2;	
					main_state <= ms_clk13_c;
				end

				ms_clk13_c: begin
					SCLK <= 1'b1;
					in4x_A1[48] <= MISO_A1; in4x_A2[48] <= MISO_A2;
					in4x_B1[48] <= MISO_B1; in4x_B2[48] <= MISO_B2;
					in4x_C1[48] <= MISO_C1; in4x_C2[48] <= MISO_C2;
					in4x_D1[48] <= MISO_D1; in4x_D2[48] <= MISO_D2;					
					in4x_E1[48] <= MISO_E1; in4x_E2[48] <= MISO_E2;
					in4x_F1[48] <= MISO_F1; in4x_F2[48] <= MISO_F2;
					in4x_G1[48] <= MISO_G1; in4x_G2[48] <= MISO_G2;
					in4x_H1[48] <= MISO_H1; in4x_H2[48] <= MISO_H2;
					main_state <= ms_clk13_d;
				end
				
				ms_clk13_d: begin
					SCLK <= 1'b1;
					in4x_A1[49] <= MISO_A1; in4x_A2[49] <= MISO_A2;
					in4x_B1[49] <= MISO_B1; in4x_B2[49] <= MISO_B2;
					in4x_C1[49] <= MISO_C1; in4x_C2[49] <= MISO_C2;
					in4x_D1[49] <= MISO_D1; in4x_D2[49] <= MISO_D2;	
					in4x_E1[49] <= MISO_E1; in4x_E2[49] <= MISO_E2;
					in4x_F1[49] <= MISO_F1; in4x_F2[49] <= MISO_F2;
					in4x_G1[49] <= MISO_G1; in4x_G2[49] <= MISO_G2;
					in4x_H1[49] <= MISO_H1; in4x_H2[49] <= MISO_H2;					
					main_state <= ms_clk14_a;
				end

				ms_clk14_a: begin
					MOSI_A <= MOSI_cmd_A[2];
					MOSI_B <= MOSI_cmd_B[2];
					MOSI_C <= MOSI_cmd_C[2];
					MOSI_D <= MOSI_cmd_D[2];
					MOSI_E <= MOSI_cmd_E[2];
					MOSI_F <= MOSI_cmd_F[2];
					MOSI_G <= MOSI_cmd_G[2];
					MOSI_H <= MOSI_cmd_H[2];
					in4x_A1[50] <= MISO_A1; in4x_A2[50] <= MISO_A2;
					in4x_B1[50] <= MISO_B1; in4x_B2[50] <= MISO_B2;
					in4x_C1[50] <= MISO_C1; in4x_C2[50] <= MISO_C2;
					in4x_D1[50] <= MISO_D1; in4x_D2[50] <= MISO_D2;		
					in4x_E1[50] <= MISO_E1; in4x_E2[50] <= MISO_E2;
					in4x_F1[50] <= MISO_F1; in4x_F2[50] <= MISO_F2;
					in4x_G1[50] <= MISO_G1; in4x_G2[50] <= MISO_G2;
					in4x_H1[50] <= MISO_H1; in4x_H2[50] <= MISO_H2;						
					main_state <= ms_clk14_b;
				end

				ms_clk14_b: begin
					in4x_A1[51] <= MISO_A1; in4x_A2[51] <= MISO_A2;
					in4x_B1[51] <= MISO_B1; in4x_B2[51] <= MISO_B2;
					in4x_C1[51] <= MISO_C1; in4x_C2[51] <= MISO_C2;
					in4x_D1[51] <= MISO_D1; in4x_D2[51] <= MISO_D2;		
					in4x_E1[51] <= MISO_E1; in4x_E2[51] <= MISO_E2;
					in4x_F1[51] <= MISO_F1; in4x_F2[51] <= MISO_F2;
					in4x_G1[51] <= MISO_G1; in4x_G2[51] <= MISO_G2;
					in4x_H1[51] <= MISO_H1; in4x_H2[51] <= MISO_H2;						
					main_state <= ms_clk14_c;
				end

				ms_clk14_c: begin
					SCLK <= 1'b1;
					in4x_A1[52] <= MISO_A1; in4x_A2[52] <= MISO_A2;
					in4x_B1[52] <= MISO_B1; in4x_B2[52] <= MISO_B2;
					in4x_C1[52] <= MISO_C1; in4x_C2[52] <= MISO_C2;
					in4x_D1[52] <= MISO_D1; in4x_D2[52] <= MISO_D2;	
					in4x_E1[52] <= MISO_E1; in4x_E2[52] <= MISO_E2;
					in4x_F1[52] <= MISO_F1; in4x_F2[52] <= MISO_F2;
					in4x_G1[52] <= MISO_G1; in4x_G2[52] <= MISO_G2;
					in4x_H1[52] <= MISO_H1; in4x_H2[52] <= MISO_H2;						
					main_state <= ms_clk14_d;
				end
				
				ms_clk14_d: begin	
					SCLK <= 1'b1;
					in4x_A1[53] <= MISO_A1; in4x_A2[53] <= MISO_A2;
					in4x_B1[53] <= MISO_B1; in4x_B2[53] <= MISO_B2;
					in4x_C1[53] <= MISO_C1; in4x_C2[53] <= MISO_C2;
					in4x_D1[53] <= MISO_D1; in4x_D2[53] <= MISO_D2;
					in4x_E1[53] <= MISO_E1; in4x_E2[53] <= MISO_E2;
					in4x_F1[53] <= MISO_F1; in4x_F2[53] <= MISO_F2;
					in4x_G1[53] <= MISO_G1; in4x_G2[53] <= MISO_G2;
					in4x_H1[53] <= MISO_H1; in4x_H2[53] <= MISO_H2;					
					main_state <= ms_clk15_a;
				end

				ms_clk15_a: begin
					MOSI_A <= MOSI_cmd_A[1];
					MOSI_B <= MOSI_cmd_B[1];
					MOSI_C <= MOSI_cmd_C[1];
					MOSI_D <= MOSI_cmd_D[1];
					MOSI_E <= MOSI_cmd_E[1];
					MOSI_F <= MOSI_cmd_F[1];
					MOSI_G <= MOSI_cmd_G[1];
					MOSI_H <= MOSI_cmd_H[1];
					in4x_A1[54] <= MISO_A1; in4x_A2[54] <= MISO_A2;
					in4x_B1[54] <= MISO_B1; in4x_B2[54] <= MISO_B2;
					in4x_C1[54] <= MISO_C1; in4x_C2[54] <= MISO_C2;
					in4x_D1[54] <= MISO_D1; in4x_D2[54] <= MISO_D2;
					in4x_E1[54] <= MISO_E1; in4x_E2[54] <= MISO_E2;
					in4x_F1[54] <= MISO_F1; in4x_F2[54] <= MISO_F2;
					in4x_G1[54] <= MISO_G1; in4x_G2[54] <= MISO_G2;
					in4x_H1[54] <= MISO_H1; in4x_H2[54] <= MISO_H2;					
					main_state <= ms_clk15_b;
				end

				ms_clk15_b: begin
					in4x_A1[55] <= MISO_A1; in4x_A2[55] <= MISO_A2;
					in4x_B1[55] <= MISO_B1; in4x_B2[55] <= MISO_B2;
					in4x_C1[55] <= MISO_C1; in4x_C2[55] <= MISO_C2;
					in4x_D1[55] <= MISO_D1; in4x_D2[55] <= MISO_D2;	
					in4x_E1[55] <= MISO_E1; in4x_E2[55] <= MISO_E2;
					in4x_F1[55] <= MISO_F1; in4x_F2[55] <= MISO_F2;
					in4x_G1[55] <= MISO_G1; in4x_G2[55] <= MISO_G2;
					in4x_H1[55] <= MISO_H1; in4x_H2[55] <= MISO_H2;						
					main_state <= ms_clk15_c;
				end

				ms_clk15_c: begin
					SCLK <= 1'b1;
					in4x_A1[56] <= MISO_A1; in4x_A2[56] <= MISO_A2;
					in4x_B1[56] <= MISO_B1; in4x_B2[56] <= MISO_B2;
					in4x_C1[56] <= MISO_C1; in4x_C2[56] <= MISO_C2;
					in4x_D1[56] <= MISO_D1; in4x_D2[56] <= MISO_D2;					
					in4x_E1[56] <= MISO_E1; in4x_E2[56] <= MISO_E2;
					in4x_F1[56] <= MISO_F1; in4x_F2[56] <= MISO_F2;
					in4x_G1[56] <= MISO_G1; in4x_G2[56] <= MISO_G2;
					in4x_H1[56] <= MISO_H1; in4x_H2[56] <= MISO_H2;	
					main_state <= ms_clk15_d;
				end
				
				ms_clk15_d: begin
					SCLK <= 1'b1;
					in4x_A1[57] <= MISO_A1; in4x_A2[57] <= MISO_A2;
					in4x_B1[57] <= MISO_B1; in4x_B2[57] <= MISO_B2;
					in4x_C1[57] <= MISO_C1; in4x_C2[57] <= MISO_C2;
					in4x_D1[57] <= MISO_D1; in4x_D2[57] <= MISO_D2;				
					in4x_E1[57] <= MISO_E1; in4x_E2[57] <= MISO_E2;
					in4x_F1[57] <= MISO_F1; in4x_F2[57] <= MISO_F2;
					in4x_G1[57] <= MISO_G1; in4x_G2[57] <= MISO_G2;
					in4x_H1[57] <= MISO_H1; in4x_H2[57] <= MISO_H2;
					main_state <= ms_clk16_a;
				end

				ms_clk16_a: begin
					MOSI_A <= MOSI_cmd_A[0];
					MOSI_B <= MOSI_cmd_B[0];
					MOSI_C <= MOSI_cmd_C[0];
					MOSI_D <= MOSI_cmd_D[0];
					MOSI_E <= MOSI_cmd_E[0];
					MOSI_F <= MOSI_cmd_F[0];
					MOSI_G <= MOSI_cmd_G[0];
					MOSI_H <= MOSI_cmd_H[0];
					in4x_A1[58] <= MISO_A1; in4x_A2[58] <= MISO_A2;
					in4x_B1[58] <= MISO_B1; in4x_B2[58] <= MISO_B2;
					in4x_C1[58] <= MISO_C1; in4x_C2[58] <= MISO_C2;
					in4x_D1[58] <= MISO_D1; in4x_D2[58] <= MISO_D2;
					in4x_E1[58] <= MISO_E1; in4x_E2[58] <= MISO_E2;
					in4x_F1[58] <= MISO_F1; in4x_F2[58] <= MISO_F2;
					in4x_G1[58] <= MISO_G1; in4x_G2[58] <= MISO_G2;
					in4x_H1[58] <= MISO_H1; in4x_H2[58] <= MISO_H2;					
					main_state <= ms_clk16_b;
				end

				ms_clk16_b: begin
					in4x_A1[59] <= MISO_A1; in4x_A2[59] <= MISO_A2;
					in4x_B1[59] <= MISO_B1; in4x_B2[59] <= MISO_B2;
					in4x_C1[59] <= MISO_C1; in4x_C2[59] <= MISO_C2;
					in4x_D1[59] <= MISO_D1; in4x_D2[59] <= MISO_D2;		
					in4x_E1[59] <= MISO_E1; in4x_E2[59] <= MISO_E2;
					in4x_F1[59] <= MISO_F1; in4x_F2[59] <= MISO_F2;
					in4x_G1[59] <= MISO_G1; in4x_G2[59] <= MISO_G2;
					in4x_H1[59] <= MISO_H1; in4x_H2[59] <= MISO_H2;					
					main_state <= ms_clk16_c;
				end

				ms_clk16_c: begin
					SCLK <= 1'b1;
					in4x_A1[60] <= MISO_A1; in4x_A2[60] <= MISO_A2;
					in4x_B1[60] <= MISO_B1; in4x_B2[60] <= MISO_B2;
					in4x_C1[60] <= MISO_C1; in4x_C2[60] <= MISO_C2;
					in4x_D1[60] <= MISO_D1; in4x_D2[60] <= MISO_D2;					
					in4x_E1[60] <= MISO_E1; in4x_E2[60] <= MISO_E2;
					in4x_F1[60] <= MISO_F1; in4x_F2[60] <= MISO_F2;
					in4x_G1[60] <= MISO_G1; in4x_G2[60] <= MISO_G2;
					in4x_H1[60] <= MISO_H1; in4x_H2[60] <= MISO_H2;	
					main_state <= ms_clk16_d;
				end
				
				ms_clk16_d: begin
					SCLK <= 1'b1;
					in4x_A1[61] <= MISO_A1; in4x_A2[61] <= MISO_A2;
					in4x_B1[61] <= MISO_B1; in4x_B2[61] <= MISO_B2;
					in4x_C1[61] <= MISO_C1; in4x_C2[61] <= MISO_C2;
					in4x_D1[61] <= MISO_D1; in4x_D2[61] <= MISO_D2;
					in4x_E1[61] <= MISO_E1; in4x_E2[61] <= MISO_E2;
					in4x_F1[61] <= MISO_F1; in4x_F2[61] <= MISO_F2;
					in4x_G1[61] <= MISO_G1; in4x_G2[61] <= MISO_G2;
					in4x_H1[61] <= MISO_H1; in4x_H2[61] <= MISO_H2;					
					main_state <= ms_clk17_a;
				end

				ms_clk17_a: begin
					if (num_data_streams_enabled[1:0] != 2'b00 && channel == 34) begin
						FIFO_data_in <= data_stream_filler;	// Send a 'filler' sample to keep number of samples divisible by four
						FIFO_write_to <= 1'b1;
					end

					MOSI_A <= 1'b0;
					MOSI_B <= 1'b0;
					MOSI_C <= 1'b0;
					MOSI_D <= 1'b0;
					MOSI_E <= 1'b0;
					MOSI_F <= 1'b0;
					MOSI_G <= 1'b0;
					MOSI_H <= 1'b0;
					in4x_A1[62] <= MISO_A1; in4x_A2[62] <= MISO_A2;
					in4x_B1[62] <= MISO_B1; in4x_B2[62] <= MISO_B2;
					in4x_C1[62] <= MISO_C1; in4x_C2[62] <= MISO_C2;
					in4x_D1[62] <= MISO_D1; in4x_D2[62] <= MISO_D2;				
					in4x_E1[62] <= MISO_E1; in4x_E2[62] <= MISO_E2;
					in4x_F1[62] <= MISO_F1; in4x_F2[62] <= MISO_F2;
					in4x_G1[62] <= MISO_G1; in4x_G2[62] <= MISO_G2;
					in4x_H1[62] <= MISO_H1; in4x_H2[62] <= MISO_H2;	
					main_state <= ms_clk17_b;
				end

				ms_clk17_b: begin
					if ((num_data_streams_enabled[1:0] == 2'b10 || num_data_streams_enabled[1:0] == 2'b11) && channel == 34) begin
						FIFO_data_in <= data_stream_filler;	// Send a 'filler' sample to keep number of samples divisible by four
						FIFO_write_to <= 1'b1;
					end

					in4x_A1[63] <= MISO_A1; in4x_A2[63] <= MISO_A2;
					in4x_B1[63] <= MISO_B1; in4x_B2[63] <= MISO_B2;
					in4x_C1[63] <= MISO_C1; in4x_C2[63] <= MISO_C2;
					in4x_D1[63] <= MISO_D1; in4x_D2[63] <= MISO_D2;
					in4x_E1[63] <= MISO_E1; in4x_E2[63] <= MISO_E2;
					in4x_F1[63] <= MISO_F1; in4x_F2[63] <= MISO_F2;
					in4x_G1[63] <= MISO_G1; in4x_G2[63] <= MISO_G2;
					in4x_H1[63] <= MISO_H1; in4x_H2[63] <= MISO_H2;					
					main_state <= ms_cs_a;
				end

				ms_cs_a: begin
					if (num_data_streams_enabled[1:0] == 2'b11 && channel == 34) begin
						FIFO_data_in <= data_stream_filler;	// Send a 'filler' sample to keep number of samples divisible by four
						FIFO_write_to <= 1'b1;
					end

					CS_b <= 1'b1;
					in4x_A1[64] <= MISO_A1; in4x_A2[64] <= MISO_A2;
					in4x_B1[64] <= MISO_B1; in4x_B2[64] <= MISO_B2;
					in4x_C1[64] <= MISO_C1; in4x_C2[64] <= MISO_C2;
					in4x_D1[64] <= MISO_D1; in4x_D2[64] <= MISO_D2;		
					in4x_E1[64] <= MISO_E1; in4x_E2[64] <= MISO_E2;
					in4x_F1[64] <= MISO_F1; in4x_F2[64] <= MISO_F2;
					in4x_G1[64] <= MISO_G1; in4x_G2[64] <= MISO_G2;
					in4x_H1[64] <= MISO_H1; in4x_H2[64] <= MISO_H2;					
					main_state <= ms_cs_b;
				end

				ms_cs_b: begin
					if (channel == 34) begin
						FIFO_data_in <= stubbed_data_stream_ADC_1;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[65] <= MISO_A1; in4x_A2[65] <= MISO_A2;
					in4x_B1[65] <= MISO_B1; in4x_B2[65] <= MISO_B2;
					in4x_C1[65] <= MISO_C1; in4x_C2[65] <= MISO_C2;
					in4x_D1[65] <= MISO_D1; in4x_D2[65] <= MISO_D2;	
					in4x_E1[65] <= MISO_E1; in4x_E2[65] <= MISO_E2;
					in4x_F1[65] <= MISO_F1; in4x_F2[65] <= MISO_F2;
					in4x_G1[65] <= MISO_G1; in4x_G2[65] <= MISO_G2;
					in4x_H1[65] <= MISO_H1; in4x_H2[65] <= MISO_H2;					
					main_state <= ms_cs_c;
				end

				ms_cs_c: begin
					if (channel == 34) begin
						FIFO_data_in <= stubbed_data_stream_ADC_2;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[66] <= MISO_A1; in4x_A2[66] <= MISO_A2;
					in4x_B1[66] <= MISO_B1; in4x_B2[66] <= MISO_B2;
					in4x_C1[66] <= MISO_C1; in4x_C2[66] <= MISO_C2;
					in4x_D1[66] <= MISO_D1; in4x_D2[66] <= MISO_D2;		
					in4x_E1[66] <= MISO_E1; in4x_E2[66] <= MISO_E2;
					in4x_F1[66] <= MISO_F1; in4x_F2[66] <= MISO_F2;
					in4x_G1[66] <= MISO_G1; in4x_G2[66] <= MISO_G2;
					in4x_H1[66] <= MISO_H1; in4x_H2[66] <= MISO_H2;						
					main_state <= ms_cs_d;
				end
				
				ms_cs_d: begin
					if (channel == 34) begin
						FIFO_data_in <= stubbed_data_stream_ADC_3;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[67] <= MISO_A1; in4x_A2[67] <= MISO_A2;
					in4x_B1[67] <= MISO_B1; in4x_B2[67] <= MISO_B2;
					in4x_C1[67] <= MISO_C1; in4x_C2[67] <= MISO_C2;
					in4x_D1[67] <= MISO_D1; in4x_D2[67] <= MISO_D2;				
					in4x_E1[67] <= MISO_E1; in4x_E2[67] <= MISO_E2;
					in4x_F1[67] <= MISO_F1; in4x_F2[67] <= MISO_F2;
					in4x_G1[67] <= MISO_G1; in4x_G2[67] <= MISO_G2;
					in4x_H1[67] <= MISO_H1; in4x_H2[67] <= MISO_H2;
					main_state <= ms_cs_e;
				end
				
				ms_cs_e: begin
					if (channel == 34) begin
						FIFO_data_in <= stubbed_data_stream_ADC_4;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[68] <= MISO_A1; in4x_A2[68] <= MISO_A2;
					in4x_B1[68] <= MISO_B1; in4x_B2[68] <= MISO_B2;
					in4x_C1[68] <= MISO_C1; in4x_C2[68] <= MISO_C2;
					in4x_D1[68] <= MISO_D1; in4x_D2[68] <= MISO_D2;				
					in4x_E1[68] <= MISO_E1; in4x_E2[68] <= MISO_E2;
					in4x_F1[68] <= MISO_F1; in4x_F2[68] <= MISO_F2;
					in4x_G1[68] <= MISO_G1; in4x_G2[68] <= MISO_G2;
					in4x_H1[68] <= MISO_H1; in4x_H2[68] <= MISO_H2;
					main_state <= ms_cs_f;
				end
				
				ms_cs_f: begin
					if (channel == 34) begin
						FIFO_data_in <= stubbed_data_stream_ADC_5;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[69] <= MISO_A1; in4x_A2[69] <= MISO_A2;
					in4x_B1[69] <= MISO_B1; in4x_B2[69] <= MISO_B2;
					in4x_C1[69] <= MISO_C1; in4x_C2[69] <= MISO_C2;
					in4x_D1[69] <= MISO_D1; in4x_D2[69] <= MISO_D2;	
					in4x_E1[69] <= MISO_E1; in4x_E2[69] <= MISO_E2;
					in4x_F1[69] <= MISO_F1; in4x_F2[69] <= MISO_F2;
					in4x_G1[69] <= MISO_G1; in4x_G2[69] <= MISO_G2;
					in4x_H1[69] <= MISO_H1; in4x_H2[69] <= MISO_H2;					
					main_state <= ms_cs_g;
				end
				
				ms_cs_g: begin
					if (channel == 34) begin
						FIFO_data_in <= stubbed_data_stream_ADC_6;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[70] <= MISO_A1; in4x_A2[70] <= MISO_A2;
					in4x_B1[70] <= MISO_B1; in4x_B2[70] <= MISO_B2;
					in4x_C1[70] <= MISO_C1; in4x_C2[70] <= MISO_C2;
					in4x_D1[70] <= MISO_D1; in4x_D2[70] <= MISO_D2;				
					in4x_E1[70] <= MISO_E1; in4x_E2[70] <= MISO_E2;
					in4x_F1[70] <= MISO_F1; in4x_F2[70] <= MISO_F2;
					in4x_G1[70] <= MISO_G1; in4x_G2[70] <= MISO_G2;
					in4x_H1[70] <= MISO_H1; in4x_H2[70] <= MISO_H2;
					main_state <= ms_cs_h;
				end
				
				ms_cs_h: begin
					if (channel == 34) begin
						FIFO_data_in <= stubbed_data_stream_ADC_7;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[71] <= MISO_A1; in4x_A2[71] <= MISO_A2;
					in4x_B1[71] <= MISO_B1; in4x_B2[71] <= MISO_B2;
					in4x_C1[71] <= MISO_C1; in4x_C2[71] <= MISO_C2;
					in4x_D1[71] <= MISO_D1; in4x_D2[71] <= MISO_D2;				
					in4x_E1[71] <= MISO_E1; in4x_E2[71] <= MISO_E2;
					in4x_F1[71] <= MISO_F1; in4x_F2[71] <= MISO_F2;
					in4x_G1[71] <= MISO_G1; in4x_G2[71] <= MISO_G2;
					in4x_H1[71] <= MISO_H1; in4x_H2[71] <= MISO_H2;
					main_state <= ms_cs_i;
				end
				
				ms_cs_i: begin
					if (channel == 34) begin
						FIFO_data_in <= stubbed_data_stream_ADC_8;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[72] <= MISO_A1; in4x_A2[72] <= MISO_A2;
					in4x_B1[72] <= MISO_B1; in4x_B2[72] <= MISO_B2;
					in4x_C1[72] <= MISO_C1; in4x_C2[72] <= MISO_C2;
					in4x_D1[72] <= MISO_D1; in4x_D2[72] <= MISO_D2;				
					in4x_E1[72] <= MISO_E1; in4x_E2[72] <= MISO_E2;
					in4x_F1[72] <= MISO_F1; in4x_F2[72] <= MISO_F2;
					in4x_G1[72] <= MISO_G1; in4x_G2[72] <= MISO_G2;
					in4x_H1[72] <= MISO_H1; in4x_H2[72] <= MISO_H2;	
					main_state <= ms_cs_j;
				end
				
				ms_cs_j: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_TTL_in;	// Write TTL inputs
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					in4x_A1[73] <= MISO_A1; in4x_A2[73] <= MISO_A2;
					in4x_B1[73] <= MISO_B1; in4x_B2[73] <= MISO_B2;
					in4x_C1[73] <= MISO_C1; in4x_C2[73] <= MISO_C2;
					in4x_D1[73] <= MISO_D1; in4x_D2[73] <= MISO_D2;				
					in4x_E1[73] <= MISO_E1; in4x_E2[73] <= MISO_E2;
					in4x_F1[73] <= MISO_F1; in4x_F2[73] <= MISO_F2;
					in4x_G1[73] <= MISO_G1; in4x_G2[73] <= MISO_G2;
					in4x_H1[73] <= MISO_H1; in4x_H2[73] <= MISO_H2;
					main_state <= ms_cs_k;
				end
				
				ms_cs_k: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_TTL_out;	// Write current value of TTL outputs so users can reconstruct exact timings
						FIFO_write_to <= 1'b1;
					end					

					CS_b <= 1'b1;
					result_A1 <= in_A1; result_A2 <= in_A2;
					result_B1 <= in_B1; result_B2 <= in_B2;
					result_C1 <= in_C1; result_C2 <= in_C2;
					result_D1 <= in_D1; result_D2 <= in_D2;
					result_E1 <= in_E1; result_E2 <= in_E2;
					result_F1 <= in_F1; result_F2 <= in_F2;
					result_G1 <= in_G1; result_G2 <= in_G2;
					result_H1 <= in_H1; result_H2 <= in_H2;
					result_DDR_A1 <= in_DDR_A1; result_DDR_A2 <= in_DDR_A2;
					result_DDR_B1 <= in_DDR_B1; result_DDR_B2 <= in_DDR_B2;
					result_DDR_C1 <= in_DDR_C1; result_DDR_C2 <= in_DDR_C2;
					result_DDR_D1 <= in_DDR_D1; result_DDR_D2 <= in_DDR_D2;
					result_DDR_E1 <= in_DDR_E1; result_DDR_E2 <= in_DDR_E2;
					result_DDR_F1 <= in_DDR_F1; result_DDR_F2 <= in_DDR_F2;
					result_DDR_G1 <= in_DDR_G1; result_DDR_G2 <= in_DDR_G2;
					result_DDR_H1 <= in_DDR_H1; result_DDR_H2 <= in_DDR_H2;
					main_state <= ms_cs_l;
				end
				
				ms_cs_l: begin
					if (channel == 34) begin
						if (aux_cmd_index_1 == max_aux_cmd_index_1) begin
							aux_cmd_index_1 <= loop_aux_cmd_index_1;
							max_aux_cmd_index_1 <= max_aux_cmd_index_1_in;
							aux_cmd_bank_1_A <= aux_cmd_bank_1_A_in;
							aux_cmd_bank_1_B <= aux_cmd_bank_1_B_in;
							aux_cmd_bank_1_C <= aux_cmd_bank_1_C_in;
							aux_cmd_bank_1_D <= aux_cmd_bank_1_D_in;
							aux_cmd_bank_1_E <= aux_cmd_bank_1_E_in;
							aux_cmd_bank_1_F <= aux_cmd_bank_1_F_in;
							aux_cmd_bank_1_G <= aux_cmd_bank_1_G_in;
							aux_cmd_bank_1_H <= aux_cmd_bank_1_H_in;
						end else begin
							aux_cmd_index_1 <= aux_cmd_index_1 + 1;
						end
						if (aux_cmd_index_2 == max_aux_cmd_index_2) begin
							aux_cmd_index_2 <= loop_aux_cmd_index_2;
							max_aux_cmd_index_2 <= max_aux_cmd_index_2_in;
							aux_cmd_bank_2_A <= aux_cmd_bank_2_A_in;
							aux_cmd_bank_2_B <= aux_cmd_bank_2_B_in;
							aux_cmd_bank_2_C <= aux_cmd_bank_2_C_in;
							aux_cmd_bank_2_D <= aux_cmd_bank_2_D_in;
							aux_cmd_bank_2_E <= aux_cmd_bank_2_E_in;
							aux_cmd_bank_2_F <= aux_cmd_bank_2_F_in;
							aux_cmd_bank_2_G <= aux_cmd_bank_2_G_in;
							aux_cmd_bank_2_H <= aux_cmd_bank_2_H_in;
						end else begin
							aux_cmd_index_2 <= aux_cmd_index_2 + 1;
						end
						if (aux_cmd_index_3 == max_aux_cmd_index_3) begin
							aux_cmd_index_3 <= loop_aux_cmd_index_3;
							max_aux_cmd_index_3 <= max_aux_cmd_index_3_in;
							aux_cmd_bank_3_A <= aux_cmd_bank_3_A_in;
							aux_cmd_bank_3_B <= aux_cmd_bank_3_B_in;
							aux_cmd_bank_3_C <= aux_cmd_bank_3_C_in;
							aux_cmd_bank_3_D <= aux_cmd_bank_3_D_in;
							aux_cmd_bank_3_E <= aux_cmd_bank_3_E_in;
							aux_cmd_bank_3_F <= aux_cmd_bank_3_F_in;
							aux_cmd_bank_3_G <= aux_cmd_bank_3_G_in;
							aux_cmd_bank_3_H <= aux_cmd_bank_3_H_in;
						end else begin
							aux_cmd_index_3 <= aux_cmd_index_3 + 1;
						end
					end
					
					// Route selected samples to DAC outputs
					if (channel_MISO == DAC_channel_sel_1) begin
						case (DAC_stream_sel_1)
							0: DAC_pre_register_1 <= data_stream_1;
							1: DAC_pre_register_1 <= data_stream_2;
							2: DAC_pre_register_1 <= data_stream_3;
							3: DAC_pre_register_1 <= data_stream_4;
							4: DAC_pre_register_1 <= data_stream_5;
							5: DAC_pre_register_1 <= data_stream_6;
							6: DAC_pre_register_1 <= data_stream_7;
							7: DAC_pre_register_1 <= data_stream_8;
							8: DAC_pre_register_1 <= data_stream_9;
							9: DAC_pre_register_1 <= data_stream_10;
							10: DAC_pre_register_1 <= data_stream_11;
							11: DAC_pre_register_1 <= data_stream_12;
							12: DAC_pre_register_1 <= data_stream_13;
							13: DAC_pre_register_1 <= data_stream_14;
							14: DAC_pre_register_1 <= data_stream_15;
							15: DAC_pre_register_1 <= data_stream_16;
							16: DAC_pre_register_1 <= data_stream_17;
							17: DAC_pre_register_1 <= data_stream_18;
							18: DAC_pre_register_1 <= data_stream_19;
							19: DAC_pre_register_1 <= data_stream_20;
							20: DAC_pre_register_1 <= data_stream_21;
							21: DAC_pre_register_1 <= data_stream_22;
							22: DAC_pre_register_1 <= data_stream_23;
							23: DAC_pre_register_1 <= data_stream_24;
							24: DAC_pre_register_1 <= data_stream_25;
							25: DAC_pre_register_1 <= data_stream_26;
							26: DAC_pre_register_1 <= data_stream_27;
							27: DAC_pre_register_1 <= data_stream_28;
							28: DAC_pre_register_1 <= data_stream_29;
							29: DAC_pre_register_1 <= data_stream_30;
							30: DAC_pre_register_1 <= data_stream_31;
							31: DAC_pre_register_1 <= data_stream_32;
							32: DAC_pre_register_1 <= DAC_manual;
							default: DAC_pre_register_1 <= 16'b0;
						endcase
					end
					if (channel_MISO == DAC_channel_sel_2) begin
						case (DAC_stream_sel_2)
							0: DAC_pre_register_2 <= data_stream_1;
							1: DAC_pre_register_2 <= data_stream_2;
							2: DAC_pre_register_2 <= data_stream_3;
							3: DAC_pre_register_2 <= data_stream_4;
							4: DAC_pre_register_2 <= data_stream_5;
							5: DAC_pre_register_2 <= data_stream_6;
							6: DAC_pre_register_2 <= data_stream_7;
							7: DAC_pre_register_2 <= data_stream_8;
							8: DAC_pre_register_2 <= data_stream_9;
							9: DAC_pre_register_2 <= data_stream_10;
							10: DAC_pre_register_2 <= data_stream_11;
							11: DAC_pre_register_2 <= data_stream_12;
							12: DAC_pre_register_2 <= data_stream_13;
							13: DAC_pre_register_2 <= data_stream_14;
							14: DAC_pre_register_2 <= data_stream_15;
							15: DAC_pre_register_2 <= data_stream_16;
							16: DAC_pre_register_2 <= data_stream_17;
							17: DAC_pre_register_2 <= data_stream_18;
							18: DAC_pre_register_2 <= data_stream_19;
							19: DAC_pre_register_2 <= data_stream_20;
							20: DAC_pre_register_2 <= data_stream_21;
							21: DAC_pre_register_2 <= data_stream_22;
							22: DAC_pre_register_2 <= data_stream_23;
							23: DAC_pre_register_2 <= data_stream_24;
							24: DAC_pre_register_2 <= data_stream_25;
							25: DAC_pre_register_2 <= data_stream_26;
							26: DAC_pre_register_2 <= data_stream_27;
							27: DAC_pre_register_2 <= data_stream_28;
							28: DAC_pre_register_2 <= data_stream_29;
							29: DAC_pre_register_2 <= data_stream_30;
							30: DAC_pre_register_2 <= data_stream_31;
							31: DAC_pre_register_2 <= data_stream_32;
							32: DAC_pre_register_2 <= DAC_manual;
							default: DAC_pre_register_2 <= 16'b0;
						endcase
					end
					if (channel_MISO == DAC_channel_sel_3) begin
						case (DAC_stream_sel_3)
							0: DAC_pre_register_3 <= data_stream_1;
							1: DAC_pre_register_3 <= data_stream_2;
							2: DAC_pre_register_3 <= data_stream_3;
							3: DAC_pre_register_3 <= data_stream_4;
							4: DAC_pre_register_3 <= data_stream_5;
							5: DAC_pre_register_3 <= data_stream_6;
							6: DAC_pre_register_3 <= data_stream_7;
							7: DAC_pre_register_3 <= data_stream_8;
							8: DAC_pre_register_3 <= data_stream_9;
							9: DAC_pre_register_3 <= data_stream_10;
							10: DAC_pre_register_3 <= data_stream_11;
							11: DAC_pre_register_3 <= data_stream_12;
							12: DAC_pre_register_3 <= data_stream_13;
							13: DAC_pre_register_3 <= data_stream_14;
							14: DAC_pre_register_3 <= data_stream_15;
							15: DAC_pre_register_3 <= data_stream_16;
							16: DAC_pre_register_3 <= data_stream_17;
							17: DAC_pre_register_3 <= data_stream_18;
							18: DAC_pre_register_3 <= data_stream_19;
							19: DAC_pre_register_3 <= data_stream_20;
							20: DAC_pre_register_3 <= data_stream_21;
							21: DAC_pre_register_3 <= data_stream_22;
							22: DAC_pre_register_3 <= data_stream_23;
							23: DAC_pre_register_3 <= data_stream_24;
							24: DAC_pre_register_3 <= data_stream_25;
							25: DAC_pre_register_3 <= data_stream_26;
							26: DAC_pre_register_3 <= data_stream_27;
							27: DAC_pre_register_3 <= data_stream_28;
							28: DAC_pre_register_3 <= data_stream_29;
							29: DAC_pre_register_3 <= data_stream_30;
							30: DAC_pre_register_3 <= data_stream_31;
							31: DAC_pre_register_3 <= data_stream_32;
							32: DAC_pre_register_3 <= DAC_manual;
							default: DAC_pre_register_3 <= 16'b0;
						endcase
					end
					if (channel_MISO == DAC_channel_sel_4) begin
						case (DAC_stream_sel_4)
							0: DAC_pre_register_4 <= data_stream_1;
							1: DAC_pre_register_4 <= data_stream_2;
							2: DAC_pre_register_4 <= data_stream_3;
							3: DAC_pre_register_4 <= data_stream_4;
							4: DAC_pre_register_4 <= data_stream_5;
							5: DAC_pre_register_4 <= data_stream_6;
							6: DAC_pre_register_4 <= data_stream_7;
							7: DAC_pre_register_4 <= data_stream_8;
							8: DAC_pre_register_4 <= data_stream_9;
							9: DAC_pre_register_4 <= data_stream_10;
							10: DAC_pre_register_4 <= data_stream_11;
							11: DAC_pre_register_4 <= data_stream_12;
							12: DAC_pre_register_4 <= data_stream_13;
							13: DAC_pre_register_4 <= data_stream_14;
							14: DAC_pre_register_4 <= data_stream_15;
							15: DAC_pre_register_4 <= data_stream_16;
							16: DAC_pre_register_4 <= data_stream_17;
							17: DAC_pre_register_4 <= data_stream_18;
							18: DAC_pre_register_4 <= data_stream_19;
							19: DAC_pre_register_4 <= data_stream_20;
							20: DAC_pre_register_4 <= data_stream_21;
							21: DAC_pre_register_4 <= data_stream_22;
							22: DAC_pre_register_4 <= data_stream_23;
							23: DAC_pre_register_4 <= data_stream_24;
							24: DAC_pre_register_4 <= data_stream_25;
							25: DAC_pre_register_4 <= data_stream_26;
							26: DAC_pre_register_4 <= data_stream_27;
							27: DAC_pre_register_4 <= data_stream_28;
							28: DAC_pre_register_4 <= data_stream_29;
							29: DAC_pre_register_4 <= data_stream_30;
							30: DAC_pre_register_4 <= data_stream_31;
							31: DAC_pre_register_4 <= data_stream_32;
							32: DAC_pre_register_4 <= DAC_manual;
							default: DAC_pre_register_4 <= 16'b0;
						endcase
					end
					if (channel_MISO == DAC_channel_sel_5) begin
						case (DAC_stream_sel_5)
							0: DAC_pre_register_5 <= data_stream_1;
							1: DAC_pre_register_5 <= data_stream_2;
							2: DAC_pre_register_5 <= data_stream_3;
							3: DAC_pre_register_5 <= data_stream_4;
							4: DAC_pre_register_5 <= data_stream_5;
							5: DAC_pre_register_5 <= data_stream_6;
							6: DAC_pre_register_5 <= data_stream_7;
							7: DAC_pre_register_5 <= data_stream_8;
							8: DAC_pre_register_5 <= data_stream_9;
							9: DAC_pre_register_5 <= data_stream_10;
							10: DAC_pre_register_5 <= data_stream_11;
							11: DAC_pre_register_5 <= data_stream_12;
							12: DAC_pre_register_5 <= data_stream_13;
							13: DAC_pre_register_5 <= data_stream_14;
							14: DAC_pre_register_5 <= data_stream_15;
							15: DAC_pre_register_5 <= data_stream_16;
							16: DAC_pre_register_5 <= data_stream_17;
							17: DAC_pre_register_5 <= data_stream_18;
							18: DAC_pre_register_5 <= data_stream_19;
							19: DAC_pre_register_5 <= data_stream_20;
							20: DAC_pre_register_5 <= data_stream_21;
							21: DAC_pre_register_5 <= data_stream_22;
							22: DAC_pre_register_5 <= data_stream_23;
							23: DAC_pre_register_5 <= data_stream_24;
							24: DAC_pre_register_5 <= data_stream_25;
							25: DAC_pre_register_5 <= data_stream_26;
							26: DAC_pre_register_5 <= data_stream_27;
							27: DAC_pre_register_5 <= data_stream_28;
							28: DAC_pre_register_5 <= data_stream_29;
							29: DAC_pre_register_5 <= data_stream_30;
							30: DAC_pre_register_5 <= data_stream_31;
							31: DAC_pre_register_5 <= data_stream_32;
							32: DAC_pre_register_5 <= DAC_manual;
							default: DAC_pre_register_5 <= 16'b0;
						endcase
					end
					if (channel_MISO == DAC_channel_sel_6) begin
						case (DAC_stream_sel_6)
							0: DAC_pre_register_6 <= data_stream_1;
							1: DAC_pre_register_6 <= data_stream_2;
							2: DAC_pre_register_6 <= data_stream_3;
							3: DAC_pre_register_6 <= data_stream_4;
							4: DAC_pre_register_6 <= data_stream_5;
							5: DAC_pre_register_6 <= data_stream_6;
							6: DAC_pre_register_6 <= data_stream_7;
							7: DAC_pre_register_6 <= data_stream_8;
							8: DAC_pre_register_6 <= data_stream_9;
							9: DAC_pre_register_6 <= data_stream_10;
							10: DAC_pre_register_6 <= data_stream_11;
							11: DAC_pre_register_6 <= data_stream_12;
							12: DAC_pre_register_6 <= data_stream_13;
							13: DAC_pre_register_6 <= data_stream_14;
							14: DAC_pre_register_6 <= data_stream_15;
							15: DAC_pre_register_6 <= data_stream_16;
							16: DAC_pre_register_6 <= data_stream_17;
							17: DAC_pre_register_6 <= data_stream_18;
							18: DAC_pre_register_6 <= data_stream_19;
							19: DAC_pre_register_6 <= data_stream_20;
							20: DAC_pre_register_6 <= data_stream_21;
							21: DAC_pre_register_6 <= data_stream_22;
							22: DAC_pre_register_6 <= data_stream_23;
							23: DAC_pre_register_6 <= data_stream_24;
							24: DAC_pre_register_6 <= data_stream_25;
							25: DAC_pre_register_6 <= data_stream_26;
							26: DAC_pre_register_6 <= data_stream_27;
							27: DAC_pre_register_6 <= data_stream_28;
							28: DAC_pre_register_6 <= data_stream_29;
							29: DAC_pre_register_6 <= data_stream_30;
							30: DAC_pre_register_6 <= data_stream_31;
							31: DAC_pre_register_6 <= data_stream_32;
							32: DAC_pre_register_6 <= DAC_manual;
							default: DAC_pre_register_6 <= 16'b0;
						endcase
					end
					if (channel_MISO == DAC_channel_sel_7) begin
						case (DAC_stream_sel_7)
							0: DAC_pre_register_7 <= data_stream_1;
							1: DAC_pre_register_7 <= data_stream_2;
							2: DAC_pre_register_7 <= data_stream_3;
							3: DAC_pre_register_7 <= data_stream_4;
							4: DAC_pre_register_7 <= data_stream_5;
							5: DAC_pre_register_7 <= data_stream_6;
							6: DAC_pre_register_7 <= data_stream_7;
							7: DAC_pre_register_7 <= data_stream_8;
							8: DAC_pre_register_7 <= data_stream_9;
							9: DAC_pre_register_7 <= data_stream_10;
							10: DAC_pre_register_7 <= data_stream_11;
							11: DAC_pre_register_7 <= data_stream_12;
							12: DAC_pre_register_7 <= data_stream_13;
							13: DAC_pre_register_7 <= data_stream_14;
							14: DAC_pre_register_7 <= data_stream_15;
							15: DAC_pre_register_7 <= data_stream_16;
							16: DAC_pre_register_7 <= data_stream_17;
							17: DAC_pre_register_7 <= data_stream_18;
							18: DAC_pre_register_7 <= data_stream_19;
							19: DAC_pre_register_7 <= data_stream_20;
							20: DAC_pre_register_7 <= data_stream_21;
							21: DAC_pre_register_7 <= data_stream_22;
							22: DAC_pre_register_7 <= data_stream_23;
							23: DAC_pre_register_7 <= data_stream_24;
							24: DAC_pre_register_7 <= data_stream_25;
							25: DAC_pre_register_7 <= data_stream_26;
							26: DAC_pre_register_7 <= data_stream_27;
							27: DAC_pre_register_7 <= data_stream_28;
							28: DAC_pre_register_7 <= data_stream_29;
							29: DAC_pre_register_7 <= data_stream_30;
							30: DAC_pre_register_7 <= data_stream_31;
							31: DAC_pre_register_7 <= data_stream_32;
							32: DAC_pre_register_7 <= DAC_manual;
							default: DAC_pre_register_7 <= 16'b0;
						endcase
					end
					if (channel_MISO == DAC_channel_sel_8) begin
						case (DAC_stream_sel_8)
							0: DAC_pre_register_8 <= data_stream_1;
							1: DAC_pre_register_8 <= data_stream_2;
							2: DAC_pre_register_8 <= data_stream_3;
							3: DAC_pre_register_8 <= data_stream_4;
							4: DAC_pre_register_8 <= data_stream_5;
							5: DAC_pre_register_8 <= data_stream_6;
							6: DAC_pre_register_8 <= data_stream_7;
							7: DAC_pre_register_8 <= data_stream_8;
							8: DAC_pre_register_8 <= data_stream_9;
							9: DAC_pre_register_8 <= data_stream_10;
							10: DAC_pre_register_8 <= data_stream_11;
							11: DAC_pre_register_8 <= data_stream_12;
							12: DAC_pre_register_8 <= data_stream_13;
							13: DAC_pre_register_8 <= data_stream_14;
							14: DAC_pre_register_8 <= data_stream_15;
							15: DAC_pre_register_8 <= data_stream_16;
							16: DAC_pre_register_8 <= data_stream_17;
							17: DAC_pre_register_8 <= data_stream_18;
							18: DAC_pre_register_8 <= data_stream_19;
							19: DAC_pre_register_8 <= data_stream_20;
							20: DAC_pre_register_8 <= data_stream_21;
							21: DAC_pre_register_8 <= data_stream_22;
							22: DAC_pre_register_8 <= data_stream_23;
							23: DAC_pre_register_8 <= data_stream_24;
							24: DAC_pre_register_8 <= data_stream_25;
							25: DAC_pre_register_8 <= data_stream_26;
							26: DAC_pre_register_8 <= data_stream_27;
							27: DAC_pre_register_8 <= data_stream_28;
							28: DAC_pre_register_8 <= data_stream_29;
							29: DAC_pre_register_8 <= data_stream_30;
							30: DAC_pre_register_8 <= data_stream_31;
							31: DAC_pre_register_8 <= data_stream_32;
							32: DAC_pre_register_8 <= DAC_manual;
							default: DAC_pre_register_8 <= 16'b0;
						endcase
					end

					// Route selected sample to DAC software re-reference input
					if (channel_MISO == DAC_reref_channel_sel) begin
						case (DAC_reref_stream_sel)
							0: DAC_reref_pre_register <= data_stream_1;
							1: DAC_reref_pre_register <= data_stream_2;
							2: DAC_reref_pre_register <= data_stream_3;
							3: DAC_reref_pre_register <= data_stream_4;
							4: DAC_reref_pre_register <= data_stream_5;
							5: DAC_reref_pre_register <= data_stream_6;
							6: DAC_reref_pre_register <= data_stream_7;
							7: DAC_reref_pre_register <= data_stream_8;
							8: DAC_reref_pre_register <= data_stream_9;
							9: DAC_reref_pre_register <= data_stream_10;
							10: DAC_reref_pre_register <= data_stream_11;
							11: DAC_reref_pre_register <= data_stream_12;
							12: DAC_reref_pre_register <= data_stream_13;
							13: DAC_reref_pre_register <= data_stream_14;
							14: DAC_reref_pre_register <= data_stream_15;
							15: DAC_reref_pre_register <= data_stream_16;
							16: DAC_reref_pre_register <= data_stream_17;
							17: DAC_reref_pre_register <= data_stream_18;
							18: DAC_reref_pre_register <= data_stream_19;
							19: DAC_reref_pre_register <= data_stream_20;
							20: DAC_reref_pre_register <= data_stream_21;
							21: DAC_reref_pre_register <= data_stream_22;
							22: DAC_reref_pre_register <= data_stream_23;
							23: DAC_reref_pre_register <= data_stream_24;
							24: DAC_reref_pre_register <= data_stream_25;
							25: DAC_reref_pre_register <= data_stream_26;
							26: DAC_reref_pre_register <= data_stream_27;
							27: DAC_reref_pre_register <= data_stream_28;
							28: DAC_reref_pre_register <= data_stream_29;
							29: DAC_reref_pre_register <= data_stream_30;
							30: DAC_reref_pre_register <= data_stream_31;
							31: DAC_reref_pre_register <= data_stream_32;
						endcase
					end
					
					if (channel == 0) begin
						timestamp <= timestamp + 1;
					end
					CS_b <= 1'b1;			
					main_state <= ms_cs_m;
				end
				
				ms_cs_m: begin
					if (channel == 34) begin
						channel <= 0;
					end else begin
						channel <= channel + 1;
					end
					if (channel_MISO == 34) begin
						channel_MISO <= 0;
					end else begin
						channel_MISO <= channel_MISO + 1;
					end
					CS_b <= 1'b1;	
					
					if (channel == 34) begin
						if (SPI_run_continuous) begin		// run continuously if SPI_run_continuous == 1
							main_state <= ms_cs_n;
						end else begin
							if (timestamp == max_timestep || max_timestep == 32'b0) begin  // stop if max_timestep reached, or if max_timestep == 0
							     main_state <= ms_finish_256bit_word_0;
							end else begin
								main_state <= ms_cs_n;
							end
						end
					end else begin
						main_state <= ms_cs_n;
					end
				end
				
				ms_finish_256bit_word_0: begin
				    if (word_counter_16bit != 4'b0000) begin
				        FIFO_data_in <= 16'b0;
				        FIFO_write_to <= 1'b1;
				        main_state <= ms_finish_256bit_word_1;
				    end else begin
				        main_state <= ms_wait;
				    end
				end
				
				ms_finish_256bit_word_1: begin
				    // Wait for 1 clock cycle to give time for counter to increment before returning to ms_finish_256bit_word_0
				    main_state <= ms_finish_256bit_word_0;
				end
								
				default: begin
					main_state <= ms_wait;
				end
				
			endcase
		end
	end
	
	// Counter tracking how many 16-bit words have been written to FIFO, resetting at 16.
	// This is used in states ms_finish_256bit_word_0 and ms_finish_256bit_word_1 to make sure
	// an acquisition session doesn't stop with anywhere between 1 and 15 16-bit words in the
	// FIFO pipeline (because RAM chip takes data in 256-bit chunks).
	always @(posedge dataclk) begin
	   if (reset) begin
	       word_counter_16bit <= 4'b0000;
	   end else if (FIFO_write_to == 1'b1) begin
	       if (word_counter_16bit == 4'b1111) begin
	           word_counter_16bit <= 4'b0000;
	       end else begin
	           word_counter_16bit <= word_counter_16bit + 1;
	       end
	   end
	end

	// Input deserializer
	
	assign serial_CLK = serial_CLK_auto | serial_CLK_manual;
	assign serial_LOAD = serial_LOAD_auto & ~serial_LOAD_manual;
	
	digital_input_deserializer deserializer (.reset(reset), .dataclk(dataclk), .main_state(main_state), .channel(channel),
		.serial_in(TTL_in_serial), .serial_in_exp(TTL_in_serial_exp), .TTL_in_direct_1(TTL_in_direct_1), .TTL_in_direct_2(TTL_in_direct_2),
		.serial_CLK(serial_CLK_auto), .serial_LOAD(serial_LOAD_auto), .TTL_parallel(TTL_parallel), .TTL_parallel_exp(TTL_in));
		

	// Evaluation board 16-bit DAC outputs

	// assign DAC_1_input_is_ref = (DAC_stream_sel_1 == { 1'b0, DAC_reref_stream_sel }) & (DAC_channel_sel_1 == DAC_reref_channel_sel);
	// assign DAC_2_input_is_ref = (DAC_stream_sel_2 == { 1'b0, DAC_reref_stream_sel }) & (DAC_channel_sel_2 == DAC_reref_channel_sel);
	// assign DAC_3_input_is_ref = (DAC_stream_sel_3 == { 1'b0, DAC_reref_stream_sel }) & (DAC_channel_sel_3 == DAC_reref_channel_sel);
	// assign DAC_4_input_is_ref = (DAC_stream_sel_4 == { 1'b0, DAC_reref_stream_sel }) & (DAC_channel_sel_4 == DAC_reref_channel_sel);
	// assign DAC_5_input_is_ref = (DAC_stream_sel_5 == { 1'b0, DAC_reref_stream_sel }) & (DAC_channel_sel_5 == DAC_reref_channel_sel);
	// assign DAC_6_input_is_ref = (DAC_stream_sel_6 == { 1'b0, DAC_reref_stream_sel }) & (DAC_channel_sel_6 == DAC_reref_channel_sel);
	// assign DAC_7_input_is_ref = (DAC_stream_sel_7 == { 1'b0, DAC_reref_stream_sel }) & (DAC_channel_sel_7 == DAC_reref_channel_sel);
	// assign DAC_8_input_is_ref = (DAC_stream_sel_8 == { 1'b0, DAC_reref_stream_sel }) & (DAC_channel_sel_8 == DAC_reref_channel_sel);
	
// 	DAC_output_scalable_HPF #(
// 		.ms_wait		(ms_wait),
// 		.ms_clk1_a 	(ms_clk1_a),
// 		.ms_clk11_a (ms_clk11_a)
// 		)
// 		DAC_output_1 (
// 		.reset			(reset),
// 		.dataclk			(dataclk),
// 		.main_state		(main_state),
// 		.channel			(channel),
// 		.DAC_input 		(DAC_register_1),
// 		.DAC_en 			(DAC_en_1),
// 		.gain				(DAC_gain),
// 		.noise_suppress(DAC_noise_suppress),
// 		.DAC_SYNC 		(DAC_SYNC),
// 		.DAC_SCLK 		(DAC_SCLK),
// 		.DAC_DIN 		(DAC_DIN_1),
// 		.DAC_thrsh     (DAC_thresh_1),
// 		.DAC_thrsh_pol (DAC_thresh_pol_1),
// 		.DAC_thrsh_out (DAC_thresh_out[0]),
// 		.HPF_coefficient (HPF_coefficient),
// 		.HPF_en			(HPF_en),
// 		.software_reference_mode (DAC_reref_mode & ~DAC_1_input_is_ref),
// 		.software_reference (DAC_reref_register)
//    );
	
// 	DAC_output_scalable_HPF #(
// 		.ms_wait		(ms_wait),
// 		.ms_clk1_a 	(ms_clk1_a),
// 		.ms_clk11_a	(ms_clk11_a)
// 		)
// 		DAC_output_2 (
// 		.reset			(reset),
// 		.dataclk			(dataclk),
// 		.main_state		(main_state),
// 		.channel			(channel),
// 		.DAC_input	 	(DAC_register_2),
// 		.DAC_en 			(DAC_en_2),
// 		.gain				(DAC_gain),
// 		.noise_suppress(DAC_noise_suppress),
// 		.DAC_SYNC 		(),
// 		.DAC_SCLK 		(),
// 		.DAC_DIN 		(DAC_DIN_2),
// 		.DAC_thrsh     (DAC_thresh_2),
// 		.DAC_thrsh_pol (DAC_thresh_pol_2),
// 		.DAC_thrsh_out (DAC_thresh_out[1]),
// 		.HPF_coefficient (HPF_coefficient),
// 		.HPF_en			(HPF_en),
// 		.software_reference_mode (DAC_reref_mode & ~DAC_2_input_is_ref),
// 		.software_reference (DAC_reref_register)
// 	);
	
// 	DAC_output_scalable_HPF #(
// 		.ms_wait		(ms_wait),
// 		.ms_clk1_a 	(ms_clk1_a),
// 		.ms_clk11_a (ms_clk11_a)
// 		)
// 		DAC_output_3 (
// 		.reset			(reset),
// 		.dataclk			(dataclk),
// 		.main_state		(main_state),
// 		.channel			(channel),
// 		.DAC_input	 	(DAC_register_3),
// 		.DAC_en 			(DAC_en_3),
// 		.gain				(DAC_gain),
// 		.noise_suppress(0),
// 		.DAC_SYNC 		(),
// 		.DAC_SCLK 		(),
// 		.DAC_DIN 		(DAC_DIN_3),
// 		.DAC_thrsh     (DAC_thresh_3),
// 		.DAC_thrsh_pol (DAC_thresh_pol_3),
// 		.DAC_thrsh_out (DAC_thresh_out[2]),
// 		.HPF_coefficient (HPF_coefficient),
// 		.HPF_en			(HPF_en),
// 		.software_reference_mode (DAC_reref_mode & ~DAC_3_input_is_ref),
// 		.software_reference (DAC_reref_register)
// 	);
	
// 	DAC_output_scalable_HPF #(
// 		.ms_wait		(ms_wait),
// 		.ms_clk1_a 	(ms_clk1_a),
// 		.ms_clk11_a	(ms_clk11_a)
// 		)
// 		DAC_output_4 (
// 		.reset			(reset),
// 		.dataclk			(dataclk),
// 		.main_state		(main_state),
// 		.channel			(channel),
// 		.DAC_input	 	(DAC_register_4),
// 		.DAC_en 			(DAC_en_4),
// 		.gain				(DAC_gain),
// 		.noise_suppress(0),
// 		.DAC_SYNC 		(),
// 		.DAC_SCLK 		(),
// 		.DAC_DIN 		(DAC_DIN_4),
// 		.DAC_thrsh     (DAC_thresh_4),
// 		.DAC_thrsh_pol (DAC_thresh_pol_4),
// 		.DAC_thrsh_out (DAC_thresh_out[3]),
// 		.HPF_coefficient (HPF_coefficient),
// 		.HPF_en			(HPF_en),
// 		.software_reference_mode (DAC_reref_mode & ~DAC_4_input_is_ref),
// 		.software_reference (DAC_reref_register)
// 	);

// 	DAC_output_scalable_HPF #(
// 		.ms_wait		(ms_wait),
// 		.ms_clk1_a 	(ms_clk1_a),
// 		.ms_clk11_a	(ms_clk11_a)
// 		)
// 		DAC_output_5 (
// 		.reset			(reset),
// 		.dataclk			(dataclk),
// 		.main_state		(main_state),
// 		.channel			(channel),
// 		.DAC_input	 	(DAC_register_5),
// 		.DAC_en 			(DAC_en_5),
// 		.gain				(DAC_gain),
// 		.noise_suppress(0),
// 		.DAC_SYNC 		(),
// 		.DAC_SCLK 		(),
// 		.DAC_DIN 		(DAC_DIN_5),
// 		.DAC_thrsh     (DAC_thresh_5),
// 		.DAC_thrsh_pol (DAC_thresh_pol_5),
// 		.DAC_thrsh_out (DAC_thresh_out[4]),
// 		.HPF_coefficient (HPF_coefficient),
// 		.HPF_en			(HPF_en),
// 		.software_reference_mode (DAC_reref_mode & ~DAC_5_input_is_ref),
// 		.software_reference (DAC_reref_register)
// 	);

	// DAC_output_scalable_HPF #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	DAC_output_6 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.DAC_input	 	(DAC_register_6),
	// 	.DAC_en 			(DAC_en_6),
	// 	.gain				(DAC_gain),
	// 	.noise_suppress(0),
	// 	.DAC_SYNC 		(),
	// 	.DAC_SCLK 		(),
	// 	.DAC_DIN 		(DAC_DIN_6),
	// 	.DAC_thrsh     (DAC_thresh_6),
	// 	.DAC_thrsh_pol (DAC_thresh_pol_6),
	// 	.DAC_thrsh_out (DAC_thresh_out[5]),
	// 	.HPF_coefficient (HPF_coefficient),
	// 	.HPF_en			(HPF_en),
	// 	.software_reference_mode (DAC_reref_mode & ~DAC_6_input_is_ref),
	// 	.software_reference (DAC_reref_register)
	// );
	
	// DAC_output_scalable_HPF #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	DAC_output_7 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.DAC_input	 	(DAC_register_7),
	// 	.DAC_en 			(DAC_en_7),
	// 	.gain				(DAC_gain),
	// 	.noise_suppress(0),
	// 	.DAC_SYNC 		(),
	// 	.DAC_SCLK 		(),
	// 	.DAC_DIN 		(DAC_DIN_7),
	// 	.DAC_thrsh     (DAC_thresh_7),
	// 	.DAC_thrsh_pol (DAC_thresh_pol_7),
	// 	.DAC_thrsh_out (DAC_thresh_out[6]),
	// 	.HPF_coefficient (HPF_coefficient),
	// 	.HPF_en			(HPF_en),
	// 	.software_reference_mode (DAC_reref_mode & ~DAC_7_input_is_ref),
	// 	.software_reference (DAC_reref_register)
	// );
	
	// DAC_output_scalable_HPF #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	DAC_output_8 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.DAC_input	 	(DAC_register_8),
	// 	.DAC_en 			(DAC_en_8),
	// 	.gain				(DAC_gain),
	// 	.noise_suppress(0),
	// 	.DAC_SYNC 		(),
	// 	.DAC_SCLK 		(),
	// 	.DAC_DIN 		(DAC_DIN_8),
	// 	.DAC_thrsh     (DAC_thresh_8),
	// 	.DAC_thrsh_pol (DAC_thresh_pol_8),
	// 	.DAC_thrsh_out (DAC_thresh_out[7]),
	// 	.HPF_coefficient (HPF_coefficient),
	// 	.HPF_en			(HPF_en),
	// 	.software_reference_mode (DAC_reref_mode & ~DAC_8_input_is_ref),
	// 	.software_reference (DAC_reref_register)
	// );
    
	// // On-board 16-bit ADC inputs

	// ADC_input #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	ADC_inout_1 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.ADC_DOUT		(ADC_DOUT_1),
	// 	.ADC_CS			(ADC_CS),
	// 	.ADC_SCLK		(ADC_SCLK),
	// 	.ADC_register	(data_stream_ADC_1)
	// );

	// ADC_input #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	ADC_inout_2 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.ADC_DOUT		(ADC_DOUT_2),
	// 	.ADC_CS			(),
	// 	.ADC_SCLK		(),
	// 	.ADC_register	(data_stream_ADC_2)
	// );

	// ADC_input #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	ADC_inout_3 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.ADC_DOUT		(ADC_DOUT_3),
	// 	.ADC_CS			(),
	// 	.ADC_SCLK		(),
	// 	.ADC_register	(data_stream_ADC_3)
	// );
	
	// ADC_input #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	ADC_inout_4 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.ADC_DOUT		(ADC_DOUT_4),
	// 	.ADC_CS			(),
	// 	.ADC_SCLK		(),
	// 	.ADC_register	(data_stream_ADC_4)
	// );

	// ADC_input #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	ADC_inout_5 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.ADC_DOUT		(ADC_DOUT_5),
	// 	.ADC_CS			(),
	// 	.ADC_SCLK		(),
	// 	.ADC_register	(data_stream_ADC_5)
	// );
	
	// ADC_input #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	ADC_inout_6 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.ADC_DOUT		(ADC_DOUT_6),
	// 	.ADC_CS			(),
	// 	.ADC_SCLK		(),
	// 	.ADC_register	(data_stream_ADC_6)
	// );
	
	// ADC_input #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	ADC_inout_7 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.ADC_DOUT		(ADC_DOUT_7),
	// 	.ADC_CS			(),
	// 	.ADC_SCLK		(),
	// 	.ADC_register	(data_stream_ADC_7)
	// );
	
	// ADC_input #(
	// 	.ms_wait		(ms_wait),
	// 	.ms_clk1_a 	(ms_clk1_a),
	// 	.ms_clk11_a	(ms_clk11_a)
	// 	)
	// 	ADC_inout_8 (
	// 	.reset			(reset),
	// 	.dataclk			(dataclk),
	// 	.main_state		(main_state),
	// 	.channel			(channel),
	// 	.ADC_DOUT		(ADC_DOUT_8),
	// 	.ADC_CS			(),
	// 	.ADC_SCLK		(),
	// 	.ADC_register	(data_stream_ADC_8)
	// );
    
	// MISO phase selectors (to compensate for headstage cable delays)

	MISO_phase_selector MISO_phase_selector_1 (
		.phase_select(delay_A), .MISO4x(in4x_A1), .MISO(in_A1));	

	MISO_phase_selector MISO_phase_selector_2 (
		.phase_select(delay_A), .MISO4x(in4x_A2), .MISO(in_A2));	

	MISO_phase_selector MISO_phase_selector_3 (
		.phase_select(delay_B), .MISO4x(in4x_B1), .MISO(in_B1));	

	MISO_phase_selector MISO_phase_selector_4 (
		.phase_select(delay_B), .MISO4x(in4x_B2), .MISO(in_B2));	
	
	MISO_phase_selector MISO_phase_selector_5 (
		.phase_select(delay_C), .MISO4x(in4x_C1), .MISO(in_C1));	

	MISO_phase_selector MISO_phase_selector_6 (
		.phase_select(delay_C), .MISO4x(in4x_C2), .MISO(in_C2));	
	
	MISO_phase_selector MISO_phase_selector_7 (
		.phase_select(delay_D), .MISO4x(in4x_D1), .MISO(in_D1));

	MISO_phase_selector MISO_phase_selector_8 (
		.phase_select(delay_D), .MISO4x(in4x_D2), .MISO(in_D2));	

	MISO_phase_selector MISO_phase_selector_9 (
		.phase_select(delay_E), .MISO4x(in4x_E1), .MISO(in_E1));	

	MISO_phase_selector MISO_phase_selector_10 (
		.phase_select(delay_E), .MISO4x(in4x_E2), .MISO(in_E2));	

	MISO_phase_selector MISO_phase_selector_11 (
		.phase_select(delay_F), .MISO4x(in4x_F1), .MISO(in_F1));	

	MISO_phase_selector MISO_phase_selector_12 (
		.phase_select(delay_F), .MISO4x(in4x_F2), .MISO(in_F2));	
	
	MISO_phase_selector MISO_phase_selector_13 (
		.phase_select(delay_G), .MISO4x(in4x_G1), .MISO(in_G1));	

	MISO_phase_selector MISO_phase_selector_14 (
		.phase_select(delay_G), .MISO4x(in4x_G2), .MISO(in_G2));	
	
	MISO_phase_selector MISO_phase_selector_15 (
		.phase_select(delay_H), .MISO4x(in4x_H1), .MISO(in_H1));

	MISO_phase_selector MISO_phase_selector_16 (
		.phase_select(delay_H), .MISO4x(in4x_H2), .MISO(in_H2));	
		
		
	MISO_DDR_phase_selector MISO_DDR_phase_selector_1 (
		.phase_select(delay_A), .MISO4x(in4x_A1), .MISO(in_DDR_A1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_2 (
		.phase_select(delay_A), .MISO4x(in4x_A2), .MISO(in_DDR_A2));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_3 (
		.phase_select(delay_B), .MISO4x(in4x_B1), .MISO(in_DDR_B1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_4 (
		.phase_select(delay_B), .MISO4x(in4x_B2), .MISO(in_DDR_B2));

	MISO_DDR_phase_selector MISO_DDR_phase_selector_5 (
		.phase_select(delay_C), .MISO4x(in4x_C1), .MISO(in_DDR_C1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_6 (
		.phase_select(delay_C), .MISO4x(in4x_C2), .MISO(in_DDR_C2));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_7 (
		.phase_select(delay_D), .MISO4x(in4x_D1), .MISO(in_DDR_D1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_8 (
		.phase_select(delay_D), .MISO4x(in4x_D2), .MISO(in_DDR_D2));

	MISO_DDR_phase_selector MISO_DDR_phase_selector_9 (
		.phase_select(delay_E), .MISO4x(in4x_E1), .MISO(in_DDR_E1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_10 (
		.phase_select(delay_E), .MISO4x(in4x_E2), .MISO(in_DDR_E2));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_11 (
		.phase_select(delay_F), .MISO4x(in4x_F1), .MISO(in_DDR_F1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_12 (
		.phase_select(delay_F), .MISO4x(in4x_F2), .MISO(in_DDR_F2));

	MISO_DDR_phase_selector MISO_DDR_phase_selector_13 (
		.phase_select(delay_G), .MISO4x(in4x_G1), .MISO(in_DDR_G1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_14 (
		.phase_select(delay_G), .MISO4x(in4x_G2), .MISO(in_DDR_G2));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_15 (
		.phase_select(delay_H), .MISO4x(in4x_H1), .MISO(in_DDR_H1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_16 (
		.phase_select(delay_H), .MISO4x(in4x_H2), .MISO(in_DDR_H2));





	wire [15:0] Hard_coded_data_stream_1 ; 
	wire [15:0] Hard_coded_data_stream_2 ; 
	wire [15:0] Hard_coded_data_stream_3 ; 
	wire [15:0] Hard_coded_data_stream_4 ; 
	assign Hard_coded_data_stream_1 = {1'b1,15'd1};
	assign Hard_coded_data_stream_2 = {1'b1,15'd2};
	assign Hard_coded_data_stream_3 = {1'b1,15'd3};
	assign Hard_coded_data_stream_4 = {1'b1,15'd4};

	wire 	hard_code_stream_control;
	assign 	hard_code_stream_control = ep0fwirein[0];

	assign 	data_stream_1 = hard_code_stream_control ? Hard_coded_data_stream_1 : result_A1;
	assign 	data_stream_2 = hard_code_stream_control ? Hard_coded_data_stream_2 : result_DDR_A1;
	assign 	data_stream_3 = hard_code_stream_control ? Hard_coded_data_stream_3 : result_A2;
	assign 	data_stream_4 = hard_code_stream_control ? Hard_coded_data_stream_4 : result_DDR_A2;


	//	ORIGINAL CODE
	//  assign data_stream_1 = result_A1;
	//  assign data_stream_2 = result_DDR_A1;
	//  assign data_stream_3 = result_A2;
	//  assign data_stream_4 = result_DDR_A2;
	assign data_stream_5 =  16'b0;
	assign data_stream_6 =  16'b0;
	assign data_stream_7 =  16'b0;
	assign data_stream_8 =  16'b0;
	assign data_stream_9 =  16'b0;
	assign data_stream_10 = 16'b0;
	assign data_stream_11 = 16'b0;
	assign data_stream_12 = 16'b0;
	assign data_stream_13 = 16'b0;
	assign data_stream_14 = 16'b0;
	assign data_stream_15 = 16'b0;
	assign data_stream_16 = 16'b0;
	assign data_stream_17 = 16'b0;
	assign data_stream_18 = 16'b0;
	assign data_stream_19 = 16'b0;
	assign data_stream_20 = 16'b0;
	assign data_stream_21 = 16'b0;
	assign data_stream_22 = 16'b0;
	assign data_stream_23 = 16'b0;
	assign data_stream_24 = 16'b0;
	assign data_stream_25 = 16'b0;
	assign data_stream_26 = 16'b0;
	assign data_stream_27 = 16'b0;
	assign data_stream_28 = 16'b0;
	assign data_stream_29 = 16'b0;
	assign data_stream_30 = 16'b0;
	assign data_stream_31 = 16'b0;
	assign data_stream_32 = 16'b0;
	// assign data_stream_5 = result_B1;
	// assign data_stream_6 = result_DDR_B1;
	// assign data_stream_7 = result_B2;
	// assign data_stream_8 = result_DDR_B2;
	// assign data_stream_9 = result_C1;
	// assign data_stream_10 = result_DDR_C1;
	// assign data_stream_11 = result_C2;
	// assign data_stream_12 = result_DDR_C2;
	// assign data_stream_13 = result_D1;
	// assign data_stream_14 = result_DDR_D1;
	// assign data_stream_15 = result_D2;
	// assign data_stream_16 = result_DDR_D2;
	// assign data_stream_17 = result_E1;
	// assign data_stream_18 = result_DDR_E1;
	// assign data_stream_19 = result_E2;
	// assign data_stream_20 = result_DDR_E2;
	// assign data_stream_21 = result_F1;
	// assign data_stream_22 = result_DDR_F1;
	// assign data_stream_23 = result_F2;
	// assign data_stream_24 = result_DDR_F2;
	// assign data_stream_25 = result_G1;
	// assign data_stream_26 = result_DDR_G1;
	// assign data_stream_27 = result_G2;
	// assign data_stream_28 = result_DDR_G2;
	// assign data_stream_29 = result_H1;
	// assign data_stream_30 = result_DDR_H1;
	// assign data_stream_31 = result_H2;
	// assign data_stream_32 = result_DDR_H2;
    


	wire [6:0] address_write;
	wire address_bank;
	wire halt_wire;
	wire write_enable_regfile;
	wire halt_write;
    wire    last_address_written;
	wire [6:0] rd_addr,rd_addr0, rd_addr1;
	wire [15:0] data_out0, data_out1;
	reg data_valid_readout;
    wire [15:0] data_out_regfile_to_fifo;
	wire [31:0]  fpgaout_fifoin_din;
	wire fpgaout_fifoin_wr_en;
	wire         fpgain_fifoout_ready_refile;
    wire  [6:0]  Index_number_remapped;
	wire 	[6:0]	address_index_readout_max;
    reg		[6:0]	address_index_readout;
	wire [6:0] address_ofset;




    initial begin 
    address_index_readout <= 7'd127;
    data_in_dual_bank_reg_file <= 0;
    end

    wire   trigger_fifo_rst;
    wire [15:0] rd_data_count,wr_data_count;
    wire FIFO_read_from_RFRM, pipeout_rdy_RFRM;
    wire rd_en_fifo, full, empty,wr_rst_busy,rd_rst_busy;


	assign	address_write = address_ofset + channel_MISO;
	assign write_enable_regfile = (~halt_write) && reg_file_enable;
	assign 	halt_write = (channel_MISO>=32);
	assign address_bank = timestamp[0];
	assign 	last_address_written = (address_write==7'd127)&&(write_enable_regfile==1'b1);
	
	assign data_out_regfile_to_fifo = address_bank ? data_out1 : data_out0;
	assign ep2fwireout = {data_out1,data_out0};
	// address_index_readout
	assign rd_addr = address_index_readout; 
	// assign rd_addr1 = address_index_readout;
	// assign rd_addr0 = Index_number_remapped; 
	// assign rd_addr1 = Index_number_remapped;


    assign address_index_readout_max 	= ep12wirein[6:0];
    assign ep29wireout 					= {24'b0,fpgain_fifoout_ready_refile,address_index_readout_max};
    assign ep2awireout 					= {25'b0,address_index_readout};


reg last_address_written_sync1,last_address_written_sync2;
always @(posedge dataclk) begin
  last_address_written_sync1 <= last_address_written;
  last_address_written_sync2 <= last_address_written_sync1;
end

wire reset_custom;
assign reset_custom = ep11wirein[0];

wire last_address_written_pulse_dataclk;
always @(posedge dataclk) begin
	if (reset) begin
		address_index_readout <= 16'd127;
		data_valid_readout <= 1'b0;
	end
	if (last_address_written_pulse_dataclk) begin
		address_index_readout 	<= 16'b0;
		data_valid_readout		<= 1'b1;
	end 
	else if (fpgain_fifoout_ready_refile &&(address_index_readout < address_index_readout_max)) begin
		address_index_readout 	<= address_index_readout + 1;
		data_valid_readout 		<= 1'b1;
	end 
	else if (~fpgain_fifoout_ready_refile | (address_index_readout >= address_index_readout_max)) begin
		data_valid_readout <= 1'b0;
	end
end



reg [31:0] counter_data_valid_readout,readout_condition_1_counter,readout_condition_2_counter,readout_condition_3_counter;
wire readout_condition_1,readout_condition_2,readout_condition_3;
assign readout_condition_1 = (address_index_readout < address_index_readout_max);

always @(posedge readout_condition_1) begin
    if (reset) begin
        readout_condition_1_counter <= 0;
    end 
    readout_condition_1_counter <= readout_condition_1_counter + 1;
end

// last_address_written
always @(posedge last_address_written) begin
    if (reset) begin
        readout_condition_2_counter <= 0;
    end 
    readout_condition_2_counter <= readout_condition_2_counter + 1;
end


// 1) The last_address_written signal comes from another domain
//    Create a toggle that flips whenever last_address_written goes high
// This logic runs in the last_address_written domain (replace this with your actual logic)
// 2) Synchronize toggle into dataclk domain
// 3) Detect edge of the toggle in dataclk domain (indicates an update)
// 4) Increment your counter in dataclk domain when detected
// 5) (Optional) Debug output to see when counter increments


reg last_address_written_toggle;
always @(posedge last_address_written) begin
  if (reset) begin
    last_address_written_toggle <= 0;
  end else begin
    last_address_written_toggle <= ~last_address_written_toggle;
  end
end
reg last_address_written_toggle_sync1, last_address_written_toggle_sync2;
always @(posedge dataclk) begin
  last_address_written_toggle_sync1 <= last_address_written_toggle;
  last_address_written_toggle_sync2 <= last_address_written_toggle_sync1;
end
assign last_address_written_pulse_dataclk = last_address_written_toggle_sync1 ^ last_address_written_toggle_sync2;

always @(posedge dataclk) begin
  if (reset) begin
    readout_condition_3_counter <= 0;
  end else if (last_address_written_pulse_dataclk) begin
    readout_condition_3_counter <= readout_condition_3_counter + 1;
  end
end





assign ep2bwireout = 				  readout_condition_1_counter;
assign ep2cwireout = 				  readout_condition_2_counter;
assign ep2dwireout = 				  {31'b0,reset};
assign ep2ewireout = 				  readout_condition_3_counter;

always @(posedge data_valid_readout) begin
    if (reset) begin
        counter_data_valid_readout <= 0;
    end 
    counter_data_valid_readout <= counter_data_valid_readout + 1;
end

assign ep28wireout = 				  counter_data_valid_readout;


assign fpgaout_fifoin_din           = {address_index_readout,data_out_regfile_to_fifo}  ;//
// assign fpgaout_fifoin_din           = {Index_number_remapped,data_out_regfile_to_fifo}  ;//
assign fpgaout_fifoin_wr_en         = data_valid_readout;
assign trigger_fifo_rst             = (ep00wirein[0]);
assign pipeout_rdy_RFRM             = ~empty;
assign fpgain_fifoout_ready_refile  = ~full;
assign ep27wireout                  = rd_data_count[15:0];


// Wires for regfile remapping



    lookup_table_case #(.OUT_WIDTH(7)) lookup_table_case (
        .in(reg_value),
        .out(address_ofset)
    );


// Wires for FIFO

// wires for dual port RAM



/// REGFILE INSTANTIATIONS BELOW
regfile_remapper regfile_remapper (
.clk(			dataclk),
.ep10wirein(	ep10wirein), 
.ep26wireout(	ep26wireout),
.Index_number(	address_index_readout), 
.Index_number_remapped(	Index_number_remapped)
    );
/// REGFILE INSTANTIATIONS ABOVE


// DUAL PORT RAM INSTANTIATIONS BELOW
    dual_bank_regfile dual_bank_regfile (
        .clk(dataclk),
        .rst(reset),
        .we(write_enable_regfile),
        .bank_sel(address_bank),
        .wr_addr(address_write),
        .data_in(data_in_dual_bank_reg_file),
        .rd_addr(rd_addr),
        // .rd_addr1(rd_addr),
        .data_out0(data_out0),
        .data_out1(data_out1),
		.ep_something(ep13wirein)

    );
// DUAL PORT RAM INSTANTIATIONS ABOVE



// FIFO INSTANTIATIONS BELOW
fifo_generator_0 fifo_hehe (
  .rst(trigger_fifo_rst),                      // input wire rst
  .wr_clk(dataclk),                // input wire wr_clk
  .rd_clk(okClk),                // input wire rd_clk
  .din(     fpgaout_fifoin_din),                      // input wire [31 : 0] din
  .wr_en(   fpgaout_fifoin_wr_en),                  // input wire wr_en
  .rd_en(   FIFO_read_from_RFRM),                  // input wire rd_en
  .dout(    FIFO_data_out_RFRM),                    // output wire [31 : 0] dout
  .full(full),                    // output wire full
  .empty(empty),                  // output wire empty
  .rd_data_count(rd_data_count),  // output wire [15 : 0] rd_data_count
  .wr_data_count(wr_data_count),  // output wire [15 : 0] wr_data_count
  .wr_rst_busy(wr_rst_busy),      // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)      // output wire rd_rst_busy
);
// FIFO INSTANTIATIONS ABOVE










    /* Standard Opal Kelly end */
    // Instantiate the okHost and connect endpoints.
    okHost okHI(
        .okUH(okUH),
        .okHU(okHU),
        .okUHU(okUHU),
        .okAA(okAA),
        .okClk(okClk),
        .okHE(okHE),
        .okEH(okEH)
    );
    
	wire [65*34-1:0] 	okEHx;
	okWireOR # (.N(34)) wireOR (okEH, okEHx);

	okWireIn     wi00 (.okHE(okHE),                            .ep_addr(8'h00), .ep_dataout(ep00wirein));
	okWireIn     wi01 (.okHE(okHE),                            .ep_addr(8'h01), .ep_dataout(ep01wirein)); // Time_step	
	okWireIn     wi02 (.okHE(okHE),                            .ep_addr(8'h02), .ep_dataout(ep02wirein)); // serial_CLK_manual, serial_LOAD_manual, 
	okWireIn     wi03 (.okHE(okHE),                            .ep_addr(8'h03), .ep_dataout(ep03wirein)); // dataclk_M, dataclk_D
	okWireIn     wi04 (.okHE(okHE),                            .ep_addr(8'h04), .ep_dataout(ep04wirein)); // delay_A, delay_B, delay_C, delay_D, delay_E, delay_F, delay_G, delay_H
	okWireIn     wi05 (.okHE(okHE),                            .ep_addr(8'h05), .ep_dataout(ep05wirein)); // RAM_addr_wr
	okWireIn     wi06 (.okHE(okHE),                            .ep_addr(8'h06), .ep_dataout(ep06wirein)); // RAM_bank_sel_wr
	okWireIn     wi07 (.okHE(okHE),                            .ep_addr(8'h07), .ep_dataout(ep07wirein)); // RAM_data_in
	okWireIn     wi08 (.okHE(okHE),                            .ep_addr(8'h08), .ep_dataout(ep08wirein)); // aux_cmd_bank_1_A_in, aux_cmd_bank_1_B_in, aux_cmd_bank_1_C_in, aux_cmd_bank_1_D_in, aux_cmd_bank_1_E_in, aux_cmd_bank_1_F_in, aux_cmd_bank_1_G_in, aux_cmd_bank_1_H_in
	okWireIn     wi09 (.okHE(okHE),                            .ep_addr(8'h09), .ep_dataout(ep09wirein)); // aux_cmd_bank_2_A_in, aux_cmd_bank_2_B_in, aux_cmd_bank_1_C_in, aux_cmd_bank_1_D_in, aux_cmd_bank_1_E_in, aux_cmd_bank_1_F_in, aux_cmd_bank_1_G_in, aux_cmd_bank_1_H_in
	okWireIn     wi0a (.okHE(okHE),                            .ep_addr(8'h0a), .ep_dataout(ep0awirein)); // aux_cmd_bank_3_A_in, aux_cmd_bank_3_B_in, aux_cmd_bank_1_C_in, aux_cmd_bank_1_D_in, aux_cmd_bank_1_E_in, aux_cmd_bank_1_F_in, aux_cmd_bank_1_G_in, aux_cmd_bank_1_H_in
	okWireIn     wi0b (.okHE(okHE),                            .ep_addr(8'h0b), .ep_dataout(ep0bwirein)); // max_aux_cmd_index_1_in, max_aux_cmd_index_2_in, max_aux_cmd_index_3_in
	okWireIn     wi0c (.okHE(okHE),                            .ep_addr(8'h0c), .ep_dataout(ep0cwirein)); // loop_aux_cmd_index_1, loop_aux_cmd_index_2, loop_aux_cmd_index_3
	okWireIn     wi0d (.okHE(okHE),                            .ep_addr(8'h0d), .ep_dataout(ep0dwirein)); // led_in
	okWireIn     wi0e (.okHE(okHE),                            .ep_addr(8'h0e), .ep_dataout(ep0ewirein)); // DAC_reref_channel_sel,DAC_reref_stream_sel,DAC_reref_mode
	okWireIn     wi0f (.okHE(okHE),                            .ep_addr(8'h0f), .ep_dataout(ep0fwirein)); // used for  mux control
	okWireIn     wi10 (.okHE(okHE),                            .ep_addr(8'h10), .ep_dataout(ep10wirein)); // remapper
	okWireIn     wi11 (.okHE(okHE),                            .ep_addr(8'h11), .ep_dataout(ep11wirein)); // custom reset 
	okWireIn     wi12 (.okHE(okHE),                            .ep_addr(8'h12), .ep_dataout(ep12wirein)); // NC
	okWireIn     wi13 (.okHE(okHE),                            .ep_addr(8'h13), .ep_dataout(ep13wirein)); // dual_data
	okWireIn     wi14 (.okHE(okHE),                            .ep_addr(8'h14), .ep_dataout(ep14wirein)); // data_stream_1_en_in - data_stream_31_en_in
	okWireIn     wi15 (.okHE(okHE),                            .ep_addr(8'h15), .ep_dataout(ep15wirein)); // TTL_out_user
	okWireIn     wi16 (.okHE(okHE),                            .ep_addr(8'h16), .ep_dataout(ep16wirein)); // DAC_channel_sel_1, DAC_stream_sel_1, DAC_en_1

	okWireIn     wi17 (.okHE(okHE),                            .ep_addr(8'h17), .ep_dataout(ep17wirein)); // DAC_channel_sel_2, DAC_stream_sel_2, DAC_en_2
	okWireIn     wi18 (.okHE(okHE),                            .ep_addr(8'h18), .ep_dataout(ep18wirein)); // DAC_channel_sel_3, DAC_stream_sel_3, DAC_en_3
	okWireIn     wi19 (.okHE(okHE),                            .ep_addr(8'h19), .ep_dataout(ep19wirein)); // DAC_channel_sel_4, DAC_stream_sel_4, DAC_en_4
	okWireIn     wi1a (.okHE(okHE),                            .ep_addr(8'h1a), .ep_dataout(ep1awirein)); // DAC_channel_sel_5, DAC_stream_sel_5, DAC_en_5
	okWireIn     wi1b (.okHE(okHE),                            .ep_addr(8'h1b), .ep_dataout(ep1bwirein)); // DAC_channel_sel_6, DAC_stream_sel_6, DAC_en_6
	okWireIn     wi1c (.okHE(okHE),                            .ep_addr(8'h1c), .ep_dataout(ep1cwirein)); // DAC_channel_sel_7, DAC_stream_sel_7, DAC_en_7
	okWireIn     wi1d (.okHE(okHE),                            .ep_addr(8'h1d), .ep_dataout(ep1dwirein)); // DAC_channel_sel_8, DAC_stream_sel_8, DAC_en_8
	okWireIn     wi1e (.okHE(okHE),                            .ep_addr(8'h1e), .ep_dataout(ep1ewirein)); // DAC_manual
	okWireIn     wi1f (.okHE(okHE),                            .ep_addr(8'h1f), .ep_dataout(ep1fwirein)); // control signals in tamdom with ep40trigin 
	
	okTriggerIn  ti40 (.okHE(okHE),                            .ep_addr(8'h40), .ep_clk(okClk),  .ep_trigger(ep40trigin)); // MMCM_prog_trigger,RAM_we_1,RAM_we_2,RAM_we_3,


	okTriggerIn  ti41 (.okHE(okHE),                            .ep_addr(8'h41), .ep_clk(dataclk), .ep_trigger(ep41trigin)); // SPI_start
	okTriggerIn  ti42 (.okHE(okHE),                            .ep_addr(8'h42), .ep_clk(okClk),  .ep_trigger(ep42trigin)); // DAC
	
	okWireOut    wo20 (.okHE(okHE), .okEH(okEHx[ 0*65 +: 65 ]),  .ep_addr(8'h20), .ep_datain(ep20wireout));	// ep20 =	num_words_in_FIFO;
	okWireOut    wo21 (.okHE(okHE), .okEH(okEHx[ 1*65 +: 65 ]),  .ep_addr(8'h21), .ep_datain(ep21wireout));	// ep21 =	{ 16'b0, 12'b0, expander_ID_1, expander_detect, TTL_in_serial_exp, TTL_in_serial };
	okWireOut    wo22 (.okHE(okHE), .okEH(okEHx[ 2*65 +: 65 ]),  .ep_addr(8'h22), .ep_datain(ep22wireout));	// ep22 =	{ 16'b0, 15'b0, SPI_running };
	okWireOut    wo23 (.okHE(okHE), .okEH(okEHx[ 3*65 +: 65 ]),  .ep_addr(8'h23), .ep_datain(ep23wireout));	// ep23 = 	{ 16'b0, TTL_in };
	okWireOut    wo24 (.okHE(okHE), .okEH(okEHx[ 4*65 +: 65 ]),  .ep_addr(8'h24), .ep_datain(ep24wireout));	// ep24 = 	{ 16'b0, 14'b0, MMCM_prog_done, dataclk_locked };
	okWireOut    wo25 (.okHE(okHE), .okEH(okEHx[ 5*65 +: 65 ]),  .ep_addr(8'h25), .ep_datain(ep25wireout));	// ep25 = 	{ 16'b0, 12'b0, board_mode };


	okWireOut    wo26 (.okHE(okHE), .okEH(okEHx[ 6*65 +: 65 ]),  .ep_addr(8'h26), .ep_datain(ep26wireout)); // REGFILE data out
	okWireOut    wo27 (.okHE(okHE), .okEH(okEHx[ 7*65 +: 65 ]),  .ep_addr(8'h27), .ep_datain(ep27wireout)); // NC
	okWireOut    wo28 (.okHE(okHE), .okEH(okEHx[ 8*65 +: 65 ]),  .ep_addr(8'h28), .ep_datain(ep28wireout)); // counter_data_valid_readout
	okWireOut    wo29 (.okHE(okHE), .okEH(okEHx[ 9*65 +: 65 ]),  .ep_addr(8'h29), .ep_datain(ep29wireout)); // NC
	okWireOut    wo2a (.okHE(okHE), .okEH(okEHx[ 10*65 +: 65 ]), .ep_addr(8'h2a), .ep_datain(ep2awireout)); // NC
	okWireOut    wo2b (.okHE(okHE), .okEH(okEHx[ 11*65 +: 65 ]), .ep_addr(8'h2b), .ep_datain(ep2bwireout)); // NC
	okWireOut    wo2c (.okHE(okHE), .okEH(okEHx[ 12*65 +: 65 ]), .ep_addr(8'h2c), .ep_datain(ep2cwireout)); // NC
	okWireOut    wo2d (.okHE(okHE), .okEH(okEHx[ 13*65 +: 65 ]), .ep_addr(8'h2d), .ep_datain(ep2dwireout)); // NC
	okWireOut    wo2e (.okHE(okHE), .okEH(okEHx[ 14*65 +: 65 ]), .ep_addr(8'h2e), .ep_datain(ep2ewireout)); // NC
	okWireOut    wo2f (.okHE(okHE), .okEH(okEHx[ 15*65 +: 65 ]), .ep_addr(8'h2f), .ep_datain(ep2fwireout)); // dual_bank_out
	okWireOut    wo30 (.okHE(okHE), .okEH(okEHx[ 16*65 +: 65 ]), .ep_addr(8'h30), .ep_datain(ep30wireout)); // NC
	okWireOut    wo31 (.okHE(okHE), .okEH(okEHx[ 17*65 +: 65 ]), .ep_addr(8'h31), .ep_datain(ep31wireout)); // NC
	okWireOut    wo32 (.okHE(okHE), .okEH(okEHx[ 18*65 +: 65 ]), .ep_addr(8'h32), .ep_datain(ep32wireout)); // NC
	okWireOut    wo33 (.okHE(okHE), .okEH(okEHx[ 19*65 +: 65 ]), .ep_addr(8'h33), .ep_datain(ep33wireout)); // NC
	okWireOut    wo34 (.okHE(okHE), .okEH(okEHx[ 20*65 +: 65 ]), .ep_addr(8'h34), .ep_datain(ep34wireout)); // NC
	okWireOut    wo35 (.okHE(okHE), .okEH(okEHx[ 21*65 +: 65 ]), .ep_addr(8'h35), .ep_datain(ep35wireout)); // NC
	okWireOut    wo36 (.okHE(okHE), .okEH(okEHx[ 22*65 +: 65 ]), .ep_addr(8'h36), .ep_datain(ep36wireout)); // NC
	okWireOut    wo37 (.okHE(okHE), .okEH(okEHx[ 23*65 +: 65 ]), .ep_addr(8'h37), .ep_datain(ep37wireout)); // NC
	okWireOut    wo38 (.okHE(okHE), .okEH(okEHx[ 24*65 +: 65 ]), .ep_addr(8'h38), .ep_datain(ep38wireout)); // NC
	okWireOut    wo39 (.okHE(okHE), .okEH(okEHx[ 25*65 +: 65 ]), .ep_addr(8'h39), .ep_datain(ep39wireout)); // NC
	okWireOut    wo3a (.okHE(okHE), .okEH(okEHx[ 26*65 +: 65 ]), .ep_addr(8'h3a), .ep_datain(ep3awireout)); // NC
	okWireOut    wo3b (.okHE(okHE), .okEH(okEHx[ 27*65 +: 65 ]), .ep_addr(8'h3b), .ep_datain(ep3bwireout)); // NC
	okWireOut    wo3c (.okHE(okHE), .okEH(okEHx[ 28*65 +: 65 ]), .ep_addr(8'h3c), .ep_datain(ep3cwireout)); // NC
	okWireOut    wo3d (.okHE(okHE), .okEH(okEHx[ 29*65 +: 65 ]), .ep_addr(8'h3d), .ep_datain(ep3dwireout)); // used for debug ep00
	okWireOut    wo3e (.okHE(okHE), .okEH(okEHx[ 30*65 +: 65 ]), .ep_addr(8'h3e), .ep_datain(ep3ewireout)); // { 16'b0, BOARD_ID };
	okWireOut    wo3f (.okHE(okHE), .okEH(okEHx[ 31*65 +: 65 ]), .ep_addr(8'h3f), .ep_datain(ep3fwireout)); // { 16'b0, BOARD_VERSION };
	
	wire pipeout_rdy;
	assign pipeout_rdy = ( FIFO_out_rdy | pipeout_override_en);
	
	// Flip the 16-bit words in the fifo for compatibility with the USB2 read methods
	okBTPipeOut    poa0 (.okHE(okHE), .okEH(okEHx[ 32*65 +: 65 ]), .ep_addr(8'ha0), .ep_read(FIFO_read_from), 
		.ep_blockstrobe(), .ep_datain({FIFO_data_out[15:0], FIFO_data_out[31:16]}), .ep_ready(pipeout_rdy));


	okBTPipeOut    poa1 (.okHE(okHE), .okEH(okEHx[ 33*65 +: 65 ]), .ep_addr(8'ha1), .ep_read(FIFO_read_from_RFRM), .ep_blockstrobe(), .ep_datain(FIFO_data_out_RFRM), .ep_ready(pipeout_rdy_RFRM));



endmodule


// This simple module creates MOSI commands.  If channel is between 0 and 31, the command is CONVERT(channel),
// and the LSB is set if DSP_settle = 1.  If channel is between 32 and 34, aux_cmd is used.
module command_selector (
	input wire [5:0] 		channel,
	input wire				DSP_settle,
	input wire [15:0] 	aux_cmd,
	input wire				digout_override,
	output reg [15:0] 	MOSI_cmd
	);

	always @(*) begin
		case (channel)
			0:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			1:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			2:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			3:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			4:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			5:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			6:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			7:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			8:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			9:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			10:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			11:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			12:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			13:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			14:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			15:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			16:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			17:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			18:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			19:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			20:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			21:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			22:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			23:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			24:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			25:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			26:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			27:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			28:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			29:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			30:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			31:      MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			32:		MOSI_cmd <= (aux_cmd[15:8] == 8'h83) ? {aux_cmd[15:1], digout_override} : aux_cmd; // If we detect a write to Register 3, overridge the digout value.
			33:		MOSI_cmd <= (aux_cmd[15:8] == 8'h83) ? {aux_cmd[15:1], digout_override} : aux_cmd; // If we detect a write to Register 3, overridge the digout value.
			34:		MOSI_cmd <= (aux_cmd[15:8] == 8'h83) ? {aux_cmd[15:1], digout_override} : aux_cmd; // If we detect a write to Register 3, overridge the digout value.
			default: MOSI_cmd <= 16'b0;
			endcase
	end	
	
endmodule











 module regfile_remapper 
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






module lookup_table_case #(
    parameter OUT_WIDTH = 8  // Default output width (can be changed)
)(
    input wire [2:0] in,       // 3-bit input
    output reg [OUT_WIDTH-1:0] out  // Parameterized output width
);

    always @(*) begin
        case (in)
            3'b000: out = 8'h00; // Example: 0
            3'b001: out = 8'h20;// Example: All 1s
            3'b010: out = 8'h40;              // Example: 0b10101010
            3'b011: out = 8'h60;              // Example: 0b01010101
            3'b100: out = 8'hFF;              // Example: 0b00001111
            3'b101: out = 8'hFF;              // Example: 0b11110000
            3'b110: out = 8'hFF;              // Example: 0b00110011
            3'b111: out = 8'hFF;              // Example: 0b11001100
            default: out = {OUT_WIDTH{1'b0}}; // Default case
        endcase
    end

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
			reg_128x7bit_map[j] <= j;
		end
	end

	always @(posedge clk) begin
		if (reset)begin 
			for (k=0; k<128; k=k+1) begin
				reg_128x7bit_map[k] <= k;
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
    





module dual_bank_regfile (
    input wire clk,
    input wire rst,
    input wire we,                    // Write enable
    input wire bank_sel,              // Bank select for writing (0: Bank 0, 1: Bank 1)
    input wire [6:0] wr_addr,         // 7-bit write address (128 entries)
    input wire [15:0] data_in,        // Data to write
    input wire [6:0] rd_addr,        // Read address for Bank 0
    output wire [15:0] data_out0,     // Data output from Bank 0
    output wire [15:0] data_out1,      // Data output from Bank 1
	input wire [31:0] ep_something  // Read address for Bank 1
);


    reg [15:0] bank0 [127:0];  // 128 x 16-bit register bank 0
    reg [15:0] bank1 [127:0];  // 128 x 16-bit register bank 1



integer i,j;
initial begin 

	for (j = 0; j < 128; j = j + 1) begin
		bank0[j] <= 16'd5;
		bank1[j] <= 16'd5;
	end

end


    always @(negedge clk) begin
    // always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 128; i = i + 1) begin
                bank0[i] <= 16'b0;
                bank1[i] <= 16'b0;
            end
        end else if (we) begin
            // Write operation
            if (bank_sel) begin 
                bank1[wr_addr] <= data_in;  // Write to Bank 1
			end else begin 
                bank0[wr_addr] <= data_in;  // Write to Bank 0
			end
        end
    end

	wire [6:0] final_rd_addr;
	assign final_rd_addr = (ep_something[7] == 1'b1) ? ep_something[6:0]: rd_addr; // Use ep_something for read address if it is not zero
    assign data_out0 = bank0[rd_addr];  // Read from Bank 0
    assign data_out1 = bank1[rd_addr];  // Read from Bank 1

endmodule














/*         EMULATOR BELOW      */



module sensor_Mosi_I ( 
	
	
	input wire  clk_i, 
	input wire  reset_i, 
	input wire  CS_i, 
	input wire  MOSI_i, 
	output wire MISO_1, 
	output wire MISO_2
	
	);


wire miso_ddr2;
wire MISO_bit_a2;
wire MISO_bit_b2;

wire [15:0] MISO_a, MISO_b;
wire [15:0] MISO_a2, MISO_b2;

// Test MOSI for sensor B for DDR
wire [15:0] miso_test_reg; 


wire SCLK_wire;
wire reset,CS_b_wire;
wire MOSI_to_sensor;
wire miso_ddr;
wire MISO_bit_a;
wire MISO_bit_b;

assign SCLK_wire = clk_i;
assign reset 			= reset_i;
assign CS_b_wire 		= CS_i;
assign MOSI_to_sensor 	= MOSI_i;
assign MISO_1 			= miso_ddr;
assign MISO_2 			= miso_ddr2;








// initial begin
// 	miso_test_reg = 16'b1010_1100_1111_0001; 
// end


	sensor_emulator #( .offset(0)) sensor_emulator_a (
		.clk(SCLK_wire),
		.reset(reset), 
		.CS(CS_b_wire),
		.MOSI(MOSI_to_sensor),
		.MISO(MISO_a)
	);
	
	sensor_emulator #( .offset(32)) sensor_emulator_b (
		.clk(SCLK_wire),
		.reset(reset), 
		.CS(CS_b_wire),
		.MOSI(MOSI_to_sensor),
		.MISO(MISO_b)
	);

	shift_reg shift_reg_a (
		.clk(SCLK_wire),
		//.clk(SCLK_wire),
		.reset(reset), 
		.CS(CS_b_wire),
		.MISO_full(MISO_a),
		.MISO(MISO_bit_a)
	);

	shift_reg shift_reg_b (
		//.clk(SCLK_wire),
		.clk(~SCLK_wire),
		.reset(reset), 
		.CS(CS_b_wire),
		//.MISO_full(miso_test_reg),
		.MISO_full(MISO_b),
		.MISO(MISO_bit_b)
	);

	ddr_mux ddr_mux (
		.clk(SCLK_wire),     
		.CS(CS_b_wire),  
    	.miso_a(MISO_bit_a),    
    	.miso_b(MISO_bit_b),    
    	.miso_ddr(miso_ddr)  
	);



// second line below 
	sensor_emulator #( .offset(64)) sensor_emulator_a2 (
		.clk(SCLK_wire),
		.reset(reset), 
		.CS(CS_b_wire),
		.MOSI(MOSI_to_sensor),
		.MISO(MISO_a2)
	);
	
	sensor_emulator #( .offset(96)) sensor_emulator_b2 (
		.clk(SCLK_wire),
		.reset(reset), 
		.CS(CS_b_wire),
		.MOSI(MOSI_to_sensor),
		.MISO(MISO_b2)
	);


	shift_reg shift_reg_a2 (
		.clk(SCLK_wire),
		//.clk(SCLK_wire),
		.reset(reset), 
		.CS(CS_b_wire),
		.MISO_full(MISO_a2),
		.MISO(MISO_bit_a2)
	);

	shift_reg shift_reg_b2 (
		//.clk(SCLK_wire),
		.clk(~SCLK_wire),
		.reset(reset), 
		.CS(CS_b_wire),
		//.MISO_full(miso_test_reg),
		.MISO_full(MISO_b2),
		.MISO(MISO_bit_b2)
	);

	ddr_mux ddr_mux2 (
		.clk(SCLK_wire),     
		.CS(CS_b_wire),  
    	.miso_a(MISO_bit_a2),    
    	.miso_b(MISO_bit_b2),    
    	.miso_ddr(miso_ddr2)  
	);

	endmodule





module sensor_emulator #(  parameter offset = 0 ) (
input wire clk,
input wire reset, 
input wire CS,
input wire MOSI,
output wire [15:0] MISO
//output wire MISO
);
/*
- Command is 16 bits wide
- Read one bit of command per CLK cycle
- Make bit counter to divide bits by 16 and distinguish commands
- MISO is 2 cycles behind MOSI and is DDR (32 bits by cycle)

MOSI command selector:
case (channel)
			0:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			1:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
			2:       MOSI_cmd <= { 2'b00, channel, 7'b0000000, DSP_settle };
            ...
            MOSI_cmd <= (aux_cmd[15:8] == 8'h83) ? {aux_cmd[15:1], digout_override} : aux_cmd;
*/

reg [15:0] MOSI_current_reg;
reg [15:0] MOSI_stored_reg;
reg [15:0] MISO_reg;
reg MISO_bit_reg;
reg [4:0] bit_count;
reg [3:0] bit_pointer;
reg [7:0] read_reg [63:0]; // 64 long reg file, byte long each -> stores on-chip registers where they are READ-only from 40 - 64
reg [15:0] conv_reg [31:0]; // 32 long reg file, 2 byte long each

// Populate reg file values and zero other registers
integer i;
initial begin
	bit_pointer = 4'b0;
	// CONVERT Reg File Initialization
	for (i=0; i < 32; i=i+1)begin 
            conv_reg[i] <= i;  
    end

    // READ-Only Reg File Initialization
    // On-chip registers:
    // 0 - 39
    for (i=0; i < 40; i=i+1)begin 
            read_reg[i] <= i;  
    end

    // On-chip Read Only registers:
    // 40 - 44
    read_reg[40] = 8'b01001001; // I 
    read_reg[41] = 8'b01001110; // N
    read_reg[42] = 8'b01010100; // T
    read_reg[43] = 8'b01000001; // A
    read_reg[44] = 8'b01001110; // N

    // 45 - 59
    for (i=45; i < 60; i=i+1)begin 
            read_reg[i] <= i;  
    end

    // 60 - 63
    read_reg[60] = 8'b00000001;
    read_reg[61] = 8'b00100000;
    read_reg[62] = 8'b00010000; // maybe should be 64 but datasheet gave only two options (32 or 16)
    read_reg[63] = 8'b00000001; // same as above but RHD2132 is 1 and RHD2216 is 1

    MOSI_current_reg = 16'b0;
    MOSI_stored_reg = 16'b0;
	MISO_reg = 16'b0;
    bit_count = 5'b0;
end

assign MISO = MISO_reg;
// assign MISO = 0101010101010101;
//assign MISO = MISO_bit_reg;

// Command tracking and storing block
always @ (posedge clk or posedge reset) begin
    
    if (reset || CS) begin
        MOSI_current_reg <= 16'b0;
        bit_count <= 5'b0;
    end else if (!CS) begin
        MOSI_current_reg <= {MOSI_current_reg[14:0], MOSI};

        // Increment bit counter up to 16
        if (bit_count < 16) begin
            bit_count <= bit_count + 1; // Increment after CS high and posedge after 1 cycle
        end else begin // MOSI_current_reg's 16 bits are filled with a full command
            bit_count <= 5'b00001;
			MOSI_stored_reg <= MOSI_current_reg; 
        	MOSI_current_reg <= {15'b0, MOSI};

			// MISO library
			casez (MOSI_stored_reg[15:12]) // CHANGE to 16 bit case
				// 4'b00??: MISO_reg <= conv_reg[MOSI_stored_reg[13:8]]; // CONVERT --> MISO_reg becomes value from conv_reg[channel]
				4'b00??: begin MISO_reg <= conv_reg[MOSI_stored_reg[13:8]] + offset;
					// # offset;
					// $display("%d Convert %b, %d",offset, MOSI_stored_reg[15:12],conv_reg[MOSI_stored_reg[13:8]]+offset);
				end				
				
				4'b10??: begin
					MISO_reg <= {8'b1, MOSI_stored_reg[7:0]}; // WRITE --> MISO_reg echoes data byte to be written
					// $display("WRITE");
				end
				4'b11??: begin
					MISO_reg <= {8'b0, read_reg[MOSI_stored_reg[13:8]]}; // READ --> MISO_reg becomes concatenated value of 0's and read_reg[channel]
					// $display("READ %b", read_reg[MOSI_stored_reg[13:8]]);
				end
				4'b0101: begin
					MISO_reg <= 16'b0; // CALIBRATE --> MISO_reg becomes 0, MSB is 1 if 2's complement mode disabled
					// $display("CALIBRATE");
				end
				4'b0110: begin
					MISO_reg <= 16'b0; // CLEAR --> MISO_reg becomes 0, MSB is 1 if 2's complement mode disabled
					// $display("CLEAR");
				end
				default: MISO_reg <= 16'b0;
			endcase

            //$display("bit_count %d MOSI_current_reg %b",bit_count, MOSI_current_reg); // Fix MOSI_current_reg

        end
    end
end

/*
// Shift Reg MISO bit by bit output
always @ (posedge clk or posedge reset or posedge CS) begin
    if (reset || CS) begin
        MISO_bit_reg <= 1'b0;
		bit_pointer <= 4'b0;
    end else if (!CS && (bit_pointer < 16)) begin
		MISO_bit_reg <= MISO_reg[15 - bit_pointer];  // MSB first
        bit_pointer <= bit_pointer + 1;         // Move to the next bit
	end
end
*/

/*
always @ (posedge CS) begin
 $display("CS is high %h", MOSI_current_reg);
end
*/

endmodule






module shift_reg (
	input wire clk,
	input wire reset,
	input wire CS,
	input wire [15:0] MISO_full,
	output wire MISO
);
	reg MISO_bit_reg;
	reg [3:0] bit_pointer;
	//reg [15:0] MISO_reg;
	assign MISO = MISO_bit_reg;
	//assign MISO_reg = MISO_full;
	initial begin
		bit_pointer = 4'b0;
	end
	wire special_clk;
	assign special_clk = clk | CS;
	wire special_clk_ddr;
	assign special_clk_ddr = ~clk | CS;
	// Shift Reg MISO bit by bit output
	// always @ (posedge clk or posedge reset or posedge CS) begin
	// 	if (reset || CS) begin
	// 		MISO_bit_reg <= 1'b0;
	// 		bit_pointer <= 4'b0;
	// 	end else if (!CS && (bit_pointer < 16)) begin
	// 		MISO_bit_reg <= MISO_full[15 - bit_pointer];  // MSB first
	// 		bit_pointer <= bit_pointer + 1;         // Move to the next bit
	// 	end
	// end
	always @ (negedge special_clk or posedge reset or posedge CS) begin
		if (reset || CS) begin
			MISO_bit_reg <= 1'b0;
			bit_pointer <= 4'b0;
		end else if (!CS && (bit_pointer < 16)) begin
			MISO_bit_reg <= MISO_full[15 - bit_pointer];  // MSB first
			bit_pointer <= bit_pointer + 1;         // Move to the next bit
		end
	end
endmodule



module ddr_mux (
    input wire clk,    // SCLK
	input wire CS, 	   // CS
    input wire miso_a, // Input sampled on rising edge
    input wire miso_b, // Input sampled on falling edge
    output wire miso_ddr // 1-bit DDR output
);

	wire miso_ddr_a;
    assign     miso_ddr_a = clk ? miso_a : miso_b; // Output miso_a or miso_b on CS high
    assign     miso_ddr = CS ? 1'b0 : miso_ddr_a; // Output miso_a or miso_b on CS high
	// always @(posedge CS) begin
    //     miso_ddr <= 1'b0; // Reset miso_ddr on CS
    // end
    // always @(posedge clk) begin
    //     miso_ddr <= miso_a; // Output miso_a on rising edge
    // end
    // always @(negedge clk) begin
    //     miso_ddr <= miso_b; // Output miso_b on falling edge
    // end

endmodule














/*         EMULATOR ABOVE      */
