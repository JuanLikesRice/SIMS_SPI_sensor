 module main #(  parameter mem_size = 4096 ) (
input  wire  clk,
input  wire  reset,
output  wire  MOSI_to_sensor, 
output wire  MISO_from_sensor,
output wire SCLK_wire,
output wire CS_b_wire,
output wire  sample_CLK_out
);

wire MISO;
    FPGA fpga_inst (
        .clk(clk),
        .reset(reset),
        .MOSI_to_sensor(MOSI_to_sensor), // This you care
		.MISO_from_sensor(MOSI_to_sensor),
        .SCLK_wire(SCLK_wire),// This you care
        .CS_b_wire(CS_b_wire), // This you care
        .sample_CLK_out(sample_CLK_out)
    );

	// sensor_emulator sensor_emulator (
	// 	.clk(SCLK_wire),
	// 	.reset(reset), 
	// 	.CS(CS_b_wire),
	// 	.MOSI(MOSI_to_sensor),
	// 	.MISO(MISO)
	// );



	// Your module goes here

endmodule








module FPGA (
input wire  clk,
input wire  reset, 
input wire MISO_from_sensor,
output wire MOSI_to_sensor,
output wire SCLK_wire,
output wire CS_b_wire,
output reg  sample_CLK_out
);
	assign 	CS_b_wire = CS_b;
	assign TTL_out_direct = TTL_out_mode ? {TTL_out_user[15:8], DAC_thresh_out} : TTL_out_user;
	assign dataclk = clk;
	assign SCLK_wire = SCLK;
	assign SPI_start = 1;
	assign DSP_settle = 0;
	assign MOSI_to_sensor = MOSI_A;
	custom_command_selector command_selector_A (
		.channel(channel), .DSP_settle(DSP_settle), .aux_cmd(aux_cmd_A), .digout_override(external_digout_A), .MOSI_cmd(MOSI_cmd_selected_A));
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
	wire [15:0]		data_stream_ADC_1, data_stream_ADC_2, data_stream_ADC_3, data_stream_ADC_4;
	wire [15:0]		data_stream_ADC_5, data_stream_ADC_6, data_stream_ADC_7, data_stream_ADC_8;
	
	wire				TTL_out_mode;
	reg [15:0]		TTL_out_user;
	
	wire			SPI_start, SPI_run_continuous;
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

    // Moved up from input deserializer
	wire [15:0] TTL_in, TTL_parallel;
	wire serial_CLK_auto, serial_LOAD_auto;
    

	wire [5:0] num_data_streams_enabled;
	
	//MODIFIED LOGIC
	// Engineer Name: Curtis North
	// Date: 1/26/2013

	//	from ep wires (Opal Kelly)
	// assign delay_A = 						ep04wirein[3:0];
	assign delay_A			   		= 4'b1;
	assign data_stream_1_en_in 		= 1'b1; // 						ep14wirein[0];
	assign data_stream_2_en_in 		= 1'b1; // 						ep14wirein[0];
	assign data_stream_3_en_in 		= 1'b1; // 						ep14wirein[0];
	assign data_stream_4_en_in 		= 1'b1; // 						ep14wirein[0];
	assign num_data_streams_enabled = 5'd4; //						


	assign data_stream_1 = result_A1;
	assign data_stream_2 = result_DDR_A1;
	assign data_stream_3 = result_A2;
	assign data_stream_4 = result_DDR_A2;
	wire [6:0] address_ofset;

	wire MOSI2_A, MOSI1_A;
    assign CS_b_A = CS_b;
	assign SCLK_A = SCLK;
	assign MOSI1_A = MOSI_A;
	assign MOSI2_A = 1'b0;
	assign MISO1_A = MISO_from_sensor;
	assign MISO2_A = MISO_from_sensor;
	assign MISO_A1 = MISO1_A;
	assign MISO_A2 = MISO2_A;
	wire [6:0] address_write;
	wire address_bank;

	assign	address_write = address_ofset + channel_MISO;
	
	wire halt_wire;
	wire write_enable_regfile;

	assign write_enable_regfile = (~halt_write) && reg_file_enable;
	assign 	halt_write = (channel_MISO>=32);


	assign address_bank = timestamp[0];
	reg [15:0] data_in_dual_bank_reg_file;

	//signals for regfile

	//Write signals -->
	//address_bank
	//address_write
	//write_enable_regfile
    wire    last_address_written;
	wire [6:0] rd_addr0, rd_addr1;
	reg  [6:0] address_index_readout;
	wire [15:0] data_out0, data_out1;

	assign 	last_address_written = (address_write==7'd127)&&(write_enable_regfile==1'b1);
    dual_bank_regfile dual_bank_regfile (
        .clk(dataclk),
        .rst(reset),
        .we(write_enable_regfile),
        .bank_sel(address_bank),
        .wr_addr(address_write),
        .data_in(data_in_dual_bank_reg_file),
        .rd_addr0(rd_addr0),
        .rd_addr1(rd_addr0),
        .data_out0(data_out0),
        .data_out1(data_out1)
    );
    wire [15:0] data_out_regfile_to_fifo;
	assign data_out_regfile_to_fifo = address_bank ? data_out1 : data_out0;
	wire fifo_ready_refile;
	assign fifo_ready_refile = 1'b1;
	assign rd_addr0 = address_index_readout;
	assign rd_addr1 = address_index_readout;
	
