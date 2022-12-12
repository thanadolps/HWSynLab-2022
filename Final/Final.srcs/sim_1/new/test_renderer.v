`timescale 1ms / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2022 06:59:27 PM
// Design Name: 
// Module Name: test_renderer
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


module test_renderer();

    localparam WIDTH = 640;
    localparam HEIGHT = 480;

    wire [11:0] color;
    reg [9:0] x, y;

    VGARender vga(
        color,
        x,
        y,
        0,
        0,
        0,
        0
    );

    wire digit_mask = vga.digit_mask;
    wire val = vga.mask_0[x];

    initial begin
        y = 0;
        x = 0;
    end

    always begin
        #1
        if (y < HEIGHT) begin
            $write(color);

            x = x + 1;
            if (x == WIDTH) begin
                x = 0;
                y = y+1;
                $write("\n");
            end
        end
    end


endmodule
