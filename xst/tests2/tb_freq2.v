`include "counters.v"
`include "three_st.v"
`timescale 1ns/1ps

module tb_freq_div_2();

reg clk, in, rst, rx;
reg [7:0] dur;
integer i;

wire pulse, out;

freq_div_2 DUT (clk, out);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b in: %b " , $time, clk, out);
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
