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
    wire [9:0] bg_x, bg_y;
    spriteSampler bg_sampler(
        .sample_x(bg_x), .sample_y(bg_y), .x(x), .y(y), .w(WIDTH/2), .h(HEIGHT/2), .px(0), .py(0), .msx(5), .msy(5)
    );
    wire [11:0] bg_color = background[WIDTH*bg_y + bg_x];

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
    wire [9:0] px = (x > WIDTH/2) ? 3*WIDTH/4 : WIDTH/4;

    wire [9:0] mw, mh;
    VGACharSize (mh, mw, char);

    wire [9:0] digit_x, digit_y;
    spriteSampler digit_sampler(
        .sample_x(digit_x), .sample_y(digit_y), .x(x), .y(y), .w(mw), .h(mh), .px(px), .py(HEIGHT/2), .msx(20), .msy(20)
    );
    
    wire digit_mask;
    VGACharRender (digit_mask, digit_x, digit_y, char);

    ////////////////////////////////
    // Combine color
    assign color = digit_mask ? 12'hFFF : bg_color;


endmodule
