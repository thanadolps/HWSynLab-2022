`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2022 11:45:09 AM
// Design Name: 
// Module Name: testALU
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


module testALU(

    );

    // Inputs
    reg signed [14:0] A;
    reg signed [14:0] B;
    reg [1:0] alu_ops;

    // Outputs
    wire signed [14:0] q;
    wire nan;

    // Instantiate the unit under test
    alu uut (
        .q(q),
        .nan(nan),
        .A(A),
        .B(B),
        .alu_ops(alu_ops)
    );

    wire exceed = uut.exceed;
    wire divison_err = uut.divison_err;

    // Test cases
    reg signed [14:0] expect_q;
    reg expect_nan;

    initial begin
        // Test case 1
        A = 15;
        B = 10;
        alu_ops = 0;
        expect_q = 25;
        expect_nan = 0;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 2
        A = -15;
        B = 10;
        alu_ops = 1;
        expect_q = -25;
        expect_nan = 0;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 3
        A = 5;
        B = -10;
        alu_ops = 2;
        expect_q = -50;
        expect_nan = 0;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 4
        A = -5;
        B = -10;
        alu_ops = 3;
        expect_q = 0;
        expect_nan = 0;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 5
        A = 0;
        B = 10;
        alu_ops = 3;
        expect_q = 0;
        expect_nan = 0;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 6
        A = 9999;
        B = 9999;
        alu_ops = 0;
        expect_q = 19998;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 7
        A = 100;
        B = 0;
        alu_ops = 3;
        expect_q = 0;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 8
        A = 9999;
        B = 9999;
        alu_ops = 0;
        expect_q = 19998;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 9
        A = -9999;
        B = -9999;
        alu_ops = 0;
        expect_q = -19998;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 10
        A = -9999;
        B = 9999;
        alu_ops = 1;
        expect_q = -19998;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 11
        A = 9999;
        B = -9999;
        alu_ops = 1;
        expect_q = 19998;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 12
        A = 10000;
        B = 10;
        alu_ops = 0;
        expect_q = 10010;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 13
        A = -10000;
        B = 10;
        alu_ops = 0;
        expect_q = -9990;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 14
        A = 1;
        B = 2;
        alu_ops = 1;
        expect_q = -1;
        expect_nan = 0;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 15
        A = 9999;
        B = 9999;
        alu_ops = 2;
        expect_q = 0;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 16
        A = 9999;
        B = -9999;
        alu_ops = 2;
        expect_q = 0;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 17
        A = -9999;
        B = -9999;
        alu_ops = 2;
        expect_q = 0;
        expect_nan = 1;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Test case 18
        A = -9999;
        B = 0;
        alu_ops = 2;
        expect_q = 0;
        expect_nan = 0;
        #10;
        if ((expect_nan != nan)) begin
            $error("Expected nan: %b, got %b", expect_nan, nan);
        end else if (nan == 0 & (expect_q != q)) begin
            $error("Expected q: %b, got %b", expect_nan, nan);
        end

        // Add more test cases as needed...
    end

    // Check results
    initial begin
        $monitor("A=%d B=%d alu_ops=%d q=%d nan=%d expect_q=%d expect_nan=%d", A, B, alu_ops, q, nan, expect_q, expect_nan);
        $display("Simulation finished.");
    end
endmodule
