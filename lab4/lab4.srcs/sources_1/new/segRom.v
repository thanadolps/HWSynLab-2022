`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 07:04:56 PM
// Design Name: 
// Module Name: segRom
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


module segRom(
    output [7:0] seg,
    input [4:0] n
    );
    
    (* synthesis, rom_block = "ROM_CELL XYZ01" *)
    reg [7:0] rom[31:0];
    initial $readmemb("rom2.mem", rom);
    
    assign seg = rom[n];
endmodule
