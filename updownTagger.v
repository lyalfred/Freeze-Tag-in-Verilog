`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2017 04:25:13 PM
// Design Name: 
// Module Name: updownTagger
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


module updownTagger(
    input clk, twoSec, top, bottom, up, down,
    output countUp, countDown, upDownLD, activeGreen
    );
    wire [14:0] con;
    wire [2:0] inD;
    wire [2:0] outQ;
    
    assign con[0] = 1'b0;
    assign con[1] = ~twoSec & outQ[0];              //used to transition to Q0
    assign con[2] = twoSec & outQ[0];               //used to transition to Q1
    assign con[3] = ~bottom & ~up & outQ[1];        //used to transition to Q1
    assign con[4] = bottom & down & outQ[1];                  //used to transition to Q1   
    assign con[5] = bottom & ~down & outQ[1];                 //used to transition to Q2
    assign con[6] = ~bottom & up & outQ[1];                    //used to transition to Q2
    assign con[7] = bottom & up & outQ[1];                     //used to transition to Q2
    assign con[8] = ~top & ~down & outQ[2];                    //used to transition to Q2
    assign con[9] = top & up & outQ[2];                        //used to transition to Q2
    assign con[10] = top & ~up & outQ[2];                      //used to transition to Q1
    assign con[11] = ~top & down & outQ[2];                    //used to transition to Q1
    assign con[12] = top & down & outQ[2];                     //used to transition to Q1
    assign con[13] = up & down & outQ[1];
    assign con[14] = up & down & outQ[2];
    
    assign inD[0] = con[1];
    assign inD[1] = con[2] | con[3] | con[4] | con[10] | con[11] | con[12];
    assign inD[2] = con[5] | con[6] | con[7] | con[8] | con[9];
    assign activeGreen = ~outQ[0];
    assign upDownLD = outQ[0];
    assign countUp = outQ[2] & ~con[9] & ~con[14];
    assign countDown = outQ[1] & ~con[4] & ~con[13];
   
    FDRE #(.INIT(1'b1)) ff_instance_0 (.C(clk), .CE(1'b1), .D(inD[0]), .Q(outQ[0]));
    FDRE #(.INIT(1'b0)) ff_instance_1 (.C(clk), .CE(1'b1), .D(inD[1]), .Q(outQ[1]));
    FDRE #(.INIT(1'b0)) ff_instance_2 (.C(clk), .CE(1'b1), .D(inD[2]), .Q(outQ[2]));


    
    
    
    
endmodule
