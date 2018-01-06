`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2017 06:48:18 PM
// Design Name: 
// Module Name: vgaControlMod
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

module vgaControlMod(
    input clk, enable, up, LD,
    input [9:0] loadD,
    output Hsync, Vsync, activeRegion,
    output [9:0] hOutQ, 
    output [9:0] vOutQ,
    output goodWall, topWall, bottomWall, leftWall, rightWall,
    output greenSquare,
    output frame
    );
    wire topgreenWall;
    wire hReset, vReset;
    wire TC;
    
    tenBitCount horizontal (.clk(clk), .enable(enable), .up(up), .down(1'b0), .LD(LD), .reset(hReset), .loadD(loadD), .outQ(hOutQ), .TC(TC));
    tenBitCountY vertical (.clk(clk), .enable(TC), .up(up), .down(1'b0), .LD(LD), .reset(vReset), .loadD(loadD), .outQ(vOutQ));
    assign activeRegion = ( (hOutQ > 10'd0) & (hOutQ < 10'd639) & (vOutQ > 10'd0) & (vOutQ < 10'd479) );
    assign hReset = ( hOutQ == 10'd799);
    assign vReset = ( vOutQ == 10'd524 & hOutQ == 10'd799);
    assign Hsync = (hOutQ < 10'd655) | (hOutQ > 10'd750); 
    assign Vsync = (vOutQ < 10'd489) | (vOutQ > 10'd490);
     
    assign topWall = ((hOutQ >= 10'd0) & (hOutQ <= 10'd639)) & ((vOutQ >= 10'd0) & (vOutQ <= 10'd8)); 
    assign bottomWall = ((hOutQ >= 10'd0) & (hOutQ <= 10'd639)) & ((vOutQ >= 10'd471) & (vOutQ <= 10'd479)); 
    assign leftWall = ((hOutQ >= 10'd0) & (hOutQ <= 10'd8)) & ((vOutQ >= 10'd0) & (vOutQ <= 10'd479)); 
    assign rightWall = ((hOutQ >= 10'd631) & (hOutQ <= 10'd639)) & ((vOutQ >= 10'd0) & (vOutQ <= 10'd479)); 

    //border
    assign goodWall = topWall | bottomWall | leftWall | rightWall;
    assign frame = ( (hOutQ == 10'd755) & (vOutQ == 10'd0) );
                 
endmodule
