`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2022 13:43:42
// Design Name: 
// Module Name: SignMagtoTwoComp
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


module SignedM2TwosC
	#(parameter W = 16)   // Default bit width
  (input [W-1:0] SM,    		// Signed-magnitude input
   output [W-1:0] TC    	// Two's complement output
  );	
  wire [W-1:0]temp;
  assign temp[W-2:0] = (~SM[W-2:0] + 1'b1);
  assign temp[W-1] = 1;
  assign TC = SM[0] == 1 ? temp : SM[W-1:0];

endmodule
