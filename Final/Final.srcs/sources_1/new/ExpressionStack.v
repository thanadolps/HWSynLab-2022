`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 09:50:30 AM
// Design Name: 
// Module Name: ExpressionStack
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


module ExpressionStack(
    output [15:0] value_left,
    output reg [2:0] op,
    output [15:0] value_right,
    input [4:0] action,
    input [15:0] calculation,
    input tclk
    );

    wire [2:0] new_op;

    wire [3:0] push_num_l;
    wire [15:0] set_num_l;
    wire [1:0] opcode_l;
    reg tclk_l;
    QuadDigitStack ql(
    	.value    (value_left ),
        .push_num (push_num_l ),
        .set_num  (set_num_l  ),
        .opcode   (opcode_l   ),
        .clk      (tclk_l     )
    );

    wire [3:0] push_num_r;
    wire [15:0] set_num_r;
    wire [1:0] opcode_r;
    reg tclk_r;
    QuadDigitStack qr(
    	.value    (value_right    ),
        .push_num (push_num_r ),
        .set_num  (set_num_r  ),
        .opcode   (opcode_r   ),
        .clk      (tclk_r     )
    );


    wire [2:0] copcode_l, copcode_r;

    assign sclk_l = ~copcode_l[2];
    assign opcode_l = copcode_l[1:0];
    
    assign sclk_r = ~copcode_r[2];
    assign opcode_r = copcode_r[1:0];

    reg [15:0] svalue_left, svalue_right;
    reg [2:0] sop;
    reg [15:0] scalculation;
    always @(negedge tclk) begin
        sop <= op;
        svalue_left <= value_left;
        svalue_right <= value_right;
        scalculation <= calculation;
    end


    ExpressionControl exp_ctrl(
    	.push_num_l  (push_num_l  ),
        .set_num_l   (set_num_l   ),
        .copcode_l   (copcode_l   ),
        .push_num_r  (push_num_r  ),
        .set_num_r   (set_num_r   ),
        .copcode_r   (copcode_r   ),
        .new_op      (new_op      ),
        .action      (action      ),
        .value_left  (svalue_left  ),
        .op          (sop          ),
        .value_right (svalue_right ),
        .calculation (scalculation)
    );
    
    always @(tclk) begin
        tclk_l  <= sclk_l & tclk;
        tclk_r  <= sclk_r & tclk;
    end

    always @(posedge tclk) begin
        op  <= new_op;
    end

    initial begin
        op = 3'b100;
        tclk_l = 0;
        tclk_r = 0;
        sop = 3'b100;
        svalue_left = {1'b1, 15'b0};
        svalue_right = {1'b1, 15'b0};
    end
endmodule
