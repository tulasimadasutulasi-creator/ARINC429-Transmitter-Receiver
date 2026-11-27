`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 19:28:54
// Design Name: 
// Module Name: tb_arinc_bprz_encoder
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

module tb_arinc_bprz_encoder;

    reg bit_in;
    reg pulse_enable;
    wire tx_a;
    wire tx_b;

    arinc_bprz_encoder uut (
        .bit_in(bit_in),
        .pulse_enable(pulse_enable),
        .tx_a(tx_a),
        .tx_b(tx_b)
    );

    initial begin
        bit_in = 0;
        pulse_enable = 0;

        #10;
        pulse_enable = 1;
        bit_in = 1;
        #10;

        pulse_enable = 0;
        #10;

        pulse_enable = 1;
        bit_in = 0;
        #10;

        pulse_enable = 0;
        #10;

        $display("BPRZ encoder test completed");
        $finish;
    end

endmodule

