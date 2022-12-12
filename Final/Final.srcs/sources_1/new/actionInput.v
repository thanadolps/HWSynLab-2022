`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2022 01:58:48 AM
// Design Name: 
// Module Name: actionInput
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


module actionInput(
    output reg [4:0] action,
    output reg action_ready,
    input [7:0] data_in,
    input data_ready
    );

    localparam [4:0] INVALID_ACTION = 5'b11111;

    always @(*) begin
        case (data_in)
            8'h30: action = {1'b0, 4'd0};
            8'h31: action = {1'b0, 4'd1};
            8'h32: action = {1'b0, 4'd2};
            8'h33: action = {1'b0, 4'd3};
            8'h34: action = {1'b0, 4'd4};
            8'h35: action = {1'b0, 4'd5};
            8'h36: action = {1'b0, 4'd6};
            8'h37: action = {1'b0, 4'd7};
            8'h38: action = {1'b0, 4'd8};
            8'h39: action = {1'b0, 4'd9};

            8'h2b: action = 5'b10000; // +
            8'h2d: action = 5'b10001; // -
            8'h2a: action = 5'b10010; // *
            8'h2f: action = 5'b10011; // /

            8'h7f: action = 5'b10100; // backspace
            8'h0D, 8'h3D: action = 5'b10101; // submit
            8'h7e, 8'h1b: action = 5'b10110; // reset

            default: action = INVALID_ACTION;
        endcase
    end

    always @(data_ready) begin
        action_ready <= data_ready & (action != INVALID_ACTION);
    end


endmodule
