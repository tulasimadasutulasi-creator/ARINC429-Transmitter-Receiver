`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 17:20:12
// Design Name: 
// Module Name: arinc_tx_shift
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



module arinc_tx_shift (
    input wire clk,
    input wire rst,
    input wire load,
    input wire shift_en,
    input wire [31:0] parallel_in,
    output wire serial_out
);

reg [31:0] shift_reg;

// Send the least significant bit first
assign serial_out = shift_reg[0];

always @(posedge clk) begin
    if (rst) begin
        shift_reg <= 32'b0;
    end
    else if (load) begin
        shift_reg <= parallel_in;
    end
    else if (shift_en) begin
        shift_reg <= {1'b0, shift_reg[31:1]};
    end
end

endmodule
