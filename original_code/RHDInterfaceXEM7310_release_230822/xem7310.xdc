############################################################################
# XEM7310 - Xilinx constraints file
#
# Pin mappings for the XEM7310.  Use this as a template and comment out
# the pins that are not used in your design.  (By default, map will fail
# if this file contains constraints for signals not in your design).
#
# Copyright (c) 2004-2016 Opal Kelly Incorporated
############################################################################

set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]

############################################################################
## FrontPanel Host Interface
############################################################################
set_property PACKAGE_PIN Y19 [get_ports {okHU[0]}]
set_property PACKAGE_PIN R18 [get_ports {okHU[1]}]
set_property PACKAGE_PIN R16 [get_ports {okHU[2]}]
set_property SLEW FAST [get_ports {okHU[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okHU[*]}]

set_property PACKAGE_PIN W19 [get_ports {okUH[0]}]
set_property PACKAGE_PIN V18 [get_ports {okUH[1]}]
set_property PACKAGE_PIN U17 [get_ports {okUH[2]}]
set_property PACKAGE_PIN W17 [get_ports {okUH[3]}]
set_property PACKAGE_PIN T19 [get_ports {okUH[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okUH[*]}]

set_property PACKAGE_PIN AB22 [get_ports {okUHU[0]}]
set_property PACKAGE_PIN AB21 [get_ports {okUHU[1]}]
set_property PACKAGE_PIN Y22 [get_ports {okUHU[2]}]
set_property PACKAGE_PIN AA21 [get_ports {okUHU[3]}]
set_property PACKAGE_PIN AA20 [get_ports {okUHU[4]}]
set_property PACKAGE_PIN W22 [get_ports {okUHU[5]}]
set_property PACKAGE_PIN W21 [get_ports {okUHU[6]}]
set_property PACKAGE_PIN T20 [get_ports {okUHU[7]}]
set_property PACKAGE_PIN R19 [get_ports {okUHU[8]}]
set_property PACKAGE_PIN P19 [get_ports {okUHU[9]}]
set_property PACKAGE_PIN U21 [get_ports {okUHU[10]}]
set_property PACKAGE_PIN T21 [get_ports {okUHU[11]}]
set_property PACKAGE_PIN R21 [get_ports {okUHU[12]}]
set_property PACKAGE_PIN P21 [get_ports {okUHU[13]}]
set_property PACKAGE_PIN R22 [get_ports {okUHU[14]}]
set_property PACKAGE_PIN P22 [get_ports {okUHU[15]}]
set_property PACKAGE_PIN R14 [get_ports {okUHU[16]}]
set_property PACKAGE_PIN W20 [get_ports {okUHU[17]}]
set_property PACKAGE_PIN Y21 [get_ports {okUHU[18]}]
set_property PACKAGE_PIN P17 [get_ports {okUHU[19]}]
set_property PACKAGE_PIN U20 [get_ports {okUHU[20]}]
set_property PACKAGE_PIN N17 [get_ports {okUHU[21]}]
set_property PACKAGE_PIN N14 [get_ports {okUHU[22]}]
set_property PACKAGE_PIN V20 [get_ports {okUHU[23]}]
set_property PACKAGE_PIN P16 [get_ports {okUHU[24]}]
set_property PACKAGE_PIN T18 [get_ports {okUHU[25]}]
set_property PACKAGE_PIN V19 [get_ports {okUHU[26]}]
set_property PACKAGE_PIN AB20 [get_ports {okUHU[27]}]
set_property PACKAGE_PIN P15 [get_ports {okUHU[28]}]
set_property PACKAGE_PIN V22 [get_ports {okUHU[29]}]
set_property PACKAGE_PIN U18 [get_ports {okUHU[30]}]
set_property PACKAGE_PIN AB18 [get_ports {okUHU[31]}]
set_property SLEW FAST [get_ports {okUHU[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okUHU[*]}]

set_property PACKAGE_PIN N13 [get_ports okAA]
set_property IOSTANDARD LVCMOS18 [get_ports okAA]


create_clock -period 9.920 -name okUH0 [get_ports {okUH[0]}]

set_input_delay -clock [get_clocks okUH0] -max -add_delay 8.000 [get_ports -regexp {okUH\[[1-4]\]}]
set_input_delay -clock [get_clocks okUH0] -min -add_delay 10.000 [get_ports -regexp {okUH\[[1-4]\]}]

create_generated_clock -name dnaclkdiv32 -source [get_pins -hier mmcm0_bufg/O] -divide_by 32 [get_pins -hier a0/d0/dna0/CLK]
set_multicycle_path -setup -from [get_ports {okUH[*]}] 2

set_output_delay -clock [get_clocks okUH0] -max -add_delay 2.000 [get_ports {okUHU[*]}]
set_output_delay -clock [get_clocks okUH0] -min -add_delay -0.500 [get_ports {okUHU[*]}]


############################################################################
## System Clock
############################################################################
set_property IOSTANDARD LVDS_25 [get_ports sys_clk_p]

set_property IOSTANDARD LVDS_25 [get_ports sys_clk_n]
set_property PACKAGE_PIN W11 [get_ports sys_clk_p]
set_property PACKAGE_PIN W12 [get_ports sys_clk_n]

set_property DIFF_TERM FALSE [get_ports sys_clk_p]

create_clock -period 5.000 -name sys_clk [get_ports sys_clk_p]

# Set outputs of MMCMs as asynchronous, as CLKOUT4 and CLKOUT6 are mutually exclusive.
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins variable_freq_clk_generator_inst/MMCME2_ADV_inst/CLKOUT4]] -group [get_clocks -of_objects [get_pins variable_freq_clk_generator_inst/MMCME2_ADV_inst/CLKOUT6]] -group [get_clocks -of_objects [get_pins okHI/mmcm0/CLKOUT0]]

# Timing through LEDs is not important
set_false_path -through [get_nets {{led[0]} {led[1]} {led[2]} {led[3]} {led[4]} {led[5]} {led[6]} {led[7]}}]
set_false_path -through [get_nets {{SPI_port_LEDs[0]} {SPI_port_LEDs[1]} {SPI_port_LEDs[2]} {SPI_port_LEDs[3]} {SPI_port_LEDs[4]} {SPI_port_LEDs[5]} {SPI_port_LEDs[6]} {SPI_port_LEDs[7]}}]

# Input/Output delay for Opal Kelly interface pins
create_clock -period 9.920 -name VIRTUAL_mmcm0_clk0 -waveform {0.000 4.960}
set_multicycle_path -setup -from [get_clocks VIRTUAL_mmcm0_clk0] -to [get_clocks mmcm0_clk0] 2
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.000 [get_ports okAA]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 4.000 [get_ports okAA]
create_clock -period 71.429 -name VIRTUAL_clk_out_4 -waveform {0.000 35.714}
create_clock -period 7.143 -name VIRTUAL_clk_out_6 -waveform {0.000 3.571}
set_output_delay -clock [get_clocks VIRTUAL_clk_out_4] -min -add_delay 0.000 [get_ports {led[*]}]
set_output_delay -clock [get_clocks VIRTUAL_clk_out_4] -max -add_delay 4.000 [get_ports {led[*]}]
set_output_delay -clock [get_clocks VIRTUAL_clk_out_6] -min -add_delay 0.000 [get_ports {led[*]}]
set_output_delay -clock [get_clocks VIRTUAL_clk_out_6] -max -add_delay 4.000 [get_ports {led[*]}]
set_output_delay -clock [get_clocks okUH0] -min -add_delay 0.000 [get_ports {led[*]}]
set_output_delay -clock [get_clocks okUH0] -max -add_delay 4.000 [get_ports {led[*]}]
set_output_delay -clock [get_clocks okUH0] -min -add_delay 0.000 [get_ports {okUHU[*]}]
set_output_delay -clock [get_clocks okUH0] -max -add_delay 4.000 [get_ports {okUHU[*]}]
set_output_delay -clock [get_clocks okUH0] -min -add_delay 0.000 [get_ports okAA]
set_output_delay -clock [get_clocks okUH0] -max -add_delay 4.000 [get_ports okAA]

# Set Opal Kelly-derived clocks as asynchronous from each other.
# They're not really, but we can't change anything in the Opal Kelly design.
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins okHI/mmcm0/CLKOUT0]] -group okUH0 -group dnaclkdiv32 -group VIRTUAL_mmcm0_clk0

