//`include "counters.v"
`timescale 1ns/1ps

module counter_8_tb();
reg clk;

wire pulse;
reg rst;

integer i;

reg [7:0] load;

counter_8 DUT (clk, pulse, rst, load);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b  pulse: %b rst: %b" , $time, clk, pulse, rst);
      clk = 1;
      load = 4;
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 0;//
      for (i=0; i<100;i=i+1)
        #10 rst = 0;//
       $finish;
    end


   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end

endmodule
