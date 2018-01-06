`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2017 05:24:04 PM
// Design Name: 
// Module Name: count8
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


module count8(
    input clk, enable, reset,
    output twoSec
    );
    wire [7:0] outQ;
    wire inD0 = enable ^ outQ[0];
    wire inD1 = (enable & outQ[0]) ^ outQ[1];
    wire inD2 = (enable & outQ[0] & outQ[1]) ^ outQ[2];
    wire inD3 = (enable & outQ[0] & outQ[1] & outQ[2]) ^ outQ[3];
    wire inD4 = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3]) ^ outQ[4];
    wire inD5 = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3] & outQ[4]) ^ outQ[5];
    wire inD6 = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3] & outQ[4] & outQ[5]) ^ outQ[6];
    wire inD7 = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3] & outQ[4] & outQ[5] & outQ[6]) ^ outQ[7];

    FDRE #(.INIT(1'b0) ) bit1 (.C(clk), .R(reset), .CE(enable & ~TC), .D(inD0), .Q(outQ[0]));
    FDRE #(.INIT(1'b0) ) bit2 (.C(clk), .R(reset), .CE(enable & ~TC), .D(inD1), .Q(outQ[1]));
    FDRE #(.INIT(1'b0) ) bit3 (.C(clk), .R(reset), .CE(enable & ~TC), .D(inD2), .Q(outQ[2]));
    FDRE #(.INIT(1'b0) ) bit4 (.C(clk), .R(reset), .CE(enable & ~TC), .D(inD3), .Q(outQ[3]));
    FDRE #(.INIT(1'b0) ) bit5 (.C(clk), .R(reset), .CE(enable & ~TC), .D(inD4), .Q(outQ[4]));
    FDRE #(.INIT(1'b0) ) bit6 (.C(clk), .R(reset), .CE(enable & ~TC), .D(inD5), .Q(outQ[5]));
    FDRE #(.INIT(1'b0) ) bit7 (.C(clk), .R(reset), .CE(enable & ~TC), .D(inD6), .Q(outQ[6]));
    FDRE #(.INIT(1'b0) ) bit8 (.C(clk), .R(reset), .CE(enable & ~TC), .D(inD7), .Q(outQ[7]));

    assign twoSec = ( ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & outQ[7] );   
    
endmodule