# For constant clock cells, within Opal Kelly design, ignore timing errors
set_false_path -to [get_cells okHI/core0/core0/a0/pm0/ram_1k_generate.v6.kcpsm6_rom]

############################################################################
## User Reset
############################################################################
#set_property PACKAGE_PIN Y18 [get_ports {reset}]
#set_property IOSTANDARD LVCMOS18 [get_ports {reset}]
#set_property SLEW FAST [get_ports {reset}]

# LEDs #####################################################################
set_property PACKAGE_PIN A13 [get_ports {led[0]}]
set_property PACKAGE_PIN B13 [get_ports {led[1]}]
set_property PACKAGE_PIN A14 [get_ports {led[2]}]
set_property PACKAGE_PIN A15 [get_ports {led[3]}]
set_property PACKAGE_PIN B15 [get_ports {led[4]}]
set_property PACKAGE_PIN A16 [get_ports {led[5]}]
set_property PACKAGE_PIN B16 [get_ports {led[6]}]
set_property PACKAGE_PIN B17 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[*]}]

# Flash ####################################################################
#set_property PACKAGE_PIN AA9 [get_ports {spi_dq0}]
#set_property PACKAGE_PIN V10 [get_ports {spi_c}]
#set_property PACKAGE_PIN W10 [get_ports {spi_s}]
#set_property PACKAGE_PIN AB10 [get_ports {spi_dq1}]
#set_property PACKAGE_PIN AA10 [get_ports {spi_w_dq2}]
#set_property PACKAGE_PIN AA11 [get_ports {spi_hold_dq3}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_dq0}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_c}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_s}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_dq1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_w_dq2}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_hold_dq3}]

