`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2017 11:50:45 AM
// Design Name: 
// Module Name: taggerMod
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

module taggerMod(
    input [9:0] hOutQ, 
    input [9:0] vOutQ,
    input frame, syncFlash, activeGreen,
    input clk, upDownLD, leftRightLD, cntUp, cntDown, cntLeft, cntRight,

    output greenSquare,
    output [9:0] xPos,
    output [9:0] yPos,
    output topHit, bottomHit, leftHit, rightHit        //collisions against the wall
    );
    wire [9:0] loadxD;
    wire [9:0] loadyD;
    wire xStop, yStop;
    tenBitCount horizontal (.clk(clk), .enable( frame & (cntLeft | cntRight)), .up(cntRight), .down(cntLeft), .LD(upDownLD), .reset(1'b0),
     .loadD(10'd320), .outQ(xPos));
    
    tenBitCount vertical (.clk(clk), .enable( frame & (cntDown | cntUp)), .up(cntDown), .down(cntUp), .LD(upDownLD), .reset(1'b0),
     .loadD(10'd240), .outQ(yPos));
     
     assign topHit = (yPos == 10'd16);
     assign bottomHit = (yPos == 10'd463);
     assign rightHit = (xPos == 10'd623);
     assign leftHit = (xPos == 10'd16);
      
     assign greenSquare = (activeGreen | syncFlash) & ((hOutQ >= xPos-10'd8) & (hOutQ <= xPos+10'd8)) & ((vOutQ >= yPos-10'd8) & (vOutQ <= yPos+10'd8)); 
     
endmodule
