`include "counters.v"
`timescale 1ns/1ps

module tb_counter20();
reg clk, level;

wire pulse;
reg rst;
integer i;

counter20 DUT (clk, pulse, rst);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b  pulse: %b rst: %b" , $time, clk, pulse, rst);
      clk = 1;
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 0;//
      #10 rst = 0;//
      #10 rst = 0;//
      #10 rst = 0;//
      #10 rst = 0;//
      #10 rst = 0;//
      #10 rst = 0;//
      for (i = 0; i <100; i = i+1)
        #10 rst = 0;//
       $finish;
    end


   always begin
     #5 clk = ~clk; // Toggle clock every 5 ticks
   end

endmodule
