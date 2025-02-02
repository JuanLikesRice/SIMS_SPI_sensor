`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 		 Intan Technologies, LLC
// 
// Design Name: 	 RHD2000 7310 Rhythm USB3 Interface
// Module Name:    variable_freq_clk_generator
// Project Name:   RHDInterfaceXEM7310
// Target Devices: 
// Tool versions: 
// Description: 	 On-FPGA programmable-frequency clock generator
//
// Dependencies: 
//
// Revision:        3.0 (10 January 2023)
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// This module uses the Artix-7 MMCM to create a programmable-frequency clock. However,
// the frequency calculation is altered so that the same inputs from software that
// would result in a specific frequency still result in the same frequency. The following
// description describes the equation from the 6-series, however, each of these M/D values
// frequency values is actually hard-coded to a specific state in mmcm_drp.v that result in
// programming the MMCM to the same frequency.
//
// NOTE: For the 7-series, this is not the equation actually used to configure the output
// frequency - that equation is clkout frequency = 200 MHz * (M/(D*O)) (see Xilinx UG742).
// However, for compatibility with software using the 6-series, each M,D pair is associated
// with a specific state in mmcm_drp.v, and a matching M,D,O trio.
//
// Assuming a 100 MHz reference clock is provided to the module, the output frequency is given
// by:
//       clkout frequency = 100 MHz * (M/D) / 2
//
// Restrictions:  M must have a value in the range of 2 - 256
//                D must have a value in the range of 1 - 256
//                M/D must fall in the range of 0.05 - 3.33
//
// (See pages 85-86 of Xilinx document UG382 "Spartan-6 FPGA Clocking Resources" for more details.)
//
// This variable-frequency clock drives the state machine that controls all SPI communication
// with the RHD2000 chips.  A complete SPI cycle (consisting of one CS pulse and 16 SCLK pulses)
// takes 80 clock cycles.  The firmware samples all 32 channels and then executes 3 "auxiliary"
// commands that can be used to read and write from other registers on the chip, or to sample from
// the temperature sensor or auxiliary ADC inputs, for example.  Therefore, a complete cycle that
// samples from each amplifier channel takes 80 * (32 + 3) = 80 * 35 = 2800 clock cycles.
//
// So the per-channel sampling rate of each amplifier is 2800 times slower than the clock frequency.
//
// Based on these design choices, we can use the following values of M and D to generate the following
// useful amplifier sampling rates for electrophysiological applications:
//
//   M    D     clkout frequency    per-channel sample rate     per-channel sample period
//  ---  ---    ----------------    -----------------------     -------------------------
//    7  125          2.80 MHz               1.00 kS/s                 1000.0 usec = 1.0 msec
//    7  100          3.50 MHz               1.25 kS/s                  800.0 usec
//   21  250          4.20 MHz               1.50 kS/s                  666.7 usec
//   14  125          5.60 MHz               2.00 kS/s                  500.0 usec                     
//   35  250          7.00 MHz               2.50 kS/s                  400.0 usec
//   21  125          8.40 MHz               3.00 kS/s                  333.3 usec
//   14   75          9.33 MHz               3.33 kS/s                  300.0 usec
//   28  125         11.20 MHz               4.00 kS/s                  250.0 usec
//    7   25         14.00 MHz               5.00 kS/s                  200.0 usec
//    7   20         17.50 MHz               6.25 kS/s                  160.0 usec
//  112  250         22.40 MHz               8.00 kS/s                  125.0 usec
//   14   25         28.00 MHz              10.00 kS/s                  100.0 usec
//    7   10         35.00 MHz              12.50 kS/s                   80.0 usec
//   21   25         42.00 MHz              15.00 kS/s                   66.7 usec
//   28   25         56.00 MHz              20.00 kS/s                   50.0 usec
//   35   25         70.00 MHz              25.00 kS/s                   40.0 usec
//   42   25         84.00 MHz              30.00 kS/s                   33.3 usec
//   28   15         93.33 MHz              33.33 kS/s                   30.0 usec
//   56   25        112.00 MHz              40.00 kS/s                   25.0 usec
//   14    5        140.00 MHz              50.00 kS/s                   20.0 usec
//
// To set a new clock frequency, assert new values for M and D (e.g., using okWireIn modules) and
// pulse MMCM_prog_trigger high (e.g., using an okTriggerIn module synchronized to okClk).  If this
// module is reset, it reverts to the default values of M_DEFAULT and D_DEFAULT.
module variable_freq_clk_generator
    (
    input wire sys_clk,
    input wire okClk,
    input wire reset,
    input wire [7:0] M,
    input wire [7:0] D,
    input wire MMCM_prog_trigger,

    output wire clkout,
    output wire MMCM_prog_done,
    output wire locked
    );
    
    reg [4:0] freq_select;
    always @(*) begin
        case ({M, D})
            {8'd007, 8'd125}: freq_select <= 1; // 1000 Hz sample rate
            {8'd007, 8'd100}: freq_select <= 2; // 1250 Hz sample rate
            {8'd021, 8'd250}: freq_select <= 3; // 1500 Hz sample rate
            {8'd014, 8'd125}: freq_select <= 4; // 2000 Hz sample rate
            {8'd035, 8'd250}: freq_select <= 5; // 2500 Hz sample rate
            {8'd021, 8'd125}: freq_select <= 6; // 3000 Hz sample rate
            {8'd014, 8'd075}: freq_select <= 7; // 3333 Hz sample rate
            {8'd028, 8'd125}: freq_select <= 8; // 4000 Hz sample rate
            {8'd007, 8'd025}: freq_select <= 9; // 5000 Hz sample rate
            {8'd007, 8'd020}: freq_select <= 10; // 6250 Hz sample rate
            {8'd112, 8'd250}: freq_select <= 11; // 8000 Hz sample rate
            {8'd014, 8'd025}: freq_select <= 12; // 10000 Hz sample rate
            {8'd007, 8'd010}: freq_select <= 13; // 12500 Hz sample rate
            {8'd021, 8'd025}: freq_select <= 14; // 15000 Hz sample rate
            {8'd028, 8'd025}: freq_select <= 15; // 20000 Hz sample rate
            {8'd035, 8'd025}: freq_select <= 16; // 25000 Hz sample rate
            {8'd042, 8'd025}: freq_select <= 17; // 30000 Hz sample rate
            {8'd028, 8'd015}: freq_select <= 18; // 33333 Hz sample rate - not used in RHX software
            {8'd056, 8'd025}: freq_select <= 19; // 40000 Hz sample rate - not used in RHX software
            {8'd014, 8'd005}: freq_select <= 20; // 50000 Hz sample rate - not used in RHX software
            default: freq_select <= 17;
        endcase
    end


    /* MMCM DRP - dynamic reprogramming of MMCM used to generate desired frequency */
    reg SSTEP;              // Pulses high for 1 okClk cycle to trigger MMCM reprogramming
    reg [4:0] STATE = 17;   // Indicates which of the 20 pre-set states the MMCM DRP should follow
    wire SRDY;              // MMCM DRP asserts for 1 okClk cycle to notify end of a reconfiguration sequence
    wire [15:0] di;         // DRP data input - register value to write to MMCM
    wire [6:0] daddr;       // DRP address input - register location to read/write from MMCM
    wire [15:0] dout;       // DRP data output - register value to read from MMCM
    wire den;               // DRP enable - enable dynamic reconfiguration feature of MMCM
    wire dwe;               // DRP data write enable - enable write of DI data to DADDR address
    wire rst_mmcm;          // Reset MMCM
    wire drdy;              // DRP ready - notify when MMCM is ready to read or write new value
    wire feedback_clk;      // Feedback signal connecting CLKFBIN and CLKFBOUT for internal feedback
    wire dclk;              // Clk used to reconfigure MMCM - currently DRP forwards okClk to this
    wire LOCKED;            // Output of MMCM indicating when MMCM has achieve phase alignment
    wire clk_out_4;         // MMCM CLKOUT4
    wire clk_out_6;         // MMCM CLKOUT6
    wire clk_mmcm_select;   // Selects between CLKOUT4 and CLKOUT6
    
    /* MMCM output mux - either CLKOUT4 or CLKOUT6 */
    // States 1-3 use clkout4 for a divide-by-2
    assign clk_mmcm_select = STATE < 4;
    
    BUFGMUX_CTRL BUFGMUX_CTRL_inst (
      .O(clkout),   // 1-bit output: Clock output
      .I0(clk_out_6), // 1-bit input: Clock input (S=0)
      .I1(clk_out_4), // 1-bit input: Clock input (S=1)
      .S(clk_mmcm_select)    // 1-bit input: Clock select
    ); 
    
    /* Logic to change target frequency */
    integer prog_state = 0;
    always @(posedge okClk) begin
        // State 0 - wait for MMCM_prog_trigger (TriggerIn), and once it happens set STATE
        if (prog_state == 0) begin
            if (MMCM_prog_trigger) begin
                STATE <= freq_select;
                prog_state <= 1;
            end
        // State 1 - set SSTEP high to initiate MMCM reprogramming
        end else if (prog_state == 1) begin
            SSTEP <= 1;
            prog_state <= 2;
        // State 2 - set SSTEP low, re-enter state 0 to resume waiting for next TriggerIn
        end else if (prog_state == 2) begin
            SSTEP <= 0;
            prog_state <= 0;
        end
    end
    
    /* MMCM */
    // MMCME2_ADV: Advanced Mixed Mode Clock Manager, Artix-7
    MMCME2_ADV #(
        // WARNING - THIS CASCADE VALUE IS OVERRIDDEN BY MX BITS IN DRP
        .CLKOUT4_CASCADE("TRUE"),      // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
        .BANDWIDTH("LOW"),
        .COMPENSATION("INTERNAL"),
        .REF_JITTER1(0.0),
        .REF_JITTER2(0.0),
        // Use M, C, O values for the highest practical frequency (84.0 MHz), so the auto-generated clock on this pin
        // represents the highest frequency we could possibly see
        .CLKFBOUT_MULT_F(21.0),
        .DIVCLK_DIVIDE(5),
        .CLKOUT4_DIVIDE(20),
        .CLKOUT6_DIVIDE(10)
    )
    MMCME2_ADV_inst (
        // Clock Outputs: 1-bit (each) output: User configurable clock outputs
        .CLKOUT0(),           // 1-bit output: CLKOUT0
        .CLKOUT0B(),         // 1-bit output: Inverted CLKOUT0
        .CLKOUT1(),           // 1-bit output: CLKOUT1
        .CLKOUT1B(),         // 1-bit output: Inverted CLKOUT1
        .CLKOUT2(),           // 1-bit output: CLKOUT2
        .CLKOUT2B(),         // 1-bit output: Inverted CLKOUT2
        .CLKOUT3(),           // 1-bit output: CLKOUT3
        .CLKOUT3B(),         // 1-bit output: Inverted CLKOUT3
        .CLKOUT4(clk_out_4),           // 1-bit output: CLKOUT4
        .CLKOUT5(),           // 1-bit output: CLKOUT5
        .CLKOUT6(clk_out_6),           // 1-bit output: CLKOUT6
        // DRP Ports: 16-bit (each) output: Dynamic reconfiguration ports
        .DO(dout),                     // 16-bit output: DRP data
        .DRDY(drdy),                 // 1-bit output: DRP ready
        .PSDONE(),
        // Feedback Clocks: 1-bit (each) output: Clock feedback ports
        .CLKFBOUT(feedback_clk),         // 1-bit output: Feedback clock
        .CLKFBOUTB(),       // 1-bit output: Inverted CLKFBOUT
        // Status Ports: 1-bit (each) output: MMCM status ports
        .CLKFBSTOPPED(), // 1-bit output: Feedback clock stopped
        .CLKINSTOPPED(), // 1-bit output: Input clock stopped
        .LOCKED(LOCKED),             // 1-bit output: LOCK
        // Clock Inputs: 1-bit (each) input: Clock inputs
        .CLKIN1(sys_clk),             // 1-bit input: Primary clock
        .CLKIN2(),             // 1-bit input: Secondary clock
        // Control Ports: 1-bit (each) input: MMCM control ports
        .CLKINSEL(1'b1),         // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
        .PWRDWN(1'b0),             // 1-bit input: Power-down
        .RST(rst_mmcm),                   // 1-bit input: Reset
        // DRP Ports: 7-bit (each) input: Dynamic reconfiguration ports
        .DADDR(daddr),               // 7-bit input: DRP address
        .DCLK(dclk),                 // 1-bit input: DRP clock
        .DEN(den),                   // 1-bit input: DRP enable
        .DI(di),                     // 16-bit input: DRP data
        .DWE(dwe),                   // 1-bit input: DRP write enable
        // Dynamic Phase Shift Ports: 1-bit (each) input: Ports used for dynamic phase shifting of the outputs
        .PSCLK(1'b0),               // 1-bit input: Phase shift clock
        .PSEN(1'b0),                 // 1-bit input: Phase shift enable
        .PSINCDEC(1'b0),         // 1-bit input: Phase shift increment/decrement
        // Feedback Clocks: 1-bit (each) input: Clock feedback ports
        .CLKFBIN(feedback_clk)            // 1-bit input: Feedback clock
    );
    
    /* MMCM_DRP */
    // Simplified version of MMCME2_DRP
    mmcm_drp mmcm_drp_inst (
        .SADDR              (STATE),
        .SEN                (SSTEP),
        .RST                (reset),
        .SRDY               (SRDY),
        .SCLK               (okClk),
        .DO                 (dout),
        .DRDY               (drdy),
        .LOCK_REG_CLK_IN    (okClk),
        .LOCKED_IN          (LOCKED),
        .DWE                (dwe),
        .DEN                (den),
        .DADDR              (daddr),
        .DI                 (di),
        .DCLK               (dclk),
        .RST_MMCM           (rst_mmcm),
        .LOCKED_OUT         (locked),
        .DONE               (MMCM_prog_done)
    );


endmodule