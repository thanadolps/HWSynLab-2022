`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2022 10:12:43 AM
// Design Name: 
// Module Name: testSignMagtoTwoComp
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


module testSignMagtoTwoComp();

    reg [14:0] signed_mag; 
    wire [14:0] two_comp;
    reg [14:0] expect_two_comp;

    SignMagtoTwoComp dut (
        .signed_mag(signed_mag),
        .two_comp(two_comp)
    );

    initial begin
        signed_mag = 0;
        expect_two_comp = 0;
        #1;
        if (two_comp != expect_two_comp) begin
            $error("Expected %b, got %b", expect_two_comp, two_comp);
        end

        signed_mag = 1;
        expect_two_comp = 1;
        #1;
        if (two_comp != expect_two_comp) begin
            $error("Expected %b, got %b", expect_two_comp, two_comp);
        end

        signed_mag = 9999;
        expect_two_comp = 9999;
        #1;
        if (two_comp != expect_two_comp) begin
            $error("Expected %b, got %b", expect_two_comp, two_comp);
        end

        signed_mag = {1'b1, 14'd1};
        expect_two_comp = -1;
        #1;
        if (two_comp != expect_two_comp) begin
            $error("Expected %b, got %b", expect_two_comp, two_comp);
        end

        signed_mag = {1'b1, 14'd9999};
        expect_two_comp = -9999;
        #1;
        if (two_comp != expect_two_comp) begin
            $error("Expected %b, got %b", expect_two_comp, two_comp);
        end
    end

endmodule
