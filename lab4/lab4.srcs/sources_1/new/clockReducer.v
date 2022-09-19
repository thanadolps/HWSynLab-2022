`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 08:35:21 PM
// Design Name: 
// Module Name: clockReducer
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


module clockReducer #(parameter N=18)(
    output targetClk,
    input clk
    );
    
    wire [N:0] tclk;
    
    assign tclk[0]=clk;
    assign targetClk=tclk[N];
    
    genvar c;
    generate for(c=0;c<N;c=c+1) begin
        clockDiv fDiv(tclk[c+1],tclk[c]);
    end endgenerate
endmodule
