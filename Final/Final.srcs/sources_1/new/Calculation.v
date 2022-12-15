`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2022 11:25:49 AM
// Design Name: 
// Module Name: Calculation
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


module Calculation(
    output [15:0] calculation,
    input [15:0] value_left,
    input [2:0] op,
    input [15:0] value_right,
    input invalid
    );

    wire [14:0] A, B;
    SignMagtoTwoComp sm2c_left(
    	.signed_mag (value_left[14:0]),
        .two_comp   (A)
    );
    SignMagtoTwoComp sm2c_right(
    	.signed_mag (value_right[14:0]),
        .two_comp   (B)
    );

    wire [14:0] q;
    wire nan;
    alu alu(
    	.q       (q       ),
        .nan     (nan     ),
        .A       (A       ),
        .B       (B       ),
        .alu_ops (op[1:0] )
    );
    
    wire [14:0] calculation_0 = nan ? 10000 : q;
    
    wire [14:0] calculation_1;
    TwoComptoSignMag c2sm_cal(
    	.two_comp   (calculation_0),
        .signed_mag (calculation_1)
    );
    
    wire nan_left = value_left[15];
    wire nan_op = op[2];
    wire nan_right = value_right[15];
    wire calculation_ready = !(nan_left | nan_op | nan_right | invalid);
    assign calculation = calculation_ready ? {1'b0, calculation_1} : {1'b1, 15'b0};


endmodule
