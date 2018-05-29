`include "one_shot.v"
`timescale 1ns/1ps

module one_shot_tb();
reg clk, in, rst, rx;
reg [7:0] dur;

wire out;

one_shot DUT (clk, in, out, dur, rx);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b in: %b out: %b dur: %b, rx: %b" , $time, clk, in, out, dur, rx);
      rst = 1'b0;
      dur = 8'b00001010;
      clk = 1'b1;
      rx = 1'b1;
      #10 in = 0;
      #10 in = 1;
      #10 in = 0;
      #10 in = 0; rx =0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 1;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0; 
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0; rx=1;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      #10 in = 0;
      $finish;
    end

   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
