`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2022 07:57:13 PM
// Design Name: 
// Module Name: VGATextFlow
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


module VGATextFlow #(
    parameter N = 11,
    parameter PAD = 16
)(
    output [4:0] char,
    output [9:0] offset_x,
    output [9:0] offset_y,
    input [5*N-1:0] chars,
    input [9:0] x,
    input [9:0] y
);

    wire [4:0] carr [0:N-1];
    wire [9:0] csizes [0:N-1];   // size/width of i'th char

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin
            // unflatten chars array
            // carr store a bunch of 5 bit char
            // index 0 is the leftest char 
            assign carr[i] = chars[(5*N-1)-5*i:(5*N-1)-5*i-4];
            
            // calculate i'th char size
            VGACharSize(_, csizes[i], carr[i]); 
        end
    endgenerate

    // (relative) top-right x pos of block
    // eg. if vga displaying 1234+189, the it would store x pos at `v`
    //   v v v v v v v v
    // |1|2|3|4|+|1|8|9|
    wire [9:0] bx [0:N-1];
    assign bx[0] = csizes[0] + PAD;  // base case
    generate
        for (i = 1; i < N; i = i + 1) begin
            // recusrive relation
            // next block x = prev block x + width of char on prev block + padding
            assign bx[i] = bx[i-1] + csizes[i] + PAD;
        end
    endgenerate
    
    // Determine which block x belong to
    // let dyn[i] be a block x might belong to when considering only box i..N-1 
    wire [9:0] dyn [0:N-1];
    assign dyn[N-1] = N-1;  // base case
    generate
        for (i = 0; i < N-1; i = i + 1) begin
            assign dyn[i] = (x < bx[i]) ? i : dyn[i+1];
        end
    endgenerate


    wire [9:0] block_idx = dyn[0];
    wire [9:0] prev_block_idx = block_idx-1;
    wire [9:0] prev_block_x = (block_idx != 0) ? bx[prev_block_idx] : 0;

    assign char = carr[block_idx];
    assign offset_x = x - prev_block_x;
    assign offset_y = y;
endmodule
