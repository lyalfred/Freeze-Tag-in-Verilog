`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2017 01:41:57 PM
// Design Name: 
// Module Name: edgeDetector
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


module edgeDetector(
    input clk, btnC,
    output edgeOut
    );
        wire [1:0] outQ;
        FDRE #(.INIT(1'b0) ) ff_instance_1 (.C(clk), .R(reset), .CE(1'b1), .D(btnC), .Q(outQ[0]));
        FDRE #(.INIT(1'b0) ) ff_instance_2 (.C(clk), .R(reset), .CE(1'b1), .D(outQ[0]), .Q(outQ[1]));
        //assign edgeOut = ~outQ[0] & outQ[1]; 
        assign edgeOut = btnC & (~outQ[0] & ~outQ[1]); 
endmodule
