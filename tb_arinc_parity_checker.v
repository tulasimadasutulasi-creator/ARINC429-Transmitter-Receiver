`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 21:47:31
// Design Name: 
// Module Name: tb_arinc_parity_checker
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

module tb_arinc_parity_checker;

reg [31:0] received_word;
wire parity_ok;
wire parity_error;

arinc_parity_checker uut (
    .received_word(received_word),
    .parity_ok(parity_ok),
    .parity_error(parity_error)
);

initial begin
    $monitor("Time=%0t Word=%h Parity_OK=%b Parity_Error=%b",
              $time, received_word, parity_ok, parity_error);

    received_word = 32'h00000001; #10;
    received_word = 32'h00000003; #10;
    received_word = 32'h7FFFFFFF; #10;
    received_word = 32'hFFFFFFFF; #10;

    $finish;
end

endmodule

