`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 10:18:57 AM
// Design Name: 
// Module Name: quadBCDCounter
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


module quadBCD(
    input [3:0] up,
    input [3:0] down,
    input set9,
    input set0,
    input clk,
    output [15:0] bcd,
    output cout,
    output bout
    );
    
    
    wire [3:0] out0;
    wire [3:0] out1;
    wire [3:0] out2;
    wire [3:0] out3;
    
    BCDCounter bcd0(up[0], down[0], set9, set0, clk, out0, cout0, bout0);
    BCDCounter bcd1(up[1], down[1], set9, set0, clk, out1, cout1, bout1);
    BCDCounter bcd2(up[2], down[2], set9, set0, clk, out2, cout2, bout2);
    BCDCounter bcd3(up[3], down[3], set9, set0, clk, out3, cout, bout);

    assign bcd = {out3, out2, out1, out0};
    
endmodule