## DRAM #####################################################################
set_property PACKAGE_PIN N18 [get_ports {ddr3_dq[0]}]
set_property PACKAGE_PIN L20 [get_ports {ddr3_dq[1]}]
set_property PACKAGE_PIN N20 [get_ports {ddr3_dq[2]}]
set_property PACKAGE_PIN K18 [get_ports {ddr3_dq[3]}]
set_property PACKAGE_PIN M18 [get_ports {ddr3_dq[4]}]
set_property PACKAGE_PIN K19 [get_ports {ddr3_dq[5]}]
set_property PACKAGE_PIN N19 [get_ports {ddr3_dq[6]}]
set_property PACKAGE_PIN L18 [get_ports {ddr3_dq[7]}]
set_property PACKAGE_PIN L16 [get_ports {ddr3_dq[8]}]
set_property PACKAGE_PIN L14 [get_ports {ddr3_dq[9]}]
set_property PACKAGE_PIN K14 [get_ports {ddr3_dq[10]}]
set_property PACKAGE_PIN M15 [get_ports {ddr3_dq[11]}]
set_property PACKAGE_PIN K16 [get_ports {ddr3_dq[12]}]
set_property PACKAGE_PIN M13 [get_ports {ddr3_dq[13]}]
set_property PACKAGE_PIN K13 [get_ports {ddr3_dq[14]}]
set_property PACKAGE_PIN L13 [get_ports {ddr3_dq[15]}]
set_property PACKAGE_PIN D22 [get_ports {ddr3_dq[16]}]
set_property PACKAGE_PIN C20 [get_ports {ddr3_dq[17]}]
set_property PACKAGE_PIN E21 [get_ports {ddr3_dq[18]}]
set_property PACKAGE_PIN D21 [get_ports {ddr3_dq[19]}]
set_property PACKAGE_PIN G21 [get_ports {ddr3_dq[20]}]
set_property PACKAGE_PIN C22 [get_ports {ddr3_dq[21]}]
set_property PACKAGE_PIN E22 [get_ports {ddr3_dq[22]}]
set_property PACKAGE_PIN B22 [get_ports {ddr3_dq[23]}]
set_property PACKAGE_PIN A20 [get_ports {ddr3_dq[24]}]
set_property PACKAGE_PIN D19 [get_ports {ddr3_dq[25]}]
set_property PACKAGE_PIN A19 [get_ports {ddr3_dq[26]}]
set_property PACKAGE_PIN F19 [get_ports {ddr3_dq[27]}]
set_property PACKAGE_PIN C18 [get_ports {ddr3_dq[28]}]
set_property PACKAGE_PIN E19 [get_ports {ddr3_dq[29]}]
set_property PACKAGE_PIN A18 [get_ports {ddr3_dq[30]}]
set_property PACKAGE_PIN C19 [get_ports {ddr3_dq[31]}]
set_property SLEW FAST [get_ports {ddr3_dq[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[*]}]

set_property PACKAGE_PIN J21 [get_ports {ddr3_addr[0]}]
set_property PACKAGE_PIN J22 [get_ports {ddr3_addr[1]}]
set_property PACKAGE_PIN K21 [get_ports {ddr3_addr[2]}]
set_property PACKAGE_PIN H22 [get_ports {ddr3_addr[3]}]
set_property PACKAGE_PIN G13 [get_ports {ddr3_addr[4]}]
set_property PACKAGE_PIN G17 [get_ports {ddr3_addr[5]}]
set_property PACKAGE_PIN H15 [get_ports {ddr3_addr[6]}]
set_property PACKAGE_PIN G16 [get_ports {ddr3_addr[7]}]
set_property PACKAGE_PIN G20 [get_ports {ddr3_addr[8]}]
set_property PACKAGE_PIN M21 [get_ports {ddr3_addr[9]}]
set_property PACKAGE_PIN J15 [get_ports {ddr3_addr[10]}]
set_property PACKAGE_PIN G15 [get_ports {ddr3_addr[11]}]
set_property PACKAGE_PIN H13 [get_ports {ddr3_addr[12]}]
set_property PACKAGE_PIN K22 [get_ports {ddr3_addr[13]}]
set_property PACKAGE_PIN L21 [get_ports {ddr3_addr[14]}]
set_property SLEW FAST [get_ports {ddr3_addr[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[*]}]

set_property PACKAGE_PIN H18 [get_ports {ddr3_ba[0]}]
set_property PACKAGE_PIN J19 [get_ports {ddr3_ba[1]}]
set_property PACKAGE_PIN H19 [get_ports {ddr3_ba[2]}]
set_property SLEW FAST [get_ports {ddr3_ba[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[*]}]

set_property PACKAGE_PIN J16 [get_ports ddr3_ras_n]
set_property SLEW FAST [get_ports ddr3_ras_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_ras_n]

set_property PACKAGE_PIN H17 [get_ports ddr3_cas_n]
set_property SLEW FAST [get_ports ddr3_cas_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_cas_n]

set_property PACKAGE_PIN J20 [get_ports ddr3_we_n]
set_property SLEW FAST [get_ports ddr3_we_n]
set_property IOSTANDARD SSTL15 [get_ports ddr3_we_n]

set_property PACKAGE_PIN F21 [get_ports ddr3_reset_n]
set_property SLEW FAST [get_ports ddr3_reset_n]
set_property IOSTANDARD LVCMOS15 [get_ports ddr3_reset_n]

set_property PACKAGE_PIN G18 [get_ports {ddr3_cke[0]}]
set_property SLEW FAST [get_ports {ddr3_cke[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke[*]}]

set_property PACKAGE_PIN H20 [get_ports {ddr3_odt[0]}]
set_property SLEW FAST [get_ports {ddr3_odt[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[*]}]

set_property PACKAGE_PIN L19 [get_ports {ddr3_dm[0]}]
set_property PACKAGE_PIN L15 [get_ports {ddr3_dm[1]}]
set_property PACKAGE_PIN D20 [get_ports {ddr3_dm[2]}]
set_property PACKAGE_PIN B20 [get_ports {ddr3_dm[3]}]
set_property SLEW FAST [get_ports {ddr3_dm[*]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[*]}]

set_property PACKAGE_PIN N22 [get_ports {ddr3_dqs_p[0]}]
set_property PACKAGE_PIN M22 [get_ports {ddr3_dqs_n[0]}]
set_property PACKAGE_PIN K17 [get_ports {ddr3_dqs_p[1]}]
set_property PACKAGE_PIN J17 [get_ports {ddr3_dqs_n[1]}]
set_property PACKAGE_PIN B21 [get_ports {ddr3_dqs_p[2]}]
set_property PACKAGE_PIN A21 [get_ports {ddr3_dqs_n[2]}]
set_property PACKAGE_PIN F18 [get_ports {ddr3_dqs_p[3]}]
set_property PACKAGE_PIN E18 [get_ports {ddr3_dqs_n[3]}]
set_property SLEW FAST [get_ports ddr3_dqs*]
set_property IOSTANDARD DIFF_SSTL15 [get_ports ddr3_dqs*]

set_property PACKAGE_PIN J14 [get_ports {ddr3_ck_p[0]}]
set_property PACKAGE_PIN H14 [get_ports {ddr3_ck_n[0]}]
set_property SLEW FAST [get_ports ddr3_ck*]
set_property IOSTANDARD DIFF_SSTL15 [get_ports ddr3_ck_*]

#STUFF I ADDED TO ALLOW DDR3 PINS TO SYNTHESIZE/IMPLEMENT WITH NO ERRORS
#- should probably be included by the DDR3 controller module
#set_property IO_BUFFER_TYPE NONE [get_ports {ddr3_ck_n[*]} ]
#set_property IO_BUFFER_TYPE NONE [get_ports {ddr3_ck_p[*]} ]

set_property INTERNAL_VREF 0.75 [get_iobanks 15]
set_property INTERNAL_VREF 0.75 [get_iobanks 16]

# TODO - Extended MCB performance mode?
# TODO - Timing Ignore constraints for paths crossing the clock domain?
# TODO - Clock constraints?

#############################################################################
### Intan Technologies RHD2000 Application-Specific Interface pins
#############################################################################

## Note: Setting "DIFF_TERM = TRUE" enables an on-FPGA 100-Ohm LVDS termination
## resistor, so no off-chip resistors are required for the MISO inputs.

## SPI buses
# 6310 FPGA PIN NAME        6310 CONNECTOR,PIN         7310 CONNECTOR,PIN           7310 FPGA PIN NAME          RHYTHM ROLE         NOTES
#       G19                         JP2,16                      MC2,16                      P6                  CS_b_A
#       F20                         JP2,18                      MC2,18                      N5                  SCLK_A
#       H20                         JP2,20                      MC2,20                      P2                  MOSI1_A
#       J19                         JP2,22                      MC2,22                      N2                  MOSI2_A
#       D19                         JP2,24                      MC2,24                      R1                  MISO1_A             PULLDOWN
#       D20                         JP2,26                      MC2,26                      P1                  MISO2_A             PULLDOWN

set_property -dict {PACKAGE_PIN P6 IOSTANDARD LVCMOS33} [get_ports CS_b_A]
set_property -dict {PACKAGE_PIN N5 IOSTANDARD LVCMOS33} [get_ports SCLK_A]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports MOSI1_A]
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports MOSI2_A]
set_property PACKAGE_PIN R1 [get_ports MISO1_A]
set_property IOSTANDARD LVCMOS33 [get_ports MISO1_A]
set_property PULLDOWN true [get_ports MISO1_A]
set_property PACKAGE_PIN P1 [get_ports MISO2_A]
set_property IOSTANDARD LVCMOS33 [get_ports MISO2_A]
set_property PULLDOWN true [get_ports MISO2_A]


#       F18                         JP2,28                      MC2,28                      M3                  CS_b_B
#       F19                         JP2,30                      MC2,30                      M2                  SCLK_B
#       M16                         JP2,32                      MC2,32                      K6                  MOSI1_B
#       L15                         JP2,34                      MC2,34                      J6                  MOSI2_B
#       K20                         JP2,38                      MC2,38                      L3                  MISO1_B             PULLDOWN
#       K19                         JP2,40                      MC2,40                      K3                  MISO2_B             PULLDOWN

set_property -dict {PACKAGE_PIN M3 IOSTANDARD LVCMOS33} [get_ports CS_b_B]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports SCLK_B]
set_property -dict {PACKAGE_PIN K6 IOSTANDARD LVCMOS33} [get_ports MOSI1_B]
set_property -dict {PACKAGE_PIN J6 IOSTANDARD LVCMOS33} [get_ports MOSI2_B]
set_property PACKAGE_PIN L3 [get_ports MISO1_B]
set_property IOSTANDARD LVCMOS33 [get_ports MISO1_B]
set_property PULLDOWN true [get_ports MISO1_B]
set_property PACKAGE_PIN K3 [get_ports MISO2_B]
set_property IOSTANDARD LVCMOS33 [get_ports MISO2_B]
set_property PULLDOWN true [get_ports MISO2_B]

#       U20                         JP2,42                      MC2,42                      J5                  CS_b_C
#       U22                         JP2,44                      MC2,44                      H5                  SCLK_C
#       R20                         JP2,46                      MC2,46                      H2                  MOSI1_C
#       R22                         JP2,48                      MC2,48                      G2                  MOSI2_C
#       N20                         JP2,50                      MC2,50                      G1                  MISO1_C             PULLDOWN
#       N22                         JP2,52                      MC2,52                      F1                  MISO2_C             PULLDOWN

set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports CS_b_C]
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports SCLK_C]
set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports MOSI1_C]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports MOSI2_C]
set_property PACKAGE_PIN G1 [get_ports MISO1_C]
set_property IOSTANDARD LVCMOS33 [get_ports MISO1_C]
set_property PULLDOWN true [get_ports MISO1_C]
set_property PACKAGE_PIN F1 [get_ports MISO2_C]
set_property IOSTANDARD LVCMOS33 [get_ports MISO2_C]
set_property PULLDOWN true [get_ports MISO2_C]


