// Declare the testbench module
module testTwoComptoSignMag;
    
    // Declare the inputs and outputs of the TwoComptoSignMag module
    reg [14:0] two_comp;
    wire [14:0] signed_mag;
    reg [14:0] expect_signed_mag;

    // Instantiate the TwoComptoSignMag module
    TwoComptoSignMag dut (
        .two_comp(two_comp),
        .signed_mag(signed_mag)
    );

    // Define the initial block for the testbench
    initial begin
        two_comp = 0;
        expect_signed_mag = 0;
        #1;
        if (signed_mag != expect_signed_mag) begin
            $error("Expected %b, got %b", expect_signed_mag, signed_mag);
        end

        two_comp = 1;
        expect_signed_mag = 1;
        #1;
        if (signed_mag != expect_signed_mag) begin
            $error("Expected %b, got %b", expect_signed_mag, signed_mag);
        end
        
        two_comp = 9999;
        expect_signed_mag = 9999;
        #1;
        if (signed_mag != expect_signed_mag) begin
            $error("Expected %b, got %b", expect_signed_mag, signed_mag);
        end

        two_comp = -1;
        expect_signed_mag = {1'b1, 14'd1};
        #1;
        if (signed_mag != expect_signed_mag) begin
            $error("Expected %b, got %b", expect_signed_mag, signed_mag);
        end

        two_comp = -9999;
        expect_signed_mag = {1'b1, 14'd9999};
        #1;
        if (signed_mag != expect_signed_mag) begin
            $error("Expected %b, got %b", expect_signed_mag, signed_mag);
        end
    end

endmodule
