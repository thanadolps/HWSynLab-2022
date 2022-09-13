`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 09:06:04 AM
// Design Name: 
// Module Name: system
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


module system(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    input [7:0] sw,
    input btnU, // set9
    input btnC, // set0
    input clk
    );
    
    // Clock
    wire targetClk;
    wire [18:0] tclk;
    
    assign tclk[0]=clk;
    
    genvar c;
    generate for(c=0;c<18;c=c+1) begin
        clockDiv fDiv(tclk[c+1],tclk[c]);
    end endgenerate
    
    clockDiv fdivTarget(targetClk,tclk[18]);
    
    ////////////////////////////////////////
    // Synchronizer
    wire [7:0] d,d2;
    genvar n;
    generate for(n=0;n<8;n=n+1) begin
        dFlipflop dFF2(d2[n],sw[n],targetClk);
        dFlipflop dFF(d[n],d2[n],targetClk);
    end endgenerate
    
    ////////////////////////////////////////
    // Single Pulser
    wire up0,up1,up2,up3,down0,down1,down2,down3;
    singlePulser spUP3(up3,d[7],targetClk);
    singlePulser spDOWN3(down3,d[6],targetClk);
    singlePulser spUP2(up2,d[5],targetClk);
    singlePulser spDOWN2(down2,d[4],targetClk);
    singlePulser spUP1(up1,d[3],targetClk);
    singlePulser spDOWN1(down1,d[2],targetClk);
    singlePulser spUP0(up0,d[1],targetClk);
    singlePulser spDOWN0(down0,d[0],targetClk);
    
    
    // BCD array
    wire [3:0] up = {up3, up2, up1, up0};
    wire [3:0] down = {down3, down2, down1, down0};
    
    wire [15:0] num;
    quadBCD qbcd(up, down, btnU, btnC, targetClk, num, cout, bout);
    
    wire [3:0] num0, num1, num2, num3;
    assign num = {num0, num1, num2, num3};
        
    // Display
    assign an = {an3, an2, an1, an0};
    quadSevenSeg(seg, dp, an0, an1, an2, an3, num0, num1, num2, num3, targetClk);    
    
endmodule
