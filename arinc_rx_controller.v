module arinc_rx_controller (
    input  wire clk,
    input  wire rst,
    input  wire rx_bit_valid,
    output reg  rx_shift_en,
    output reg  rx_word_done
);

reg [5:0] bit_count;
reg rx_bit_valid_d;
reg pending_done;

always @(posedge clk) begin
    if (rst) begin
        bit_count     <= 0;
        rx_bit_valid_d <= 0;
        rx_shift_en   <= 0;
        rx_word_done  <= 0;
        pending_done  <= 0;
    end
    else begin
        rx_bit_valid_d <= rx_bit_valid;
                rx_shift_en    <= 0;
        rx_word_done   <= pending_done;
        pending_done   <= 0;

        if (rx_bit_valid && !rx_bit_valid_d) begin
            rx_shift_en <= 1;

            if (bit_count == 31) begin
                bit_count    <= 0;
                pending_done <= 1;
            end
            else begin
                bit_count <= bit_count + 1;
            end
        end
    end
end

endmodule