How the emulator modules work:
Since the RHD sensor has a total of 64 channels made from two separate 32 channel chips,
the logic is split into "a" and "b", representing each 32 channel chip.

Additional variables needed:
wire miso_ddr; --> output of DDR (combining a and b)
wire MISO_bit_a; --> MISO bit from a
wire MISO_bit_b; --> MISO bit from b
reg [15:0] MISO_a, MISO_b; --> Entire MISO(16 bit register) from one command


Explanation of modules:
sensor_emulator --> function: read MOSI and output MISO as a 16 bit register each command cycle
- By tracking the number of clk cycles after CS falls, it detects when the 16 bit command is 
  is being recorded and when it is complete
- MISO is 0 for the first two command cycles
- 1st cycle: MOSI_current_reg is set to the current command
- 2nd cycle: MOSI_stored_reg is set to the command from the last cycle while MOSI_current_reg tracks the current command
- 3rd cycle: MISO_reg is determined based on MOSI_stored_reg
- MISO depends on 5 commands: CONVERT, WRITE, READ, CALIBRATE, CLEAR

shift_reg --> function: take the 16 bit register MISO from sensor_emulator and output it bit-by-bit per clk cycle
- creates special_clk to align MISO output

ddr_mux --> function: take MISO outputs from shift_reg_a and shift_reg_b and output via DDR
- samples MISO_a on rising edge of clk
- samples MISO_b on falling edge of clk
