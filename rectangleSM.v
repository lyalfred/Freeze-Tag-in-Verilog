`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 11:31:45 PM
// Design Name: 
// Module Name: rectangleSM
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


module rectangleSM(
    input hit, allHit, timeOut,
    input clk, btnC,
    output startState,loadTime,
    output returnHit, resetState,
    output flash, go, activeRed
    );
    wire [9:0] con;
    wire [3:0] inD;
    wire [3:0] outQ;
    assign con[0] = ~btnC & outQ[0];            //used to transition to Q0
    assign con[1] = btnC & outQ[0];             //used to transition to Q1    
    assign con[2] = ~hit & outQ[1];             //used to transition to Q1                
    assign con[3] = hit & outQ[1] & ~timeOut;              //used to transition to Q2
    assign con[4] = ~allHit & outQ[2] & ~timeOut;          //used to transition to Q2
    assign con[5] = allHit & outQ[2];           //used to transition to Q3
    assign con[6] = ~btnC & outQ[3];            //used to transition to Q3
    assign con[7] = (btnC & outQ[3])|timeOut;   //used to transition to Q1
    assign con[8] = timeOut & outQ[2];          //used to transition to Q1
    assign con[9] = timeOut & outQ[1];
    assign inD[0] = con[0];
    assign inD[1] = con[1] | con[2] | con[7] | con[8];
    assign inD[2] = con[3] | con[4];
    assign inD[3] = con[5] | con[6];
    
    FDRE #(.INIT(1'b1)) ff_instance_0 (.C(clk), .CE(1'b1), .D(inD[0]), .Q(outQ[0]));
    FDRE #(.INIT(1'b0)) ff_instance_1 (.C(clk), .CE(1'b1), .D(inD[1]), .Q(outQ[1]));
    FDRE #(.INIT(1'b0)) ff_instance_2 (.C(clk), .CE(1'b1), .D(inD[2]), .Q(outQ[2]));
    FDRE #(.INIT(1'b0)) ff_instance_3 (.C(clk), .CE(1'b1), .D(inD[3]), .Q(outQ[3]));
    
    assign loadTime = con[8] | con[9];
    assign startState = outQ[0];
    assign resetState = con[7] | timeOut;
    assign returnHit = outQ[2] | outQ[3] ;
    assign go = outQ[1];
    assign flash = outQ[2] | outQ[3];
    assign activeRed = outQ[1];

endmodule
