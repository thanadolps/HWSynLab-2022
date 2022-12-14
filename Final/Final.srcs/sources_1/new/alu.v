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
	output reg signed [15:0] S,
	output z,
	input signed [15:0] A,
	input signed [15:0] B,
	input [2:0] alu_ops
	);

    assign z=~|S;
    
    always @(A or B or alu_ops) begin
        case (alu_ops)
            3'b00: S = A+B;
            3'b01: S = A-B;
            3'b10: begin S=A*B; end
            3'b11: begin S=A/B; end
        endcase
    end

endmodule