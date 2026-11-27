`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 19:15:58
// Design Name: 
// Module Name: arinc_bprz_encoder
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


module arinc_bprz_encoder (
    input  wire bit_in,
    input  wire pulse_enable,
    output reg  tx_a,
    output reg  tx_b
);

always @(*) begin
    tx_a = 1'b0;
    tx_b = 1'b0;

    if (pulse_enable) begin
        if (bit_in == 1'b1)
            tx_a = 1'b1;
        else
            tx_b = 1'b1;
    end
end

endmodule