`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 05:16:38 PM
// Design Name: 
// Module Name: testStack
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


module testStack();
    wire [7:0] top; 
    wire [8:0] len;
    reg [7:0] value;
    reg push, pop;

    integer i;

    Stack s(top, len, value, push, pop);

    initial begin
        push = 0;
        pop = 0;
        
        // Basic Test ==========
        
        // push 0
        value = 0;
        #20 push = 1;
        #20 push = 0;
        
        // push FF
        value = 'hFF;
        #20 push = 1;
        #20 push = 0;
        
        // push BE
        value = 'hBE;
        #20 push = 1;
        #20 push = 0;
        
        // push EF
        value = 'hEF;
        #20 push = 1;
        #20 push = 0;
        
        // pop 4 times (to empty)
        // and another time, which should do nothing
        for(i=0; i<5; i=i+1) begin
            #20 pop = 1;
            #20 pop = 0;
        end
        
        // No overflow Test ==========
        // push 256 element
        for(i=0; i<256; i=i+1) begin
            value = i;
            #1 push = 1;
            #1 push = 0;
        end
        
        // try push another element (should do nothing)
        value = 'hDC;
        #20 push = 1;
        #20 push = 0;
        
    
    end
endmodule