#       M20                         JP2,54                      MC2,54                      E1                  CS_b_D
#       L19                         JP2,58                      MC2,58                      D1                  SCLK_D
#       K21                         JP2,60                      MC2,60                      C2                  MOSI1_D
#       K22                         JP2,62                      MC2,62                      B2                  MOSI2_D
#       G20                         JP2,64                      MC2,64                      U15                 MISO1_D             PULLDOWN
#       G22                         JP2,66                      MC2,66                      V15                 MISO2_D             PULLDOWN

set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports CS_b_D]
set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS33} [get_ports SCLK_D]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports MOSI1_D]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports MOSI2_D]
set_property PACKAGE_PIN U15 [get_ports MISO1_D]
set_property IOSTANDARD LVCMOS33 [get_ports MISO1_D]
set_property PULLDOWN true [get_ports MISO1_D]
set_property PACKAGE_PIN V15 [get_ports MISO2_D]
set_property IOSTANDARD LVCMOS33 [get_ports MISO2_D]
set_property PULLDOWN true [get_ports MISO2_D]

#       E20                         JP2,68                      MC2,68                      T14                 CS_b_E
#       E22                         JP2,70                      MC2,70                      T15                 SCLK_E
#       C20                         JP2,72                      MC2,72                      W14                 MOSI1_E
#       C22                         JP2,74                      MC2,74                      Y14                 MOSI2_E
#       A20                         JP2,76                      MC2,76                      Y12                 MISO1_E             PULLDOWN
#       J22                         JP2,79                      MC2,79                      G4                  MISO2_E             PULLDOWN

