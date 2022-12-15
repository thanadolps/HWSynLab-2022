module ESSpecialOp(
    output reg [3:0] push_num_l,
    output reg [15:0] set_num_l,
    output reg [1:0] opcode_l,
    output reg clk_l,
    output reg [3:0] push_num_r,
    output reg [15:0] set_num_r,
    output reg [1:0] opcode_r,
    output reg clk_r,
    input [15:0] value_left,
    input [2:0] op,
    input [15:0] value_right,
    input [4:0] action,
    input [15:0] calculation,
    input clk
);
endmodule