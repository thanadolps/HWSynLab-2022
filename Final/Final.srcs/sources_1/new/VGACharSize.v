`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2022 05:34:52 PM
// Design Name: 
// Module Name: VGACharSize
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


module VGACharSize(
    output [9:0] h,
    output reg [9:0] w,
    input [4:0] char // 0123456789+-*/=Na
);

    localparam M_H = 79;
    localparam M0_W = 47;
    localparam M1_W = 30;
    localparam M2_W = 45;
    localparam M3_W = 47;
    localparam M4_W = 51;
    localparam M5_W = 46;
    localparam M6_W = 47;
    localparam M7_W = 42;
    localparam M8_W = 48;
    localparam M9_W = 47;
    localparam M_add_W = 49;
    localparam M_sub_W = 32;
    localparam M_mul_W = 32;
    localparam M_div_W = 40;
    localparam M_eq_W = 40;
    localparam M_N_W = 47;
    localparam M_a_W = 41;

    assign h = M_H;

    always @(char) begin
        case (char)
            0: w = M0_W;
            1: w = M1_W;
            2: w = M2_W;
            3: w = M3_W;
            4: w = M4_W; 
            5: w = M5_W;
            6: w = M6_W;
            7: w = M7_W;
            8: w = M8_W;
            9: w = M9_W;
            10: w = M_add_W;
            11: w = M_sub_W;
            12: w = M_mul_W;
            13: w = M_div_W;
            14: w = M_eq_W;
            15: w = M_N_W;
            16: w = M_a_W;
            default: w = 0;
        endcase
    end

endmodule
