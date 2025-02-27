Instructions for setting up a Rhythm or RhythmStim project in Xilinx Vivado

1. Create a new project
-----------------------
After starting the Vivado software, select Create Project. Click Next.
Specify a desired project name, and a location where all the project-specific files will be. Click Next.
Make sure RTL project is clicked, and select "Do not specify sources at this time"
In the part search field, enter 'xc7a75tfgg484-1' to find the FPGA part on the XEM7310 board. Select the part and click Next.
Click Finish.

2. Add source files to project
------------------------------
Copy all Intan-provided Verilog files into the project location specified in step #1, in the same directory as the .xpr file that was just created.
This should include several .v files, for example 'ADC_input.v', 'main.v', 'SDRAM_FIFO.v', etc., as well as several Opal Kelly .v files like 'okWireIn.v'
Also, copy files 'mmcm_drp_func.h', 'xem7310.xdc', and 'xem7310_sdram.xdc' into this directory.
In Vivado's Project Manager, select 'Add Sources' -> 'Add or create design sources'. Click Add Files and add all .v and .h files you just copied. Click Finish.
Select 'Add Sources' -> 'Add or Create Constraints'. Click 'Add or create constraints' and add 'xem7310.xdc'. DO NOT add 'xem7310_sdram.xdc'. Click Finish.
Next is building the various Xilinx IP modules that are used in the Rhythm and RhythmStim designs.

3. Build 'ddr3_256_32' module
-----------------------------
The ddr3_256_32 module that interfaces between the user design and the on-board SDRAM chip is critical, but is Xilinx's IP that must be integrated into the design.
In this section, we'll describe the default settings we used for this interface in Rhythm and RhythmStim.
In Vivado's Project Manager, select IP Catalog. Search for 'mig' and double-click the Memory Interface Generator (MIG 7 Series).

Select Create Design, and enter 'ddr3_256_32' as the Component Name. Click Next.

Pin Compatible FPGAS
	Click Next.

Memory Selection
	Select DDR3 SDRAM. Click Next.

Controller Options
	Set the PHY to Controller Clock Ratio to 4:1, and then set the Clock Period to 2500 ps.
	Set the Memory Part to MT41K256M16XX-125, and set the Data Width to 32.
	Check the Data Mask box.
	Set ORDERING to Normal. Click Next.

Memory Options
	Set Input Clock Period to 5000 ps.
	Set RTT to RZQ/6 and set Controller Chip Select Pin to Disable. Click Next.

FPGA Options
	Set System Clock to No Buffer.
	Set Reference Clock to Use System Clock.
	Set System Reset Polarity to ACTIVE HIGH.
	Check Internal Vref. Click Next.

Extended FPGA Options
	Set Internal Termination Impedance to 60 Ohms. Click Next.

IO Planning Options
	Select Fixed Pin Out. Click Next.

Pin Selection
	Click Read XDC/UCF, then select 'xem7310_sdram.xdc'. You should be able to click Validate and get a success message. Click Next.

Continue clicking Next through the remaining sections until you can accept the license agreement and generate the memory interface IP.

We use the Out of context per IP Synthesis option, and Run Settings On local host with 4 jobs. Click Generate. This will take a while to finish.

4. Build 'fifo_w16_256_r32_128'
-------------------------------
In addition to the ddr3_256_32 IP module, we also need 3 IP modules for the three mini-FIFOs on the FPGA to write data into and read data out of the DDR3 interface.
This is the first, the Stage 1 FIFO which has 16-bit words written to it, and has 32-bit words read from it. The input and output are also on separate clocks.
The name refers to writing 16 bits, with a capacity of 256 16-bit words, and reading 32 bits, with a capacity of 128 32-bit words.
In Vivado's Project Manager, select IP Catalog. Search for 'fifo generator' and double-click the FIFO Generator (version 13.2 as of this document's creation).

Component Name: fifo_w16_256_r32_128

Basic
	Interface Type: Native, Independent Clocks Block RAM, 2 Synchronization Stages
	
Native Ports
	Read Mode: Standard FIFO
	Data Port Parameters: Write Width 16, Write Depth 256, Read Width 32, Read Depth 128
	ECC, Output Register and Power Gating Options: Leave everything at default (unchecked)
	Initialization: Leave everything at default
		Check Reset Pin, Check Enable Reset Synchronziation, Check Enable Safety Circuit.
		Reset Type: Asynchronous reset
		Full Flags Reset Value: 1
		Dout Reset Value: Checked, with a value of 0.
	
