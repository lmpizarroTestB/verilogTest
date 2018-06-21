`timescale 1ns/1ps

module tb_trapCtrl();
 
  reg signed [15:0] x;
  wire signed [31:0] out;

  reg signed [7:0] m1;
  reg signed [7:0] m2;

  reg signed [7:0] delayK;
  reg signed [7:0] delayL;
  reg clk, sclk; 
  reg clr;

  reg [15:0] data;
  reg c, w;

  integer i;
  reg delay;

  trapCtrl  #(.Nbits(16)) DUT (.data(data), .c(c), .w(w), .X(x), .Y(out),  .clk(clk), .sclk(sclk), .clr(clr));

  
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   x %d   y %d    clr %b %d",$time, x, out,  clr,i);
    $dumpvars(0, DUT);
    m1 = 3;
    m2 = 5;
    delayK = 6;
    delayL = 5;
    #200 x=13'd0; clr=0;
    #200 x=13'd0; clr=1;
    #200 x=13'd0; clr=1;
    #200 x=13'd0; clr=1;
    #200 x=13'd0; clr=0;
    #200 x=13'd0; clr=0;
    #200 x=13'd0; clr=0;
    #200 x=13'd0; clr=0; delay = 4;
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x= 0; $display("%d   %d ",x, out);
    #200 x= 1000; $display("%d   %d ",x, out, delay);
    for (i=0; i<200; i=i+1)
        #200 x= x/1.01; 


    $finish;
  end

  always begin
       clk = 1'b0;
       forever #100 clk = ~clk; // Toggle clock every 5 ticks
  end

  always begin
    sclk = 1'b0;
    forever #100 sclk=~sclk;
  end
endmodule
