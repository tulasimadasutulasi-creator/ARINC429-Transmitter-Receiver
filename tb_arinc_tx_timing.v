`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 16:16:06
// Design Name: 
// Module Name: tb_arinc_tx_timing
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

module tb_arinc_tx_timing;

reg clk;
reg rst;

wire half_bit_tick;
wire bit_tick;

arinc_tx_timing uut (
    .clk(clk),
    .rst(rst),
    .half_bit_tick(half_bit_tick),
    .bit_tick(bit_tick)
);

// 1 MHz clock: 1 microsecond period
initial clk = 0;
always #500 clk = ~clk;

initial begin
    rst = 1;

    #2000;
    rst = 0;

    #25000;
    $finish;
end

endmodule