always @(posedge dataclk) begin
	if (reset) begin
		address_index_readout <= 16'b0;
	end else if (last_address_written)begin
		address_index_readout <= 16'b0;
	end else if (fifo_ready_refile &&(address_index_readout < 7'd127)) begin
		address_index_readout <= address_index_readout + 1;;
	end 
end




initial begin 
in4x_A1 <=0;
in4x_A2 <=0;
address_index_readout <= 0;
data_in_dual_bank_reg_file <= 0;
end

	// assign num_data_streams_enabled =
	// 	data_stream_1_en + data_stream_2_en + data_stream_3_en + data_stream_4_en + 
	// 	data_stream_5_en + data_stream_6_en + data_stream_7_en + data_stream_8_en + 
	// 	data_stream_9_en + data_stream_10_en + data_stream_11_en + data_stream_12_en + 
	// 	data_stream_13_en + data_stream_14_en + data_stream_15_en + data_stream_16_en + 
	// 	data_stream_17_en + data_stream_18_en + data_stream_19_en + data_stream_20_en + 
	// 	data_stream_21_en + data_stream_22_en + data_stream_23_en + data_stream_24_en + 
	// 	data_stream_25_en + data_stream_26_en + data_stream_27_en + data_stream_28_en + 
	// 	data_stream_29_en + data_stream_30_en + data_stream_31_en + data_stream_32_en;
	


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


	reg [3:0] word_counter_16bit = 0;
	reg 	  reg_file_enable;
	reg [2:0] reg_value;
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
			// CS_b <= 1'b0;
			// SCLK <= 1'b0;
			FIFO_data_in <= 16'b0;
			FIFO_write_to <= 1'b0;

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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk1_a;
				end

				ms_clk1_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk1_b;
				end

				ms_clk1_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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

					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk1_c;
				end

				ms_clk1_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					// in4x_B1[0] <= MISO_B1; in4x_B2[0] <= MISO_B2;
					// in4x_C1[0] <= MISO_C1; in4x_C2[0] <= MISO_C2;
					// in4x_D1[0] <= MISO_D1; in4x_D2[0] <= MISO_D2;
					// in4x_E1[0] <= MISO_E1; in4x_E2[0] <= MISO_E2;
					// in4x_F1[0] <= MISO_F1; in4x_F2[0] <= MISO_F2;
					// in4x_G1[0] <= MISO_G1; in4x_G2[0] <= MISO_G2;
					// in4x_H1[0] <= MISO_H1; in4x_H2[0] <= MISO_H2;					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk1_d;
				end
				
				ms_clk1_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk2_a;
				end

				ms_clk2_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk2_b;
				end

				ms_clk2_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk2_c;
				end

				ms_clk2_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk2_d;
				end
				
				ms_clk2_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					if (channel == 31) begin
						aux_cmd_C <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_C <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_C <= RAM_data_out_3;
					end

					if (data_stream_1_en == 1'b1) begin
						FIFO_data_in 	<= data_stream_1;
						data_in_dual_bank_reg_file <= data_stream_1;

						FIFO_write_to 	<= 1'b1;
						reg_file_enable <= 1'b1;
						reg_value       <= 3'd0;
					end else begin 
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
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
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_D;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_D;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_D;
					end

					if (data_stream_2_en == 1'b1) begin
						FIFO_data_in <= data_stream_2;
						data_in_dual_bank_reg_file <= data_stream_2;
						FIFO_write_to <= 1'b1;
						reg_file_enable <= 1'b1;
						reg_value       <= 3'd1;
					end else begin 
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
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
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					if (channel == 31) begin
						aux_cmd_D <= RAM_data_out_1;
					end else if (channel == 32) begin
						aux_cmd_D <= RAM_data_out_2;
					end else if (channel == 33) begin
						aux_cmd_D <= RAM_data_out_3;
					end
					if (data_stream_3_en == 1'b1) begin
						FIFO_data_in <= data_stream_3;
						data_in_dual_bank_reg_file <= data_stream_3;
						FIFO_write_to <= 1'b1;
						reg_file_enable <= 1'b1;
						reg_value       <= 3'd2;
					end else begin 
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
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
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					if (channel == 31) begin
						RAM_bank_sel_rd <= aux_cmd_bank_1_E;
					end else if (channel == 32) begin
						RAM_bank_sel_rd <= aux_cmd_bank_2_E;
					end else if (channel == 33) begin
						RAM_bank_sel_rd <= aux_cmd_bank_3_E;
					end
					if (data_stream_4_en == 1'b1) begin
						FIFO_data_in <= data_stream_4;
						data_in_dual_bank_reg_file <= data_stream_4;
						FIFO_write_to <= 1'b1;
						reg_file_enable <= 1'b1;
						reg_value       <= 3'd3;
					end else begin 
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
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
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk4_a;
				end

				ms_clk4_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk4_b;
				end

				ms_clk4_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk4_c;
				end

				ms_clk4_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk4_d;
				end
				
				ms_clk4_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk5_a;
				end
				
				ms_clk5_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk5_b;
				end

				ms_clk5_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk5_c;
				end

				ms_clk5_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk5_d;
				end
				
				ms_clk5_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk6_a;
				end
				
				ms_clk6_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk6_b;
				end

				ms_clk6_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk6_c;
				end

				ms_clk6_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk6_d;
				end
				
				ms_clk6_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk7_a;
				end
				
				ms_clk7_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk7_b;
				end

				ms_clk7_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk7_c;
				end

				ms_clk7_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk7_d;
				end
				
				ms_clk7_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk8_a;
				end

				ms_clk8_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk8_b;
				end

				ms_clk8_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk8_c;
				end

				ms_clk8_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk8_d;
				end
				
				ms_clk8_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk9_a;
				end

				ms_clk9_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk9_b;
				end

				ms_clk9_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk9_c;
				end

				ms_clk9_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk9_d;
				end
				
				ms_clk9_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk10_a;
				end

				ms_clk10_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk10_b;
				end

				ms_clk10_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk10_c;
				end

				ms_clk10_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk10_d;
				end
				
				ms_clk10_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[37] <= MISO_A1; in4x_A2[37] <= MISO_A2;
					in4x_B1[37] <= MISO_B1; in4x_B2[37] <= MISO_B2;
					in4x_C1[37] <= MISO_C1; in4x_C2[37] <= MISO_C2;
					in4x_D1[37] <= MISO_D1; in4x_D2[37] <= MISO_D2;				
					in4x_E1[37] <= MISO_E1; in4x_E2[37] <= MISO_E2;
					in4x_F1[37] <= MISO_F1; in4x_F2[37] <= MISO_F2;
					in4x_G1[37] <= MISO_G1; in4x_G2[37] <= MISO_G2;
					in4x_H1[37] <= MISO_H1; in4x_H2[37] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk11_a;
				end

				ms_clk11_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk11_b;
				end

				ms_clk11_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					in4x_A1[39] <= MISO_A1; in4x_A2[39] <= MISO_A2;
					in4x_B1[39] <= MISO_B1; in4x_B2[39] <= MISO_B2;
					in4x_C1[39] <= MISO_C1; in4x_C2[39] <= MISO_C2;
					in4x_D1[39] <= MISO_D1; in4x_D2[39] <= MISO_D2;				
					in4x_E1[39] <= MISO_E1; in4x_E2[39] <= MISO_E2;
					in4x_F1[39] <= MISO_F1; in4x_F2[39] <= MISO_F2;
					in4x_G1[39] <= MISO_G1; in4x_G2[39] <= MISO_G2;
					in4x_H1[39] <= MISO_H1; in4x_H2[39] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk11_c;
				end

				ms_clk11_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[40] <= MISO_A1; in4x_A2[40] <= MISO_A2;
					in4x_B1[40] <= MISO_B1; in4x_B2[40] <= MISO_B2;
					in4x_C1[40] <= MISO_C1; in4x_C2[40] <= MISO_C2;
					in4x_D1[40] <= MISO_D1; in4x_D2[40] <= MISO_D2;					
					in4x_E1[40] <= MISO_E1; in4x_E2[40] <= MISO_E2;
					in4x_F1[40] <= MISO_F1; in4x_F2[40] <= MISO_F2;
					in4x_G1[40] <= MISO_G1; in4x_G2[40] <= MISO_G2;
					in4x_H1[40] <= MISO_H1; in4x_H2[40] <= MISO_H2;	
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk11_d;
				end
				
				ms_clk11_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[41] <= MISO_A1; in4x_A2[41] <= MISO_A2;
					in4x_B1[41] <= MISO_B1; in4x_B2[41] <= MISO_B2;
					in4x_C1[41] <= MISO_C1; in4x_C2[41] <= MISO_C2;
					in4x_D1[41] <= MISO_D1; in4x_D2[41] <= MISO_D2;	
					in4x_E1[41] <= MISO_E1; in4x_E2[41] <= MISO_E2;
					in4x_F1[41] <= MISO_F1; in4x_F2[41] <= MISO_F2;
					in4x_G1[41] <= MISO_G1; in4x_G2[41] <= MISO_G2;
					in4x_H1[41] <= MISO_H1; in4x_H2[41] <= MISO_H2;					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk12_a;
				end

				ms_clk12_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk12_b;
				end

				ms_clk12_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					in4x_A1[43] <= MISO_A1; in4x_A2[43] <= MISO_A2;
					in4x_B1[43] <= MISO_B1; in4x_B2[43] <= MISO_B2;
					in4x_C1[43] <= MISO_C1; in4x_C2[43] <= MISO_C2;
					in4x_D1[43] <= MISO_D1; in4x_D2[43] <= MISO_D2;	
					in4x_E1[43] <= MISO_E1; in4x_E2[43] <= MISO_E2;
					in4x_F1[43] <= MISO_F1; in4x_F2[43] <= MISO_F2;
					in4x_G1[43] <= MISO_G1; in4x_G2[43] <= MISO_G2;
					in4x_H1[43] <= MISO_H1; in4x_H2[43] <= MISO_H2;						
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk12_c;
				end

				ms_clk12_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[44] <= MISO_A1; in4x_A2[44] <= MISO_A2;
					in4x_B1[44] <= MISO_B1; in4x_B2[44] <= MISO_B2;
					in4x_C1[44] <= MISO_C1; in4x_C2[44] <= MISO_C2;
					in4x_D1[44] <= MISO_D1; in4x_D2[44] <= MISO_D2;	
					in4x_E1[44] <= MISO_E1; in4x_E2[44] <= MISO_E2;
					in4x_F1[44] <= MISO_F1; in4x_F2[44] <= MISO_F2;
					in4x_G1[44] <= MISO_G1; in4x_G2[44] <= MISO_G2;
					in4x_H1[44] <= MISO_H1; in4x_H2[44] <= MISO_H2;					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk12_d;
				end
				
				ms_clk12_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[45] <= MISO_A1; in4x_A2[45] <= MISO_A2;
					in4x_B1[45] <= MISO_B1; in4x_B2[45] <= MISO_B2;
					in4x_C1[45] <= MISO_C1; in4x_C2[45] <= MISO_C2;
					in4x_D1[45] <= MISO_D1; in4x_D2[45] <= MISO_D2;				
					in4x_E1[45] <= MISO_E1; in4x_E2[45] <= MISO_E2;
					in4x_F1[45] <= MISO_F1; in4x_F2[45] <= MISO_F2;
					in4x_G1[45] <= MISO_G1; in4x_G2[45] <= MISO_G2;
					in4x_H1[45] <= MISO_H1; in4x_H2[45] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk13_a;
				end

				ms_clk13_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk13_b;
				end

				ms_clk13_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					in4x_A1[47] <= MISO_A1; in4x_A2[47] <= MISO_A2;
					in4x_B1[47] <= MISO_B1; in4x_B2[47] <= MISO_B2;
					in4x_C1[47] <= MISO_C1; in4x_C2[47] <= MISO_C2;
					in4x_D1[47] <= MISO_D1; in4x_D2[47] <= MISO_D2;				
					in4x_E1[47] <= MISO_E1; in4x_E2[47] <= MISO_E2;
					in4x_F1[47] <= MISO_F1; in4x_F2[47] <= MISO_F2;
					in4x_G1[47] <= MISO_G1; in4x_G2[47] <= MISO_G2;
					in4x_H1[47] <= MISO_H1; in4x_H2[47] <= MISO_H2;	
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk13_c;
				end

				ms_clk13_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[48] <= MISO_A1; in4x_A2[48] <= MISO_A2;
					in4x_B1[48] <= MISO_B1; in4x_B2[48] <= MISO_B2;
					in4x_C1[48] <= MISO_C1; in4x_C2[48] <= MISO_C2;
					in4x_D1[48] <= MISO_D1; in4x_D2[48] <= MISO_D2;					
					in4x_E1[48] <= MISO_E1; in4x_E2[48] <= MISO_E2;
					in4x_F1[48] <= MISO_F1; in4x_F2[48] <= MISO_F2;
					in4x_G1[48] <= MISO_G1; in4x_G2[48] <= MISO_G2;
					in4x_H1[48] <= MISO_H1; in4x_H2[48] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk13_d;
				end
				
				ms_clk13_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[49] <= MISO_A1; in4x_A2[49] <= MISO_A2;
					in4x_B1[49] <= MISO_B1; in4x_B2[49] <= MISO_B2;
					in4x_C1[49] <= MISO_C1; in4x_C2[49] <= MISO_C2;
					in4x_D1[49] <= MISO_D1; in4x_D2[49] <= MISO_D2;	
					in4x_E1[49] <= MISO_E1; in4x_E2[49] <= MISO_E2;
					in4x_F1[49] <= MISO_F1; in4x_F2[49] <= MISO_F2;
					in4x_G1[49] <= MISO_G1; in4x_G2[49] <= MISO_G2;
					in4x_H1[49] <= MISO_H1; in4x_H2[49] <= MISO_H2;					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk14_a;
				end

				ms_clk14_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk14_b;
				end

				ms_clk14_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					in4x_A1[51] <= MISO_A1; in4x_A2[51] <= MISO_A2;
					in4x_B1[51] <= MISO_B1; in4x_B2[51] <= MISO_B2;
					in4x_C1[51] <= MISO_C1; in4x_C2[51] <= MISO_C2;
					in4x_D1[51] <= MISO_D1; in4x_D2[51] <= MISO_D2;		
					in4x_E1[51] <= MISO_E1; in4x_E2[51] <= MISO_E2;
					in4x_F1[51] <= MISO_F1; in4x_F2[51] <= MISO_F2;
					in4x_G1[51] <= MISO_G1; in4x_G2[51] <= MISO_G2;
					in4x_H1[51] <= MISO_H1; in4x_H2[51] <= MISO_H2;						
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk14_c;
				end

				ms_clk14_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[52] <= MISO_A1; in4x_A2[52] <= MISO_A2;
					in4x_B1[52] <= MISO_B1; in4x_B2[52] <= MISO_B2;
					in4x_C1[52] <= MISO_C1; in4x_C2[52] <= MISO_C2;
					in4x_D1[52] <= MISO_D1; in4x_D2[52] <= MISO_D2;	
					in4x_E1[52] <= MISO_E1; in4x_E2[52] <= MISO_E2;
					in4x_F1[52] <= MISO_F1; in4x_F2[52] <= MISO_F2;
					in4x_G1[52] <= MISO_G1; in4x_G2[52] <= MISO_G2;
					in4x_H1[52] <= MISO_H1; in4x_H2[52] <= MISO_H2;						
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk14_d;
				end
				
				ms_clk14_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;	
					SCLK <= 1'b1;
					in4x_A1[53] <= MISO_A1; in4x_A2[53] <= MISO_A2;
					in4x_B1[53] <= MISO_B1; in4x_B2[53] <= MISO_B2;
					in4x_C1[53] <= MISO_C1; in4x_C2[53] <= MISO_C2;
					in4x_D1[53] <= MISO_D1; in4x_D2[53] <= MISO_D2;
					in4x_E1[53] <= MISO_E1; in4x_E2[53] <= MISO_E2;
					in4x_F1[53] <= MISO_F1; in4x_F2[53] <= MISO_F2;
					in4x_G1[53] <= MISO_G1; in4x_G2[53] <= MISO_G2;
					in4x_H1[53] <= MISO_H1; in4x_H2[53] <= MISO_H2;					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk15_a;
				end

				ms_clk15_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk15_b;
				end

				ms_clk15_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					in4x_A1[55] <= MISO_A1; in4x_A2[55] <= MISO_A2;
					in4x_B1[55] <= MISO_B1; in4x_B2[55] <= MISO_B2;
					in4x_C1[55] <= MISO_C1; in4x_C2[55] <= MISO_C2;
					in4x_D1[55] <= MISO_D1; in4x_D2[55] <= MISO_D2;	
					in4x_E1[55] <= MISO_E1; in4x_E2[55] <= MISO_E2;
					in4x_F1[55] <= MISO_F1; in4x_F2[55] <= MISO_F2;
					in4x_G1[55] <= MISO_G1; in4x_G2[55] <= MISO_G2;
					in4x_H1[55] <= MISO_H1; in4x_H2[55] <= MISO_H2;						
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk15_c;
				end

				ms_clk15_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[56] <= MISO_A1; in4x_A2[56] <= MISO_A2;
					in4x_B1[56] <= MISO_B1; in4x_B2[56] <= MISO_B2;
					in4x_C1[56] <= MISO_C1; in4x_C2[56] <= MISO_C2;
					in4x_D1[56] <= MISO_D1; in4x_D2[56] <= MISO_D2;					
					in4x_E1[56] <= MISO_E1; in4x_E2[56] <= MISO_E2;
					in4x_F1[56] <= MISO_F1; in4x_F2[56] <= MISO_F2;
					in4x_G1[56] <= MISO_G1; in4x_G2[56] <= MISO_G2;
					in4x_H1[56] <= MISO_H1; in4x_H2[56] <= MISO_H2;	
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk15_d;
				end
				
				ms_clk15_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[57] <= MISO_A1; in4x_A2[57] <= MISO_A2;
					in4x_B1[57] <= MISO_B1; in4x_B2[57] <= MISO_B2;
					in4x_C1[57] <= MISO_C1; in4x_C2[57] <= MISO_C2;
					in4x_D1[57] <= MISO_D1; in4x_D2[57] <= MISO_D2;				
					in4x_E1[57] <= MISO_E1; in4x_E2[57] <= MISO_E2;
					in4x_F1[57] <= MISO_F1; in4x_F2[57] <= MISO_F2;
					in4x_G1[57] <= MISO_G1; in4x_G2[57] <= MISO_G2;
					in4x_H1[57] <= MISO_H1; in4x_H2[57] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk16_a;
				end

				ms_clk16_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk16_b;
				end

				ms_clk16_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					in4x_A1[59] <= MISO_A1; in4x_A2[59] <= MISO_A2;
					in4x_B1[59] <= MISO_B1; in4x_B2[59] <= MISO_B2;
					in4x_C1[59] <= MISO_C1; in4x_C2[59] <= MISO_C2;
					in4x_D1[59] <= MISO_D1; in4x_D2[59] <= MISO_D2;		
					in4x_E1[59] <= MISO_E1; in4x_E2[59] <= MISO_E2;
					in4x_F1[59] <= MISO_F1; in4x_F2[59] <= MISO_F2;
					in4x_G1[59] <= MISO_G1; in4x_G2[59] <= MISO_G2;
					in4x_H1[59] <= MISO_H1; in4x_H2[59] <= MISO_H2;					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk16_c;
				end

				ms_clk16_c: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					SCLK <= 1'b1;
					in4x_A1[60] <= MISO_A1; in4x_A2[60] <= MISO_A2;
					in4x_B1[60] <= MISO_B1; in4x_B2[60] <= MISO_B2;
					in4x_C1[60] <= MISO_C1; in4x_C2[60] <= MISO_C2;
					in4x_D1[60] <= MISO_D1; in4x_D2[60] <= MISO_D2;					
					in4x_E1[60] <= MISO_E1; in4x_E2[60] <= MISO_E2;
					in4x_F1[60] <= MISO_F1; in4x_F2[60] <= MISO_F2;
					in4x_G1[60] <= MISO_G1; in4x_G2[60] <= MISO_G2;
					in4x_H1[60] <= MISO_H1; in4x_H2[60] <= MISO_H2;	
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk16_d;
				end
				
				ms_clk16_d: begin
					CS_b <= 1'b0;
					SCLK <= 1'b1;
					// SCLK <= 1'b1;
					in4x_A1[61] <= MISO_A1; in4x_A2[61] <= MISO_A2;
					in4x_B1[61] <= MISO_B1; in4x_B2[61] <= MISO_B2;
					in4x_C1[61] <= MISO_C1; in4x_C2[61] <= MISO_C2;
					in4x_D1[61] <= MISO_D1; in4x_D2[61] <= MISO_D2;
					in4x_E1[61] <= MISO_E1; in4x_E2[61] <= MISO_E2;
					in4x_F1[61] <= MISO_F1; in4x_F2[61] <= MISO_F2;
					in4x_G1[61] <= MISO_G1; in4x_G2[61] <= MISO_G2;
					in4x_H1[61] <= MISO_H1; in4x_H2[61] <= MISO_H2;					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk17_a;
				end

				ms_clk17_a: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_clk17_b;
				end

				ms_clk17_b: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_a;
				end

				ms_cs_a: begin
					// CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_b;
				end

				ms_cs_b: begin
					// CS_b <= 1'b0;
					SCLK <= 1'b0;
					if (channel == 34) begin
						FIFO_data_in <= data_stream_ADC_1;	// Write evaluation-board ADC samples
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_c;
				end

				ms_cs_c: begin
					// CS_b <= 1'b0;
					SCLK <= 1'b0;
					if (channel == 34) begin
						FIFO_data_in <= data_stream_ADC_2;	// Write evaluation-board ADC samples
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_d;
				end
				
				ms_cs_d: begin
					SCLK <= 1'b0;
					if (channel == 34) begin
						FIFO_data_in <= data_stream_ADC_3;	// Write evaluation-board ADC samples
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_e;
				end
				
				ms_cs_e: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_ADC_4;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					
					SCLK <= 1'b0;
					CS_b <= 1'b1;
					in4x_A1[68] <= MISO_A1; in4x_A2[68] <= MISO_A2;
					in4x_B1[68] <= MISO_B1; in4x_B2[68] <= MISO_B2;
					in4x_C1[68] <= MISO_C1; in4x_C2[68] <= MISO_C2;
					in4x_D1[68] <= MISO_D1; in4x_D2[68] <= MISO_D2;				
					in4x_E1[68] <= MISO_E1; in4x_E2[68] <= MISO_E2;
					in4x_F1[68] <= MISO_F1; in4x_F2[68] <= MISO_F2;
					in4x_G1[68] <= MISO_G1; in4x_G2[68] <= MISO_G2;
					in4x_H1[68] <= MISO_H1; in4x_H2[68] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_f;
				end
				
				ms_cs_f: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_ADC_5;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					
					SCLK <= 1'b0;
					CS_b <= 1'b1;
					in4x_A1[69] <= MISO_A1; in4x_A2[69] <= MISO_A2;
					in4x_B1[69] <= MISO_B1; in4x_B2[69] <= MISO_B2;
					in4x_C1[69] <= MISO_C1; in4x_C2[69] <= MISO_C2;
					in4x_D1[69] <= MISO_D1; in4x_D2[69] <= MISO_D2;	
					in4x_E1[69] <= MISO_E1; in4x_E2[69] <= MISO_E2;
					in4x_F1[69] <= MISO_F1; in4x_F2[69] <= MISO_F2;
					in4x_G1[69] <= MISO_G1; in4x_G2[69] <= MISO_G2;
					in4x_H1[69] <= MISO_H1; in4x_H2[69] <= MISO_H2;					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_g;
				end
				
				ms_cs_g: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_ADC_6;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					
					SCLK <= 1'b0;
					CS_b <= 1'b1;
					in4x_A1[70] <= MISO_A1; in4x_A2[70] <= MISO_A2;
					in4x_B1[70] <= MISO_B1; in4x_B2[70] <= MISO_B2;
					in4x_C1[70] <= MISO_C1; in4x_C2[70] <= MISO_C2;
					in4x_D1[70] <= MISO_D1; in4x_D2[70] <= MISO_D2;				
					in4x_E1[70] <= MISO_E1; in4x_E2[70] <= MISO_E2;
					in4x_F1[70] <= MISO_F1; in4x_F2[70] <= MISO_F2;
					in4x_G1[70] <= MISO_G1; in4x_G2[70] <= MISO_G2;
					in4x_H1[70] <= MISO_H1; in4x_H2[70] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_h;
				end
				
				ms_cs_h: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_ADC_7;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					
					SCLK <= 1'b0;
					CS_b <= 1'b1;
					in4x_A1[71] <= MISO_A1; in4x_A2[71] <= MISO_A2;
					in4x_B1[71] <= MISO_B1; in4x_B2[71] <= MISO_B2;
					in4x_C1[71] <= MISO_C1; in4x_C2[71] <= MISO_C2;
					in4x_D1[71] <= MISO_D1; in4x_D2[71] <= MISO_D2;				
					in4x_E1[71] <= MISO_E1; in4x_E2[71] <= MISO_E2;
					in4x_F1[71] <= MISO_F1; in4x_F2[71] <= MISO_F2;
					in4x_G1[71] <= MISO_G1; in4x_G2[71] <= MISO_G2;
					in4x_H1[71] <= MISO_H1; in4x_H2[71] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_i;
				end
				
				ms_cs_i: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_ADC_8;	// Write evaluation-board ADC samples
						FIFO_write_to <= 1'b1;
					end					
					SCLK <= 1'b0;
					CS_b <= 1'b1;
					in4x_A1[72] <= MISO_A1; in4x_A2[72] <= MISO_A2;
					in4x_B1[72] <= MISO_B1; in4x_B2[72] <= MISO_B2;
					in4x_C1[72] <= MISO_C1; in4x_C2[72] <= MISO_C2;
					in4x_D1[72] <= MISO_D1; in4x_D2[72] <= MISO_D2;				
					in4x_E1[72] <= MISO_E1; in4x_E2[72] <= MISO_E2;
					in4x_F1[72] <= MISO_F1; in4x_F2[72] <= MISO_F2;
					in4x_G1[72] <= MISO_G1; in4x_G2[72] <= MISO_G2;
					in4x_H1[72] <= MISO_H1; in4x_H2[72] <= MISO_H2;	
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_j;
				end
				
				ms_cs_j: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_TTL_in;	// Write TTL inputs
						FIFO_write_to <= 1'b1;
					end					
					SCLK <= 1'b0;
					CS_b <= 1'b1;
					in4x_A1[73] <= MISO_A1; in4x_A2[73] <= MISO_A2;
					in4x_B1[73] <= MISO_B1; in4x_B2[73] <= MISO_B2;
					in4x_C1[73] <= MISO_C1; in4x_C2[73] <= MISO_C2;
					in4x_D1[73] <= MISO_D1; in4x_D2[73] <= MISO_D2;				
					in4x_E1[73] <= MISO_E1; in4x_E2[73] <= MISO_E2;
					in4x_F1[73] <= MISO_F1; in4x_F2[73] <= MISO_F2;
					in4x_G1[73] <= MISO_G1; in4x_G2[73] <= MISO_G2;
					in4x_H1[73] <= MISO_H1; in4x_H2[73] <= MISO_H2;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_k;
				end
				
				ms_cs_k: begin
					if (channel == 34) begin
						FIFO_data_in <= data_stream_TTL_out;	// Write current value of TTL outputs so users can reconstruct exact timings
						FIFO_write_to <= 1'b1;
					end	

					// reg_enable <= 1'b1;
					SCLK <= 1'b0;
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
					
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_l;

					//	begin writing to Register file
					// First index
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
					SCLK <= 1'b0;
					CS_b <= 1'b1;			
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_m;
				end
				
				ms_cs_m: begin
					// CS_b <= 1'b0;
					SCLK <= 1'b0;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
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
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_cs_n;
					end
				end
				
				ms_finish_256bit_word_0: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
				    reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
				    if (word_counter_16bit != 4'b0000) begin
				        FIFO_data_in <= 16'b0;
				        FIFO_write_to <= 1'b1;
					main_state <= ms_finish_256bit_word_1;
				    end else begin
					main_state <= ms_wait;
				    end
				end
				
				ms_finish_256bit_word_1: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
				    reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
	
				    // Wait for 1 clock cycle to give time for counter to increment before returning to ms_finish_256bit_word_0
					main_state <= ms_finish_256bit_word_0;
				end
								
				default: begin
					CS_b <= 1'b0;
					SCLK <= 1'b0;
					reg_file_enable <= 1'b0;
					reg_value       <= 3'd5;
					main_state <= ms_wait;
				end
				
			endcase
		end
	end
	




	// Normal selector
	MISO_phase_selector MISO_phase_selector_1 (
		.phase_select(delay_A), .MISO4x(in4x_A1), .MISO(in_A1));	

	MISO_phase_selector MISO_phase_selector_2 (
		.phase_select(delay_A), .MISO4x(in4x_A2), .MISO(in_A2));	


	// DDR selector
	MISO_DDR_phase_selector MISO_DDR_phase_selector_1 (
		.phase_select(delay_A), .MISO4x(in4x_A1), .MISO(in_DDR_A1));	

	MISO_DDR_phase_selector MISO_DDR_phase_selector_2 (
		.phase_select(delay_A), .MISO4x(in4x_A2), .MISO(in_DDR_A2));	

    lookup_table_case #(.OUT_WIDTH(7)) lookup_table_case (
        .in(reg_value),
        .out(address_ofset)
    );



endmodule




module custom_command_selector (
	input wire [5:0] 		channel,
	input wire				DSP_settle,
	input wire [15:0] 	aux_cmd,
	input wire				digout_override,
	output reg [15:0] 	MOSI_cmd
	);

	always @(*) begin
		case (channel)
			0:       MOSI_cmd <= { 16'd0 };
			1:       MOSI_cmd <= { 16'd1 };
			2:       MOSI_cmd <= { 16'd2 };
			3:       MOSI_cmd <= { 16'd3 };
			4:       MOSI_cmd <= { 16'd4 };
			5:       MOSI_cmd <= { 16'd5 };
			6:       MOSI_cmd <= { 16'd6 };
			7:       MOSI_cmd <= { 16'd7 };
			8:       MOSI_cmd <= { 16'd8 };
			9:       MOSI_cmd <= { 16'd9 };
			10:      MOSI_cmd <= { 16'd10};
			11:      MOSI_cmd <= { 16'd11};
			12:      MOSI_cmd <= { 16'd12};
			13:      MOSI_cmd <= { 16'd13};
			14:      MOSI_cmd <= { 16'd14};
			15:      MOSI_cmd <= { 16'd15};
			16:      MOSI_cmd <= { 16'd16};
			17:      MOSI_cmd <= { 16'd17};
			18:      MOSI_cmd <= { 16'd18};
			19:      MOSI_cmd <= { 16'd19};
			20:      MOSI_cmd <= { 16'd20};
			21:      MOSI_cmd <= { 16'd21};
			22:      MOSI_cmd <= { 16'd22};
			23:      MOSI_cmd <= { 16'd23};
			24:      MOSI_cmd <= { 16'd24};
			25:      MOSI_cmd <= { 16'd25};
			26:      MOSI_cmd <= { 16'd26};
			27:      MOSI_cmd <= { 16'd27};
			28:      MOSI_cmd <= { 16'd28};
			29:      MOSI_cmd <= { 16'd29};
			30:      MOSI_cmd <= { 16'd30};
			31:      MOSI_cmd <= { 16'd31};
			32:		 MOSI_cmd <= { 16'd32};
			33:		 MOSI_cmd <= { 16'd33};
			34:		 MOSI_cmd <= { 16'd34};
			default: MOSI_cmd <= 16'b0;
			endcase
	end	
	
endmodule




	
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
			32:		 MOSI_cmd <= (aux_cmd[15:8] == 8'h83) ? {aux_cmd[15:1], digout_override} : aux_cmd; // If we detect a write to Register 3, overridge the digout value.
			33:		 MOSI_cmd <= (aux_cmd[15:8] == 8'h83) ? {aux_cmd[15:1], digout_override} : aux_cmd; // If we detect a write to Register 3, overridge the digout value.
			34:		 MOSI_cmd <= (aux_cmd[15:8] == 8'h83) ? {aux_cmd[15:1], digout_override} : aux_cmd; // If we detect a write to Register 3, overridge the digout value.
			default: MOSI_cmd <= 16'b0;
			endcase
	end	
	
endmodule







module MISO_phase_selector(
	input wire [3:0] 		phase_select,	// MISO sampling phase lag to compensate for headstage cable delay
	input wire [73:0] 	MISO4x,			// 4x oversampled MISO input
	output reg [15:0] 	MISO				// 16-bit MISO output
	);

	always @(*) begin
		case (phase_select)
			0:       MISO <= {MISO4x[0],  MISO4x[4],  MISO4x[8],  MISO4x[12], MISO4x[16], MISO4x[20], MISO4x[24], MISO4x[28], MISO4x[32], MISO4x[36], MISO4x[40], MISO4x[44], MISO4x[48], MISO4x[52], MISO4x[56], MISO4x[60]};
			1:       MISO <= {MISO4x[1],  MISO4x[5],  MISO4x[9],  MISO4x[13], MISO4x[17], MISO4x[21], MISO4x[25], MISO4x[29], MISO4x[33], MISO4x[37], MISO4x[41], MISO4x[45], MISO4x[49], MISO4x[53], MISO4x[57], MISO4x[61]};
			2:       MISO <= {MISO4x[2],  MISO4x[6],  MISO4x[10], MISO4x[14], MISO4x[18], MISO4x[22], MISO4x[26], MISO4x[30], MISO4x[34], MISO4x[38], MISO4x[42], MISO4x[46], MISO4x[50], MISO4x[54], MISO4x[58], MISO4x[62]};
			3:       MISO <= {MISO4x[3],  MISO4x[7],  MISO4x[11], MISO4x[15], MISO4x[19], MISO4x[23], MISO4x[27], MISO4x[31], MISO4x[35], MISO4x[39], MISO4x[43], MISO4x[47], MISO4x[51], MISO4x[55], MISO4x[59], MISO4x[63]};
			4:       MISO <= {MISO4x[4],  MISO4x[8],  MISO4x[12], MISO4x[16], MISO4x[20], MISO4x[24], MISO4x[28], MISO4x[32], MISO4x[36], MISO4x[40], MISO4x[44], MISO4x[48], MISO4x[52], MISO4x[56], MISO4x[60], MISO4x[64]};
			5:       MISO <= {MISO4x[5],  MISO4x[9],  MISO4x[13], MISO4x[17], MISO4x[21], MISO4x[25], MISO4x[29], MISO4x[33], MISO4x[37], MISO4x[41], MISO4x[45], MISO4x[49], MISO4x[53], MISO4x[57], MISO4x[61], MISO4x[65]};
			6:       MISO <= {MISO4x[6],  MISO4x[10], MISO4x[14], MISO4x[18], MISO4x[22], MISO4x[26], MISO4x[30], MISO4x[34], MISO4x[38], MISO4x[42], MISO4x[46], MISO4x[50], MISO4x[54], MISO4x[58], MISO4x[62], MISO4x[66]};
			7:       MISO <= {MISO4x[7],  MISO4x[11], MISO4x[15], MISO4x[19], MISO4x[23], MISO4x[27], MISO4x[31], MISO4x[35], MISO4x[39], MISO4x[43], MISO4x[47], MISO4x[51], MISO4x[55], MISO4x[59], MISO4x[63], MISO4x[67]};
			8:       MISO <= {MISO4x[8],  MISO4x[12], MISO4x[16], MISO4x[20], MISO4x[24], MISO4x[28], MISO4x[32], MISO4x[36], MISO4x[40], MISO4x[44], MISO4x[48], MISO4x[52], MISO4x[56], MISO4x[60], MISO4x[64], MISO4x[68]};
			9:       MISO <= {MISO4x[9],  MISO4x[13], MISO4x[17], MISO4x[21], MISO4x[25], MISO4x[29], MISO4x[33], MISO4x[37], MISO4x[41], MISO4x[45], MISO4x[49], MISO4x[53], MISO4x[57], MISO4x[61], MISO4x[65], MISO4x[69]};
			10:      MISO <= {MISO4x[10], MISO4x[14], MISO4x[18], MISO4x[22], MISO4x[26], MISO4x[30], MISO4x[34], MISO4x[38], MISO4x[42], MISO4x[46], MISO4x[50], MISO4x[54], MISO4x[58], MISO4x[62], MISO4x[66], MISO4x[70]};
			11:      MISO <= {MISO4x[11], MISO4x[15], MISO4x[19], MISO4x[23], MISO4x[27], MISO4x[31], MISO4x[35], MISO4x[39], MISO4x[43], MISO4x[47], MISO4x[51], MISO4x[55], MISO4x[59], MISO4x[63], MISO4x[67], MISO4x[71]};
			default: MISO <= {MISO4x[11], MISO4x[15], MISO4x[19], MISO4x[23], MISO4x[27], MISO4x[31], MISO4x[35], MISO4x[39], MISO4x[43], MISO4x[47], MISO4x[51], MISO4x[55], MISO4x[59], MISO4x[63], MISO4x[67], MISO4x[71]};
		endcase
	end
	
endmodule


module MISO_DDR_phase_selector(
	input wire [3:0] 		phase_select,	// MISO sampling phase lag to compensate for headstage cable delay
	input wire [73:0] 	MISO4x,			// 4x oversampled MISO input
	output reg [15:0] 	MISO				// 16-bit MISO output
	);
	
	always @(*) begin
		case (phase_select)
			0:       MISO <= {MISO4x[2],  MISO4x[6],  MISO4x[10], MISO4x[14], MISO4x[18], MISO4x[22], MISO4x[26], MISO4x[30], MISO4x[34], MISO4x[38], MISO4x[42], MISO4x[46], MISO4x[50], MISO4x[54], MISO4x[58], MISO4x[62]};
			1:       MISO <= {MISO4x[3],  MISO4x[7],  MISO4x[11], MISO4x[15], MISO4x[19], MISO4x[23], MISO4x[27], MISO4x[31], MISO4x[35], MISO4x[39], MISO4x[43], MISO4x[47], MISO4x[51], MISO4x[55], MISO4x[59], MISO4x[63]};
			2:       MISO <= {MISO4x[4],  MISO4x[8],  MISO4x[12], MISO4x[16], MISO4x[20], MISO4x[24], MISO4x[28], MISO4x[32], MISO4x[36], MISO4x[40], MISO4x[44], MISO4x[48], MISO4x[52], MISO4x[56], MISO4x[60], MISO4x[64]};
			3:       MISO <= {MISO4x[5],  MISO4x[9],  MISO4x[13], MISO4x[17], MISO4x[21], MISO4x[25], MISO4x[29], MISO4x[33], MISO4x[37], MISO4x[41], MISO4x[45], MISO4x[49], MISO4x[53], MISO4x[57], MISO4x[61], MISO4x[65]};
			4:       MISO <= {MISO4x[6],  MISO4x[10], MISO4x[14], MISO4x[18], MISO4x[22], MISO4x[26], MISO4x[30], MISO4x[34], MISO4x[38], MISO4x[42], MISO4x[46], MISO4x[50], MISO4x[54], MISO4x[58], MISO4x[62], MISO4x[66]};
			5:       MISO <= {MISO4x[7],  MISO4x[11], MISO4x[15], MISO4x[19], MISO4x[23], MISO4x[27], MISO4x[31], MISO4x[35], MISO4x[39], MISO4x[43], MISO4x[47], MISO4x[51], MISO4x[55], MISO4x[59], MISO4x[63], MISO4x[67]};
			6:       MISO <= {MISO4x[8],  MISO4x[12], MISO4x[16], MISO4x[20], MISO4x[24], MISO4x[28], MISO4x[32], MISO4x[36], MISO4x[40], MISO4x[44], MISO4x[48], MISO4x[52], MISO4x[56], MISO4x[60], MISO4x[64], MISO4x[68]};
			7:       MISO <= {MISO4x[9],  MISO4x[13], MISO4x[17], MISO4x[21], MISO4x[25], MISO4x[29], MISO4x[33], MISO4x[37], MISO4x[41], MISO4x[45], MISO4x[49], MISO4x[53], MISO4x[57], MISO4x[61], MISO4x[65], MISO4x[69]};
			8:       MISO <= {MISO4x[10], MISO4x[14], MISO4x[18], MISO4x[22], MISO4x[26], MISO4x[30], MISO4x[34], MISO4x[38], MISO4x[42], MISO4x[46], MISO4x[50], MISO4x[54], MISO4x[58], MISO4x[62], MISO4x[66], MISO4x[70]};
			9:       MISO <= {MISO4x[11], MISO4x[15], MISO4x[19], MISO4x[23], MISO4x[27], MISO4x[31], MISO4x[35], MISO4x[39], MISO4x[43], MISO4x[47], MISO4x[51], MISO4x[55], MISO4x[59], MISO4x[63], MISO4x[67], MISO4x[71]};
			10:      MISO <= {MISO4x[12], MISO4x[16], MISO4x[20], MISO4x[24], MISO4x[28], MISO4x[32], MISO4x[36], MISO4x[40], MISO4x[44], MISO4x[48], MISO4x[52], MISO4x[56], MISO4x[60], MISO4x[64], MISO4x[68], MISO4x[72]};
			11:      MISO <= {MISO4x[13], MISO4x[17], MISO4x[21], MISO4x[25], MISO4x[29], MISO4x[33], MISO4x[37], MISO4x[41], MISO4x[45], MISO4x[49], MISO4x[53], MISO4x[57], MISO4x[61], MISO4x[65], MISO4x[69], MISO4x[73]};
			default: MISO <= {MISO4x[13], MISO4x[17], MISO4x[21], MISO4x[25], MISO4x[29], MISO4x[33], MISO4x[37], MISO4x[41], MISO4x[45], MISO4x[49], MISO4x[53], MISO4x[57], MISO4x[61], MISO4x[65], MISO4x[69], MISO4x[73]};
		endcase
	end
	
endmodule



module dual_bank_regfile (
    input wire clk,
    input wire rst,
    input wire we,                    // Write enable
    input wire bank_sel,              // Bank select for writing (0: Bank 0, 1: Bank 1)
    input wire [6:0] wr_addr,         // 7-bit write address (128 entries)
    input wire [15:0] data_in,        // Data to write
    input wire [6:0] rd_addr0,        // Read address for Bank 0
    input wire [6:0] rd_addr1,        // Read address for Bank 1
    output wire [15:0] data_out0,     // Data output from Bank 0
    output wire [15:0] data_out1      // Data output from Bank 1
);

integer i,j;
initial begin 

	for (j = 0; j < 128; j = j + 1) begin
		bank0[j] <= 16'b0;
		bank1[j] <= 16'b0;
	end

end

    reg [15:0] bank0 [127:0];  // 128 x 16-bit register bank 0
    reg [15:0] bank1 [127:0];  // 128 x 16-bit register bank 1

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 128; i = i + 1) begin
                bank0[i] <= 16'b0;
                bank1[i] <= 16'b0;
            end
        end else if (we) begin
            // Write operation
            if (bank_sel)
                bank1[wr_addr] <= data_in;  // Write to Bank 1
            else
                bank0[wr_addr] <= data_in;  // Write to Bank 0
        end
    end

    assign data_out0 = bank0[rd_addr0];  // Read from Bank 0
    assign data_out1 = bank1[rd_addr1];  // Read from Bank 1

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

module remap_7bit (
    input wire [6:0] in,       // 7-bit input (0 to 127)
    output reg [6:0] out       // 7-bit output (mapped value)
);

    always @(*) begin
        case (in)
            0: out =    7'd0 ;  
            1: out =    7'd2 ;  
            2: out =    7'd4 ; 
            3: out =    7'd8 ;  
            4: out =    7'd16;  
            5: out =    7'd32 ;  
            6: out =    7'd64 ;  
            7: out =    7'd5 ; 
            8: out =    7'd3 ;   
            9: out =    7'd69 ; 
            10: out =   7'd50 ; 
            11: out =   7'd100 ; 
            12: out =   7'd101 ; 
            13: out =   7'd102 ; 
            14: out =   7'd113 ; 
            15: out =   7'd110 ; 
            default: out = 0; 
        endcase
    end

endmodule
