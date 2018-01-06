`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2017 11:55:53 AM
// Design Name: 
// Module Name: selector
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


module selector(
    input [3:0] sel,
    input [15:0] N,
    output [3:0] H
    );
    /*
    H is x[15:12] when sel=(1000)
    H is x[11:8] when sel=(0100)
    H is x[7:4] when sel=(0010)
    H is x[3:0] when sel=(0001)
    */
    assign H = ((N[15:12] & {4{sel[3]}}) | (N[11:8] & {4{sel[2]}}) | (N[7:4] & {4{sel[1]}}) | (N[3:0] & {4{sel[0]}}));
    
endmodule
