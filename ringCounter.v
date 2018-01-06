`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2017 12:15:10 PM
// Design Name: 
// Module Name: ringCounter
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


module ringCounter(
    input clk,digsel,
    output [3:0] sel
    );
    wire [3:0] outQ;
//    wire inD0 = 1'b1 ^ outQ[0];
//    wire inD1 = (1'b1 & outQ[0]) ^ outQ[1];

    //start off with a 2 bit counter.
      //FDRE #(.INIT(1'b1) ) ff_instance_1 (.C(clk), .R(reset), .CE(digsel), .D(digsel), .Q(outQ[0]));
      //FDRE #(.INIT(1'b0) ) ff_instance_2 (.C(clk), .R(reset), .CE(digsel), .D(outQ[0]), .Q(outQ[1]));
        FDRE #(.INIT(1'b1) ) ff_instance_1 (.C(clk), .R(reset), .CE(digsel), .D(outQ[3]), .Q(outQ[0]));
        FDRE #(.INIT(1'b0) ) ff_instance_2 (.C(clk), .R(reset), .CE(digsel), .D(outQ[0]), .Q(outQ[1]));
        FDRE #(.INIT(1'b0) ) ff_instance_3 (.C(clk), .R(reset), .CE(digsel), .D(outQ[1]), .Q(outQ[2]));
        FDRE #(.INIT(1'b0) ) ff_instance_4 (.C(clk), .R(reset), .CE(digsel), .D(outQ[2]), .Q(outQ[3]));
        
        assign sel = outQ;
    //decode into 4 bits
//        assign sel[3] = (outQ[0])&(outQ[1]);
//        assign sel[2] = (~outQ[0])&(outQ[1]);
//        assign sel[1] = (outQ[0])&(~outQ[1]);
//        assign sel[0] = (~outQ[0])&(~outQ[1]);   
endmodule
