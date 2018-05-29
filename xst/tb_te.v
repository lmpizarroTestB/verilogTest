`include "counters.v"
`include "three_st.v"
`timescale 1ns/1ps

module ABC (clk, rx, out);
 input clk, rx;
 output out;

 reg [3:0] cnt10 = 4'b0000;
 reg [4:0] cntbit = 5'b00000;
 reg [7:0] cntFrame = 8'b00000000;

 reg delayBitStart = 1'b0;
 reg centerStartBitPulse = 1'b0;
 reg validFrame = 1'b0;
 reg clkBit = 1'b0;
 reg cd = 0; 

 always @(negedge (rx|validFrame))
 begin
  delayBitStart <= 1'b1;
 end

 always @(negedge delayBitStart)
 begin
   centerStartBitPulse = 1'b1 & ~rx;
   cd = 1'b1;
   cntbit = 5'b00000;
 end

 always @(posedge clk)
 begin
  if (delayBitStart == 1'b1)
  begin
    cnt10 <= cnt10 + 1;
    if (cnt10 == 4'b1001) 
    begin
     delayBitStart <= 1'b0;
     cnt10 <= 4'b0000;
    end
  end
 end

 always @(posedge clk)
 begin
  if (cd==1'b1) begin
   centerStartBitPulse = 1'b0;
   cd = 1'b0;
  end
 end

 always @(negedge centerStartBitPulse)
 begin
   validFrame <= 1'b1;
 end


 // generate clkBit
 always @(posedge (clk))
 begin
  if ( validFrame) begin
   cntbit = cntbit + 5'b00001;
   if (cntbit == 5'b10100) 
   begin 
    cntbit <= 5'b00000;
    clkBit <= 1'b1;
   end
   else clkBit <= 1'b0;
  end
 end

 // generate  frame valid
 always @(posedge (clk))
 begin
  if ( validFrame) begin
   cntFrame = cntFrame + 1;
   if (cntFrame == 8'b11010011) 
   begin 
    cntFrame <= 8'b00000000;
    validFrame = 1'b0;
   end
  end
 end

 assign out = centerStartBitPulse;

endmodule

/*---------------------------------------------
 test
---------------------------------------------*/
module tb_te();
reg clk, rx, in;
integer i;


wire out;

ABC DUT1 (clk, rx, out);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT1);

      $monitor ( "time: %2g   clk: %b rx: %b out: %b " , $time, clk, rx, out);
      clk = 1'b1;
      rx = 1'b1;
      #10 in = 1;
      #10 in = 1;
      #10 in = 1;
      #10 in = 1;
      #10 in = 0;
      #10 in = 0; rx =0;
      for (i =0; i < 40; i = i + 1)
         #10 in = 0;
      #10 in = 0; rx=1;
      for (i =0; i < 500; i = i + 1)
         #10 in = 0;
      #10 in = 0; rx=0;
      for (i =0; i < 10; i = i + 1)
         #10 in = 0;
      #10 in = 0; rx=1;
      for (i =0; i < 100; i = i + 1)
         #10 in = 0;
      $finish;
    end

   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
