`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 04:52:51 PM
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
    input [8:0] sw,
    input btnU,
    input btnL,
    input btnD,
    input btnR,
    input btnC,
    input clk
    );
    
    ////////////////////////////////////////
    // Clock
    wire targetClk;
    clockReducer(targetClk, clk);
    
    ////////////////////////////////////////
    // Mode
    reg [1:0] mode = 0;
    wire modeSW;
    singlePulser(modeSW, sw[8], targetClk);
    
    always @(posedge modeSW) begin
        mode <= (mode + 1)%3;     
    end
    
    
    ////////////////////////////////////////
    // Stack (Ex. 1)
    
    wire modeStack = (mode == 0);
    wire [7:0] top; 
    wire [8:0] len;
    
    Stack s(top, len, sw[7:0], btnU && modeStack, btnC && modeStack);
    
    wire [15:0] num_ex1 = {top, len};
    
    ////////////////////////////////////////
    // Seg ROM (Ex. 2)
    
    wire [15:0] num_ex2;
    assign num_ex2[15:8] = 0;
    segRom srom(num_ex2[7:0], sw[4:0]);
    
    ////////////////////////////////////////
    // cal ROM (Ex. 3)
    
    wire [15:0] num_ex3;
    reg [1:0] op;
    always @(posedge (mode == 2) && (btnU || btnL || btnD || btnR)) begin
            case({btnU, btnL, btnD, btnR})
            4'b1000: op = 0; //plus
            4'b0100: op = 1; //subtract
            4'b0010: op = 2; //multiply
            4'b0001: op = 3; //divide
        endcase
    end
    
    calRom crom(num_ex3, sw[7:4], sw[3:0], op);
    
    ////////////////////////////////////////
    // Display
    
    wire an0,an1,an2,an3;
    assign {an3,an2,an1,an0}=an;
    
    wire [3:0] num0,num1,num2,num3;
    

    
    assign {num3, num2, num1, num0} = (mode == 0) ? num_ex1 : (mode == 1) ? num_ex2 : num_ex3;
    
    quadSevenSeg q7seg(seg,dp,an0,an1,an2,an3,num0,num1,num2,num3,targetClk);
    
endmodule
