`include "counters.v"
`include "three_st.v"
`timescale 1ns/1ps



module rx_tb();
reg clk, in, rst, rx;
reg [7:0] dur;
integer i;

wire pulse, out;

//counter10 DUT (clk, pulse, rst);
bit_clk DUT1 (clk, out, rx);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT1);

      $monitor ( "time: %2g   clk: %b in: %b out: %b dur: %b, rx: %b" , $time, clk, out, pulse, rx, rst);
      rst = 1'b0;
      dur = 8'b00001010;
      clk = 1'b1;
      rx = 1'b1;
      #10 in = 0;
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
