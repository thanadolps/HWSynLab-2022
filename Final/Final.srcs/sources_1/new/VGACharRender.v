`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2022 02:37:13 AM
// Design Name: 
// Module Name: VGADigitRender
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


module VGACharRender(
    output reg render,
    input [9:0] x,
    input [9:0] y,
    input [4:0] char // 0123456789+-*/=Na
);

    localparam M_H = 158;
    localparam M0_W = 90;
    localparam M1_W = 58;
    localparam M2_W = 87;
    localparam M3_W = 91;
    localparam M4_W = 99;
    localparam M5_W = 90;
    localparam M6_W = 92;
    localparam M7_W = 81;
    localparam M8_W = 94;
    localparam M9_W = 90;
    localparam M_add_W = 96;
    localparam M_sub_W = 62;
    localparam M_mul_W = 60;
    localparam M_div_W = 77;
    localparam M_eq_W = 76;
    localparam M_N_W = 93;
    localparam M_a_W = 79;

    reg [0:0] mask_0 [0:M_H*M0_W-1];
    reg [0:0] mask_1 [0:M_H*M1_W-1];
    reg [0:0] mask_2 [0:M_H*M2_W-1];
    reg [0:0] mask_3 [0:M_H*M3_W-1];
    reg [0:0] mask_4 [0:M_H*M4_W-1];
    reg [0:0] mask_5 [0:M_H*M5_W-1];
    reg [0:0] mask_6 [0:M_H*M6_W-1];
    reg [0:0] mask_7 [0:M_H*M7_W-1];
    reg [0:0] mask_8 [0:M_H*M8_W-1];
    reg [0:0] mask_9 [0:M_H*M9_W-1];
    reg [0:0] mask_add [0:M_H*M_add_W-1];
    reg [0:0] mask_sub [0:M_H*M_sub_W-1];
    reg [0:0] mask_mul [0:M_H*M_mul_W-1];
    reg [0:0] mask_div [0:M_H*M_div_W-1];
    reg [0:0] mask_eq [0:M_H*M_eq_W-1];
    reg [0:0] mask_N [0:M_H*M_N_W-1];
    reg [0:0] mask_a [0:M_H*M_a_W-1];

    initial begin
        $readmemb("0.mem", mask_0);
        $readmemb("1.mem", mask_1);
        $readmemb("2.mem", mask_2);
        $readmemb("3.mem", mask_3);
        $readmemb("4.mem", mask_4);
        $readmemb("5.mem", mask_5);
        $readmemb("6.mem", mask_6);
        $readmemb("7.mem", mask_7);
        $readmemb("8.mem", mask_8);
        $readmemb("9.mem", mask_9);
        $readmemb("add.mem", mask_add);
        $readmemb("sub.mem", mask_sub);
        $readmemb("mul.mem", mask_mul);
        $readmemb("div.mem", mask_div);
        $readmemb("eq.mem", mask_eq);
        $readmemb("N.mem", mask_N);
        $readmemb("a.mem", mask_a);
    end

    wire [9:0] h, w;
    VGACharSize (h, w,char);
    wire [19:0] i = w*y + x;

    always @(char, i) begin
        case (char)
            0: render = mask_0[i];
            1: render = mask_1[i];
            2: render = mask_2[i];
            3: render = mask_3[i];
            4: render = mask_4[i]; 
            5: render = mask_5[i];
            6: render = mask_6[i];
            7: render = mask_7[i];
            8: render = mask_8[i];
            9: render = mask_9[i];
            10: render = mask_add[i];
            11: render = mask_sub[i];
            12: render = mask_mul[i];
            13: render = mask_div[i];
            14: render = mask_eq[i];
            15: render = mask_N[i];
            16: render = mask_a[i];
            default: render = 0;
        endcase
    end

endmodule
