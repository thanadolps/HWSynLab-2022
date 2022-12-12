`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2022 12:20:26 PM
// Design Name: 
// Module Name: VGAOutput
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


module VGAOutput(
    output [11:0] rgb,
    output hsync, vsync,
    input [15:0] value_left,
    input [2:0] op,
    input [15:0] value_right,
    input [15:0] invalid,
    input clk
    );

    wire [9:0] x;
    wire [9:0] y;
    wire [11:0] color_in;

    ///////////////////////////////////////
    // Driver
    VGADriver driver(
    	.hsync (hsync ),
        .vsync (vsync ),
        .x     (x     ),
        .y     (y     ),
        .rgb   (rgb   ),
        .color_in (color_in ),
        .clk   (clk   ),
        .reset (0)
    );
    
    ///////////////////////////////////////
    // Rendering, take x and y and assign color_in (RRRRGGGGBBBB)
    VGARender render(
    	.color       (color_in       ),
        .x           (x           ),
        .y           (y           ),
        .value_left  (value_left  ),
        .op          (op          ),
        .value_right (value_right ),
        .clk         (clk         )
    );

endmodule
