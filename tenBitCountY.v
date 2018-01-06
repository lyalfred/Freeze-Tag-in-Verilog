`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2017 06:24:32 PM
// Design Name: 
// Module Name: tenBitCount
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


module tenBitCountY(
    input clk, enable, up, down, LD, reset, 
    input [9:0] loadD,
    output [9:0] outQ,
    output TC
);
wire [9:0] inD;
wire [9:0] invD;
wire [9:0] countSelect;
wire [9:0] loadSelect;
wire [9:0] temp;
//upCount logic
assign inD[0] = enable ^ outQ[0];
assign inD[1] = (enable & outQ[0]) ^ outQ[1];
assign inD[2] = (enable & outQ[0] & outQ[1]) ^ outQ[2];
assign inD[3] = (enable & outQ[0] & outQ[1] & outQ[2]) ^ outQ[3];
assign inD[4] = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3]) ^ outQ[4];
assign inD[5] = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3] & outQ[4]) ^ outQ[5];
assign inD[6] = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3] & outQ[4] & outQ[5]) ^ outQ[6];
assign inD[7] = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3] & outQ[4] & outQ[5] & outQ[6]) ^ outQ[7];
assign inD[8] = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3] & outQ[4] & outQ[5] & outQ[6] & outQ[7]) ^ outQ[8];
assign inD[9] = (enable & outQ[0] & outQ[1] & outQ[2] & outQ[3] & outQ[4] & outQ[5] & outQ[6] & outQ[7] & outQ[8]) ^ outQ[9];
//downCount logic
assign invD[0] = enable ^ outQ[0];
assign invD[1] = (enable & ~outQ[0]) ^ outQ[1];
assign invD[2] = (enable & ~outQ[0] & ~outQ[1]) ^ outQ[2];
assign invD[3] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2]) ^ outQ[3];
assign invD[4] = (enable & outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3]) ^ outQ[4];
assign invD[5] = (enable & outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4]) ^ outQ[5];
assign invD[6] = (enable & outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5]) ^ outQ[6];
assign invD[7] = (enable & outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6]) ^ outQ[7];
assign invD[8] = (enable & outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7]) ^ outQ[8];
assign invD[9] = (enable & outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7] & ~outQ[8]) ^ outQ[9];

assign temp[0] =  ( (~LD & up & inD[0]) | (~LD & down & invD[0]) | (LD & loadD[0]) );
assign temp[1] =  ( (~LD & up & inD[1]) | (~LD & down & invD[1]) | (LD & loadD[1]) );
assign temp[2] =  ( (~LD & up & inD[2]) | (~LD & down & invD[2]) | (LD & loadD[2]) );
assign temp[3] =  ( (~LD & up & inD[3]) | (~LD & down & invD[3]) | (LD & loadD[3]) );
assign temp[4] =  ( (~LD & up & inD[4]) | (~LD & down & invD[4]) | (LD & loadD[4]) );
assign temp[5] =  ( (~LD & up & inD[5]) | (~LD & down & invD[5]) | (LD & loadD[5]) );
assign temp[6] =  ( (~LD & up & inD[6]) | (~LD & down & invD[6]) | (LD & loadD[6]) );
assign temp[7] =  ( (~LD & up & inD[7]) | (~LD & down & invD[7]) | (LD & loadD[7]) );
assign temp[8] =  ( (~LD & up & inD[8]) | (~LD & down & invD[8]) | (LD & loadD[8]) );
assign temp[9] =  ( (~LD & up & inD[9]) | (~LD & down & invD[9]) | (LD & loadD[9]) );
//0011110000
FDRE #(.INIT(1'b0) ) ff_instance_1 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[0]), .Q(outQ[0]));
FDRE #(.INIT(1'b0) ) ff_instance_2 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[1]), .Q(outQ[1]));
FDRE #(.INIT(1'b1) ) ff_instance_3 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[2]), .Q(outQ[2]));
FDRE #(.INIT(1'b1) ) ff_instance_4 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[3]), .Q(outQ[3]));
FDRE #(.INIT(1'b1) ) ff_instance_5 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[4]), .Q(outQ[4]));
FDRE #(.INIT(1'b1) ) ff_instance_6 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[5]), .Q(outQ[5]));
FDRE #(.INIT(1'b0) ) ff_instance_7 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[6]), .Q(outQ[6]));
FDRE #(.INIT(1'b0) ) ff_instance_8 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[7]), .Q(outQ[7]));
FDRE #(.INIT(1'b0) ) ff_instance_9 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[8]), .Q(outQ[8]));
FDRE #(.INIT(1'b0) ) ff_instance_10 (.C(clk), .R(reset), .CE(enable | LD), .D(temp[9]), .Q(outQ[9]));

assign TC = outQ[9] & outQ[8] & ~outQ[7] & ~outQ[6] & ~outQ[5] & outQ[4] & outQ[3] & outQ[2] & outQ[1] & outQ[0];

endmodule
