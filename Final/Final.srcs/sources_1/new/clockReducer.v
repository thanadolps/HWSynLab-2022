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

module clockReducer #(
    parameter CLOCK_FREQ = 100000000,
    parameter TARGET_FREQ = 9600
)(
    output reg targetClk,
    input clk  
);
    parameter CNT_COUNT = CLOCK_FREQ / (2*TARGET_FREQ);
    parameter CNT_WIDTH = $clog2(CNT_COUNT);
    
    reg [CNT_WIDTH-1:0] counter;
    
    initial begin
        counter = 0;
    end

    always @(posedge clk) begin
        if (counter == CNT_COUNT-1) begin
            counter <= 0;
            targetClk <= ~targetClk;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
