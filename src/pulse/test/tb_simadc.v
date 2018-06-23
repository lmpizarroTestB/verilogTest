`timescale 1ns/1ps

module tb_simadc();
 
  wire signed [13:0] x;
  reg clk; 
  reg [3:0] sel;
  integer i;

 simADC ZC(.Y(x), .clk(clk), .sel(sel));

  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   y %d   sel %b ",$time, x, sel);
    $dumpvars(0,  ZC);
    #200 sel = 1;
    #200;
    #200;
    #200;
    #200;
    #200;
    #200;
    #200;
    #200;
    #200;
    #200;
    $finish;
  end
  always begin
       clk = 1'b0;
       forever #100 clk = ~clk; // Toggle clock every 5 ticks
  end

endmodule