set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports CS_b_E]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports SCLK_E]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports MOSI1_E]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports MOSI2_E]
set_property PACKAGE_PIN Y12 [get_ports MISO1_E]
set_property IOSTANDARD LVCMOS33 [get_ports MISO1_E]
set_property PULLDOWN true [get_ports MISO1_E]
set_property PACKAGE_PIN G4 [get_ports MISO2_E]
set_property IOSTANDARD LVCMOS33 [get_ports MISO2_E]
set_property PULLDOWN true [get_ports MISO2_E]

#       J20                         JP2,77                      MC2,77                      H4                  CS_b_F
#       A21                         JP2,75                      MC2,75                      Y11                 SCLK_F
#       B22                         JP2,73                      MC2,73                      V14                 MOSI1_F
#       B21                         JP2,71                      MC2,71                      V13                 MOSI2_F
#       D22                         JP2,69                      MC2,69                      U16                 MISO1_F             PULLDOWN
#       D21                         JP2,67                      MC2,67                      T16                 MISO2_F             PULLDOWN

set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports CS_b_F]
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS33} [get_ports SCLK_F]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports MOSI1_F]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports MOSI2_F]
set_property PACKAGE_PIN U16 [get_ports MISO1_F]
set_property IOSTANDARD LVCMOS33 [get_ports MISO1_F]
set_property PULLDOWN true [get_ports MISO1_F]
set_property PACKAGE_PIN T16 [get_ports MISO2_F]
set_property IOSTANDARD LVCMOS33 [get_ports MISO2_F]
set_property PULLDOWN true [get_ports MISO2_F]

