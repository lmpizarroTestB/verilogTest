`include "counters.v"
`include "uart.v"
`timescale 1ns/1ps

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
