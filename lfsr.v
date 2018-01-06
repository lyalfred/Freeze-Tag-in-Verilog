`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2017 11:36:13 AM
// Design Name: 
// Module Name: lfsr
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


module lfsr(
    input clk, frame,
    output [7:0] rnd
    );
        wire TC;
        wire rndIn1 = rnd[0] ^ rnd[5] ^ rnd[6] ^ rnd[7];
        FDRE #(.INIT(1'b0) ) ff_instance_1 (.C(clk), .R(1'b0), .CE(frame), .D(rndIn1), .Q(rnd[0]));
        FDRE #(.INIT(1'b0) ) ff_instance_2 (.C(clk), .R(1'b0), .CE(frame), .D(rnd[0]), .Q(rnd[1]));
        FDRE #(.INIT(1'b0) ) ff_instance_3 (.C(clk), .R(1'b0), .CE(frame), .D(rnd[1]), .Q(rnd[2]));
        FDRE #(.INIT(1'b0) ) ff_instance_4 (.C(clk), .R(1'b0), .CE(frame), .D(rnd[2]), .Q(rnd[3]));
        FDRE #(.INIT(1'b0) ) ff_instance_5 (.C(clk), .R(1'b0), .CE(frame), .D(rnd[3]), .Q(rnd[4]));
        FDRE #(.INIT(1'b0) ) ff_instance_6 (.C(clk), .R(1'b0), .CE(frame), .D(rnd[4]), .Q(rnd[5]));
        FDRE #(.INIT(1'b0) ) ff_instance_7 (.C(clk), .R(1'b0), .CE(frame), .D(rnd[5]), .Q(rnd[6]));
        FDRE #(.INIT(1'b1) ) ff_instance_8 (.C(clk), .R(1'b0), .CE(frame), .D(rnd[6]), .Q(rnd[7]));
        
        assign TC = rnd[0] & rnd[1] & rnd[2] & rnd[3] & rnd[4] & rnd[5] & rnd[6] & rnd[7];

endmodule
