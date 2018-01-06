`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2017 11:58:33 AM
// Design Name: 
// Module Name: hex7seg
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


module hex7seg(
    input [3:0] n,
    input enable,
    output [6:0] seg
    );
    
    wire notN = ~n[0];
 
    m8_le ca (.in({ 1'b0, n[0], n[0], 1'b0, 1'b0, notN, 1'b0, n[0]}), .sel({n[3], n[2], n[1]}), .e(enable), .o(seg[0]));
    m8_le cb (.in({ 1'b1, notN, n[0], 1'b0, notN, n[0], 1'b0, 1'b0}), .sel({n[3], n[2], n[1]}), .e(enable), .o(seg[1]));
    m8_le cc (.in({ 1'b1, notN, 1'b0, 1'b0, 1'b0, 1'b0, notN, 1'b0}), .sel({n[3], n[2], n[1]}), .e(enable), .o(seg[2]));
    m8_le cd (.in({ n[0], 1'b0, notN, 1'b0, n[0], notN, 1'b0, n[0]}), .sel({n[3], n[2], n[1]}), .e(enable), .o(seg[3]));
    m8_le ce (.in({ 1'b0, 1'b0, 1'b0, n[0], n[0], 1'b1, n[0], n[0]}), .sel({n[3], n[2], n[1]}), .e(enable), .o(seg[4]));
    m8_le cf (.in({ 1'b0, n[0], 1'b0, 1'b0, n[0], 1'b0, 1'b1, n[0]}), .sel({n[3], n[2], n[1]}), .e(enable), .o(seg[5]));
    m8_le cg (.in({ 1'b0, notN, 1'b0, 1'b0, n[0], 1'b0, 1'b0, 1'b1}), .sel({n[3], n[2], n[1]}), .e(enable), .o(seg[6]));

endmodule
