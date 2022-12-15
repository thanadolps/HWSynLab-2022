`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 12:00:49 PM
// Design Name: 
// Module Name: ESDigit
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


module ESDigit(
    output reg [3:0] push_num_l,
    output reg [15:0] set_num_l,
    output reg [1:0] opcode_l,
    output reg clk_l,
    output reg [3:0] push_num_r,
    output reg [15:0] set_num_r,
    output reg [1:0] opcode_r,
    output reg clk_r,
    input [15:0] value_left,
    input [2:0] op,
    input [15:0] value_right,
    input [4:0] action,
    input [15:0] calculation,
    input clk
);

    wire op_null = op[2] == 1;
    wire value_left_null = value_left[15] == 1;
    wire value_right_null = value_right[15] == 1;
    wire calculation_null = calculation[15] == 1;

    always @(posedge clk) begin
        if (op_null) begin
            opcode_l <= 0;
            push_num_l <= action[3:0];
            clk_l <= clk;
        end else begin
            opcode_r <= 0;
            push_num_r <= action[3:0];
            clk_r <= clk;
        end        
    end
endmodule
