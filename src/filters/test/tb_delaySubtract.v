`timescale 1ns/1ps

module tb_delaySubstract();
 
  reg signed [15:0] x;
  wire signed  [15:0] out;
  reg clk, sclk; 
  reg clr;
  integer i;
  reg [7:0] delay;

  delaySubstract  #(.Nbits(16), .ADDR_WIDTH(8)) DUT (.X(x), .Y(out), .clk(clk), .sclk(sclk), .clr(clr), .delay(delay));

  
  initial begin
    $dumpfile("simple.vcd");
    //$monitor ("time %g   x %d   y %d    clr %b %d",$time, x, out,  clr,i);
    $dumpvars(0, DUT);
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
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x= 200; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
    #200 x=0; $display("%d   %d ",x, out, delay);
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
