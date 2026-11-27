`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 13:07:28
// Design Name: 
// Module Name: arnic_tx_timing
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



module arinc_tx_timing #(
    parameter CLK_PER_BIT = 10
)(
    input  wire clk,
    input  wire rst,
    output reg  half_bit_tick,
    output reg  bit_tick
);

reg [15:0] count;

always @(posedge clk) begin
    if (rst) begin
        count         <= 0;
        half_bit_tick <= 0;
        bit_tick      <= 0;
    end
    else begin
        half_bit_tick <= 0;
        bit_tick      <= 0;

        if (count == CLK_PER_BIT - 1) begin
            count         <= 0;
            half_bit_tick <= 1;
            bit_tick      <= 1;
        end
        else begin
            count <= count + 1;

            if (count == (CLK_PER_BIT/2 - 1))
                half_bit_tick <= 1;
        end
    end
end

endmodule
