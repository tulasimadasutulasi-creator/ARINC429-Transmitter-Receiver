`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 20:50:00
// Design Name: 
// Module Name: tb_arinc_rx_shift
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

module tb_arinc_rx_shift;

    reg clk;
    reg rst;
    reg shift_en;
    reg serial_in;

    wire [31:0] parallel_out;

    reg [31:0] test_word;
    integer i;

    // Instantiate receiver shift register
    arinc_rx_shift uut (
        .clk(clk),
        .rst(rst),
        .shift_en(shift_en),
        .serial_in(serial_in),
        .parallel_out(parallel_out)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;
        shift_en = 0;
        serial_in = 0;
        test_word = 32'hA5A5_3CC3;

        // Apply reset
        #10;
        rst = 0;

        // Send 32 serial bits
        shift_en = 1;

        for (i = 0; i < 32; i = i + 1) begin
            @(negedge clk);
            serial_in = test_word[i];
            @(posedge clk);
        end

        #1;
        shift_en = 0;

        $display("Expected Word = %h", test_word);
        $display("Received Word = %h", parallel_out);

        if (parallel_out == test_word)
            $display("PASS: Receiver shift register working");
        else
            $display("FAIL: Data mismatch");

        #10;
        $finish;

    end

endmodule

