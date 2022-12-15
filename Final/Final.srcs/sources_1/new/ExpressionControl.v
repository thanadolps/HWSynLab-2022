`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2022 06:01:43 PM
// Design Name: 
// Module Name: ExpressionControl
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


module ExpressionControl(
    output reg [3:0] push_num_l,
    output reg [15:0] set_num_l,
    output reg [2:0] copcode_l,
    output reg [3:0] push_num_r,
    output reg [15:0] set_num_r,
    output reg [2:0] copcode_r,
    output reg [2:0] new_op,
    input [4:0] action,
    input [15:0] value_left,
    input [2:0] op,
    input [15:0] value_right
    );

    wire op_null = op[2];
    wire value_left_null = value_left[15] == 1;
    wire value_right_null = value_right[15] == 1;
    
    wire value_left_sign = value_left[14];
    wire value_right_sign = value_right[14];
    // wire calculation_null = calculation[15] == 1;

    always @(*) begin
         casez (action[4:2])
            3'b0??: 
                if (op_null) begin
                    // push left
                    copcode_l  = 0;
                    push_num_l  = action[3:0];
                    set_num_l  = 0;

                    copcode_r  = -1;
                    push_num_r  = 0;
                    set_num_r  = 0;

                    new_op = op;  
                end else begin
                    // push right
                    copcode_l  = -1;
                    push_num_l  = 0;
                    set_num_l  = 0;

                    copcode_r  = 0;
                    push_num_r  = action[3:0];
                    set_num_r  = 0;

                    new_op  = op;
                end
            3'b100: 
                if(value_left_null & (action[1:0] == 1)) begin
                    // negate left
                    copcode_l  = 3;
                    push_num_l  = 0;
                    set_num_l  = 0;

                    copcode_r  = -1;
                    push_num_r  = 0;
                    set_num_r  = 0;

                    new_op  = op;
                end else if(!value_left_null & op_null) begin
                    // set op
                    copcode_l  = -1;
                    push_num_l  = 0;
                    set_num_l  = 0;

                    copcode_r  = -1;
                    push_num_r  = 0;
                    set_num_r  = 0;

                    new_op  = action[1:0];
                end else if(!op_null & (action[1:0] == 1)) begin 
                    // negate right
                    copcode_l  = -1;
                    push_num_l  = 0;
                    set_num_l  = 0;

                    // clk_r = 0;
                    // opcode_r = 0;
                    // push_num_r = 0;
                    // set_num_r = 0;
                    copcode_r  = 3;
                    push_num_r  = 0;
                    set_num_r  = 0;

                    new_op  = op;
                end else begin
                    // default case
                    copcode_l  = -1;
                    push_num_l  = 0;
                    set_num_l  = 0;

                    copcode_r  = -1;
                    push_num_r  = 0;
                    set_num_r  = 0;

                    new_op  = op;
                end
            3'b101:
                case (action[1:0])
                    // backspace
                    0: begin
                        if (!value_right_null | value_right_sign) begin
                            // pop right
                            copcode_l  = -1;
                            push_num_l  = 0;
                            set_num_l  = 0;

                            copcode_r  = 1;
                            push_num_r  = 0;
                            set_num_r  = 0;

                            new_op  = op;
                        end else if (!op_null) begin
                            // pop op
                            copcode_l  = -1;
                            push_num_l  = 0;
                            set_num_l  = 0;

                            copcode_r  = -1;
                            push_num_r  = 0;
                            set_num_r  = 0;

                            new_op  = 3'b100;
                        end else begin
                            // pop left
                            copcode_l  = 1;
                            push_num_l  = 0;
                            set_num_l  = 0;

                            copcode_r  = -1;
                            push_num_r  = 0;
                            set_num_r  = 0;

                            new_op  = op;
                        end
                    end
                    // submit
                    1: begin
                        if (!calculation_null) begin
                            clk_l <= 1;
                            opcode_l = 2;
                            push_num_l = 0;
                            set_num_l = calculation;

                            clk_r = 1;
                            opcode_r = 2;
                            push_num_r = 0;
                            set_num_r = {1'b1, 15'b0};

                            aop = 3'b100;             
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
                    end
                    // reset
                    2: begin
                        copcode_l  = 2;
                        push_num_l  = 0;
                        set_num_l  = {1'b1, 15'b0};

                        copcode_r  = 2;
                        push_num_r  = 0;
                        set_num_r  = {1'b1, 15'b0};

                        new_op  = 3'b100;
                        // invalid  = 0;                      
                    end
                    default: begin
                        copcode_l  = -1;
                        push_num_l  = 0;
                        set_num_l  = 0;

                        copcode_r  = -1;
                        push_num_r  = 0;
                        set_num_r  = 0;

                        new_op  = op; 
                    end
                endcase
            default: begin
                copcode_l  = -1;
                push_num_l  = 0;
                set_num_l  = 0;

                copcode_r  = -1;
                push_num_r  = 0;
                set_num_r  = 0;

                new_op  = op; 
            end
        endcase
    end


endmodule
