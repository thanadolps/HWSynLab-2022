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
    input [15:0] calculation,
    input clk
    );

    localparam WIDTH = 640;
    localparam HEIGHT = 480;
    
    wire frame, sec, halfsec;
    clockReducer #(.TARGET_FREQ (60)) frame_timer(frame, clk); // 60 fps timer
    // clockReducer #(.CLOCK_FREQ(60), .TARGET_FREQ (1)) sec_timer(sec, frame); // 1 fps timer
    // clockReducer #(.CLOCK_FREQ(60), .TARGET_FREQ (2)) halfsec_timer(halfsec, frame); // 2 fps timer

    ////////////////////////////////
    // Load images

    // Background is stored in half resolution of the screen
    reg [11:0] background [0:(HEIGHT/2)*(WIDTH/2)-1];
    initial $readmemh("bg.mem", background);

    ////////////////////////////////
    // Background rendering
    wire [9:0] bg_x, bg_y;
    reg [9:0] bg_offset_x=0;
    wire [9:0] ox = (x + bg_offset_x)%WIDTH;

    spriteSampler bg_sampler(
        .sample_x(bg_x), .sample_y(bg_y), .x(ox), .y(y), .w(WIDTH/2), .h(HEIGHT/2), .px(0), .py(0), .msx(5), .msy(5)
    );
    wire [11:0] bg_color = background[WIDTH*bg_y + bg_x];

    always @(posedge frame) begin
        bg_offset_x <= (bg_offset_x + 1)%WIDTH;
    end



    ////////////////////////////////
    // Make Text
    localparam N_CHAR = 11;

    wire [5*5-1:0] chars_left, chars_right;
    VGAInt2Text left_string (chars_left, value_left);
    VGAInt2Text right_string (chars_right, value_right);

    reg [4:0] char_op;
    always @(op) begin
        case (op)
            0: char_op = 10;
            1: char_op = 11;
            2: char_op = 12;
            3: char_op = 13;
            default: char_op = -1;
        endcase
    end

    wire [5*N_CHAR-1:0] chars_1 = {chars_left, char_op, chars_right};

    wire [5*5-1:0] chars_bot;
    VGAInt2Text bot_string (chars_bot, calculation);
    wire [5*N_CHAR-1:0] chars_2 = {5'd14, chars_bot, 25'b1111111111111111111111111};

    ////////////////////////////////
    // Text rendering

    wire [9:0] line1_x, line1_y;
    spriteSampler line1_sampler(
        .sample_x(line1_x), .sample_y(line1_y), .x(x), .y(y), .w(-1), .h(79), .px(0), .py(HEIGHT/2), .msx(10), .msy(10)
    );

    wire [9:0] line2_x, line2_y;
    spriteSampler line2_sampler(
        .sample_x(line2_x), .sample_y(line2_y), .x(x), .y(y), .w(-1), .h(79), .px(0), .py(HEIGHT/2+79), .msx(10), .msy(10)
    );

    wire vsel = (line1_x != 0) | (line1_y != 0);
    wire [9:0] line_x = vsel ? line1_x : line2_x;
    wire [9:0] line_y = vsel ? line1_y : line2_y;
    wire [5*N_CHAR-1:0] chars = vsel ? chars_1 : chars_2;

    wire [9:0] char_x, char_y;
    wire [4:0] char;
    VGATextFlow #(.N(N_CHAR)) text_flow(
    	.char     (char),
        .offset_x (char_x ),
        .offset_y (char_y ),
        .chars    (chars),
        .x        (line_x),
        .y        (line_y)
    );
    
    wire char_mask;
    VGACharRender char_render(char_mask, char_x, char_y, char);

    ////////////////////////////////
    // Combine color
    assign color = char_mask ? 12'hFFF : bg_color;


endmodule
