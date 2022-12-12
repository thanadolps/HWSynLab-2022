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
    output reg [9:0] w,
    input [19:0] i,
    input [3:0] type
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
    // reg [0:0] mask_add [0:158*96-1];
    // reg [0:0] mask_sub [0:158*62-1];
    // reg [0:0] mask_mul [0:158*60-1];
    // reg [0:0] mask_div [0:158*77-1];
    // reg [0:0] mask_eq [0:158*76-1];

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
        // $readmemb("add.mem", mask_add);
        // $readmemb("sub.mem", mask_sub);
        // $readmemb("mul.mem", mask_mul);
        // $readmemb("div.mem", mask_div);
        // $readmemb("eq.mem", mask_eq);
    end

    always @(type, i) begin
        case (type)
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
            default: render = 0;
        endcase
    end

    always @(type) begin
        case (type)
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
            default: w = M0_W;
        endcase
    end

endmodule
