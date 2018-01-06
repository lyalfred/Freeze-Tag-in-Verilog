`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 03:01:31 PM
// Design Name: 
// Module Name: count8D
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


module count8D(
    input clk, enable, LD, reset,
    input [7:0] inD,
    output TC
);
    wire [7:0] invD;
    wire [7:0] outQ;
    wire [7:0] temp;
    assign invD[0] = enable ^ outQ[0];
    assign invD[1] = (enable & ~outQ[0]) ^ outQ[1];
    assign invD[2] = (enable & ~outQ[0] & ~outQ[1]) ^ outQ[2];
    assign invD[3] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2]) ^ outQ[3];
    assign invD[4] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3]) ^ outQ[4];
    assign invD[5] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4]) ^ outQ[5];
    assign invD[6] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5]) ^ outQ[6];
    assign invD[7] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6]) ^ outQ[7];
    
    assign temp[0] =  ( (~LD & invD[0]) | (LD & inD[0]) );
    assign temp[1] =  ( (~LD & invD[1]) | (LD & inD[1]) );
    assign temp[2] =  ( (~LD & invD[2]) | (LD & inD[2]) );
    assign temp[3] =  ( (~LD & invD[3]) | (LD & inD[3]) );
    assign temp[4] =  ( (~LD & invD[4]) | (LD & inD[4]) );
    assign temp[5] =  ( (~LD & invD[5]) | (LD & inD[5]) );
    assign temp[6] =  ( (~LD & invD[6]) | (LD & inD[6]) );
    assign temp[7] =  ( (~LD & invD[7]) | (LD & inD[7]) );

    
FDRE #(.INIT(1'b0) ) bit1 (.C(clk), .R(reset), .CE(enable & (~TC | LD)), .D(temp[0]), .Q(outQ[0]));
FDRE #(.INIT(1'b0) ) bit2 (.C(clk), .R(reset), .CE(enable & (~TC | LD)), .D(temp[1]), .Q(outQ[1]));
FDRE #(.INIT(1'b0) ) bit3 (.C(clk), .R(reset), .CE(enable & (~TC | LD)), .D(temp[2]), .Q(outQ[2]));
FDRE #(.INIT(1'b0) ) bit4 (.C(clk), .R(reset), .CE(enable & (~TC | LD)), .D(temp[3]), .Q(outQ[3]));
FDRE #(.INIT(1'b0) ) bit5 (.C(clk), .R(reset), .CE(enable & (~TC | LD)), .D(temp[4]), .Q(outQ[4]));
FDRE #(.INIT(1'b0) ) bit6 (.C(clk), .R(reset), .CE(enable & (~TC | LD)), .D(temp[5]), .Q(outQ[5]));
FDRE #(.INIT(1'b0) ) bit7 (.C(clk), .R(reset), .CE(enable & (~TC | LD)), .D(temp[6]), .Q(outQ[6]));
FDRE #(.INIT(1'b0) ) bit8 (.C(clk), .R(reset), .CE(enable & (~TC | LD)), .D(temp[7]), .Q(outQ[7]));

assign TC = ( ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7]);   

endmodule