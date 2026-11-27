`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 12:08:04
// Design Name: 
// Module Name: tb_arinc_parity
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

module tb_arinc_parity;

reg  [30:0] data_in;
wire [31:0] word_out;
wire parity_bit;

arinc_parity uut (
    .data_in(data_in),
    .word_out(word_out),
    .parity_bit(parity_bit)
);

initial begin

    data_in = 31'b0;
    #10;

    data_in = 31'b0000000000000000000000000001010;
    #10;

    data_in = 31'b0000000000000000000000000001101;
    #10;

    data_in = 31'b1111111111111111111111111111111;
    #10;

    $finish;
end

endmodule
