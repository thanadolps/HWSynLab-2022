`timescale 1ns / 1ps

module bcd_counter_tb();

    wire [3:0] outputs;
    wire cout, bout;
    reg clk, set9, set0, inc, dec;

    BCDCounter bcd(outputs,cout,bout,set9,set0,inc,dec,clk);
    
    // clock
    always
        #10 clk=~clk;
    
    // testBCDcounter
    initial begin
        #0 clk=0;inc=0;dec=0;set9=0;set0=1;
        #1 set0=0;
        #20
        #10 inc = 1;
        #310
        #10 inc=0; dec=0; set0 = 1;
        #10 set0=0; set9 = 1;
        #10 set9=0; dec = 1;
        #310
        #10 inc=0; dec=0; set0 = 1;
        #10 set0=0; set9 = 1;
    end
endmodule