#       F22                         JP2,65                      MC2,65                      J4                  CS_b_G
#       F21                         JP2,63                      MC2,63                      K4                  SCLK_G
#       H22                         JP2,61                      MC2,61                      A1                  MOSI1_G
#       H21                         JP2,59                      MC2,59                      B1                  MOSI2_G
#       L22                         JP2,57                      MC2,57                      E3                  MISO1_G             PULLDOWN
#       L20                         JP2,53                      MC2,53                      F3                  MISO2_G             PULLDOWN

set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports CS_b_G]
set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVCMOS33} [get_ports SCLK_G]
set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports MOSI1_G]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports MOSI2_G]
set_property PACKAGE_PIN E3 [get_ports MISO1_G]
set_property IOSTANDARD LVCMOS33 [get_ports MISO1_G]
set_property PULLDOWN true [get_ports MISO1_G]
set_property PACKAGE_PIN F3 [get_ports MISO2_G]
set_property IOSTANDARD LVCMOS33 [get_ports MISO2_G]
set_property PULLDOWN true [get_ports MISO2_G]

#       M22                         JP2,51                      MC2,51                      D2                  CS_b_H
#       M21                         JP2,49                      MC2,49                      E2                  SCLK_H
#       P22                         JP2,47                      MC2,47                      G3                  MOSI1_H
#       P21                         JP2,45                      MC2,45                      H3                  MOSI2_H
#       T22                         JP2,43                      MC2,43                      J1                  MISO1_H             PULLDOWN
#       T21                         JP2,41                      MC2,41                      K1                  MISO2_H             PULLDOWN

set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports CS_b_H]
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports SCLK_H]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports MOSI1_H]
set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33} [get_ports MOSI2_H]
set_property PACKAGE_PIN J1 [get_ports MISO1_H]
set_property IOSTANDARD LVCMOS33 [get_ports MISO1_H]
set_property PULLDOWN true [get_ports MISO1_H]
set_property PACKAGE_PIN K1 [get_ports MISO2_H]
set_property IOSTANDARD LVCMOS33 [get_ports MISO2_H]
set_property PULLDOWN true [get_ports MISO2_H]

## SPI LED indicators

# 6310 FPGA PIN NAME        6310 CONNECTOR,PIN         7310 CONNECTOR,PIN           7310 FPGA PIN NAME          RHYTHM ROLE         NOTES
#       V22                         JP2,39                      MC2,39                      J2                  SPI_port_LEDS[0]
#       V21                         JP2,37                      MC2,37                      K2                  SPI_port_LEDS[1]
#       J16                         JP2,33                      MC2,33                      L1                  SPI_port_LEDS[2]
#       K16                         JP2,31                      MC2,31                      M1                  SPI_port_LEDS[3]
#       K17                         JP2,29                      MC2,29                      M5                  SPI_port_LEDS[4]
#       J17                         JP2,27                      MC2,27                      M6                  SPI_port_LEDS[5]
#       F17                         JP2,25                      MC2,25                      L4                  SPI_port_LEDS[6]
#       F16                         JP2,23                      MC2,23                      L5                  SPI_port_LEDS[7]

set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {SPI_port_LEDs[0]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {SPI_port_LEDs[1]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {SPI_port_LEDs[2]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {SPI_port_LEDs[3]}]
set_property -dict {PACKAGE_PIN M5 IOSTANDARD LVCMOS33} [get_ports {SPI_port_LEDs[4]}]
set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVCMOS33} [get_ports {SPI_port_LEDs[5]}]
set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS33} [get_ports {SPI_port_LEDs[6]}]
set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS33} [get_ports {SPI_port_LEDs[7]}]

## TTL inputs

# 6310 FPGA PIN NAME        6310 CONNECTOR,PIN         7310 CONNECTOR,PIN           7310 FPGA PIN NAME          RHYTHM ROLE         NOTES
#       B18                         JP1,76                      MC1,76                      AA16                TTL_in_direct_1
#       A16                         JP1,74                      MC1,74                      W16                 TTL_in_direct_2
#       H19                         JP2,19                      MC2,19                      N4                  serial_LOAD
#       H18                         JP2,21                      MC2,21                      N3                  serial_CLK
#       A13                         JP1,65                      MC1,65                      AB1                 TTL_in_serial
#       C13                         JP1,63                      MC1,63                      AA1                 TTL_in_serial_exp
#       A3                          JP1,49                      MC1,49                      U2                  spare_1             Dont use
#       A15                         JP1,69                      MC1,69                      AB17                expander_detect
#       C15                         JP1,67                      MC1,67                      AB16                expander_ID_1

