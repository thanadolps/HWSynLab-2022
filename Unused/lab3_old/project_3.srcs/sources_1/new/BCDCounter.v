`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2022 11:48:51 PM
// Design Name: 
// Module Name: BCDCounter
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


module BCDCounter(
    input up,
    input down,
    input set9,
    input set0,
    input clk,
    output reg [3:0] bcd,
    output reg cout,
    output reg bout
    );
    
    initial bcd = 4'b0000;
    
    always @(posedge clk) begin
        case({up, down, set0, set9})
            4'b1000: bcd <= (bcd + 1)%10;
            4'b0100: bcd <= (bcd + 9)%10;
            4'b0010: bcd <= 0;
            4'b0001: bcd <= 9;
        endcase
        
         cout <= (bcd == 9) & up;
         bout <= (bcd == 0) & down;
    end
    
endmodule
