`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2022 11:52:20 PM
// Design Name: 
// Module Name: tester
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

/*
module testBCD();
 reg up = 0, down = 0, set9 = 0, set0 = 0;
    reg clk = 0;
    
    wire [3:0] bcd;
    wire cout, bout;
    
    
    BCDCounter bcdCounter(up, down, set9, set0, clk, bcd, cout, bout);
    
    always #10 clk = ~clk; 
    
    
    initial begin
        # 100 up = 1;
        # 300 {up, down} = 'b01;
        # 300 {up, down, set9} = 'b001;
        # 100 {set9, set0} = 'b01;
    end
endmodule
*/

/*module testQBCD();
    reg [3:0] up = 4'b0000;
    reg [3:0] down = 4'b0000;
    reg set9 = 0, set0 = 0;
    
    reg clk = 0;
    
    wire [15:0] bcd;
    wire cout, bout;
    
    BCDCounter quadBCD(up, down, set9, set0, clk, bcd, cout, bout);
    
    always #10 clk = ~clk; 
    
    
    initial begin
        # 100 up = 1;
    end

endmodule*/

module tester();
    reg [3:0] up = 4'b0000;
    reg [3:0] down = 4'b0000;
    reg set9 = 1, set0 = 0;
    
    reg clk = 0;
    
    wire [15:0] bcd;
    wire cout, bout;
    
    quadBCD qBCD(up, down, set9, set0, clk, bcd, cout, bout);
    
    always #10 clk = ~clk; 
    
    
    initial begin
        # 100 set9 = 0; up = 4'b0001;
    end
endmodule
