`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 09:29:26 AM
// Design Name: 
// Module Name: QuadDigitStack
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


module QuadDigitStack(
    output reg [15:0] value,
    input [3:0] push_num,
    input [15:0] set_num,
    input [1:0] opcode,
    input clk
    );

    initial begin
        value = {1'b1, 15'b0};
    end

    // unpacking
    wire null = value[15];
    wire sign = value[14];
    wire [13:0] mag = value[13:0];

    // digit extraction
    wire [3:0] thousandth = (mag / 1000) % 10;
    wire [3:0] hundredth = (mag / 100) % 10;
    wire [3:0] tenth = (mag / 10) % 10;
    wire [3:0] oneth = mag % 10;

    // push
    wire [16:0] new_value = value[13:0]*10 + push_num;

    always @(posedge clk) begin
        case (opcode)
            // push
            0: begin
                if (new_value <= 9999) begin
                    value[13:0] <= new_value[13:0];
                    value[15] <= 0;
                end
            end
            // pop
            1: begin
                if (null) begin
                    value[14] = 0;
                end else if((value[13:0] / 10) != 0) begin
                    value[13:0] <= value[13:0]/10;
                end else begin
                    value[13:0] <= 0;
                    value[15] <= 1; 
                end
            end
            // set
            2: value <= set_num;
            // negate
            3: value[14] <= ~sign; 
        endcase
    end

endmodule
