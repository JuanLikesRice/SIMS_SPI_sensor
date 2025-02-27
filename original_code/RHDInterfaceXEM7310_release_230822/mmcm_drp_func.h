// Header file, to be used in conjunction with mmcm_drp.v

`define FRAC_PRECISION  10
`define FIXED_WIDTH     32

// This function takes a fixed point number and rounds it to the nearest
//    fractional precision bit.
function [`FIXED_WIDTH:1] round_frac
   (
      // Input is (FIXED_WIDTH-FRAC_PRECISION).FRAC_PRECISION fixed point number
      input [`FIXED_WIDTH:1] decimal,

      // This describes the precision of the fraction, for example a value
      //    of 1 would modify the fractional so that instead of being a .16
      //    fractional, it would be a .1 (rounded to the nearest 0.5 in turn)
      input [`FIXED_WIDTH:1] precision
   );

   begin
      // If the fractional precision bit is high then round up
      if( decimal[(`FRAC_PRECISION-precision)] == 1'b1) begin
         round_frac = decimal + (1'b1 << (`FRAC_PRECISION-precision));
      end else begin
         round_frac = decimal;
      end
   end
endfunction

// This function calculates high_time, low_time, w_edge, and no_count
//    of a non-fractional counter based on the divide and duty cycle
//
// NOTE: high_time and low_time are returned as integers between 0 and 63
//    inclusive.  64 should equal 6'b000000 (in other words it is okay to
//    ignore the overflow)
function [13:0] mmcm_divider
   (
      input [7:0] divide,       // Max divide is 128
      input [31:0] duty_cycle
   );

   reg [`FIXED_WIDTH:1]    duty_cycle_fix;
      // min/max allowed duty cycle range calc for divide => 64
   reg [`FIXED_WIDTH:1]    duty_cycle_min;
   reg [`FIXED_WIDTH:1]    duty_cycle_max;

   // High/Low time is initially calculated with a wider integer to prevent a
   // calculation error when it overflows to 64.
   reg [6:0]               high_time;
   reg [6:0]               low_time;
   reg                     w_edge;
   reg                     no_count;

   reg [`FIXED_WIDTH:1]    temp;

   begin
      if (divide >= 64) begin     // DCD and frequency generation fix if O divide => 64
           duty_cycle_min = ((divide - 64) * 100_000) / divide;
           duty_cycle_max = (64.5 / divide) * 100_000;
           if (duty_cycle > duty_cycle_max)  duty_cycle = duty_cycle_max;
           if (duty_cycle < duty_cycle_min)  duty_cycle = duty_cycle_min;
       end
      // Convert to FIXED_WIDTH-FRAC_PRECISION.FRAC_PRECISION fixed point
      duty_cycle_fix = (duty_cycle << `FRAC_PRECISION) / 100_000;

      // If the divide is 1 nothing needs to be set except the no_count bit.
      //    Other values are dummies
      if(divide == 7'h01) begin
         high_time   = 7'h01;
         w_edge      = 1'b0;
         low_time    = 7'h01;
         no_count    = 1'b1;
      end else begin
         temp = round_frac(duty_cycle_fix*divide, 1);

         // comes from above round_frac
         high_time   = temp[`FRAC_PRECISION+7:`FRAC_PRECISION+1];
         // If the duty cycle * divide rounded is .5 or greater then this bit
         //    is set.
         w_edge      = temp[`FRAC_PRECISION]; // comes from round_frac

         // If the high time comes out to 0, it needs to be set to at least 1
         // and w_edge set to 0
         if(high_time == 7'h00) begin
            high_time   = 7'h01;
            w_edge      = 1'b0;
         end

         if(high_time == divide) begin
            high_time   = divide - 1;
            w_edge      = 1'b1;
         end

         // Calculate low_time based on the divide setting and set no_count to
         //    0 as it is only used when divide is 1.
         low_time    = divide - high_time;
         no_count    = 1'b0;
      end

      // Set the return value.
      mmcm_divider = {w_edge,no_count,high_time[5:0],low_time[5:0]};
   end
endfunction

// This function takes the divide value and outputs the necessary lock values
function [39:0] mmcm_lock_lookup
   (
      input [6:0] divide // Max divide is 64
   );

   reg [2559:0]   lookup;

   begin
      lookup = {
         // This table is composed of:
         // LockRefDly_LockFBDly_LockCnt_LockSatHigh_UnlockCnt
         40'b00110_00110_1111101000_1111101001_0000000001,
         40'b00110_00110_1111101000_1111101001_0000000001,
         40'b01000_01000_1111101000_1111101001_0000000001,
         40'b01011_01011_1111101000_1111101001_0000000001,
         40'b01110_01110_1111101000_1111101001_0000000001,
         40'b10001_10001_1111101000_1111101001_0000000001,
         40'b10011_10011_1111101000_1111101001_0000000001,
         40'b10110_10110_1111101000_1111101001_0000000001,
         40'b11001_11001_1111101000_1111101001_0000000001,
         40'b11100_11100_1111101000_1111101001_0000000001,
         40'b11111_11111_1110000100_1111101001_0000000001,
         40'b11111_11111_1100111001_1111101001_0000000001,
         40'b11111_11111_1011101110_1111101001_0000000001,
         40'b11111_11111_1010111100_1111101001_0000000001,
         40'b11111_11111_1010001010_1111101001_0000000001,
         40'b11111_11111_1001110001_1111101001_0000000001,
         40'b11111_11111_1000111111_1111101001_0000000001,
         40'b11111_11111_1000100110_1111101001_0000000001,
         40'b11111_11111_1000001101_1111101001_0000000001,
         40'b11111_11111_0111110100_1111101001_0000000001,
         40'b11111_11111_0111011011_1111101001_0000000001,
         40'b11111_11111_0111000010_1111101001_0000000001,
         40'b11111_11111_0110101001_1111101001_0000000001,
         40'b11111_11111_0110010000_1111101001_0000000001,
         40'b11111_11111_0110010000_1111101001_0000000001,
         40'b11111_11111_0101110111_1111101001_0000000001,
         40'b11111_11111_0101011110_1111101001_0000000001,
         40'b11111_11111_0101011110_1111101001_0000000001,
         40'b11111_11111_0101000101_1111101001_0000000001,
         40'b11111_11111_0101000101_1111101001_0000000001,
         40'b11111_11111_0100101100_1111101001_0000000001,
         40'b11111_11111_0100101100_1111101001_0000000001,
         40'b11111_11111_0100101100_1111101001_0000000001,
         40'b11111_11111_0100010011_1111101001_0000000001,
         40'b11111_11111_0100010011_1111101001_0000000001,
         40'b11111_11111_0100010011_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001,
         40'b11111_11111_0011111010_1111101001_0000000001
      };

      // Set lookup_entry with the explicit bits from lookup with a part select
      mmcm_lock_lookup = lookup[ ((64-divide)*40) +: 40];
   end
endfunction

// This function takes the divide value (assumes LOW bandwidth setting of MMCM)
//  and outputs the digital filter settings necessary.
function [9:0] mmcm_filter_lookup
  (
     input [6:0] divide // Max divide is 64
  );

  reg [639:0] lookup_low;

  begin
    lookup_low = {
      // CP_RES_LFHF
      10'b0010_1111_00, // 1
      10'b0010_1111_00, // 2
      10'b0010_1111_00, // 3
      10'b0010_1111_00, // 4
      10'b0010_0111_00, // ....
      10'b0010_1011_00,
      10'b0010_1101_00,
      10'b0010_0011_00,
      10'b0010_0101_00,
      10'b0010_0101_00,
      10'b0010_1001_00,
      10'b0010_1110_00,
      10'b0010_1110_00,
      10'b0010_1110_00,
      10'b0010_1110_00,
      10'b0010_0001_00,
      10'b0010_0001_00,
      10'b0010_0001_00,
      10'b0010_0110_00,
      10'b0010_0110_00,
      10'b0010_0110_00,
      10'b0010_0110_00,
      10'b0010_0110_00,
      10'b0010_0110_00,
      10'b0010_0110_00,
      10'b0010_1010_00,
      10'b0010_1010_00,
      10'b0010_1010_00,
      10'b0010_1010_00,
      10'b0010_1010_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_1100_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00,
      10'b0010_0010_00, // ....
      10'b0010_0010_00, // 61
      10'b0010_0010_00, // 62
      10'b0010_0010_00, // 63
      10'b0010_0010_00  // 64
    };

    // Set lookup_entry with the explicit bits from lookup with a part select
    // Low Bandwidth
    mmcm_filter_lookup = lookup_low[((64-divide)*10) +: 10];

  end
endfunction

// This function takes in the divide setting to calculate the upper and lower counter registers.
// Assume phase of 0 and duty cycle 50,000
function [37:0] mmcm_count_calc
   (
      input [7:0] divide // Max divide is 128
   );

   reg [13:0] div_calc;
   reg [16:0] phase_calc;

   begin

      // w_edge[13], no_count[12], high_time[11:6], low_time[5:0]
      div_calc = mmcm_divider(divide, 50_000);
      // mx[10:9], pm[8:6], dt[5:0]
      phase_calc = 0;

      // Return value is the upper and lower address of counter
      //    Upper address is:
      //       RESERVED    [31:26]
      //       MX          [25:24]
      //       EDGE        [23]
      //       NOCOUNT     [22]
      //       DELAY_TIME  [21:16]
      //    Lower Address is:
      //       PHASE_MUX   [15:13]
      //       RESERVED    [12]
      //       HIGH_TIME   [11:6]
      //       LOW_TIME    [5:0]

      mmcm_count_calc =
         {
            // Upper Address
            6'h00, phase_calc[10:9], div_calc[13:12], phase_calc[5:0],
            // Lower Address
            phase_calc[8:6], 1'b0, div_calc[11:0]
         };
   end
endfunction