`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2021 09:53:11 PM
// Design Name: 
// Module Name: alu
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


module alu(
	output signed [14:0] q,
    output nan,
	input signed [14:0] A,
	input signed [14:0] B,
	input [1:0] alu_ops
	);
    
    wire divison_err = (alu_ops == 2'b11) & (B == 0);

    // extend the bits, to avoid overflow
    wire signed [31:0] Ai = {{17{A[14]}}, A};
    wire signed [31:0] Bi = {{17{B[14]}}, B};
    reg signed [31:0] qi;
    assign q = qi;

    always @(A or B or alu_ops) begin
        case (alu_ops)
            2'b00: qi = Ai+Bi;
            2'b01: qi = Ai-Bi;
            2'b10: qi = Ai*Bi;
            2'b11: qi = divison_err ? 0 : Ai/Bi;
        endcase
    end

    wire A_exceed = (A > 9999) | (A < -9999);
    wire B_exceed = (B > 9999) | (B < -9999);
    wire q_exceed = (qi > 9999) | (qi < -9999);
    wire exceed = A_exceed | B_exceed | q_exceed;

    assign nan = exceed | divison_err;

endmodule