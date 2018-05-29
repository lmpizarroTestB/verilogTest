`include "counters.v"
`include "three_st.v"
`timescale 1ns/1ps

module ABC (clk, in, out);
input clk, in;
output out;

reg [3:0] counter = 0;
reg cd = 0; 

reg outl = 1'b0;
reg outp = 1'b0;

always @(negedge in)
 begin
   outl <= 1'b1;
 end


always @(posedge clk)
begin
 if (outl == 1'b1)
 begin
   counter <= counter + 1;
   if (counter == 4'b1001) 
   begin
    outl <= 1'b0;
    counter <= 4'b0000;
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

assign out = outp;
endmodule

/*---------------------------------------------
 test
---------------------------------------------*/
module tb_te();
reg clk, rx, in;
integer i;


wire out;

//counter10 DUT (clk, pulse, rst);
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
      for (i =0; i < 400; i = i + 1)
         #10 in = 0;
      $finish;
    end

   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
