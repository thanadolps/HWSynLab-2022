`timescale 1ns / 1ps

module single_pulser_tb();
    
    wire d2;
    reg clk, pushed=0;
    reg clkToggle = 1;

    singlePulser sp(d2,pushed,clk);
    
    // clock
    always
        #10 clk=clkToggle^clk;

    // testPulser
    initial begin
        #0  clk=0;
        #20
        #15  pushed = 1;
        #30 pushed = 0;
        #15  pushed = 1;
        #60 pushed = 0;
        #26  pushed = 1;
        #47 pushed = 0;
        #26  pushed = 1;
        #47 pushed = 0;
        #26  pushed = 1;
        #47 pushed = 0;
        #47  pushed = 1;
        #26 pushed = 0;
        
        #10 clkToggle=0;
        
        #15  pushed = 1;
        #30 pushed = 0;
        #15  pushed = 1;
        #60 pushed = 0;
        #26  pushed = 1;
        #47 pushed = 0;
        
        #10 clkToggle=1;
        
        #26  pushed = 1;
        #47 pushed = 0;
        #26  pushed = 1;
        #47 pushed = 0;
        #47  pushed = 1;
        #26 pushed = 0;
            
        #600 $finish;
    end
endmodule
