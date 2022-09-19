`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 07:15:09 PM
// Design Name: 
// Module Name: calRom
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


module calRom(
    output [15:0] res,
    input [3:0] a,
    input [3:0] b,
    input [1:0] mode
    );
    
    (* synthesis, rom_block = "ROM_CELL XYZ01" *)
    reg [15:0] rom[2**10-1:0];
    initial $readmemb("rom4.mem", rom);
    assign res = rom[{mode, a, b}];
endmodule
