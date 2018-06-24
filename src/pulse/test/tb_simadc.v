`timescale 1ns/1ps

module tb_simadc();
 
  wire signed [13:0] x;
  reg clk; 
  reg [3:0] sel;
  integer i;
  reg [13:0] val;
  reg load;

  genPulse ZC(.Y(x), .clk(clk), .sel(sel),.load(load), .val(val));

  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   y %d   sel %b ",$time, x, sel);
    $dumpvars(0,  ZC);
    #200 sel = 10; load = 1; val=8191;
    #200; load =0;
    #200;
    for (i=0; i <40000; i=i+1)
    #200;
    $finish;
  end
  always begin
       clk = 1'b0;
       forever #100 clk = ~clk; // Toggle clock every 5 ticks
  end

endmodule