set_property -dict {PACKAGE_PIN AA16 IOSTANDARD LVCMOS33} [get_ports TTL_in_direct_1]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports TTL_in_direct_2]

set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports serial_LOAD]
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports serial_CLK]

set_property -dict {PACKAGE_PIN AB1 IOSTANDARD LVCMOS33} [get_ports TTL_in_serial]
set_property -dict {PACKAGE_PIN AA1 IOSTANDARD LVCMOS33} [get_ports TTL_in_serial_exp]

# Don't use this pin; it is tied to FPGA HSWAP function.
# If it is held low at powerup the Opal Kelly SDRAM won't work.
# set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {spare_1}]

set_property -dict {PACKAGE_PIN AB17 IOSTANDARD LVCMOS33} [get_ports expander_detect]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD LVCMOS33} [get_ports expander_ID_1]

## TTL outputs

# 6310 FPGA PIN NAME        6310 CONNECTOR,PIN         7310 CONNECTOR,PIN           7310 FPGA PIN NAME          RHYTHM ROLE         NOTES
#       T20                         JP1,18                      MC1,18                      V8                  TTL_out_direct[0]
#       P17                         JP1,20                      MC1,20                      V7                  TTL_out_direct[1]
#       N16                         JP1,22                      MC2,22                      W7                  TTL_out_direct[2]
#       M17                         JP1,24                      MC2,24                      Y8                  TTL_out_direct[3]
#       M18                         JP1,26                      MC1,26                      Y7                  TTL_out_direct[4]
#       P18                         JP1,28                      MC1,28                      W6                  TTL_out_direct[5]
#       R19                         JP1,30                      MC1,30                      W5                  TTL_out_direct[6]
#       D11                         JP1,42                      MC1,42                      Y6                  TTL_out_direct[7]
#       C12                         JP1,44                      MC1,44                      AA6                 TTL_out_direct[8]
#       D15                         JP1,46                      MC1,46                      AA8                 TTL_out_direct[9]
#       C16                         JP1,48                      MC1,48                      AB8                 TTL_out_direct[10]
#       B6                          JP1,50                      MC1,50                      U3                  TTL_out_direct[11]
#       A6                          JP1,52                      MC1,52                      V3                  TTL_out_direct[12]
#       C7                          JP1,54                      MC1,54                      W1                  TTL_out_direct[13]
#       A7                          JP1,58                      MC1,58                      Y1                  TTL_out_direct[14]
#       C9                          JP1,60                      MC1,60                      AB3                 TTL_out_direct[15]

set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[0]}]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[1]}]
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[2]}]
set_property -dict {PACKAGE_PIN Y8 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[3]}]
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[4]}]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[5]}]
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[6]}]
set_property -dict {PACKAGE_PIN Y6 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[7]}]
set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[8]}]
set_property -dict {PACKAGE_PIN AA8 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[9]}]
set_property -dict {PACKAGE_PIN AB8 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[10]}]
set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[11]}]
set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[12]}]
set_property -dict {PACKAGE_PIN W1 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[13]}]
set_property -dict {PACKAGE_PIN Y1 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[14]}]
set_property -dict {PACKAGE_PIN AB3 IOSTANDARD LVCMOS33} [get_ports {TTL_out_direct[15]}]

#       G17                         JP2,17                      MC2,17                      P4                  mark_out
#       G16                         JP2,15                      MC2,15                      P5                  sample_CLK_out

set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports mark_out]
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports sample_CLK_out]

#       A18                         JP1,75                      MC1,75                      Y16                 status_LEDs[0]
#       A17                         JP1,73                      MC1,73                      AB15                status_LEDs[1]
#       C17                         JP1,71                      MC1,71                      AA15                status_LEDs[2]

set_property -dict {PACKAGE_PIN Y16 IOSTANDARD LVCMOS33} [get_ports {status_LEDs[0]}]
set_property -dict {PACKAGE_PIN AB15 IOSTANDARD LVCMOS33} [get_ports {status_LEDs[1]}]
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33} [get_ports {status_LEDs[2]}]

## DAC control

# 6310 FPGA PIN NAME        6310 CONNECTOR,PIN         7310 CONNECTOR,PIN           7310 FPGA PIN NAME          RHYTHM ROLE         NOTES
#       U19                         JP1,19                      MC1,19                      R6                  DAC_SYNC
#       W22                         JP1,17                      MC1,17                      Y9                  DAC_SCLK
#       A8                          JP1,57                      MC1,57                      Y2                  DAC_DIN_1
#       B8                          JP1,53                      MC1,53                      W2                  DAC_DIN_2
#       A4                          JP1,51                      MC1,51                      V2                  DAC_DIN_3
#       D8                          JP1,39                      MC1,39                      AB6                 DAC_DIN_4
#       D7                          JP1,37                      MC1,37                      AB7                 DAC_DIN_5
#       C14                         JP1,29                      MC1,29                      U5                  DAC_DIN_6
#       D14                         JP1,27                      MC1,27                      T5                  DAC_DIN_7
#       V20                         JP1,21                      MC1,21                      T6                  DAC_DIN_8

