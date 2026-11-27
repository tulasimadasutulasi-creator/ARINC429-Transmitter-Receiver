`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 20:38:03
// Design Name: 
// Module Name: tb_arinc_bprz_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



`timescale 1ns / 1ps

module tb_arinc_bprz_decoder;

    reg rx_a;
    reg rx_b;

    wire bit_out;
    wire bit_valid;

    // Instantiate the decoder
    arinc_bprz_decoder uut (
        .rx_a(rx_a),
        .rx_b(rx_b),
        .bit_out(bit_out),
        .bit_valid(bit_valid)
    );

    initial begin

        $monitor("Time=%0t | RX_A=%b RX_B=%b | DATA=%b VALID=%b",
                 $time, rx_a, rx_b, bit_out, bit_valid);

        // Test 1: Null
        rx_a = 0; rx_b = 0;
        #10;

        // Test 2: Logic 1
        rx_a = 1; rx_b = 0;
        #10;

        // Test 3: Null
        rx_a = 0; rx_b = 0;
        #10;

        // Test 4: Logic 0
        rx_a = 0; rx_b = 1;
        #10;

        // Test 5: Invalid input
        rx_a = 1; rx_b = 1;
        #10;

        $display("BPRZ decoder test completed");
        $finish;

    end

endmodule

