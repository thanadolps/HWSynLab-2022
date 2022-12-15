`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 10:59:37 AM
// Design Name: 
// Module Name: testExpressionStack
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


module testExpressionStack(

    );
    reg [4:0] action=0;
    reg clk=0;
    reg [15:0] calculation=1234;

    wire [15:0] value_left, value_right;
    wire [2:0] op;
    wire invalid;

    // unpacking
    wire null_left = value_left[15];
    wire sign_left = value_left[14];
    wire [13:0] mag_left = value_left[13:0];

    wire null_right = value_right[15];
    wire sign_right = value_right[14];
    wire [13:0] mag_right = value_right[13:0];

    ExpressionStack expr(
    	.value_left  (value_left  ),
        .op          (op          ),
        .value_right (value_right ),
        .invalid     (invalid     ),
        .action      (action      ),
        .calculation (calculation ),
        .clk         (clk)
    );

    initial begin
        #5
        action = 5'b10001; // sub
        clk = 0; #1;
        clk = 1;
        #5
        action = {1'b0, 4'd5};
        clk = 0; #1;
        clk = 1;
        #5
        action = {1'b0, 4'd7};
        clk = 0; #1;
        clk = 1;
        #5
        action = {1'b0, 4'd3};
        clk = 0; #1;
        clk = 1;
        #5
        action = {1'b0, 4'd9};
        clk = 0; #1;
        clk = 1;
        #5
        action = 5'b10001; // sub
        clk = 0; #1;
        clk = 1;
        #5
        action = 5'b10001; // sub
        clk = 0; #1;
        clk = 1;
        #5
        action = {1'b0, 4'd2};
        clk = 0; #1;
        clk = 1;
        #5
        action = {1'b0, 4'd7};
        clk = 0; #1;
        clk = 1;
        #5
        action = {1'b0, 4'd0};
        clk = 0; #1;
        clk = 1;
        #5
        action = {1'b0, 4'd8};
        clk = 0; #1;
        clk = 1;
        #5
        action = 5'b10101; // submit
        clk = 0; #1;
        clk = 1;
    end

endmodule