set_property -dict {PACKAGE_PIN R6 IOSTANDARD LVCMOS33} [get_ports DAC_SYNC]
set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports DAC_SCLK]
set_property -dict {PACKAGE_PIN Y2 IOSTANDARD LVCMOS33} [get_ports DAC_DIN_1]
set_property -dict {PACKAGE_PIN W2 IOSTANDARD LVCMOS33} [get_ports DAC_DIN_2]
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports DAC_DIN_3]
set_property -dict {PACKAGE_PIN AB6 IOSTANDARD LVCMOS33} [get_ports DAC_DIN_4]
set_property -dict {PACKAGE_PIN AB7 IOSTANDARD LVCMOS33} [get_ports DAC_DIN_5]
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports DAC_DIN_6]
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports DAC_DIN_7]
set_property -dict {PACKAGE_PIN T6 IOSTANDARD LVCMOS33} [get_ports DAC_DIN_8]

## ADC control

# 6310 FPGA PIN NAME        6310 CONNECTOR,PIN         7310 CONNECTOR,PIN           7310 FPGA PIN NAME          RHYTHM ROLE         NOTES
#       W20                         JP1,15                      MC1,15                      W9                  ADC_CS
#       T19                         JP1,16                      MC1,16                      V9                  ADC_SCLK
#       A10                         JP1,61                      MC1,61                      U1                  ADC_DOUT_1
#       B10                         JP1,59                      MC1,59                      T1                  ADC_DOUT_2
#       B16                         JP1,72                      MC1,72                      W15                 ADC_DOUT_3
#       A14                         JP1,70                      MC1,70                      AB13                ADC_DOUT_4
#       B14                         JP1,68                      MC1,68                      AA13                ADC_DOUT_5
#       A12                         JP1,66                      MC1,66                      AA14                ADC_DOUT_6
#       B12                         JP1,64                      MC1,64                      Y13                 ADC_DOUT_7
#       A9                          JP1,62                      MC1,62                      AB2                 ADC_DOUT_8

set_property -dict {PACKAGE_PIN W9 IOSTANDARD LVCMOS33} [get_ports ADC_CS]
set_property -dict {PACKAGE_PIN V9 IOSTANDARD LVCMOS33} [get_ports ADC_SCLK]
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports ADC_DOUT_1]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports ADC_DOUT_2]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports ADC_DOUT_3]
set_property -dict {PACKAGE_PIN AB13 IOSTANDARD LVCMOS33} [get_ports ADC_DOUT_4]
set_property -dict {PACKAGE_PIN AA13 IOSTANDARD LVCMOS33} [get_ports ADC_DOUT_5]
set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS33} [get_ports ADC_DOUT_6]
set_property -dict {PACKAGE_PIN Y13 IOSTANDARD LVCMOS33} [get_ports ADC_DOUT_7]
set_property -dict {PACKAGE_PIN AB2 IOSTANDARD LVCMOS33} [get_ports ADC_DOUT_8]

## Configuration bits

# 6310 FPGA PIN NAME        6310 CONNECTOR,PIN         7310 CONNECTOR,PIN           7310 FPGA PIN NAME          RHYTHM ROLE         NOTES
#       D9                         JP1,32                      MC1,32                      R4                  board_mode[0]        PULLDOWN
#       C8                         JP1,34                      MC1,34                      T4                  board_mode[1]        PULLDOWN
#       D10                        JP1,38                      MC1,38                      Y4                  board_mode[2]        PULLDOWN
#       C10                        JP1,40                      MC1,40                      AA4                 board_mode[3]        PULLDOWN

set_property PACKAGE_PIN R4 [get_ports {board_mode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {board_mode[0]}]
set_property PULLDOWN true [get_ports {board_mode[0]}]
set_property PACKAGE_PIN T4 [get_ports {board_mode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {board_mode[1]}]
set_property PULLDOWN true [get_ports {board_mode[1]}]
set_property PACKAGE_PIN Y4 [get_ports {board_mode[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {board_mode[2]}]
set_property PULLDOWN true [get_ports {board_mode[2]}]
set_property PACKAGE_PIN AA4 [get_ports {board_mode[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {board_mode[3]}]
set_property PULLDOWN true [get_ports {board_mode[3]}]

set_clock_groups -asynchronous -group [get_clocks {mmcm0_clk0 okUH0}] -group [get_clocks {sys_clk clk_pll_i}]
#set_clock_groups -asynchronous -group [get_clocks {mmcm0_clk0 okUH0}] -group [get_clocks {sys_clk}] -group [get_clocks -include_generated_clocks -of_objects [get_pins SDRAM_FIFO_inst/u_ddr3_256_32_mig/u_ddr3_infrastructure/gen_mmcm.mmcm_i/CLKFBOUT]]