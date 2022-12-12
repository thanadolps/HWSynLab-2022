`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2022 01:21:14 AM
// Design Name: 
// Module Name: uartInput
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


module uartInput #(
    parameter CLOCK_FREQ = 100000000,
    parameter BAUD_RATE = 9600
)(
    output reg [7:0] data,
    output reg data_ready,
    input in,
    input clk  // 16x baud rate
);
    wire baud16_clk;
    clockReducer #(.CLOCK_FREQ(CLOCK_FREQ), .TARGET_FREQ(BAUD_RATE*16)) baud_16x_sampler(baud16_clk, clk);

    reg receiving;
    reg prev_bit;
    reg [7:0] tick;

    initial begin
        data = 8'b0;
        data_ready = 0;
        receiving = 0;
    end

    always @(posedge baud16_clk) begin
        if (~receiving & prev_bit & ~in) begin
            receiving <= 1;
            data_ready <= 0;
            tick <= 0;
        end

        prev_bit <= in;
        tick <= (receiving) ? tick+1 : 0;

        case (tick)
            8'd24:  data[0] <= in;
            8'd40:  data[1] <= in;
            8'd56:  data[2] <= in;
            8'd72:  data[3] <= in;
            8'd88:  data[4] <= in;
            8'd104: data[5] <= in;
            8'd120: data[6] <= in;
            8'd136: data[7] <= in;
            8'd152: begin data_ready <= 1; receiving <= 0; end
        endcase
    end

endmodule
