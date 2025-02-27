`timescale 1ps/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:        Intan Technologies, LLC
// 
// Design Name:    RHD2000 7310 Rhythm USB3 Interface
// Module Name:    mmcm_drp
// Project Name:   RHDInterfaceXEM7310
// Target Devices: 
// Tool versions: 
// Description:    Reprogram MMCM to achieve a specific frequency specified by
//                  M, D, and O. Adapted from mmcme2_drp.v, an example provided by Xilinx.
//
// Dependencies: 
//
// Revision:       3.0 (10 January 2023)
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module mmcm_drp
    #(
    // M: CLKFBOUT_MULT
    // D: DIVCLK_DIVIDE
    // O: CLKOUT6_DIVIDE
    
    // 5.6 MHz (divide by 2 to get 2.8 MHz on clkout4)
    parameter S1_CLKFBOUT_MULT   = 7,
    parameter S1_DIVCLK_DIVIDE   = 2,
    parameter S1_CLKOUT6_DIVIDE  = 125,
    
    // 7.0 MHz (divide by 2 to get 3.5 MHz on clkout4)
    parameter S2_CLKFBOUT_MULT   = 7,
    parameter S2_DIVCLK_DIVIDE   = 2,
    parameter S2_CLKOUT6_DIVIDE  = 100,
    
    // 8.4 MHz (divide by 2 to get 4.2 MHz on clkout4)
    parameter S3_CLKFBOUT_MULT   = 21,
    parameter S3_DIVCLK_DIVIDE   = 4,
    parameter S3_CLKOUT6_DIVIDE  = 125,
    
    // 5.6 MHz
    parameter S4_CLKFBOUT_MULT   = 7,
    parameter S4_DIVCLK_DIVIDE   = 2,
    parameter S4_CLKOUT6_DIVIDE  = 125,
    
    // 7.0 MHz
    parameter S5_CLKFBOUT_MULT   = 7,
    parameter S5_DIVCLK_DIVIDE   = 2,
    parameter S5_CLKOUT6_DIVIDE  = 100,
    
    // 8.4 MHz
    parameter S6_CLKFBOUT_MULT   = 21,
    parameter S6_DIVCLK_DIVIDE   = 4,
    parameter S6_CLKOUT6_DIVIDE  = 125,
    
    // 9.33 MHz
    parameter S7_CLKFBOUT_MULT   = 7,
    parameter S7_DIVCLK_DIVIDE   = 2,
    parameter S7_CLKOUT6_DIVIDE  = 75,
    
    // 11.20 MHz
    parameter S8_CLKFBOUT_MULT   = 21,
    parameter S8_DIVCLK_DIVIDE   = 5,
    parameter S8_CLKOUT6_DIVIDE  = 75,
    
    // 14.00 MHz
    parameter S9_CLKFBOUT_MULT   = 7,
    parameter S9_DIVCLK_DIVIDE   = 2,
    parameter S9_CLKOUT6_DIVIDE  = 50,
   
    // 17.50 MHz
    parameter S10_CLKFBOUT_MULT   = 7,
    parameter S10_DIVCLK_DIVIDE   = 2,
    parameter S10_CLKOUT6_DIVIDE  = 40,
    
    // 22.40 MHz
    parameter S11_CLKFBOUT_MULT   = 28,
    parameter S11_DIVCLK_DIVIDE   = 5,
    parameter S11_CLKOUT6_DIVIDE  = 50,
    
    // 28.0 MHz
    parameter S12_CLKFBOUT_MULT   = 7,
    parameter S12_DIVCLK_DIVIDE   = 2,
    parameter S12_CLKOUT6_DIVIDE  = 25,
    
    // 35.0 MHz
    parameter S13_CLKFBOUT_MULT   = 7,
    parameter S13_DIVCLK_DIVIDE   = 2,
    parameter S13_CLKOUT6_DIVIDE  = 20,
    
    // 42.0 MHz
    parameter S14_CLKFBOUT_MULT   = 21,
    parameter S14_DIVCLK_DIVIDE   = 4,
    parameter S14_CLKOUT6_DIVIDE  = 25,
    
    // 56.0 MHz
    parameter S15_CLKFBOUT_MULT   = 21,
    parameter S15_DIVCLK_DIVIDE   = 5,
    parameter S15_CLKOUT6_DIVIDE  = 15,
    
    // 70.0 MHz
    parameter S16_CLKFBOUT_MULT   = 7,
    parameter S16_DIVCLK_DIVIDE   = 2,
    parameter S16_CLKOUT6_DIVIDE  = 10,
    
    // 84.0 MHz
    parameter S17_CLKFBOUT_MULT   = 21,
    parameter S17_DIVCLK_DIVIDE   = 5,
    parameter S17_CLKOUT6_DIVIDE  = 10,
    
    // 93.33 MHz
    parameter S18_CLKFBOUT_MULT   = 14,
    parameter S18_DIVCLK_DIVIDE   = 3,
    parameter S18_CLKOUT6_DIVIDE  = 10,
    
    // 112.00 MHz
    parameter S19_CLKFBOUT_MULT   = 28,
    parameter S19_DIVCLK_DIVIDE   = 5,
    parameter S19_CLKOUT6_DIVIDE  = 10,
   
    // 140.00 MHz
    parameter S20_CLKFBOUT_MULT   = 7,
    parameter S20_DIVCLK_DIVIDE   = 2,
    parameter S20_CLKOUT6_DIVIDE  = 5
    ) (
        // These signals are controlled by user logic interface and are covered
        // in more detail within the XAPP.
        input      [4:0]  SADDR,
        input             SEN,
        input             SCLK,
        input             RST,
        output reg        SRDY,
        //
        // These signals are to be connected to the MMCM_ADV by port name.
        // Their use matches the MMCM port description in the Device User Guide.
        input      [15:0] DO,
        input             DRDY,
        input             LOCK_REG_CLK_IN,
        input             LOCKED_IN,
        output reg        DWE,
        output reg        DEN,
        output reg [6:0]  DADDR,
        output reg [15:0] DI,
        output            DCLK,
        output reg        RST_MMCM,
        output            LOCKED_OUT,
        output reg        DONE = 1'b1
    );
//----------------------------------------------------------------------------------------
    //
    wire        IntLocked;
    wire        IntRstMmcm;
    //
    // 100 ps delay for behavioral simulations
    localparam  TCQ = 100;
    
    // Always divide-by-2 on clkout4
    localparam [37:0] CLKOUT4           =   mmcm_count_calc(2);
    localparam [15:0] CLKOUT4_REG1      =   CLKOUT4[15:0];
    localparam [15:0] CLKOUT4_REG2      =   CLKOUT4[31:16];

    // Make sure the memory is implemented as distributed
    (* rom_style = "distributed" *)
    //
    // ROM of:  39 bit word 260 words deep
    reg [38:0] rom[259:0];
    reg [8:0]  rom_addr;
    reg [38:0]  rom_do;
    reg         next_srdy;
    reg [8:0]   next_rom_addr;
    reg [6:0]   next_daddr;
    reg         next_dwe;
    reg         next_den;
    reg         next_rst_mmcm;
    reg [15:0]  next_di;


    assign LOCKED_OUT = LOCKED_IN;
    assign IntLocked = LOCKED_IN;
    
    // Integer used to initialize remainder of unused ROM
    integer ii;

    // Pass SCLK to DCLK for the MMCM
    assign DCLK = SCLK;
    assign IntRstMmcm = RST_MMCM;

    // Include the MMCM reconfiguration functions.  This contains the constant
    // functions that are used in the calculations below.  This file is
    // required.
    `include "mmcm_drp_func.h"

    //**************************************************************************
    // State 1 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S1_CLKFBOUT       = mmcm_count_calc(S1_CLKFBOUT_MULT);
    localparam [9:0]  S1_DIGITAL_FILT   = mmcm_filter_lookup(S1_CLKFBOUT_MULT);
    localparam [39:0] S1_LOCK           = mmcm_lock_lookup(S1_CLKFBOUT_MULT);
    localparam [37:0] S1_DIVCLK         = mmcm_count_calc(S1_DIVCLK_DIVIDE);

    localparam [37:0] S1_CLKOUT6        = mmcm_count_calc(S1_CLKOUT6_DIVIDE);
    localparam [15:0] S1_CLKOUT6_REG1   = S1_CLKOUT6[15:0];
    localparam [15:0] S1_CLKOUT6_REG2   = S1_CLKOUT6[31:16];

    //**************************************************************************
    // State 2 Calculations
    //**************************************************************************
    localparam [37:0] S2_CLKFBOUT       = mmcm_count_calc(S2_CLKFBOUT_MULT);
    localparam [9:0]  S2_DIGITAL_FILT   = mmcm_filter_lookup(S2_CLKFBOUT_MULT);
    localparam [39:0] S2_LOCK           = mmcm_lock_lookup(S2_CLKFBOUT_MULT);
    localparam [37:0] S2_DIVCLK         = mmcm_count_calc(S2_DIVCLK_DIVIDE);

    localparam [37:0] S2_CLKOUT6        = mmcm_count_calc(S2_CLKOUT6_DIVIDE);
    localparam [15:0] S2_CLKOUT6_REG1   = S2_CLKOUT6[15:0];
    localparam [15:0] S2_CLKOUT6_REG2   = S2_CLKOUT6[31:16];
       
    //**************************************************************************
    // State 3 Calculations
    //**************************************************************************
    localparam [37:0] S3_CLKFBOUT       = mmcm_count_calc(S3_CLKFBOUT_MULT);
    localparam [9:0] S3_DIGITAL_FILT    = mmcm_filter_lookup(S3_CLKFBOUT_MULT);
    localparam [39:0] S3_LOCK           = mmcm_lock_lookup(S3_CLKFBOUT_MULT);
    localparam [37:0] S3_DIVCLK         = mmcm_count_calc(S3_DIVCLK_DIVIDE);

    localparam [37:0] S3_CLKOUT6        = mmcm_count_calc(S3_CLKOUT6_DIVIDE);
    localparam [15:0] S3_CLKOUT6_REG1   = S3_CLKOUT6[15:0];
    localparam [15:0] S3_CLKOUT6_REG2   = S3_CLKOUT6[31:16];
       
    //**************************************************************************
    // State 4 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S4_CLKFBOUT       = mmcm_count_calc(S4_CLKFBOUT_MULT);
    localparam [9:0]  S4_DIGITAL_FILT   = mmcm_filter_lookup(S4_CLKFBOUT_MULT);
    localparam [39:0] S4_LOCK           = mmcm_lock_lookup(S4_CLKFBOUT_MULT);
    localparam [37:0] S4_DIVCLK         = mmcm_count_calc(S4_DIVCLK_DIVIDE);

    localparam [37:0] S4_CLKOUT6        = mmcm_count_calc(S4_CLKOUT6_DIVIDE);
    localparam [15:0] S4_CLKOUT6_REG1   = S4_CLKOUT6[15:0];
    localparam [15:0] S4_CLKOUT6_REG2   = S4_CLKOUT6[31:16];
       
    //**************************************************************************
    // State 5 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S5_CLKFBOUT       = mmcm_count_calc(S5_CLKFBOUT_MULT);
    localparam [9:0]  S5_DIGITAL_FILT   = mmcm_filter_lookup(S5_CLKFBOUT_MULT);
    localparam [39:0] S5_LOCK           = mmcm_lock_lookup(S5_CLKFBOUT_MULT);
    localparam [37:0] S5_DIVCLK         = mmcm_count_calc(S5_DIVCLK_DIVIDE);

    localparam [37:0] S5_CLKOUT6        = mmcm_count_calc(S5_CLKOUT6_DIVIDE);
    localparam [15:0] S5_CLKOUT6_REG1   = S5_CLKOUT6[15:0];
    localparam [15:0] S5_CLKOUT6_REG2   = S5_CLKOUT6[31:16];
       
    //**************************************************************************
    // State 6 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S6_CLKFBOUT       = mmcm_count_calc(S6_CLKFBOUT_MULT);
    localparam [9:0]  S6_DIGITAL_FILT   = mmcm_filter_lookup(S6_CLKFBOUT_MULT);
    localparam [39:0] S6_LOCK           = mmcm_lock_lookup(S6_CLKFBOUT_MULT);
    localparam [37:0] S6_DIVCLK         = mmcm_count_calc(S6_DIVCLK_DIVIDE);

    localparam [37:0] S6_CLKOUT6        = mmcm_count_calc(S6_CLKOUT6_DIVIDE);
    localparam [15:0] S6_CLKOUT6_REG1   = S6_CLKOUT6[15:0];
    localparam [15:0] S6_CLKOUT6_REG2   = S6_CLKOUT6[31:16];
       
    //**************************************************************************
    // State 7 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S7_CLKFBOUT       = mmcm_count_calc(S7_CLKFBOUT_MULT);
    localparam [9:0]  S7_DIGITAL_FILT   = mmcm_filter_lookup(S7_CLKFBOUT_MULT);
    localparam [39:0] S7_LOCK           = mmcm_lock_lookup(S7_CLKFBOUT_MULT);
    localparam [37:0] S7_DIVCLK         = mmcm_count_calc(S7_DIVCLK_DIVIDE);

    localparam [37:0] S7_CLKOUT6        = mmcm_count_calc(S7_CLKOUT6_DIVIDE);
    localparam [15:0] S7_CLKOUT6_REG1   = S7_CLKOUT6[15:0];
    localparam [15:0] S7_CLKOUT6_REG2   = S7_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 8 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S8_CLKFBOUT       = mmcm_count_calc(S8_CLKFBOUT_MULT);
    localparam [9:0]  S8_DIGITAL_FILT   = mmcm_filter_lookup(S8_CLKFBOUT_MULT);
    localparam [39:0] S8_LOCK           = mmcm_lock_lookup(S8_CLKFBOUT_MULT);
    localparam [37:0] S8_DIVCLK         = mmcm_count_calc(S8_DIVCLK_DIVIDE);

    localparam [37:0] S8_CLKOUT6        = mmcm_count_calc(S8_CLKOUT6_DIVIDE);
    localparam [15:0] S8_CLKOUT6_REG1   = S8_CLKOUT6[15:0];
    localparam [15:0] S8_CLKOUT6_REG2   = S8_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 9 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S9_CLKFBOUT       = mmcm_count_calc(S9_CLKFBOUT_MULT);
    localparam [9:0]  S9_DIGITAL_FILT   = mmcm_filter_lookup(S9_CLKFBOUT_MULT);
    localparam [39:0] S9_LOCK           = mmcm_lock_lookup(S9_CLKFBOUT_MULT);
    localparam [37:0] S9_DIVCLK         = mmcm_count_calc(S9_DIVCLK_DIVIDE);

    localparam [37:0] S9_CLKOUT6        = mmcm_count_calc(S9_CLKOUT6_DIVIDE);
    localparam [15:0] S9_CLKOUT6_REG1   = S9_CLKOUT6[15:0];
    localparam [15:0] S9_CLKOUT6_REG2   = S9_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 10 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S10_CLKFBOUT       = mmcm_count_calc(S10_CLKFBOUT_MULT);
    localparam [9:0]  S10_DIGITAL_FILT   = mmcm_filter_lookup(S10_CLKFBOUT_MULT);
    localparam [39:0] S10_LOCK           = mmcm_lock_lookup(S10_CLKFBOUT_MULT);
    localparam [37:0] S10_DIVCLK         = mmcm_count_calc(S10_DIVCLK_DIVIDE);

    localparam [37:0] S10_CLKOUT6        = mmcm_count_calc(S10_CLKOUT6_DIVIDE);
    localparam [15:0] S10_CLKOUT6_REG1   = S10_CLKOUT6[15:0];
    localparam [15:0] S10_CLKOUT6_REG2   = S10_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 11 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S11_CLKFBOUT       = mmcm_count_calc(S11_CLKFBOUT_MULT);
    localparam [9:0]  S11_DIGITAL_FILT   = mmcm_filter_lookup(S11_CLKFBOUT_MULT);
    localparam [39:0] S11_LOCK           = mmcm_lock_lookup(S11_CLKFBOUT_MULT);
    localparam [37:0] S11_DIVCLK         = mmcm_count_calc(S11_DIVCLK_DIVIDE);

    localparam [37:0] S11_CLKOUT6        = mmcm_count_calc(S11_CLKOUT6_DIVIDE);
    localparam [15:0] S11_CLKOUT6_REG1   = S11_CLKOUT6[15:0];
    localparam [15:0] S11_CLKOUT6_REG2   = S11_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 12 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S12_CLKFBOUT       = mmcm_count_calc(S12_CLKFBOUT_MULT);
    localparam [9:0]  S12_DIGITAL_FILT   = mmcm_filter_lookup(S12_CLKFBOUT_MULT);
    localparam [39:0] S12_LOCK           = mmcm_lock_lookup(S12_CLKFBOUT_MULT);
    localparam [37:0] S12_DIVCLK         = mmcm_count_calc(S12_DIVCLK_DIVIDE);

    localparam [37:0] S12_CLKOUT6        = mmcm_count_calc(S12_CLKOUT6_DIVIDE);
    localparam [15:0] S12_CLKOUT6_REG1   = S12_CLKOUT6[15:0];
    localparam [15:0] S12_CLKOUT6_REG2   = S12_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 13 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S13_CLKFBOUT       = mmcm_count_calc(S13_CLKFBOUT_MULT);
    localparam [9:0]  S13_DIGITAL_FILT   = mmcm_filter_lookup(S13_CLKFBOUT_MULT);
    localparam [39:0] S13_LOCK           = mmcm_lock_lookup(S13_CLKFBOUT_MULT);
    localparam [37:0] S13_DIVCLK         = mmcm_count_calc(S13_DIVCLK_DIVIDE);

    localparam [37:0] S13_CLKOUT6        = mmcm_count_calc(S13_CLKOUT6_DIVIDE);
    localparam [15:0] S13_CLKOUT6_REG1   = S13_CLKOUT6[15:0];
    localparam [15:0] S13_CLKOUT6_REG2   = S13_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 14 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S14_CLKFBOUT       = mmcm_count_calc(S14_CLKFBOUT_MULT);
    localparam [9:0]  S14_DIGITAL_FILT   = mmcm_filter_lookup(S14_CLKFBOUT_MULT);
    localparam [39:0] S14_LOCK           = mmcm_lock_lookup(S14_CLKFBOUT_MULT);
    localparam [37:0] S14_DIVCLK         = mmcm_count_calc(S14_DIVCLK_DIVIDE);

    localparam [37:0] S14_CLKOUT6        = mmcm_count_calc(S14_CLKOUT6_DIVIDE);
    localparam [15:0] S14_CLKOUT6_REG1   = S14_CLKOUT6[15:0];
    localparam [15:0] S14_CLKOUT6_REG2   = S14_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 15 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S15_CLKFBOUT       = mmcm_count_calc(S15_CLKFBOUT_MULT);
    localparam [9:0]  S15_DIGITAL_FILT   = mmcm_filter_lookup(S15_CLKFBOUT_MULT);
    localparam [39:0] S15_LOCK           = mmcm_lock_lookup(S15_CLKFBOUT_MULT);
    localparam [37:0] S15_DIVCLK         = mmcm_count_calc(S15_DIVCLK_DIVIDE);

    localparam [37:0] S15_CLKOUT6        = mmcm_count_calc(S15_CLKOUT6_DIVIDE);
    localparam [15:0] S15_CLKOUT6_REG1   = S15_CLKOUT6[15:0];
    localparam [15:0] S15_CLKOUT6_REG2   = S15_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 16 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S16_CLKFBOUT       = mmcm_count_calc(S16_CLKFBOUT_MULT);
    localparam [9:0]  S16_DIGITAL_FILT   = mmcm_filter_lookup(S16_CLKFBOUT_MULT);
    localparam [39:0] S16_LOCK           = mmcm_lock_lookup(S16_CLKFBOUT_MULT);
    localparam [37:0] S16_DIVCLK         = mmcm_count_calc(S16_DIVCLK_DIVIDE);

    localparam [37:0] S16_CLKOUT6        = mmcm_count_calc(S16_CLKOUT6_DIVIDE);
    localparam [15:0] S16_CLKOUT6_REG1   = S16_CLKOUT6[15:0];
    localparam [15:0] S16_CLKOUT6_REG2   = S16_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 17 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S17_CLKFBOUT       = mmcm_count_calc(S17_CLKFBOUT_MULT);
    localparam [9:0]  S17_DIGITAL_FILT   = mmcm_filter_lookup(S17_CLKFBOUT_MULT);
    localparam [39:0] S17_LOCK           = mmcm_lock_lookup(S17_CLKFBOUT_MULT);
    localparam [37:0] S17_DIVCLK         = mmcm_count_calc(S17_DIVCLK_DIVIDE);

    localparam [37:0] S17_CLKOUT6        = mmcm_count_calc(S17_CLKOUT6_DIVIDE);
    localparam [15:0] S17_CLKOUT6_REG1   = S17_CLKOUT6[15:0];
    localparam [15:0] S17_CLKOUT6_REG2   = S17_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 18 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S18_CLKFBOUT       = mmcm_count_calc(S18_CLKFBOUT_MULT);
    localparam [9:0]  S18_DIGITAL_FILT   = mmcm_filter_lookup(S18_CLKFBOUT_MULT);
    localparam [39:0] S18_LOCK           = mmcm_lock_lookup(S18_CLKFBOUT_MULT);
    localparam [37:0] S18_DIVCLK         = mmcm_count_calc(S18_DIVCLK_DIVIDE);

    localparam [37:0] S18_CLKOUT6        = mmcm_count_calc(S18_CLKOUT6_DIVIDE);
    localparam [15:0] S18_CLKOUT6_REG1   = S18_CLKOUT6[15:0];
    localparam [15:0] S18_CLKOUT6_REG2   = S18_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 19 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S19_CLKFBOUT       = mmcm_count_calc(S19_CLKFBOUT_MULT);
    localparam [9:0]  S19_DIGITAL_FILT   = mmcm_filter_lookup(S19_CLKFBOUT_MULT);
    localparam [39:0] S19_LOCK           = mmcm_lock_lookup(S19_CLKFBOUT_MULT);
    localparam [37:0] S19_DIVCLK         = mmcm_count_calc(S19_DIVCLK_DIVIDE);

    localparam [37:0] S19_CLKOUT6        = mmcm_count_calc(S19_CLKOUT6_DIVIDE);
    localparam [15:0] S19_CLKOUT6_REG1   = S19_CLKOUT6[15:0];
    localparam [15:0] S19_CLKOUT6_REG2   = S19_CLKOUT6[31:16];
    
    //**************************************************************************
    // State 20 Calculations
    //**************************************************************************
    // Please see header for information.
    localparam [37:0] S20_CLKFBOUT       = mmcm_count_calc(S20_CLKFBOUT_MULT);
    localparam [9:0]  S20_DIGITAL_FILT   = mmcm_filter_lookup(S20_CLKFBOUT_MULT);
    localparam [39:0] S20_LOCK           = mmcm_lock_lookup(S20_CLKFBOUT_MULT);
    localparam [37:0] S20_DIVCLK         = mmcm_count_calc(S20_DIVCLK_DIVIDE);

    localparam [37:0] S20_CLKOUT6        = mmcm_count_calc(S20_CLKOUT6_DIVIDE);
    localparam [15:0] S20_CLKOUT6_REG1   = S20_CLKOUT6[15:0];
    localparam [15:0] S20_CLKOUT6_REG2   = S20_CLKOUT6[31:16];


    initial begin
       // rom entries contain (in order) the address, a bitmask, and a bitset
       //***********************************************************************
       // State 1 Initialization
       //***********************************************************************

       // Store the power bits
       rom[0] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[1]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[2] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[3] = {7'h12, 16'h1000, S1_CLKOUT6[15:0]};
       rom[4] = {7'h13, 16'hC000, S1_CLKOUT6[31:16]};

       // Store the input divider
       rom[5] = {7'h16, 16'hC000, {2'h0, S1_DIVCLK[23:22], S1_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[6] = {7'h14, 16'h1000, S1_CLKFBOUT[15:0]};
       rom[7] = {7'h15, 16'h8000, S1_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[8] = {7'h18, 16'hFC00, {6'h00, S1_LOCK[29:20]} };
       rom[9] = {7'h19, 16'h8000, {1'b0 , S1_LOCK[34:30], S1_LOCK[9:0]} };
       rom[10] = {7'h1A, 16'h8000, {1'b0 , S1_LOCK[39:35], S1_LOCK[19:10]} };

       // Store the filter settings
       rom[11] = {7'h4E, 16'h66FF,
                 S1_DIGITAL_FILT[9], 2'h0, S1_DIGITAL_FILT[8:7], 2'h0,
                 S1_DIGITAL_FILT[6], 8'h00 };
       rom[12] = {7'h4F, 16'h666F,
                 S1_DIGITAL_FILT[5], 2'h0, S1_DIGITAL_FILT[4:3], 2'h0,
                 S1_DIGITAL_FILT[2:1], 2'h0, S1_DIGITAL_FILT[0], 4'h0 };

       //***********************************************************************
       // State 2 Initialization
       //***********************************************************************

       // Store the power bits
       rom[13] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[14] = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[15] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[16] = {7'h12, 16'h1000, S2_CLKOUT6[15:0]};
       rom[17] = {7'h13, 16'hC000, S2_CLKOUT6[31:16]};

       // Store the input divider
       rom[18] = {7'h16, 16'hC000, {2'h0, S2_DIVCLK[23:22], S2_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[19] = {7'h14, 16'h1000, S2_CLKFBOUT[15:0]};
       rom[20] = {7'h15, 16'h8000, S2_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[21] = {7'h18, 16'hFC00, {6'h00, S2_LOCK[29:20]} };
       rom[22] = {7'h19, 16'h8000, {1'b0 , S2_LOCK[34:30], S2_LOCK[9:0]} };
       rom[23] = {7'h1A, 16'h8000, {1'b0 , S2_LOCK[39:35], S2_LOCK[19:10]} };

       // Store the filter settings
       rom[24] = {7'h4E, 16'h66FF,
                 S2_DIGITAL_FILT[9], 2'h0, S2_DIGITAL_FILT[8:7], 2'h0,
                 S2_DIGITAL_FILT[6], 8'h00 };
       rom[25] = {7'h4F, 16'h666F,
                 S2_DIGITAL_FILT[5], 2'h0, S2_DIGITAL_FILT[4:3], 2'h0,
                 S2_DIGITAL_FILT[2:1], 2'h0, S2_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 3 Initialization
       //***********************************************************************

       // Store the power bits
       rom[26] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[27]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[28] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[29] = {7'h12, 16'h1000, S3_CLKOUT6[15:0]};
       rom[30] = {7'h13, 16'hC000, S3_CLKOUT6[31:16]};

       // Store the input divider
       rom[31] = {7'h16, 16'hC000, {2'h0, S3_DIVCLK[23:22], S3_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[32] = {7'h14, 16'h1000, S3_CLKFBOUT[15:0]};
       rom[33] = {7'h15, 16'h8000, S3_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[34] = {7'h18, 16'hFC00, {6'h00, S3_LOCK[29:20]} };
       rom[35] = {7'h19, 16'h8000, {1'b0 , S3_LOCK[34:30], S3_LOCK[9:0]} };
       rom[36] = {7'h1A, 16'h8000, {1'b0 , S3_LOCK[39:35], S3_LOCK[19:10]} };

       // Store the filter settings
       rom[37] = {7'h4E, 16'h66FF,
                 S3_DIGITAL_FILT[9], 2'h0, S3_DIGITAL_FILT[8:7], 2'h0,
                 S3_DIGITAL_FILT[6], 8'h00 };
       rom[38] = {7'h4F, 16'h666F,
                 S3_DIGITAL_FILT[5], 2'h0, S3_DIGITAL_FILT[4:3], 2'h0,
                 S3_DIGITAL_FILT[2:1], 2'h0, S3_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 4 Initialization
       //***********************************************************************

       // Store the power bits
       rom[39] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[40]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[41] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[42] = {7'h12, 16'h1000, S4_CLKOUT6[15:0]};
       rom[43] = {7'h13, 16'hC000, S4_CLKOUT6[31:16]};

       // Store the input divider
       rom[44] = {7'h16, 16'hC000, {2'h0, S4_DIVCLK[23:22], S4_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[45] = {7'h14, 16'h1000, S4_CLKFBOUT[15:0]};
       rom[46] = {7'h15, 16'h8000, S4_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[47] = {7'h18, 16'hFC00, {6'h00, S4_LOCK[29:20]} };
       rom[48] = {7'h19, 16'h8000, {1'b0 , S4_LOCK[34:30], S4_LOCK[9:0]} };
       rom[49] = {7'h1A, 16'h8000, {1'b0 , S4_LOCK[39:35], S4_LOCK[19:10]} };

       // Store the filter settings
       rom[50] = {7'h4E, 16'h66FF,
                 S4_DIGITAL_FILT[9], 2'h0, S4_DIGITAL_FILT[8:7], 2'h0,
                 S4_DIGITAL_FILT[6], 8'h00 };
       rom[51] = {7'h4F, 16'h666F,
                 S4_DIGITAL_FILT[5], 2'h0, S4_DIGITAL_FILT[4:3], 2'h0,
                 S4_DIGITAL_FILT[2:1], 2'h0, S4_DIGITAL_FILT[0], 4'h0 };
                 
                 
       //***********************************************************************
       // State 5 Initialization
       //***********************************************************************

       // Store the power bits
       rom[52] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[53]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[54] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[55] = {7'h12, 16'h1000, S5_CLKOUT6[15:0]};
       rom[56] = {7'h13, 16'hC000, S5_CLKOUT6[31:16]};

       // Store the input divider
       rom[57] = {7'h16, 16'hC000, {2'h0, S5_DIVCLK[23:22], S5_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[58] = {7'h14, 16'h1000, S5_CLKFBOUT[15:0]};
       rom[59] = {7'h15, 16'h8000, S5_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[60] = {7'h18, 16'hFC00, {6'h00, S5_LOCK[29:20]} };
       rom[61] = {7'h19, 16'h8000, {1'b0 , S5_LOCK[34:30], S5_LOCK[9:0]} };
       rom[62] = {7'h1A, 16'h8000, {1'b0 , S5_LOCK[39:35], S5_LOCK[19:10]} };

       // Store the filter settings
       rom[63] = {7'h4E, 16'h66FF,
                 S5_DIGITAL_FILT[9], 2'h0, S5_DIGITAL_FILT[8:7], 2'h0,
                 S5_DIGITAL_FILT[6], 8'h00 };
       rom[64] = {7'h4F, 16'h666F,
                 S5_DIGITAL_FILT[5], 2'h0, S5_DIGITAL_FILT[4:3], 2'h0,
                 S5_DIGITAL_FILT[2:1], 2'h0, S5_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 6 Initialization
       //***********************************************************************

       // Store the power bits
       rom[65] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[66]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[67] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[68] = {7'h12, 16'h1000, S6_CLKOUT6[15:0]};
       rom[69] = {7'h13, 16'hC000, S6_CLKOUT6[31:16]};

       // Store the input divider
       rom[70] = {7'h16, 16'hC000, {2'h0, S6_DIVCLK[23:22], S6_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[71] = {7'h14, 16'h1000, S6_CLKFBOUT[15:0]};
       rom[72] = {7'h15, 16'h8000, S6_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[73] = {7'h18, 16'hFC00, {6'h00, S6_LOCK[29:20]} };
       rom[74] = {7'h19, 16'h8000, {1'b0 , S6_LOCK[34:30], S6_LOCK[9:0]} };
       rom[75] = {7'h1A, 16'h8000, {1'b0 , S6_LOCK[39:35], S6_LOCK[19:10]} };

       // Store the filter settings
       rom[76] = {7'h4E, 16'h66FF,
                 S6_DIGITAL_FILT[9], 2'h0, S6_DIGITAL_FILT[8:7], 2'h0,
                 S6_DIGITAL_FILT[6], 8'h00 };
       rom[77] = {7'h4F, 16'h666F,
                 S6_DIGITAL_FILT[5], 2'h0, S6_DIGITAL_FILT[4:3], 2'h0,
                 S6_DIGITAL_FILT[2:1], 2'h0, S6_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 7 Initialization
       //***********************************************************************

       // Store the power bits
       rom[78] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[79]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[80] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[81] = {7'h12, 16'h1000, S7_CLKOUT6[15:0]};
       rom[82] = {7'h13, 16'hC000, S7_CLKOUT6[31:16]};

       // Store the input divider
       rom[83] = {7'h16, 16'hC000, {2'h0, S7_DIVCLK[23:22], S7_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[84] = {7'h14, 16'h1000, S7_CLKFBOUT[15:0]};
       rom[85] = {7'h15, 16'h8000, S7_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[86] = {7'h18, 16'hFC00, {6'h00, S7_LOCK[29:20]} };
       rom[87] = {7'h19, 16'h8000, {1'b0 , S7_LOCK[34:30], S7_LOCK[9:0]} };
       rom[88] = {7'h1A, 16'h8000, {1'b0 , S7_LOCK[39:35], S7_LOCK[19:10]} };

       // Store the filter settings
       rom[89] = {7'h4E, 16'h66FF,
                 S7_DIGITAL_FILT[9], 2'h0, S7_DIGITAL_FILT[8:7], 2'h0,
                 S7_DIGITAL_FILT[6], 8'h00 };
       rom[90] = {7'h4F, 16'h666F,
                 S7_DIGITAL_FILT[5], 2'h0, S7_DIGITAL_FILT[4:3], 2'h0,
                 S7_DIGITAL_FILT[2:1], 2'h0, S7_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 8 Initialization
       //***********************************************************************

       // Store the power bits
       rom[91] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[92]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[93] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[94] = {7'h12, 16'h1000, S8_CLKOUT6[15:0]};
       rom[95] = {7'h13, 16'hC000, S8_CLKOUT6[31:16]};

       // Store the input divider
       rom[96] = {7'h16, 16'hC000, {2'h0, S8_DIVCLK[23:22], S8_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[97] = {7'h14, 16'h1000, S8_CLKFBOUT[15:0]};
       rom[98] = {7'h15, 16'h8000, S8_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[99] = {7'h18, 16'hFC00, {6'h00, S8_LOCK[29:20]} };
       rom[100] = {7'h19, 16'h8000, {1'b0 , S8_LOCK[34:30], S8_LOCK[9:0]} };
       rom[101] = {7'h1A, 16'h8000, {1'b0 , S8_LOCK[39:35], S8_LOCK[19:10]} };

       // Store the filter settings
       rom[102] = {7'h4E, 16'h66FF,
                 S8_DIGITAL_FILT[9], 2'h0, S8_DIGITAL_FILT[8:7], 2'h0,
                 S8_DIGITAL_FILT[6], 8'h00 };
       rom[103] = {7'h4F, 16'h666F,
                 S8_DIGITAL_FILT[5], 2'h0, S8_DIGITAL_FILT[4:3], 2'h0,
                 S8_DIGITAL_FILT[2:1], 2'h0, S8_DIGITAL_FILT[0], 4'h0 };
                 
              
       //***********************************************************************
       // State 9 Initialization
       //***********************************************************************

       // Store the power bits
       rom[104] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[105]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[106] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[107] = {7'h12, 16'h1000, S9_CLKOUT6[15:0]};
       rom[108] = {7'h13, 16'hC000, S9_CLKOUT6[31:16]};

       // Store the input divider
       rom[109] = {7'h16, 16'hC000, {2'h0, S9_DIVCLK[23:22], S9_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[110] = {7'h14, 16'h1000, S9_CLKFBOUT[15:0]};
       rom[111] = {7'h15, 16'h8000, S9_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[112] = {7'h18, 16'hFC00, {6'h00, S9_LOCK[29:20]} };
       rom[113] = {7'h19, 16'h8000, {1'b0 , S9_LOCK[34:30], S9_LOCK[9:0]} };
       rom[114] = {7'h1A, 16'h8000, {1'b0 , S9_LOCK[39:35], S9_LOCK[19:10]} };

       // Store the filter settings
       rom[115] = {7'h4E, 16'h66FF,
                 S9_DIGITAL_FILT[9], 2'h0, S9_DIGITAL_FILT[8:7], 2'h0,
                 S9_DIGITAL_FILT[6], 8'h00 };
       rom[116] = {7'h4F, 16'h666F,
                 S9_DIGITAL_FILT[5], 2'h0, S9_DIGITAL_FILT[4:3], 2'h0,
                 S9_DIGITAL_FILT[2:1], 2'h0, S9_DIGITAL_FILT[0], 4'h0 };

       //***********************************************************************
       // State 10 Initialization
       //***********************************************************************

       // Store the power bits
       rom[117] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[118]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[119] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[120] = {7'h12, 16'h1000, S10_CLKOUT6[15:0]};
       rom[121] = {7'h13, 16'hC000, S10_CLKOUT6[31:16]};

       // Store the input divider
       rom[122] = {7'h16, 16'hC000, {2'h0, S10_DIVCLK[23:22], S10_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[123] = {7'h14, 16'h1000, S10_CLKFBOUT[15:0]};
       rom[124] = {7'h15, 16'h8000, S10_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[125] = {7'h18, 16'hFC00, {6'h00, S10_LOCK[29:20]} };
       rom[126] = {7'h19, 16'h8000, {1'b0 , S10_LOCK[34:30], S10_LOCK[9:0]} };
       rom[127] = {7'h1A, 16'h8000, {1'b0 , S10_LOCK[39:35], S10_LOCK[19:10]} };

       // Store the filter settings
       rom[128] = {7'h4E, 16'h66FF,
                 S10_DIGITAL_FILT[9], 2'h0, S10_DIGITAL_FILT[8:7], 2'h0,
                 S10_DIGITAL_FILT[6], 8'h00 };
       rom[129] = {7'h4F, 16'h666F,
                 S10_DIGITAL_FILT[5], 2'h0, S10_DIGITAL_FILT[4:3], 2'h0,
                 S10_DIGITAL_FILT[2:1], 2'h0, S10_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 11 Initialization
       //***********************************************************************

       // Store the power bits
       rom[130] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[131]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[132] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[133] = {7'h12, 16'h1000, S11_CLKOUT6[15:0]};
       rom[134] = {7'h13, 16'hC000, S11_CLKOUT6[31:16]};

       // Store the input divider
       rom[135] = {7'h16, 16'hC000, {2'h0, S11_DIVCLK[23:22], S11_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[136] = {7'h14, 16'h1000, S11_CLKFBOUT[15:0]};
       rom[137] = {7'h15, 16'h8000, S11_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[138] = {7'h18, 16'hFC00, {6'h00, S11_LOCK[29:20]} };
       rom[139] = {7'h19, 16'h8000, {1'b0 , S11_LOCK[34:30], S11_LOCK[9:0]} };
       rom[140] = {7'h1A, 16'h8000, {1'b0 , S11_LOCK[39:35], S11_LOCK[19:10]} };

       // Store the filter settings
       rom[141] = {7'h4E, 16'h66FF,
                 S11_DIGITAL_FILT[9], 2'h0, S11_DIGITAL_FILT[8:7], 2'h0,
                 S11_DIGITAL_FILT[6], 8'h00 };
       rom[142] = {7'h4F, 16'h666F,
                 S11_DIGITAL_FILT[5], 2'h0, S11_DIGITAL_FILT[4:3], 2'h0,
                 S11_DIGITAL_FILT[2:1], 2'h0, S11_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 12 Initialization
       //***********************************************************************

       // Store the power bits
       rom[143] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[144]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[145] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[146] = {7'h12, 16'h1000, S12_CLKOUT6[15:0]};
       rom[147] = {7'h13, 16'hC000, S12_CLKOUT6[31:16]};

       // Store the input divider
       rom[148] = {7'h16, 16'hC000, {2'h0, S12_DIVCLK[23:22], S12_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[149] = {7'h14, 16'h1000, S12_CLKFBOUT[15:0]};
       rom[150] = {7'h15, 16'h8000, S12_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[151] = {7'h18, 16'hFC00, {6'h00, S12_LOCK[29:20]} };
       rom[152] = {7'h19, 16'h8000, {1'b0 , S12_LOCK[34:30], S12_LOCK[9:0]} };
       rom[153] = {7'h1A, 16'h8000, {1'b0 , S12_LOCK[39:35], S12_LOCK[19:10]} };

       // Store the filter settings
       rom[154] = {7'h4E, 16'h66FF,
                 S12_DIGITAL_FILT[9], 2'h0, S12_DIGITAL_FILT[8:7], 2'h0,
                 S12_DIGITAL_FILT[6], 8'h00 };
       rom[155] = {7'h4F, 16'h666F,
                 S12_DIGITAL_FILT[5], 2'h0, S12_DIGITAL_FILT[4:3], 2'h0,
                 S12_DIGITAL_FILT[2:1], 2'h0, S12_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 13 Initialization
       //***********************************************************************

       // Store the power bits
       rom[156] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[157]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[158] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[159] = {7'h12, 16'h1000, S13_CLKOUT6[15:0]};
       rom[160] = {7'h13, 16'hC000, S13_CLKOUT6[31:16]};

       // Store the input divider
       rom[161] = {7'h16, 16'hC000, {2'h0, S13_DIVCLK[23:22], S13_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[162] = {7'h14, 16'h1000, S13_CLKFBOUT[15:0]};
       rom[163] = {7'h15, 16'h8000, S13_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[164] = {7'h18, 16'hFC00, {6'h00, S13_LOCK[29:20]} };
       rom[165] = {7'h19, 16'h8000, {1'b0 , S13_LOCK[34:30], S13_LOCK[9:0]} };
       rom[166] = {7'h1A, 16'h8000, {1'b0 , S13_LOCK[39:35], S13_LOCK[19:10]} };

       // Store the filter settings
       rom[167] = {7'h4E, 16'h66FF,
                 S13_DIGITAL_FILT[9], 2'h0, S13_DIGITAL_FILT[8:7], 2'h0,
                 S13_DIGITAL_FILT[6], 8'h00 };
       rom[168] = {7'h4F, 16'h666F,
                 S13_DIGITAL_FILT[5], 2'h0, S13_DIGITAL_FILT[4:3], 2'h0,
                 S13_DIGITAL_FILT[2:1], 2'h0, S13_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 14 Initialization
       //***********************************************************************

       // Store the power bits
       rom[169] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[170]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[171] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[172] = {7'h12, 16'h1000, S14_CLKOUT6[15:0]};
       rom[173] = {7'h13, 16'hC000, S14_CLKOUT6[31:16]};

       // Store the input divider
       rom[174] = {7'h16, 16'hC000, {2'h0, S14_DIVCLK[23:22], S14_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[175] = {7'h14, 16'h1000, S14_CLKFBOUT[15:0]};
       rom[176] = {7'h15, 16'h8000, S14_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[177] = {7'h18, 16'hFC00, {6'h00, S14_LOCK[29:20]} };
       rom[178] = {7'h19, 16'h8000, {1'b0 , S14_LOCK[34:30], S14_LOCK[9:0]} };
       rom[179] = {7'h1A, 16'h8000, {1'b0 , S14_LOCK[39:35], S14_LOCK[19:10]} };

       // Store the filter settings
       rom[180] = {7'h4E, 16'h66FF,
                 S14_DIGITAL_FILT[9], 2'h0, S14_DIGITAL_FILT[8:7], 2'h0,
                 S14_DIGITAL_FILT[6], 8'h00 };
       rom[181] = {7'h4F, 16'h666F,
                 S14_DIGITAL_FILT[5], 2'h0, S14_DIGITAL_FILT[4:3], 2'h0,
                 S14_DIGITAL_FILT[2:1], 2'h0, S14_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 15 Initialization
       //***********************************************************************

       // Store the power bits
       rom[182] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[183]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[184] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[185] = {7'h12, 16'h1000, S15_CLKOUT6[15:0]};
       rom[186] = {7'h13, 16'hC000, S15_CLKOUT6[31:16]};

       // Store the input divider
       rom[187] = {7'h16, 16'hC000, {2'h0, S15_DIVCLK[23:22], S15_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[188] = {7'h14, 16'h1000, S15_CLKFBOUT[15:0]};
       rom[189] = {7'h15, 16'h8000, S15_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[190] = {7'h18, 16'hFC00, {6'h00, S15_LOCK[29:20]} };
       rom[191] = {7'h19, 16'h8000, {1'b0 , S15_LOCK[34:30], S15_LOCK[9:0]} };
       rom[192] = {7'h1A, 16'h8000, {1'b0 , S15_LOCK[39:35], S15_LOCK[19:10]} };

       // Store the filter settings
       rom[193] = {7'h4E, 16'h66FF,
                 S15_DIGITAL_FILT[9], 2'h0, S15_DIGITAL_FILT[8:7], 2'h0,
                 S15_DIGITAL_FILT[6], 8'h00 };
       rom[194] = {7'h4F, 16'h666F,
                 S15_DIGITAL_FILT[5], 2'h0, S15_DIGITAL_FILT[4:3], 2'h0,
                 S15_DIGITAL_FILT[2:1], 2'h0, S15_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 16 Initialization
       //***********************************************************************

       // Store the power bits
       rom[195] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[196]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[197] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[198] = {7'h12, 16'h1000, S16_CLKOUT6[15:0]};
       rom[199] = {7'h13, 16'hC000, S16_CLKOUT6[31:16]};

       // Store the input divider
       rom[200] = {7'h16, 16'hC000, {2'h0, S16_DIVCLK[23:22], S16_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[201] = {7'h14, 16'h1000, S16_CLKFBOUT[15:0]};
       rom[202] = {7'h15, 16'h8000, S16_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[203] = {7'h18, 16'hFC00, {6'h00, S16_LOCK[29:20]} };
       rom[204] = {7'h19, 16'h8000, {1'b0 , S16_LOCK[34:30], S16_LOCK[9:0]} };
       rom[205] = {7'h1A, 16'h8000, {1'b0 , S16_LOCK[39:35], S16_LOCK[19:10]} };

       // Store the filter settings
       rom[206] = {7'h4E, 16'h66FF,
                 S16_DIGITAL_FILT[9], 2'h0, S16_DIGITAL_FILT[8:7], 2'h0,
                 S16_DIGITAL_FILT[6], 8'h00 };
       rom[207] = {7'h4F, 16'h666F,
                 S16_DIGITAL_FILT[5], 2'h0, S16_DIGITAL_FILT[4:3], 2'h0,
                 S16_DIGITAL_FILT[2:1], 2'h0, S16_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 17 Initialization
       //***********************************************************************

       // Store the power bits
       rom[208] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[209]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[210] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[211] = {7'h12, 16'h1000, S17_CLKOUT6[15:0]};
       rom[212] = {7'h13, 16'hC000, S17_CLKOUT6[31:16]};

       // Store the input divider
       rom[213] = {7'h16, 16'hC000, {2'h0, S17_DIVCLK[23:22], S17_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[214] = {7'h14, 16'h1000, S17_CLKFBOUT[15:0]};
       rom[215] = {7'h15, 16'h8000, S17_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[216] = {7'h18, 16'hFC00, {6'h00, S17_LOCK[29:20]} };
       rom[217] = {7'h19, 16'h8000, {1'b0 , S17_LOCK[34:30], S17_LOCK[9:0]} };
       rom[218] = {7'h1A, 16'h8000, {1'b0 , S17_LOCK[39:35], S17_LOCK[19:10]} };

       // Store the filter settings
       rom[219] = {7'h4E, 16'h66FF,
                 S17_DIGITAL_FILT[9], 2'h0, S17_DIGITAL_FILT[8:7], 2'h0,
                 S17_DIGITAL_FILT[6], 8'h00 };
       rom[220] = {7'h4F, 16'h666F,
                 S17_DIGITAL_FILT[5], 2'h0, S17_DIGITAL_FILT[4:3], 2'h0,
                 S17_DIGITAL_FILT[2:1], 2'h0, S17_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 18 Initialization
       //***********************************************************************

       // Store the power bits
       rom[221] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[222]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[223] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[224] = {7'h12, 16'h1000, S18_CLKOUT6[15:0]};
       rom[225] = {7'h13, 16'hC000, S18_CLKOUT6[31:16]};

       // Store the input divider
       rom[226] = {7'h16, 16'hC000, {2'h0, S18_DIVCLK[23:22], S18_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[227] = {7'h14, 16'h1000, S18_CLKFBOUT[15:0]};
       rom[228] = {7'h15, 16'h8000, S18_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[229] = {7'h18, 16'hFC00, {6'h00, S18_LOCK[29:20]} };
       rom[230] = {7'h19, 16'h8000, {1'b0 , S18_LOCK[34:30], S18_LOCK[9:0]} };
       rom[231] = {7'h1A, 16'h8000, {1'b0 , S18_LOCK[39:35], S18_LOCK[19:10]} };

       // Store the filter settings
       rom[232] = {7'h4E, 16'h66FF,
                 S18_DIGITAL_FILT[9], 2'h0, S18_DIGITAL_FILT[8:7], 2'h0,
                 S18_DIGITAL_FILT[6], 8'h00 };
       rom[233] = {7'h4F, 16'h666F,
                 S18_DIGITAL_FILT[5], 2'h0, S18_DIGITAL_FILT[4:3], 2'h0,
                 S18_DIGITAL_FILT[2:1], 2'h0, S18_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 19 Initialization
       //***********************************************************************

       // Store the power bits
       rom[234] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[235]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[236] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[237] = {7'h12, 16'h1000, S19_CLKOUT6[15:0]};
       rom[238] = {7'h13, 16'hC000, S19_CLKOUT6[31:16]};

       // Store the input divider
       rom[239] = {7'h16, 16'hC000, {2'h0, S19_DIVCLK[23:22], S19_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[240] = {7'h14, 16'h1000, S19_CLKFBOUT[15:0]};
       rom[241] = {7'h15, 16'h8000, S19_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[242] = {7'h18, 16'hFC00, {6'h00, S19_LOCK[29:20]} };
       rom[243] = {7'h19, 16'h8000, {1'b0 , S19_LOCK[34:30], S19_LOCK[9:0]} };
       rom[244] = {7'h1A, 16'h8000, {1'b0 , S19_LOCK[39:35], S19_LOCK[19:10]} };

       // Store the filter settings
       rom[245] = {7'h4E, 16'h66FF,
                 S19_DIGITAL_FILT[9], 2'h0, S19_DIGITAL_FILT[8:7], 2'h0,
                 S19_DIGITAL_FILT[6], 8'h00 };
       rom[246] = {7'h4F, 16'h666F,
                 S19_DIGITAL_FILT[5], 2'h0, S19_DIGITAL_FILT[4:3], 2'h0,
                 S19_DIGITAL_FILT[2:1], 2'h0, S19_DIGITAL_FILT[0], 4'h0 };
                 
       //***********************************************************************
       // State 20 Initialization
       //***********************************************************************

       // Store the power bits
       rom[247] = {7'h28, 16'h0000, 16'hFFFF};

       // Store CLKOUT4 divide and phase
       rom[248]  = {7'h10, 16'h1000, CLKOUT4[15:0]};
       rom[249] = {7'h11, 16'hFC00, CLKOUT4[31:26],2'b10,CLKOUT4[23:16]};

       // Store CLKOUT6 divide and phase
       rom[250] = {7'h12, 16'h1000, S20_CLKOUT6[15:0]};
       rom[251] = {7'h13, 16'hC000, S20_CLKOUT6[31:16]};

       // Store the input divider
       rom[252] = {7'h16, 16'hC000, {2'h0, S20_DIVCLK[23:22], S20_DIVCLK[11:0]} };

       // Store the feedback divide and phase
       rom[253] = {7'h14, 16'h1000, S20_CLKFBOUT[15:0]};
       rom[254] = {7'h15, 16'h8000, S20_CLKFBOUT[31:16]};

       // Store the lock settings
       rom[255] = {7'h18, 16'hFC00, {6'h00, S20_LOCK[29:20]} };
       rom[256] = {7'h19, 16'h8000, {1'b0 , S20_LOCK[34:30], S20_LOCK[9:0]} };
       rom[257] = {7'h1A, 16'h8000, {1'b0 , S20_LOCK[39:35], S20_LOCK[19:10]} };

       // Store the filter settings
       rom[258] = {7'h4E, 16'h66FF,
                 S20_DIGITAL_FILT[9], 2'h0, S20_DIGITAL_FILT[8:7], 2'h0,
                 S20_DIGITAL_FILT[6], 8'h00 };
       rom[259] = {7'h4F, 16'h666F,
                 S20_DIGITAL_FILT[5], 2'h0, S20_DIGITAL_FILT[4:3], 2'h0,
                 S20_DIGITAL_FILT[2:1], 2'h0, S20_DIGITAL_FILT[0], 4'h0 };
                 
//       // Initialize the rest of the ROM
//       rom[130] = {7'h28,32'h0000_0000};
//       for (ii = 131; ii < 260; ii = ii + 1) begin
//        rom[ii] = 0;
//       end

    end

    // Output the initialized rom value based on rom_addr each clock cycle
    always @(posedge SCLK) begin
       rom_do<= #TCQ rom[rom_addr];
    end

    //**************************************************************************
    // Everything below is associated whith the state machine that is used to
    // Read/Modify/Write to the MMCM.
    //**************************************************************************

    // State Definitions
    localparam RESTART      = 4'h1;
    localparam WAIT_LOCK    = 4'h2;
    localparam WAIT_SEN     = 4'h3;
    localparam ADDRESS      = 4'h4;
    localparam WAIT_A_DRDY  = 4'h5;
    localparam BITMASK      = 4'h6;
    localparam BITSET       = 4'h7;
    localparam WRITE        = 4'h8;
    localparam WAIT_DRDY    = 4'h9;

    // State sync
    reg [3:0]  current_state   = RESTART;
    reg [3:0]  next_state      = RESTART;

    // These variables are used to keep track of the number of iterations that
    //    each state takes to reconfigure.
    // STATE_COUNT_CONST is used to reset the counters and should match the
    //    number of registers necessary to reconfigure each state.
    localparam STATE_COUNT_CONST = 13;
    reg [3:0] state_count         = STATE_COUNT_CONST;
    reg [3:0] next_state_count    = STATE_COUNT_CONST;

    // This block assigns the next register value from the state machine below
    always @(posedge SCLK) begin
       DADDR       <= #TCQ next_daddr;
       DWE         <= #TCQ next_dwe;
       DEN         <= #TCQ next_den;
       RST_MMCM    <= #TCQ next_rst_mmcm;
       DI          <= #TCQ next_di;

       SRDY        <= #TCQ next_srdy;

       rom_addr    <= #TCQ next_rom_addr;
       state_count <= #TCQ next_state_count;
    end

    // This block assigns the next state, reset is syncronous.
    always @(posedge SCLK) begin
       if(RST) begin
          current_state <= #TCQ RESTART;
       end else begin
          current_state <= #TCQ next_state;
       end
    end
    
    // Set DONE low when programming begins, high when it finishes.
    always @(posedge SCLK) begin
        if (current_state == ADDRESS) begin
            DONE <= 1'b0;
        end else if (current_state == WAIT_LOCK) begin
            DONE <= 1'b1;
        end
    end

    always @* begin
       // Setup the default values
       next_srdy         = 1'b0;
       next_daddr        = DADDR;
       next_dwe          = 1'b0;
       next_den          = 1'b0;
       next_rst_mmcm     = RST_MMCM;
       next_di           = DI;
       next_rom_addr     = rom_addr;
       next_state_count  = state_count;

       case (current_state)
          // If RST is asserted reset the machine
          RESTART: begin
             next_daddr     = 7'h00;
             next_di        = 16'h0000;
             next_rom_addr  = 9'h000;
             next_rst_mmcm  = 1'b1;
             next_state     = WAIT_LOCK;
          end

          // Waits for the MMCM to assert IntLocked - once it does asserts SRDY
          WAIT_LOCK: begin
             
             // Make sure reset is de-asserted
             next_rst_mmcm   = 1'b0;
             // Reset the number of registers left to write for the next
             // reconfiguration event.
             next_state_count = STATE_COUNT_CONST ;
             next_rom_addr = SADDR ? (SADDR - 1) * STATE_COUNT_CONST : 0;

             if(IntLocked) begin
                // MMCM is IntLocked, go on to wait for the SEN signal
                next_state  = WAIT_SEN;
                // Assert SRDY to indicate that the reconfiguration module is
                // ready
                next_srdy   = 1'b1;
             end else begin
                // Keep waiting, IntLocked has not asserted yet
                next_state  = WAIT_LOCK;
             end
          end

          // Wait for the next SEN pulse and set the ROM addr appropriately
          //    based on SADDR
          WAIT_SEN: begin
             next_rom_addr = SADDR ? (SADDR - 1) * STATE_COUNT_CONST : 0;

             if (SEN) begin
                next_rom_addr = SADDR ? (SADDR - 1) * STATE_COUNT_CONST : 0;

                // Go on to address the MMCM
                next_state = ADDRESS;
             end else begin
                // Keep waiting for SEN to be asserted
                next_state = WAIT_SEN;
             end
          end

          // Set the address on the MMCM and assert DEN to read the value
          ADDRESS: begin
             // Reset the DCM through the reconfiguration
             next_rst_mmcm  = 1'b1;
             // Enable a read from the MMCM and set the MMCM address
             next_den       = 1'b1;
             next_daddr     = rom_do[38:32];

             // Wait for the data to be ready
             next_state     = WAIT_A_DRDY;
          end

          // Wait for DRDY to assert after addressing the MMCM
          WAIT_A_DRDY: begin
             if (DRDY) begin
                // Data is ready, mask out the bits to save
                next_state = BITMASK;
             end else begin
                // Keep waiting till data is ready
                next_state = WAIT_A_DRDY;
             end
          end

          // Zero out the bits that are not set in the mask stored in rom
          BITMASK: begin
             // Do the mask
             next_di     = rom_do[31:16] & DO;
             // Go on to set the bits
             next_state  = BITSET;
          end

          // After the input is masked, OR the bits with calculated value in rom
          BITSET: begin
             // Set the bits that need to be assigned
             next_di           = rom_do[15:0] | DI;
             // Set the next address to read from ROM
             next_rom_addr     = rom_addr + 1'b1;
             // Go on to write the data to the MMCM
             next_state        = WRITE;
          end

          // DI is setup so assert DWE, DEN, and RST_MMCM.  Subtract one from the
          //    state count and go to wait for DRDY.
          WRITE: begin
             // Set WE and EN on MMCM
             next_dwe          = 1'b1;
             next_den          = 1'b1;

             // Decrement the number of registers left to write
             next_state_count  = state_count - 1'b1;
             // Wait for the write to complete
             next_state        = WAIT_DRDY;
          end

          // Wait for DRDY to assert from the MMCM.  If the state count is not 0
          //    jump to ADDRESS (continue reconfiguration).  If state count is
          //    0 wait for lock.
          WAIT_DRDY: begin
             if(DRDY) begin
                // Write is complete
                if(state_count > 0) begin
                   // If there are more registers to write keep going
                   next_state  = ADDRESS;
                end else begin
                   // There are no more registers to write so wait for the MMCM
                   // to lock
                   next_state  = WAIT_LOCK;
                end
             end else begin
                // Keep waiting for write to complete
                next_state     = WAIT_DRDY;
             end
          end

          // If in an unknown state reset the machine
          default: begin
             next_state = RESTART;
          end
       endcase
    end
endmodule