Status Flags
	Check Read Port Handshaking's Valid Flag, and make sure it's Active High.
	
Data Counts
	Check Write Data Count.
	
Click Generate.

5. Build 'fifo_w32_2048_r256_256'
---------------------------------
Next, we need the Stage 2 fifo that translates from 32-bit words to 256-bit words for the DDR3 interface.
The name, 'fifo_w32_2048_r256_256' refers to writing 32 bits, with a capacity of 2048 32-bit words, and reading 256 bits, with a capacity of 256 256-bit words.
Open the FIFO Generator from the IP Catalog.

Component Name: fifo_w32_2048_r256_256

Basic
	Interface Type: Native, Common Clock Block RAM
	
Native Ports
	Read Mode: Standard FIFO
	Data Port Parameters: Write Width 32, Write Depth 2048, Read Width 256, Read Depth 256
	ECC, Output Register and Power Gating Options: Leave everything at default (unchecked)
	Initialization: Leave everything at default
		Check Reset Pin
		Reset Type: Synchronous Reset
		Full Flags Reset Value: 0
		Dout Reset Value: Checked, with a value of 0.
	
Status Flags
	Check Write Port Handshaking's Write Acknowledge Flag, and make sure it's Active High.
	Check Read Port Handshaking's Valid Flag, and make sure it's Active High.
	
Data Counts
	Check Write Data Count.
	Check Read Data Count.
	
Click Generate.

6. Build 'fifo_w256_8192_r32_65536' module
------------------------------------------
Next, we need the output fifo that writes in 256-bit words from the DDR3 interface and reads out 32-bit words to the BTPipeOut.
The name, 'fifo_w256_8192_r32_65536' refers to writing 256 bits, with a capacity of 8192 256-bit words, and reading 32 bits, with a capacity of 65536 32-bit words.
Open the FIFO Generator from the IP Catalog.

Component Name: fifo_w256_8192_r32_65536

Basic
	Interface Type: Native, Independent Clocks Block RAM, 2 Synchronization Stages
	
Native Ports
	Read Mode: Standard FIFO
	Data Port Parameters: Write Width 256, Write Depth 8192, Read Width 32, Read Depth 65536
	ECC, Output Register and Power Gating Options: Leave everything at default (unchecked)
	Initialization:
		Check Reset Pin, Check Enable Reset Synchronziation, Check Enable Safety Circuit.
		Reset Type: Asynchronous reset
		Full Flags Reset Value: 0
		Dout Reset Value: Checked, with a value of 0.
	
Status Flags
	Leave everything unchecked.
	
Data Counts
	Check Write Data Count.
	Check Read Data Count.
	
Click Generate.

7. Build 'multiplier_18x18' module
----------------------------------
Finally, we need a module to multiply two 18-bit numbers.
The name, 'fifo_w256_8192_r32_65536' refers to writing 256 bits, with a capacity of 8192 256-bit words, and reading 32 bits, with a capacity of 65536 32-bit words.
Open the IP Catalog and search for 'multiplier'. Open the 'Multiplier' (not complex, version 12.0 as of this document's creation).

Component Name: multiplier_18x18

Basic
	Multiplier Type: Parallel Multiplier
	Input Options: Signed, 18-bit for both A and B.
	Multiplier Construction: Use Mults
	Optimization Options: Speed Optimized
	
Output and Control
	Leave everything unchecked.
	Pipeline Stages: 0
	
Click Generate.

8. Generate .bit file
---------------------

You should now be able to click 'Generate Bitstream' in the Project manager. This will automatically progress through Synthesis, then Implementation,
then bitstream generation. If any step fails, the bit file will not be created, and any errors in the Messages tab should be addressed before trying again.

After the bit file is generated, you can find it, from your project directory, at 'your_project_name'.runs/impl_1/main.bit.
In order to use this bit file in the RHX software, you should rename this to ConfigRHDController_7310.bit or ConfigRHSController_7310.bit, depending
on if this is the Rhythm or RhythmStim design, and move it to the directory the RHX software is running in.