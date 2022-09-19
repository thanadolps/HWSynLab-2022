`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 05:11:23 PM
// Design Name: 
// Module Name: stack
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


// Write your modules here!
module Stack(
  output [7:0] top,
  output reg [8:0] len,
  input [7:0] value,
  input push,
  input pop
);
  localparam CAP = 256;

  (* synthesis , ram="block" *)
  reg [7:0] mem [CAP-1:0];
 
  assign top = mem[len-1];
  
  initial begin
  	len = 0;
  end
  
  wire do_push = push && len < CAP;
  wire do_pop = pop && len != 0;
  
  always @(posedge (push | pop)) begin
    if(do_push) begin
        mem[len] <= value;
    end
    
    len <= len + do_push - do_pop;
  end
endmodule
