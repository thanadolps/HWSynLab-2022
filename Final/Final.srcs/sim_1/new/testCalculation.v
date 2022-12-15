`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2022 01:11:45 PM
// Design Name: 
// Module Name: testCalculation
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


module testCalculation;
  reg [15:0] value_left;
  reg [2:0] op;
  reg [15:0] value_right;
  reg invalid;
  wire [15:0] calculation;
  reg [15:0] expect_calculation;

  Calculation DUT (
    .calculation(calculation),
    .value_left(value_left),
    .op(op),
    .value_right(value_right),
    .invalid(invalid)
  );

  wire [14:0] A = DUT.A;
  wire [14:0] B = DUT.B;
  wire [14:0] q = DUT.q;
  wire nan = DUT.nan;

  initial begin
    value_left = 0;
    op = 0;
    value_right = 0;
    invalid = 0;
    expect_calculation = 0;

    #1;

    if (calculation != expect_calculation) begin
      $error("Test case failed: got %h (null=%b, sign=%b, magnitude=%h), expected %h (null=%b, sign=%b, magnitude=%h)",
        calculation, calculation[15], calculation[14], calculation[13:0],
        expect_calculation, expect_calculation[15], expect_calculation[14], expect_calculation[13:0]
      );
    end

    value_left = 1;
    op = 1;
    value_right = 2;
    invalid = 0;
    expect_calculation = {2'b01, 14'd1};

    #1;

    if (calculation != expect_calculation) begin
      $error("Test case failed: got %h (null=%b, sign=%b, magnitude=%h), expected %h (null=%b, sign=%b, magnitude=%h)",
        calculation, calculation[15], calculation[14], calculation[13:0],
        expect_calculation, expect_calculation[15], expect_calculation[14], expect_calculation[13:0]
      );
    end

  end
endmodule

