
`timescale 1ns / 1ps

module tb_arinc429_top;

reg clk;
reg rst;
reg tx_start;
reg [30:0] tx_data;

wire tx_a;
wire tx_b;
wire tx_busy;
wire [31:0] rx_data;
wire rx_valid;
wire rx_error;

reg [31:0] expected_word;
reg rx_valid_seen;

always @(posedge clk) begin
    if (rst)
        rx_valid_seen <= 0;
    else if (rx_valid)
        rx_valid_seen <= 1;
end

arinc429_top uut (
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx_a(tx_a),
    .tx_b(tx_b),
    .tx_busy(tx_busy),
    .rx_data(rx_data),
    .rx_valid(rx_valid),
    .rx_error(rx_error)
);

// 1 MHz clock
initial clk = 0;
always #500 clk = ~clk;

initial begin

    rst = 1;
    tx_start = 0;
    tx_data = 31'h1234567;

    expected_word = {~(^tx_data), tx_data};

    $display("ARINC 429 LOOPBACK TEST STARTED");

    // Reset
    #2000;
    rst = 0;

    // Start transmission
    @(negedge clk);
    tx_start = 1;

    @(negedge clk);
    tx_start = 0;

       // Wait for receiver result
   #500000;
    #1;
    

    $display("Expected Word = %h", expected_word);
    $display("Received Word = %h", rx_data);

   if (rx_valid_seen && rx_data == expected_word) begin
    $display("PASS: ARINC 429 LOOPBACK SUCCESS");
end
else begin
    $display("FAIL: ARINC 429 LOOPBACK ERROR");
end

    #1000;
    $finish;

end

endmodule
