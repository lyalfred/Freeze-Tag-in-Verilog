`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2017 07:46:23 PM
// Design Name: 
// Module Name: topMod
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


module topMod(
    input btnU, btnL, btnC, btnR, btnD,
    input clkin,
    input [15:0] sw,
    output [3:0] an,
    output [6:0] seg,
    output [15:0] led,
    output Hsync, Vsync,
    output [3:0]vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen
    );
    wire clk, digsel, frame, eightSec, twoSec, edgeOut; 
    wire [7:0] doneCount;
    wire topHit, bottomHit, cntUp, cntDown, cntRight, cntLeft, upDownLD, leftRightLD;
    wire activeGreen, greenSquareOut, greenTagger;
    wire [7:0] redRect,activeRed,resetState, startState,loadTime;
    wire redRectPass;
    wire activeRegion, goodWall, topWall, bottomWall, leftWall, rightWall;
    wire [9:0] hOutQ, vOutQ;
    wire [7:0] outOfAR, doneC;
    wire [7:0] rnd, rnd1, rnd2, rnd3, rnd4, rnd5, rnd6, rnd7;
    wire allhit, anyHit, timeOut; 
    wire [3:0] scoreCounterEnable;
    wire [13:0] tempInTime;
    wire [13:0] outTime;
    wire [7:0] hit, returnHit;
    wire [15:0] selectorIn;
    wire [3:0] ringOut;
    wire [3:0] selOut;
    wire btncFilter;
    FDRE #(.INIT(1'b0) ) syncFlsh (.C(clk), .R(1'b0), .CE(1'b1), .D(eightSec^syncFlash), .Q(syncFlash));
    //Counter Modules
    lab7_clks not_so_slow (.clkin(clkin), .greset(sw[0]), .clk(clk), .digsel(digsel));
    count8 twoSecCount (.clk(clk), .enable(frame), .reset(1'b0), .twoSec(twoSec));      //ued to generate two second signal
    count4 eighthSecCount (.clk(clk), .enable(frame), .eightSec(eightSec));             //used to generate eighth second signal
    edgeDetector ed_btnC (.clk(clk), .btnC(btnC), .edgeOut(edgeOut)); 
    
    //VGA Module
    vgaControlMod monitor (.clk(clk), .enable(1'b1), .up(1'b1), .LD(1'b0), .Hsync(Hsync),
     .activeRegion(activeRegion), .Vsync(Vsync), .hOutQ(hOutQ), .vOutQ(vOutQ), .goodWall(goodWall),
     .topWall(topWall), .bottomWall(bottomWall), .leftWall(leftWall), .rightWall(rightWall), .frame(frame) );
    
    
    //Tagger Object
    taggerMod greenSq ( .hOutQ (hOutQ), .vOutQ(vOutQ), .frame(frame), .syncFlash(syncFlash), .activeGreen(activeGreen),
     .clk(clk), .cntUp(cntUp), .cntDown(cntDown), .cntRight(cntRight), .cntLeft(cntLeft), .upDownLD(upDownLD),
      .leftRightLD(leftRightLD), .greenSquare(greenSquareOut), .topHit(topHit), .bottomHit(bottomHit), .leftHit(leftHit), .rightHit(rightHit) );
    //State Machines for Tagger Movement
    updownTagger upDownSM (.clk(clk), .twoSec(twoSec), .top(topHit), .bottom(bottomHit), .up(btnU), .down(btnD),
     .countUp(cntUp), .countDown(cntDown), .upDownLD(upDownLD), .activeGreen(activeGreen) );
    updownTagger leftRightSM (.clk(clk), .twoSec(twoSec), .top(rightHit), .bottom(leftHit), .up(btnR), .down(btnL),
     .countUp(cntRight), .countDown(cntLeft), .upDownLD(leftRightLD) );

    //Rectangle Objects
    lfsr rect1Random (.clk(clk), .frame(frame), .rnd(rnd));
    assign rnd1 = {1'b1, rnd[1], 1'b0, rnd[4], 1'b1, rnd[6], 1'b0, rnd[2]};
    assign rnd2 = {1'b0, rnd[1], 1'b0, rnd[3], 1'b0, rnd[5], 1'b0, rnd[7]};
    assign rnd3 = {1'b0, rnd[2], 1'b0, rnd[4], 1'b0, rnd[6], 1'b0, rnd[3]};
    assign rnd4 = {1'b1, rnd[1], 1'b1, rnd[3], 1'b1, rnd[5], 1'b1, rnd[7]};
    assign rnd5 = {1'b1, rnd[2], 1'b1, rnd[4], 1'b1, rnd[6], 1'b1, rnd[6]};
    assign rnd6 = {1'b0, rnd[1], 1'b1, rnd[3], 1'b0, rnd[5], 1'b1, rnd[7]};
    assign rnd7 = {1'b0, rnd[2], 1'b1, rnd[4], 1'b0, rnd[6], 1'b1, rnd[5]};
    assign rnd8 = {1'b1, rnd[2], 1'b0, rnd[4], 1'b1, rnd[3], 1'b0, rnd[6]}; // | resetState[0] | startState[0] | loadTime[0]
    count8D count1 (.clk(clk), .enable(frame), .reset(1'b0), .LD(outOfAR[0]), .inD(rnd), .TC(doneC[0]) );
    count8D count2 (.clk(clk), .enable(frame), .reset(1'b0), .LD(outOfAR[1]), .inD(rnd1), .TC(doneC[1]) );
    count8D count3 (.clk(clk), .enable(frame), .reset(1'b0), .LD(outOfAR[2]), .inD(rnd2), .TC(doneC[2]) );
    count8D count4 (.clk(clk), .enable(frame), .reset(1'b0), .LD(outOfAR[3]), .inD(rnd3), .TC(doneC[3]) );
    count8D count5 (.clk(clk), .enable(frame), .reset(1'b0), .LD(outOfAR[4]), .inD(rnd4), .TC(doneC[4]) );
    count8D count6 (.clk(clk), .enable(frame), .reset(1'b0), .LD(outOfAR[5]), .inD(rnd5), .TC(doneC[5]) );
    count8D count7 (.clk(clk), .enable(frame), .reset(1'b0), .LD(outOfAR[6]), .inD(rnd6), .TC(doneC[6]) );
    count8D count8 (.clk(clk), .enable(frame), .reset(1'b0), .LD(outOfAR[7]), .inD(rnd7), .TC(doneC[7]) );
    redRectangle rect1 (.clk(clk), .btnC(edgeOut), .frame(frame), .timeOut(timeOut), .syncFlash(syncFlash), .hit(hit[0]), .allHit(allHit), .returnHit(returnHit[0]), .doneCount(doneC[0]), .sw(sw), .hOutQ(hOutQ), .vOutQ(vOutQ), .horizontalPosition(10'd78), .redRect(redRect[0]), .outOfAR(outOfAR[0]),  .activeRed(activeRed[0]), .resetState(resetState[0]), .startState(startState[0]),.loadTime(loadTime[0]) );
    redRectangle rect2 (.clk(clk), .btnC(edgeOut), .frame(frame), .timeOut(timeOut), .syncFlash(syncFlash), .hit(hit[1]), .allHit(allHit), .returnHit(returnHit[1]), .doneCount(doneC[1]), .sw(sw), .hOutQ(hOutQ), .vOutQ(vOutQ), .horizontalPosition(10'd146), .redRect(redRect[1]), .outOfAR(outOfAR[1]), .activeRed(activeRed[1]), .resetState(resetState[1]), .startState(startState[1]),.loadTime(loadTime[1])  );
    redRectangle rect3 (.clk(clk), .btnC(edgeOut), .frame(frame), .timeOut(timeOut), .syncFlash(syncFlash), .hit(hit[2]), .allHit(allHit), .returnHit(returnHit[2]), .doneCount(doneC[2]), .sw(sw), .hOutQ(hOutQ), .vOutQ(vOutQ), .horizontalPosition(10'd214), .redRect(redRect[2]), .outOfAR(outOfAR[2]), .activeRed(activeRed[2]), .resetState(resetState[2]), .startState(startState[2]),.loadTime(loadTime[2])  );
    redRectangle rect4 (.clk(clk), .btnC(edgeOut), .frame(frame), .timeOut(timeOut), .syncFlash(syncFlash), .hit(hit[3]), .allHit(allHit), .returnHit(returnHit[3]), .doneCount(doneC[3]), .sw(sw), .hOutQ(hOutQ), .vOutQ(vOutQ), .horizontalPosition(10'd282), .redRect(redRect[3]), .outOfAR(outOfAR[3]), .activeRed(activeRed[3]), .resetState(resetState[3]), .startState(startState[3]),.loadTime(loadTime[3])  );
    redRectangle rect5 (.clk(clk), .btnC(edgeOut), .frame(frame), .timeOut(timeOut), .syncFlash(syncFlash), .hit(hit[4]), .allHit(allHit), .returnHit(returnHit[4]), .doneCount(doneC[4]), .sw(sw), .hOutQ(hOutQ), .vOutQ(vOutQ), .horizontalPosition(10'd350), .redRect(redRect[4]), .outOfAR(outOfAR[4]), .activeRed(activeRed[4]), .resetState(resetState[4]), .startState(startState[4]),.loadTime(loadTime[4])  );
    redRectangle rect6 (.clk(clk), .btnC(edgeOut), .frame(frame), .timeOut(timeOut), .syncFlash(syncFlash), .hit(hit[5]), .allHit(allHit), .returnHit(returnHit[5]), .doneCount(doneC[5]), .sw(sw), .hOutQ(hOutQ), .vOutQ(vOutQ), .horizontalPosition(10'd418), .redRect(redRect[5]), .outOfAR(outOfAR[5]), .activeRed(activeRed[5]), .resetState(resetState[5]), .startState(startState[5]),.loadTime(loadTime[5])  );
    redRectangle rect7 (.clk(clk), .btnC(edgeOut), .frame(frame), .timeOut(timeOut), .syncFlash(syncFlash), .hit(hit[6]), .allHit(allHit), .returnHit(returnHit[6]), .doneCount(doneC[6]), .sw(sw), .hOutQ(hOutQ), .vOutQ(vOutQ), .horizontalPosition(10'd486), .redRect(redRect[6]), .outOfAR(outOfAR[6]), .activeRed(activeRed[6]), .resetState(resetState[6]), .startState(startState[6]),.loadTime(loadTime[6])  );
    redRectangle rect8 (.clk(clk), .btnC(edgeOut), .frame(frame), .timeOut(timeOut), .syncFlash(syncFlash), .hit(hit[7]), .allHit(allHit), .returnHit(returnHit[7]), .doneCount(doneC[7]), .sw(sw), .hOutQ(hOutQ), .vOutQ(vOutQ), .horizontalPosition(10'd554), .redRect(redRect[7]), .outOfAR(outOfAR[7]), .activeRed(activeRed[7]), .resetState(resetState[7]), .startState(startState[7]),.loadTime(loadTime[7]) );
    assign btncFilter = {8{btnC}} & resetState & startState & loadTime;
    //all the hit logic you could possibly want
    assign hit[0] = {redRect[0] & greenTagger};     //used to detect a hit in rect 1
    assign hit[1] = {redRect[1] & greenTagger};     //used to detect a hit in rect 2
    assign hit[2] = {redRect[2] & greenTagger};     //used to detect a hit in rect 3
    assign hit[3] = {redRect[3] & greenTagger};     //used to detect a hit in rect 4
    assign hit[4] = {redRect[4] & greenTagger};     //used to detect a hit in rect 5
    assign hit[5] = {redRect[5] & greenTagger};     //used to detect a hit in rect 6
    assign hit[6] = {redRect[6] & greenTagger};     //used to detect a hit in rect 7
    assign hit[7] = {redRect[7] & greenTagger};     //used to detect a hit in rect 8
    assign scoreCounterEnable = { {3'b000, returnHit[0]} + {3'b000, returnHit[1]} + {3'b000, returnHit[2]} + {3'b000, returnHit[3]} + {3'b000, returnHit[4]} +
     {3'b000, returnHit[5]} + {3'b000, returnHit[6]} + {3'b000, returnHit[7]} };
    assign allHit = {returnHit[0]&returnHit[1]&returnHit[2]&returnHit[3]&returnHit[4]&returnHit[5]&returnHit[6]&returnHit[7]};
    assign anyHit = {returnHit[0]|returnHit[1]|returnHit[2]|returnHit[3]|returnHit[4]|returnHit[5]|returnHit[6]|returnHit[7]};
    //VGA Colors
    assign redRectPass = (activeRegion & redRect[0])|(activeRegion & redRect[1])|(activeRegion & redRect[2])|(activeRegion & redRect[3])
     |(activeRegion & redRect[4])|(activeRegion & redRect[5])|(activeRegion & redRect[6])|(activeRegion & redRect[7]);  
    assign vgaRed = {4{redRectPass | (activeRegion & goodWall& allHit & syncFlash) }};
    assign greenTagger = activeRegion & greenSquareOut;
    assign vgaGreen = {4{greenTagger | (activeRegion & goodWall & allHit & syncFlash) }};
    assign vgaBlue = {4{(activeRegion & goodWall & ~allHit) | 
    (activeRegion & goodWall & allHit & syncFlash)}};
    
    count14D countDown (.clk(clk), .enable(frame & (anyHit & scoreCounterEnable < 4'd8)), .LD(startState | resetState), .sw(sw), .outQ(outTime), .TC(timeOut)  );

    //assign tempInTime = ( 10'd16 + sw[15:7]*10'd32 );
    //assign selectorIn = {scoreCounterEnable, 1'b0,1'b0,1'b0,1'b0, ((~anyHit & tempInTime[13:10])|(anyHit & outTime[13:10])), ((~anyHit & tempInTime[9:6])|(anyHit & outTime[9:6]))};
    assign selectorIn = {scoreCounterEnable, 1'b0,1'b0,1'b0,1'b0, outTime[13:10],outTime[9:6]};

    ringCounter ring (.clk(clk), .digsel(digsel), .sel(ringOut));
    selector select (.sel(ringOut), .N(selectorIn), .H(selOut));
    hex7seg display (.n(selOut), .enable(1'b1), .seg(seg));
    
    assign led[15:4] = sw[15:4];
    assign an[0] = ~ringOut[0];
    assign an[1] = ~ringOut[1];
    assign an[2] = 1'b1;
    assign an[3] = ~ringOut[3];
    
    
endmodule
