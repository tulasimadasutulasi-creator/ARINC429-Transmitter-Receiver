`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2026 22:20:00
// Design Name: 
// Module Name: arinc429_top
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



module arinc429_top (
    input  wire        clk,
    input  wire        rst,

    // Transmitter inputs
    input  wire        tx_start,
    input  wire [30:0] tx_data,

    // Transmitter outputs
    output wire        tx_a,
    output wire        tx_b,
    output wire        tx_busy,

    // Receiver outputs
    output wire [31:0] rx_data,
    output wire        rx_valid,
    output wire        rx_error
);

wire [31:0] tx_word;

arinc_parity parity_unit (
    .data_in(tx_data),
    .word_out(tx_word),
    .parity_bit()
);

wire half_bit_tick;
wire bit_tick;

arinc_tx_timing #(
    .CLK_PER_BIT(10)
) timing_unit (
    .clk(clk),
    .rst(rst),
    .half_bit_tick(half_bit_tick),
    .bit_tick(bit_tick)
);

// TX shift register control signals
wire tx_load;
wire tx_shift_en;
wire tx_serial_bit;

// TX shift register
arinc_tx_shift tx_shift_unit (
    .clk(clk),
    .rst(rst),
    .load(tx_load),
    .shift_en(tx_shift_en),
    .parallel_in(tx_word),
    .serial_out(tx_serial_bit)
);

// BPRZ encoder control signal
wire tx_pulse_enable;

// BPRZ encoder
arinc_bprz_encoder tx_encoder (
    .bit_in(tx_serial_bit),
    .pulse_enable(tx_pulse_enable),
    .tx_a(tx_a),
    .tx_b(tx_b)
);

 // RX decoder signals
wire rx_serial_bit;
wire rx_bit_valid;

// BPRZ decoder - internal loopback
arinc_bprz_decoder rx_decoder (
    .rx_a(tx_a),
    .rx_b(tx_b),
    .bit_out(rx_serial_bit),
    .bit_valid(rx_bit_valid)
);

// RX shift register control
wire rx_shift_en;

// RX shift register
arinc_rx_shift rx_shift_unit (
    .clk(clk),
    .rst(rst),
    .shift_en(rx_shift_en),
    .serial_in(rx_serial_bit),
    .parallel_out(rx_data)
);
// RX parity checker
wire rx_parity_ok;

arinc_parity_checker rx_parity_unit (
    .received_word(rx_data),
    .parity_ok(rx_parity_ok),
    .parity_error()
);

// TX controller
arinc_tx_controller tx_control_unit (
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .bit_tick(bit_tick),
    .half_bit_tick(half_bit_tick),
    .tx_load(tx_load),
    .tx_shift_en(tx_shift_en),
    .tx_pulse_enable(tx_pulse_enable),
    .tx_busy(tx_busy)
);

wire rx_word_done;

arinc_rx_controller rx_control_unit (
    .clk(clk),
    .rst(rst),
    .rx_bit_valid(rx_bit_valid),
    .rx_shift_en(rx_shift_en),
    .rx_word_done(rx_word_done)
);
assign rx_valid = rx_word_done & rx_parity_ok;
assign rx_error = rx_word_done & ~rx_parity_ok;


endmodule
