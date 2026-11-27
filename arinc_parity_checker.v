`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 21:42:04
// Design Name: 
// Module Name: arinc_parity_checker
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



module arinc_parity_checker (
    input  wire [31:0] received_word,
    output wire        parity_ok,
    output wire        parity_error
);

assign parity_ok    = ^received_word;
assign parity_error = ~parity_ok;

endmodule
