`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 20:35:23
// Design Name: 
// Module Name: arinc_bprz_decoder
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



module arinc_bprz_decoder (
    input  wire rx_a,
    input  wire rx_b,
    output wire bit_out,
    output wire bit_valid
);

    // Decode the BPRZ input
    assign bit_out = rx_a;

    // Valid data pulse when exactly one input is HIGH
    assign bit_valid = rx_a ^ rx_b;

endmodule
