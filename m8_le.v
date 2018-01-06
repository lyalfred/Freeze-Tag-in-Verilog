`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2017 12:16:07 PM
// Design Name: 
// Module Name: m8_le
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


module m8_le(
    input [7:0] in,
    input [2:0] sel,
    input e,
    output o
    );
    
    wire [7:0] c;
    
    assign c[0] = (~sel[2] & ~sel[1] & ~sel[0] * in[0]);
    assign c[1] = (~sel[2] & ~sel[1] & sel[0] * in[1]);
    assign c[2] = (~sel[2] & sel[1] & ~sel[0] * in[2]);
    assign c[3] = (~sel[2] & sel[1] & sel[0] * in[3]);
    assign c[4] = (sel[2] & ~sel[1] & ~sel[0] * in[4]);
    assign c[5] = (sel[2] & ~sel[1] & sel[0] * in[5]);
    assign c[6] = (sel[2] & sel[1] & ~sel[0] * in[6]);
    assign c[7] = (sel[2] & sel[1] & sel[0] * in[7]);
    assign o = e & (c[0] | c[1] | c[2] | c[3] | c[4] | c[5] | c[6] | c[7]);
    
endmodule