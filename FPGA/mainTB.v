
`timescale 1ns / 1ps
`include "params.vh"

module mainTB//;
#(
    parameter   N_param = 32 
)
();
//     glbl glbl ();
    parameter mem_size = 4096;

    reg clk;
    reg reset;
    wire MOSI_to_sensor, MISO_from_sensor, SCLK_wire, CS_b_wire, sample_CLK_out;
    reg [63:0] Single_Instruction;
    reg [31:0] address;
    reg [31:0] storeData;
    wire [31:0] loadData_w;
    reg [15:0] data_to_send;
    reg CS, MOSI;
    //wire CS, MOSI;


main
`ifndef GATESIM
#(    .mem_size(mem_size)
      ) 
`endif
    dut (
    // dataMem #(mem_size) dut (
    .clk(clk),
    .reset(reset),
    .MOSI_to_sensor(MOSI_to_sensor),
    .MISO_from_sensor(MISO_from_sensor),
    .SCLK_wire(SCLK_wire),
    .CS_b_wire(CS_b_wire),
    .sample_CLK_out(sample_CLK_out)
    // .(),
    );


// input wire clk,
// input wire reset, 
// input wire CS,
// input wire MOSI,
// output wire MISO,
// output wire SCLK_wire,
// output reg sample_CLK_out




    always #5 clk = ~clk; // 100 MHz clock

    initial begin : init
        //logic [32*8-1:0] vcdfile;
        string vcdfile;
        int vcdlevel;
        if ($value$plusargs("VCDFILE=%s",vcdfile))
            $dumpfile(vcdfile);
        if ($value$plusargs("VCDLEVEL=%d",vcdlevel))
            $dumpvars(vcdlevel);
            end

/*
    initial begin
        // data_to_send = 16'hA5F0; // Example data to send
        clk = 0;
        reset = 1;
        // MOSI = 0;
        // CS = 1;
        repeat (1) @(posedge clk);
        reset = 0;
        repeat (200) @(posedge clk);
        $finish;
    end
*/

    initial begin
        data_to_send = 16'b01_010101_0101010_1; // Example data to send
        clk = 0; // WAS 0
        reset = 0;
        CS = 1;
        MOSI = 0;

        repeat (5) @(posedge clk);
        transmit_spi(data_to_send);
        //data_to_send = 16'h0F0F; // Example data to send
        transmit_spi(data_to_send);
        //data_to_send = 16'h0F0F; // Example data to send
        transmit_spi(data_to_send);
        //data_to_send = 16'h0F0F; // Example data to send
        transmit_spi(data_to_send);
        //data_to_send = 16'h0F0F; // Example data to send
        transmit_spi(data_to_send);
        //data_to_send = 16'h0F0F; // Example data to send
        transmit_spi(data_to_send);
        //data_to_send = 16'h0F0F; // Example data to send
        transmit_spi(data_to_send);
        //repeat (1) @(posedge clk);

        // repeat (1) @(posedge clk);


        //repeat (1) @(posedge clk);

        // repeat (1) @(posedge clk);

        // transmit_spi(data_to_send, clk, CS, MOSI);
        repeat (150) @(posedge clk);
        $finish;
    end

    task transmit_spi(input [15:0] data_in);
        integer i;
        repeat (2) @(posedge clk);
        begin
            // Assert CS low to begin transmission
            CS = 0;

            for (i = 14; i >=0; i = i - 1) begin // USED TO BE 15
                MOSI = data_in[i];
                @(posedge clk);
            end
            repeat (1) @(posedge clk);
            // Deassert CS to end transmission
            CS = 1;
        repeat (2) @(posedge clk);

        end
    endtask




    // task transmit_spi(input [15:0] data_in);
    //     integer i;
    //     begin
    //         // Assert CS low to begin transmission
    //         CS = 0;

    //         for (i = 15; i >=0; i = i - 1) begin
    //             MOSI = data_in[i];
    //             @(posedge clk);
    //         end

    //         // Deassert CS to end transmission
    //         CS = 1;
    //     end
    // endtask

endmodule


