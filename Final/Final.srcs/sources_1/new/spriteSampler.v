`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2022 04:23:08 PM
// Design Name: 
// Module Name: spriteSampler
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


module spriteSampler (
    output [19:0] i,
    input [9:0] x,    
    input [9:0] y,
    input [9:0] w, // sprite width
    input [9:0] h, // sprite height
    input [9:0] px,
    input [9:0] py,
    input [9:0] msx,
    input [9:0] msy
);

    wire [19:0] sample_x = msx*(x-px)/10;
    wire [19:0] sample_y = msy*(y-py)/10;

    wire out_of_bound = (sample_x > w) | (sample_y > h);
    assign i = out_of_bound ? (0) : (w*(sample_y)+(sample_x));

endmodule
