`include "counters.v"
`include "three_st.v"
`timescale 1ns/1ps

module ABC (clk, in, out);
input clk, in;
output out;

reg [3:0] cnt10 = 4'b0000;
reg [4:0] cntbit = 4'b0000;
reg [7:0] cntFrame = 8'b00000000;
reg cd = 0; 

reg outl = 1'b0;
reg outp = 1'b0;
reg ffbb = 1'b0;
reg bitPulse = 1'b0;


always @(negedge (in|ffbb))
 begin
   outl <= 1'b1;
 end

always @(posedge clk)
begin
 if (outl == 1'b1)
 begin
   cnt10 <= cnt10 + 1;
   if (cnt10 == 4'b1001) 
   begin
    outl <= 1'b0;
    cnt10 <= 4'b0000;
    ffbb <= 1'b1;
   end
 end
 if (cd==1'b1) begin
  outp <= 1'b0;
  cd <= 1'b0;
 end
end

always @(negedge outl)
begin
  outp <= 1'b1 & ~in;
  cd <= 1'b1;
end

always @(posedge clk&ffbb)
begin
  cntFrame = cntFrame + 1;
  if (cntFrame == 8'b11010011) begin 
	  cntFrame <= 8'b00000000;
	  ffbb = 1'b0;
  end
end


always @(posedge (clk&ffbb))
begin
  cntbit = cntbit + 1;
  if (cntbit == 5'b10100) begin 
	  cntbit <= 5'b00000;
	  bitPulse <= 1'b1;
  end
  else bitPulse <= 1'b0;
end


assign out = outp;
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
      for (i =0; i < 40; i = i + 1)
         #10 in = 0;
      #10 in = 0; rx=1;
      for (i =0; i < 40; i = i + 1)
         #10 in = 0;
      $finish;
    end

   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
