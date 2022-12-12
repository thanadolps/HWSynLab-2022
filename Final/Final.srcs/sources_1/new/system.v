`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2022 09:28:28 PM
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
    output [2:0] led,
    input RsRx,
    input clk
    );
        
    ////////////////////////////////////////
    // Clock
    wire targetClk;
    clockReducer #(.TARGET_FREQ(400)) (targetClk, clk);


    ////////////////////////////////////////
    // Uart
    wire [7:0] data;
    wire data_ready;
    uartInput (data, data_ready, RsRx, clk);

    ////////////////////////////////////////
    // Uart -> Action
    wire [4:0] action;
    wire action_ready;
    actionInput (action, action_ready, data, data_ready);

    ////////////////////////////////////////
    // Assign number
    wire [3:0] num3, num2, num1, num0;
    
    assign {num3, num2, num1, num0} = {action[4:0], data[7:0]};
    
    wire an0,an1,an2,an3;
    assign an = {an3,an2,an1,an0};
    
    ////////////////////////////////////////
    // Display
    quadSevenSeg q7seg(seg,dp,an0,an1,an2,an3,num0,num1,num2,num3,targetClk);
    assign led[2:0] = {1'b0, action_ready, data_ready};
    // assign led[2:0] = {overflow, underflow, nan};
    
endmodule