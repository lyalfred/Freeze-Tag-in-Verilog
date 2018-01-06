`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 01:27:44 PM
// Design Name: 
// Module Name: redRectangle
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


module redRectangle(
    input syncFlash, timeOut,
    input hit, allHit,
    input [15:0] sw,
    input [9:0] hOutQ,
    input [9:0] vOutQ,
    input [9:0] horizontalPosition,
    input clk, frame, doneCount,
    input btnC,
    output redRect, flash, startState, loadTime,
    output [9:0] yPos,
    output outOfAR, outOfTopAR,
    output resetState, activeRed,
    output returnHit
    );
    wire topWall, leftWall, rightWall, bottomWall;
    wire  go;
    wire activeRegion;
    wire [9:0] recLength;
    wire bottomLength = yPos+recLength; 
    rectangleSM rectSM (.clk(clk), .btnC(btnC), .hit(hit), .timeOut(timeOut), .loadTime(loadTime), .allHit(allHit), .startState(startState), .returnHit(returnHit), .activeRed(activeRed), .flash(flash), .go(go), .resetState(resetState) ); 

    tenBitCount vertical (.clk(clk), .reset(resetState | startState), .enable(go & frame & doneCount), .up(1'b1), .down(1'b0),
     .LD(1'b0), .outQ(yPos) );
    
    assign activeRegion = ( (hOutQ > 10'd8) & (hOutQ < 10'd631) & (vOutQ > 10'd8) & (vOutQ < 10'd471) );
    //assign outOfTopAR = ( yPos == 10'd0);
    assign outOfAR = ( yPos == 10'd4 );//( yPos == 10'd471);
    assign recLength = ( 10'd16 + sw[6:4]*10'd32 );
    //vertical length depends on switches
    //horizontal length depends on fixed position
    assign redRect = (activeRed | (syncFlash & flash)) & ~(yPos < 10'd9) & ~startState & doneCount & activeRegion & 
    ((hOutQ >= horizontalPosition-10'd4) & (hOutQ <= horizontalPosition+10'd4)) & ((vOutQ >= yPos) & (vOutQ <= yPos+recLength)); 
    
endmodule
