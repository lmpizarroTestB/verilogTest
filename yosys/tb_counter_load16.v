`include "counter_y16.v"
`timescale 1ns/1ps

module counter_load16_tb();
reg clk, load, en;

wire pulse;
reg rst;

integer i;

reg [15:0] data;

counter_y16 DUT (clk, rst, en, data, pulse);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b  pulse: %b rst: %b" , $time, clk, pulse, rst);
      clk = 1;
      data = 10;
      en = 0;
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 0; load =1; //
      #10 rst = 0;load =1; //
      #10 rst = 0;load =1; //
      #10 rst = 0;load =0; //
      #10 rst = 0;//
      #10 rst = 0; en = 1;//
      for (i=0; i<100;i=i+1)
        #10 rst = 0;//
       $finish;
    end


   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end

endmodule
