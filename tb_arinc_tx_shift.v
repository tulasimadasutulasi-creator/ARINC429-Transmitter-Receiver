`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 17:25:27
// Design Name: 
// Module Name: tb_arinc_tx_shift
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


module tb_arinc_tx_shift;

reg clk;
reg rst;
reg load;
reg shift_en;
reg [31:0] parallel_in;

wire serial_out;
integer i;

arinc_tx_shift uut (
    .clk(clk),
    .rst(rst),
    .load(load),
    .shift_en(shift_en),
    .parallel_in(parallel_in),
    .serial_out(serial_out)
);

// Generate 1 MHz clock
initial clk = 0;
always #500 clk = ~clk;

initial begin
    rst = 1;
    load = 0;
    shift_en = 0;
    parallel_in = 32'hA5A53CC3;

    // Apply reset
    repeat (2) @(negedge clk);
    rst = 0;

    // Load 32-bit data
    @(negedge clk);
    load = 1;

    @(negedge clk);
    load = 0;

    // Shift and observe all 32 bits
    for (i = 0; i < 32; i = i + 1) begin
        @(negedge clk);
        $display("Bit %0d = %b", i, serial_out);
        shift_en = 1;
    end

    @(negedge clk);
    shift_en = 0;

    $display("Shift register test completed");
    $finish;
end

endmodule

