`timescale 1ns/1ps

module tb_time_tags();
  reg clk;
  reg logic_pulse;
  reg reset;

  wire [45:0] tag_time;
  wire new_tag;

  time_tags DUT (.logic_pulse(logic_pulse), .clk(clk), .reset(reset), .tag_time(tag_time), .new_tag(new_tag));

  initial begin
    $dumpfile("simple.vcd");
    $monitor ("%d %d %d %d %d", logic_pulse, clk, reset, tag_time, new_tag);
    $dumpvars(0,  DUT);
    #100 reset=0; logic_pulse = 0;
    #100 reset=0;
    #100 reset=1;
    #100 reset=1;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0; logic_pulse = 1;
    #100 reset=0; logic_pulse = 1;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=1;
    #100 reset=1;
    #100 reset=1;
    #100 reset=1;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;
    #100 reset=0;


  $finish;
  end
  always begin
       clk = 1'b0;
       forever #100 clk = ~clk; // Toggle clock every 5 ticks
  end


endmodule
