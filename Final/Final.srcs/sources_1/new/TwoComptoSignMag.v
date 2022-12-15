`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2022 10:00:19 AM
// Design Name: 
// Module Name: TwoComptoSignMag
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


module TwoComptoSignMag (input [14:0] two_comp, output reg [14:0] signed_mag);

  // Check the sign bit of the input
  always @(*) begin
    if (two_comp[14] == 0) begin
      // If the sign bit is 0, the number is positive, so just copy the input to the output
      signed_mag = two_comp;
    end else begin
      // If the sign bit is 1, the number is negative, so invert all the bits and add 1 to get the signed magnitude representation
      signed_mag = {1'b1, ~two_comp[13:0] + 1};
    end
  end

endmodule


