`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2022 09:28:28 PM
// Design Name: 
// Module Name: system
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


module system(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [6:0] led,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output Hsync,
    output Vsync,
    input RsRx,
    input [1:0] sw,
    input clk
    );
        
    ////////////////////////////////////////
    // Clock
    wire targetClk;
    clockReducer #(.TARGET_FREQ(400)) sevenseg_timing(targetClk, clk);


    ////////////////////////////////////////
    // Uart
    wire [7:0] data;
    wire data_ready;
    uartInput (data, data_ready, RsRx, clk);

    ////////////////////////////////////////
    // Uart -> Action
    wire [4:0] action;
    wire action_ready;
    actionInput (action, action_ready, data, data_ready);

    // Syncronize
    reg [4:0] s_action;
    reg s_action_ready;
    always @(posedge clk) begin
        s_action <= action;
        s_action_ready <= action_ready;
    end

    ////////////////////////////////////////
    // ExpressionStack
    wire [15:0] value_left, value_right, calculation;
    wire [2:0] op; 
    wire invalid;

    ExpressionStack expr(
    	.value_left  (value_left  ),
        .op          (op          ),
        .value_right (value_right ),
        .invalid     (invalid     ),
        .action      (s_action      ),
        .calculation (calculation ),
        .tclk        (s_action_ready)
    );

    ////////////////////////////////////////
    // Calculation
    Calculation (
    	.calculation (calculation ),
        .value_left  (value_left  ),
        .op          (op          ),
        .value_right (value_right ),
        .invalid     (invalid     )
    );
    


    ////////////////////////////////////////
    // Assign number
    // unpacking
    wire null = (sw == 2'b00) ? value_left[15] : (sw == 2'b01) ? value_right[15] : calculation[15];
    wire sign = (sw == 2'b00) ? value_left[14] : (sw == 2'b01) ? value_right[14]: calculation[14];
    wire [13:0] mag = (sw == 2'b00) ? value_left[13:0] : (sw == 2'b01) ? value_right[13:0] : calculation[13:0];

    wire overflow = mag > 9999;

    // digit extraction
    wire [3:0] thousandth = (mag / 1000) % 10;
    wire [3:0] hundredth = (mag / 100) % 10;
    wire [3:0] tenth = (mag / 10) % 10;
    wire [3:0] oneth = mag % 10;

    wire [3:0] num3, num2, num1, num0;
    assign {num3, num2, num1, num0} = {
        thousandth,
        hundredth,
        tenth,
        oneth
    };
    
    wire an0,an1,an2,an3;
    assign an = {an3,an2,an1,an0};
    
    ////////////////////////////////////////
    // Display 7 Segments
    quadSevenSeg q7seg(seg,dp,an0,an1,an2,an3,num0,num1,num2,num3,targetClk);
    assign led = {invalid, overflow, null, sign, op};

    ///////////////////////////////////////
    // Display VGA

    VGAOutput vga(
    	.rgb   ({vgaRed, vgaGreen, vgaBlue}),
        .hsync (Hsync),
        .vsync (Vsync),
        .value_left  (value_left),
        .op          (op),
        .value_right (value_right),
        .invalid     (invalid),
        .calculation (calculation),
        .clk         (clk)
    );

endmodule