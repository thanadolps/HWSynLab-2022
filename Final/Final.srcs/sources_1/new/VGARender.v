`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2022 02:26:57 PM
// Design Name: 
// Module Name: VGARender
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


module VGARender(
    output [11:0] color,
    input [9:0] x,
    input [9:0] y,
    input [15:0] value_left,
    input [2:0] op,
    input [15:0] value_right,
    input clk
    );

    localparam WIDTH = 640;
    localparam HEIGHT = 480;
    
    wire frame, sec;
    clockReducer #(.TARGET_FREQ (60)) frame_timer(frame, clk); // 60 fps timer
    clockReducer #(.CLOCK_FREQ(60), .TARGET_FREQ (1)) second_timer(sec, frame); // 1 fps timer

    ////////////////////////////////
    // Load images

    // Background is stored in half resolution of the screen
    reg [11:0] background [0:(HEIGHT/2)*(WIDTH/2)-1];
    initial $readmemh("bg.mem", background);

    // Digits
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

    ////////////////////////////////
    // Background rendering
    wire [19:0] bg_i;
    spriteSampler bg_sampler(
        .i(bg_i), .x(x), .y(y), .w(WIDTH/2), .h(HEIGHT/2), .px(0), .py(0), .msx(5), .msy(5)
    );
    wire [11:0] bg_color = background[bg_i];


    ////////////////////////////////
    // staging
    reg [9:0] px=0, py=0;

    always @(posedge frame) begin
        px <= (px + 1)%WIDTH;
        py <= (px + 2)%HEIGHT;
    end

    reg [3:0] state = 0;
    always @(posedge sec) begin
        state <= (state + 1)%10;
    end

    reg [9:0] mw;
    always @(state) begin
        case (state)
            0: mw = M0_W;
            1: mw = M1_W;
            2: mw = M2_W;
            3: mw = M3_W;
            4: mw = M4_W; 
            5: mw = M5_W;
            6: mw = M6_W;
            7: mw = M7_W;
            8: mw = M8_W;
            9: mw = M9_W;
            default: mw = M0_W;
        endcase
    end

    ////////////////////////////////
    // Text rendering

    wire [19:0] digit1_i;
    spriteSampler digit1_sampler(
        .i(digit1_i), .x(x), .y(y), .w(mw), .h(M_H), .px(WIDTH/4), .py(HEIGHT/2), .msx(20), .msy(20)
    );
    
    wire [19:0] digit2_i;
    spriteSampler digit2_sampler(
        .i(digit2_i), .x(x), .y(y), .w(mw), .h(M_H), .px(3*WIDTH/4), .py(HEIGHT/2), .msx(20), .msy(20)
    );

    wire [19:0] digit_i = digit1_i ? digit1_i : digit2_i;
    
    
    reg digit_mask;
    always @(state, digit_i) begin
        case (state)
            0: digit_mask = mask_0[digit_i];
            1: digit_mask = mask_1[digit_i];
            2: digit_mask = mask_2[digit_i];
            3: digit_mask = mask_3[digit_i];
            4: digit_mask = mask_4[digit_i]; 
            5: digit_mask = mask_5[digit_i];
            6: digit_mask = mask_6[digit_i];
            7: digit_mask = mask_7[digit_i];
            8: digit_mask = mask_8[digit_i];
            9: digit_mask = mask_9[digit_i];
            default: digit_mask = 0;
        endcase
    end
    

    ////////////////////////////////
    // Combine color
    assign color = digit_mask ? 12'hFFF : bg_color;
    

endmodule
