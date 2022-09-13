`timescale 1ns / 1ns

module singlePulser(
    input in,
    input clk,
    output reg out
    );
    reg state = 0;
    always @(posedge clk) begin
        state <= in;
        out <= in & ~state;
    end
 endmodule