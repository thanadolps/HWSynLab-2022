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


module SignMagtoTwoComp (input [14:0] signed_mag, output reg [14:0] two_comp);

  // Check the sign bit of the input
  always @(*) begin
    if (signed_mag[14] == 0) begin
      // If the sign bit is 0, the number is positive, so just copy the input to the output
      two_comp = signed_mag;
    end else begin
      // If the sign bit is 1, the number is negative, so invert all the bits and add 1 to get the two's complement representation
      two_comp = {1'b1, ~signed_mag[13:0] + 1};
    end
  end

endmodule
