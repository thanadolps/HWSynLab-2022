`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 12:29:23 AM
// Design Name: 
// Module Name: VGAInt2Text
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


module VGAInt2Text(
        output [5*5-1:0] chars,
        input  [15:0] value
    );

    // unpacking
    wire null = value[15];
    wire sign = value[14];
    wire [13:0] mag = value[13:0];

    // digit extraction
    wire [3:0] thousandth = (mag / 1000) % 10;
    wire [3:0] hundredth = (mag / 100) % 10;
    wire [3:0] tenth = (mag / 10) % 10;
    wire [3:0] oneth = mag % 10;

    // determine which digit to display
    // the unit is display when it's not zero or a digit on a higer place is displayed
    // with the exception of oneth which are always display
    wire should_thousandth = thousandth > 0;
    wire should_hundredth = (hundredth > 0) | should_thousandth;
    wire should_tenth = (tenth > 0) | should_hundredth;

    wire [4:0] disp_thousandth = should_thousandth ? thousandth : -1;
    wire [4:0] disp_hundredth = should_hundredth ? hundredth : -1;
    wire [4:0] disp_tenth = should_tenth ? tenth : -1;
    wire [4:0] disp_oneth = oneth;

    // combine into output
    wire nan = mag > 9999;
    wire [5*4-1:0] uchars = null ? -1 : (nan ? 
        {5'b11111, 5'd15, 5'd16, 5'd15} : 
        {disp_thousandth, disp_hundredth, disp_tenth, disp_oneth});

    wire [4:0] disp_sign = sign ? 5'd11 : -1;
    assign chars = {disp_sign, uchars};

endmodule
