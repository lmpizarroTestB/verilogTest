`include "counters.v"
`include "three_st.v"
`timescale 1ns/1ps

module tb_divider();

reg clk, in, rst, rx;
reg [7:0] dur;
integer i;

reg [7:0] tmp;

wire pulse, out;

dividerAsPWM DUT (clk, out, dur);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);
      tmp = (1<<8) - 1;
      $monitor ( "time: %2g   clk: %b in: %b %b" , $time, clk, out, tmp );
      rst = 1'b0;
      dur = 8'b11111110;
      clk = 1'b1;
      rx = 1'b1;
      #10 in = 0;
      #10 in = 1;
      #10 in = 0;
      #10 in = 0; rx =0;
      #10 in = 0; rx=1;
      for (i =0; i < 1500; i = i + 1)
         #10 in = 0;
      $finish;
    end

   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
