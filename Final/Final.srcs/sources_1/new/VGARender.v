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
    
    ////////////////////////////////
    // Text rendering

    wire  digit_mask;
    wire [9:0] mw;
    wire [19:0] digit_i;
    VGACharRender (digit_mask, mw, digit_i, (state + (x > WIDTH/2))%10);

    wire [19:0] digit1_i;
    spriteSampler digit1_sampler(
        .i(digit1_i), .x(x), .y(y), .w(mw), .h(M_H), .px(WIDTH/4), .py(HEIGHT/2), .msx(20), .msy(20)
    );
    
    wire [19:0] digit2_i;
    spriteSampler digit2_sampler(
        .i(digit2_i), .x(x), .y(y), .w(mw), .h(M_H), .px(3*WIDTH/4), .py(HEIGHT/2), .msx(20), .msy(20)
    );

    assign digit_i = digit1_i ? digit1_i : digit2_i;
    

    ////////////////////////////////
    // Combine color
    assign color = digit_mask ? 12'hFFF : bg_color;
    

endmodule
