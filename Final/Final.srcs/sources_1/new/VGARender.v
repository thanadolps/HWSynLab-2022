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
    localparam M_H = 158;
    
    wire frame, sec, halfsec;
    clockReducer #(.TARGET_FREQ (60)) frame_timer(frame, clk); // 60 fps timer
    clockReducer #(.CLOCK_FREQ(60), .TARGET_FREQ (1)) sec_timer(sec, frame); // 1 fps timer
    clockReducer #(.CLOCK_FREQ(60), .TARGET_FREQ (2)) halfsec_timer(halfsec, frame); // 2 fps timer

    ////////////////////////////////
    // Load images

    // Background is stored in half resolution of the screen
    reg [11:0] background [0:(HEIGHT/2)*(WIDTH/2)-1];
    initial $readmemh("bg.mem", background);

    ////////////////////////////////
    // Background rendering
    wire [19:0] bg_i;
    spriteSampler bg_sampler(
        .i(bg_i), .x(x), .y(y), .w(WIDTH/2), .h(HEIGHT/2), .px(0), .py(0), .msx(5), .msy(5)
    );
    wire [11:0] bg_color = background[bg_i];


    ////////////////////////////////
    // staging
    reg [4:0] char1 = 0;
    always @(posedge sec) begin
        char1 <= (char1 + 1)%17;
    end
    
    reg [4:0] char2 = 0;
    always @(posedge halfsec) begin
        char2 <= (char2 + 1)%17;
    end

    ////////////////////////////////
    // Text rendering

    wire [4:0] char = (x > WIDTH/2) ? char2 : char1;

    wire [9:0] mw;
    VGACharSize (mw, char);

    wire [19:0] digit1_i;
    spriteSampler digit1_sampler(
        .i(digit1_i), .x(x), .y(y), .w(mw), .h(M_H), .px(WIDTH/4), .py(HEIGHT/2), .msx(20), .msy(20)
    );
    
    wire [19:0] digit2_i;
    spriteSampler digit2_sampler(
        .i(digit2_i), .x(x), .y(y), .w(mw), .h(M_H), .px(3*WIDTH/4), .py(HEIGHT/2), .msx(20), .msy(20)
    );

    wire [19:0] digit_i = digit1_i ? digit1_i : digit2_i;
    
    wire digit_mask;
    VGACharRender (digit_mask, digit_i, char);

    ////////////////////////////////
    // Combine color
    assign color = digit_mask ? 12'hFFF : bg_color;
    

endmodule
