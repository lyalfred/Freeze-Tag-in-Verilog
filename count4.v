`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 01:09:07 PM
// Design Name: 
// Module Name: count4
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


module count4(
input clk, enable,
    output eightSec
    );
    wire [3:0] outQ;
    wire inD0 = enable ^ outQ[0];
    wire inD1 = (enable & outQ[0]) ^ outQ[1];
    wire inD2 = (enable & outQ[0] & outQ[1]) ^ outQ[2];
    wire inD3 = (enable & outQ[0] & outQ[1] & outQ[2]) ^ outQ[3];

    FDRE #(.INIT(1'b0) ) bit1 (.C(clk), .R(eightSec), .CE(enable), .D(inD0), .Q(outQ[0]));
    FDRE #(.INIT(1'b0) ) bit2 (.C(clk), .R(eightSec), .CE(enable), .D(inD1), .Q(outQ[1]));
    FDRE #(.INIT(1'b0) ) bit3 (.C(clk), .R(eightSec), .CE(enable), .D(inD2), .Q(outQ[2]));
    FDRE #(.INIT(1'b0) ) bit4 (.C(clk), .R(eightSec), .CE(enable), .D(inD3), .Q(outQ[3]));

   
    assign eightSec = ( ~outQ[0] & ~outQ[1] & ~outQ[2] & outQ[3] );   
    
endmodule