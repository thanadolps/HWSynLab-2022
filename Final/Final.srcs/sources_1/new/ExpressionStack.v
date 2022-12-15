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
    output reg invalid,
    input [4:0] action,
    input [15:0] calculation,
    input clk
    );

    reg [2:0] aop;

    reg [3:0] push_num_l;
    reg [15:0] set_num_l;
    reg [1:0] opcode_l;
    reg sclk_l, clk_l;
    QuadDigitStack ql(
    	.value    (value_left ),
        .push_num (push_num_l ),
        .set_num  (set_num_l  ),
        .opcode   (opcode_l   ),
        .clk      (sclk_l     )
    );

    reg [3:0] push_num_r;
    reg [15:0] set_num_r;
    reg [1:0] opcode_r;
    reg sclk_r, clk_r;
    QuadDigitStack qr(
    	.value    (value_right    ),
        .push_num (push_num_r ),
        .set_num  (set_num_r  ),
        .opcode   (opcode_r   ),
        .clk      (sclk_r     )
    );
    

    initial begin
        invalid = 0;
        op = 3'b100;
        aop = 3'b100;
    end

    wire op_null = op[2] == 1;
    wire value_left_null = value_left[15] == 1;
    wire value_right_null = value_right[15] == 1;
    wire calculation_null = calculation[15] == 1;

    always @(*) begin
        casez (action[4:2])
            3'b0??: 
                if (op_null) begin
                    // push left

                    clk_l = 1;
                    opcode_l = 0;
                    push_num_l = action[3:0];
                    set_num_l = 0;

                    clk_r = 0;
                    opcode_r = 0;
                    push_num_r = 0;
                    set_num_r = 0;

                    aop = op;  
                end else begin
                    // push right

                    clk_l = 0;
                    opcode_l = 0;
                    push_num_l = 0;
                    set_num_l = 0;

                    clk_r = 1;
                    opcode_r = 0;
                    push_num_r = action[3:0];
                    set_num_r = 0;

                    aop = op;
                end
            3'b100: 
                if(value_left_null & action[1:0] == 1) begin
                    // negate left
                    clk_l = 1;
                    opcode_l = 3;
                    push_num_l = 0;
                    set_num_l = 0;

                    clk_r = 0;
                    opcode_r = 0;
                    push_num_r = 0;
                    set_num_r = 0;

                    aop = op;
                end else if(!value_left_null & op_null) begin
                    // set op
                    clk_l = 0;
                    opcode_l = 0;
                    push_num_l = 0;
                    set_num_l = 0;

                    clk_r = 0;
                    opcode_r = 0;
                    push_num_r = 0;
                    set_num_r = 0;

                    aop = action[1:0];
                end else if(!op_null & action[1:0] == 1) begin 
                    // negate right
                    clk_l = 0;
                    opcode_l = 0;
                    push_num_l = 0;
                    set_num_l = 0;

                    clk_r = 0;
                    opcode_r = 0;
                    push_num_r = 0;
                    set_num_r = 0;
                    // clk_r = 1;
                    // opcode_r = 3;
                    // push_num_r = 0;
                    // set_num_r = 0;

                    aop = op;
                end else begin
                    // default case
                    clk_l = 0;
                    opcode_l = 0;
                    push_num_l = 0;
                    set_num_l = 0;

                    clk_r = 0;
                    opcode_r = 0;
                    push_num_r = 0;
                    set_num_r = 0;

                    aop = op;
                end
            3'b101:
                case (action[1:0])
                    // backspace
                    // 0: begin
                    //     if (!value_right_null) begin
                    //         // pop right
                    //         clk_l = 0;
                    //         opcode_l = 0;
                    //         push_num_l = 0;
                    //         set_num_l = 0;

                    //         clk_r = 1;
                    //         opcode_r = 1;
                    //         push_num_r = 0;
                    //         set_num_r = 0;

                    //         aop = op;
                    //     end else if (!op_null) begin
                    //         // pop op
                    //         clk_l = 0;
                    //         opcode_l = 0;
                    //         push_num_l = 0;
                    //         set_num_l = 0;

                    //         clk_r = 0;
                    //         opcode_r = 1;
                    //         push_num_r = 0;
                    //         set_num_r = 0;

                    //         aop = 3'b100;
                    //     end else begin
                    //         // pop left
                    //         clk_l = 1;
                    //         opcode_l = 1;
                    //         push_num_l = 0;
                    //         set_num_l = 0;

                    //         clk_r = 0;
                    //         opcode_r = 0;
                    //         push_num_r = 0;
                    //         set_num_r = 0;

                    //         aop = op;
                    //     end
                    // end
                    // // submit
                    // 1: begin
                    //     if (!calculation_null) begin
                    //         clk_l = 1;
                    //         opcode_l = 2;
                    //         push_num_l = 0;
                    //         set_num_l = calculation;

                    //         clk_r = 1;
                    //         opcode_r = 2;
                    //         push_num_r = 0;
                    //         set_num_r = {1'b1, 15'b0};

                    //         aop = 3'b100;             
                    //     end else begin
                    //         // default case
                    //         clk_l = 0;
                    //         opcode_l = 0;
                    //         push_num_l = 0;
                    //         set_num_l = 0;

                    //         clk_r = 0;
                    //         opcode_r = 0;
                    //         push_num_r = 0;
                    //         set_num_r = 0;

                    //         aop = op;
                    //     end
                    // end
                    // reset
                    2: begin
                        clk_l = 1;
                        opcode_l = 2;
                        push_num_l = 0;
                        set_num_l = {1'b1, 15'b0};

                        clk_r = 1;
                        opcode_r = 2;
                        push_num_r = 0;
                        set_num_r = {1'b1, 15'b0};

                        aop = 3'b100;
                        // invalid = 0;                      
                    end
                    default: begin
                        clk_l = 0;
                        opcode_l = 0;
                        push_num_l = 0;
                        set_num_l = 0;

                        clk_r = 0;
                        opcode_r = 0;
                        push_num_r = 0;
                        set_num_r = 0;

                        aop = op; 
                    end
                endcase
            default: begin
                clk_l = 0;
                opcode_l = 0;
                push_num_l = 0;
                set_num_l = 0;

                clk_r = 0;
                opcode_r = 0;
                push_num_r = 0;
                set_num_r = 0;

                aop = op;
            end
        endcase
    end

    always @(clk) begin
        sclk_l <= clk_l & clk;
        sclk_r <= clk_r & clk;
    end

    always @(posedge clk) begin
        op <= aop;
    end




endmodule
