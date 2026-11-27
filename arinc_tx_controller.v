
module arinc_tx_controller (
    input  wire clk,
    input  wire rst,
    input  wire tx_start,
    input  wire bit_tick,
    input  wire half_bit_tick,
    output reg  tx_load,
    output reg  tx_shift_en,
    output reg  tx_pulse_enable,
    output reg  tx_busy
);

localparam IDLE = 2'b00;
localparam SEND = 2'b01;
localparam GAP  = 2'b10;

reg [1:0] state;
reg [5:0] bit_count;
reg [2:0] gap_count;

always @(posedge clk) begin
    if (rst) begin
        state           <= IDLE;
        bit_count       <= 0;
        gap_count       <= 0;
        tx_load         <= 0;
        tx_shift_en     <= 0;
        tx_pulse_enable <= 0;
        tx_busy         <= 0;
    end
    else begin
        tx_load     <= 0;
        tx_shift_en <= 0;

        case (state)

            IDLE: begin
                tx_busy         <= 0;
                tx_pulse_enable <= 0;

                if (tx_start) begin
                    tx_load   <= 1;
                    bit_count <= 0;
                    state     <= SEND;
                    tx_busy   <= 1;
                end
            end

            SEND: begin
                tx_busy <= 1;

                if (half_bit_tick)
                    tx_pulse_enable <= 1;

                if (bit_tick) begin
                    tx_pulse_enable <= 0;
                    tx_shift_en <= 1;

                    if (bit_count == 31) begin
                        gap_count <= 0;
                        state <= GAP;
                    end
                    else begin
                        bit_count <= bit_count + 1;
                    end
                end
            end

            GAP: begin
                tx_busy <= 1;
                tx_pulse_enable <= 0;

                if (bit_tick) begin
                    if (gap_count == 3) begin
                        state <= IDLE;
                        tx_busy <= 0;
                    end
                    else begin
                        gap_count <= gap_count + 1;
                    end
                end
            end

            default: begin
                state <= IDLE;
            end

        endcase
    end
end

endmodule
