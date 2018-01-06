`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2017 11:39:17 PM
// Design Name: 
// Module Name: count14D
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


module count14D(
    input clk, enable, LD, reset,
    input [15:0] sw,
    output [13:0] outQ,
    output TC
);  
    wire internalReset;
    wire [13:0] inD;
    wire [13:0] invD;
    wire [13:0] temp;
    assign inD = ( 10'd16 + sw[15:7]*10'd32 );
    assign invD[0] = enable ^ outQ[0];
    assign invD[1] = (enable & ~outQ[0]) ^ outQ[1];
    assign invD[2] = (enable & ~outQ[0] & ~outQ[1]) ^ outQ[2];
    assign invD[3] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2]) ^ outQ[3];
    assign invD[4] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3]) ^ outQ[4];
    assign invD[5] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4]) ^ outQ[5];
    assign invD[6] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5]) ^ outQ[6];
    assign invD[7] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6]) ^ outQ[7];
    assign invD[8] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7]) ^ outQ[8];
    assign invD[9] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7] & ~outQ[8]) ^ outQ[9];
    assign invD[10] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7] & ~outQ[8] & ~outQ[9]) ^ outQ[10];
    assign invD[11] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7] & ~outQ[8] & ~outQ[9] & ~outQ[10]) ^ outQ[11];
    assign invD[12] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7] & ~outQ[8] & ~outQ[9] & ~outQ[10] & ~outQ[11]) ^ outQ[12];
    assign invD[13] = (enable & ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7] & ~outQ[8] & ~outQ[9] & ~outQ[10] & ~outQ[11] & ~outQ[12]) ^ outQ[13];

    assign temp[0] =  ( (~LD & invD[0]) | (LD & inD[0]) );
    assign temp[1] =  ( (~LD & invD[1]) | (LD & inD[1]) );
    assign temp[2] =  ( (~LD & invD[2]) | (LD & inD[2]) );
    assign temp[3] =  ( (~LD & invD[3]) | (LD & inD[3]) );
    assign temp[4] =  ( (~LD & invD[4]) | (LD & inD[4]) );
    assign temp[5] =  ( (~LD & invD[5]) | (LD & inD[5]) );
    assign temp[6] =  ( (~LD & invD[6]) | (LD & inD[6]) );
    assign temp[7] =  ( (~LD & invD[7]) | (LD & inD[7]) );
    assign temp[8] =  ( (~LD & invD[8]) | (LD & inD[8]) );
    assign temp[9] =  ( (~LD & invD[9]) | (LD & inD[9]) );
    assign temp[10] =  ( (~LD & invD[10]) | (LD & inD[10]) );
    assign temp[11] =  ( (~LD & invD[11]) | (LD & inD[11]) );
    assign temp[12] =  ( (~LD & invD[12]) | (LD & inD[12]) );
    assign temp[13] =  ( (~LD & invD[13]) | (LD & inD[13]) );

    FDRE #(.INIT(1'b0) ) bit1 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[0]), .Q(outQ[0]));
    FDRE #(.INIT(1'b0) ) bit2 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[1]), .Q(outQ[1]));
    FDRE #(.INIT(1'b0) ) bit3 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[2]), .Q(outQ[2]));
    FDRE #(.INIT(1'b0) ) bit4 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[3]), .Q(outQ[3]));
    FDRE #(.INIT(1'b0) ) bit5 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[4]), .Q(outQ[4]));
    FDRE #(.INIT(1'b0) ) bit6 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[6]), .Q(outQ[6]));
    FDRE #(.INIT(1'b0) ) bit8 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[7]), .Q(outQ[7]));
    FDRE #(.INIT(1'b0) ) bit9 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[8]), .Q(outQ[8]));
    FDRE #(.INIT(1'b0) ) bit10 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[9]), .Q(outQ[9]));
    FDRE #(.INIT(1'b0) ) bit11 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[10]), .Q(outQ[10]));
    FDRE #(.INIT(1'b0) ) bit12 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[11]), .Q(outQ[11]));
    FDRE #(.INIT(1'b0) ) bit13 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[12]), .Q(outQ[12]));
    FDRE #(.INIT(1'b0) ) bit14 (.C(clk), .R(1'b0), .CE((enable | LD)), .D(temp[13]), .Q(outQ[13]));
    
//    assign internalReset = ( ~outQ[0] & ~outQ[1] & ~outQ[2] & ~outQ[3] & ~outQ[4] & ~outQ[5] & ~outQ[6] & ~outQ[7] &
//         ~outQ[8] & ~outQ[9] & ~outQ[10] & ~outQ[11] & ~outQ[12] & ~outQ[13]);
    assign TC = (~outQ[6] & ~outQ[7] & ~outQ[8] & ~outQ[9] & ~outQ[10] & ~outQ[11] & ~outQ[12] & ~outQ[13]);
    
    //( temp[0] & ~temp[1] & ~temp[2] & ~temp[3] & ~temp[4] & ~temp[5] & ~temp[6] & ~temp[7] &
    // ~temp[8] & ~temp[9] & ~temp[10] & ~temp[11] & ~temp[12] & ~temp[13]);   

endmodule