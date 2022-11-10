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
    output [7:0] led,
    input clk
    );
    

    
    ////////////////////////////////////////
    // Clock
    wire targetClk;
    wire [26:0] tclk;
    assign tclk[0]=clk;
    assign targetClk = tclk[26];
    
    genvar c;
    generate for(c=0;c<26;c=c+1) begin
        clockDiv fDiv(tclk[c+1],tclk[c]);
    end endgenerate

    
    ////////////////////////////////////////
    // Display
    reg [2:0] state = 0;
    reg [4:0] out = 5'b00000;
    reg tg = 0;
    assign led[4:0] = out[4:0];
    assign led[7] = tg;
    
    always @(posedge targetClk) begin
        state <= (state+1)%5;
        tg = ~tg;
    end
    
    always @(state) begin
        case(state)
            0: out = 5'b00000;
            1: out = 5'b00010;
            2: out = 5'b00110;
            3: out = 5'b01110;
            4: out = 5'b11110;
        endcase
    end
    
    
    
    
endmodule
