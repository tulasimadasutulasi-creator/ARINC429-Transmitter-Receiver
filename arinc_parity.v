`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 11:56:52
// Design Name: 
// Module Name: arinc_parity
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


module arinc_parity (
    input  [30:0] data_in,
    output [31:0] word_out,
    output        parity_bit
);

assign parity_bit = ~(^data_in);

assign word_out = {parity_bit, data_in};

endmodule

