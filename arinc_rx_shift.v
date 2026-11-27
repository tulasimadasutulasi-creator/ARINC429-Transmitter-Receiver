`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 20:47:34
// Design Name: 
// Module Name: arinc_rx_shift
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



module arinc_rx_shift (
    input  wire clk,
    input  wire rst,
    input  wire shift_en,
    input  wire serial_in,
    output reg  [31:0] parallel_out
);

    always @(posedge clk) begin
        if (rst) begin
            parallel_out <= 32'b0;
        end
        else if (shift_en) begin
            parallel_out <= {serial_in, parallel_out[31:1]};
        end
    end

endmodule
