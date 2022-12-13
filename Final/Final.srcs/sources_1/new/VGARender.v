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

    wire [4:0] char3 = (char1+1)%17;
    wire [4:0] char4 = (char2+2)%17;

    ////////////////////////////////
    // Text rendering

    wire [9:0] line_x, line_y;
    wire [9:0] ms = (char1 == 0) ? 20 : 10;
    spriteSampler digit_sampler(
        .sample_x(line_x), .sample_y(line_y), .x(x), .y(y), .w(-1), .h(HEIGHT), .px(WIDTH/6), .py(HEIGHT/2), .msx(ms), .msy(ms)
    );

    wire [9:0] char_x, char_y;
    wire [4:0] char;
    VGATextFlow #(.N(4)) text_flow(
    	.char     (char),
        .offset_x (char_x ),
        .offset_y (char_y ),
        .chars    ({char1, char2, (char3 > 5) ? char3 : 5'b11111, char4}),
        .x        (line_x),
        .y        (line_y)
    );
    
    
    wire char_mask;
    VGACharRender char_render(char_mask, char_x, char_y, char);

    ////////////////////////////////
    // Combine color
    assign color = char_mask ? 12'hFFF : bg_color;


endmodule
