`timescale 1ns/1ps

module tb_accumulator();
 
  reg signed [13:0] x;
  wire signed  [13:0] out;
  reg clk; 
  reg clr;
  reg oe;
  integer i;
 
  accumulator  DUT (.X(x), .Y(out), .CLK(clk), .CLR(clr), .OE(oe));
 
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   x %d   y %d   clk %b   clr %b ",$time, x, out, clk, clr);
    $dumpvars(0, DUT);
    #20 x=0; clk=1'b1; clr=1'b0; oe =0;
    /*
    #20 clr=1'b0;
    #20 clr=1'b1;
    #20 clr=1'b1;
    #20 clr=1'b0;
    #20 clr=1'b0;
    #20 x = 13'd10;
    #20 x = 13'd1;
    #20 x = 13'd1;
    #20 x = 13'd10;
    #20 x = -13'd4;
    #20 x = -13'd4;
    #20 x = 13'd0;
    #20 x = 13'd0; oe =1;
    #20 x = 13'd0;
    #20 x = 13'd4;
    #20 x = 13'd0;
    #20 x = 13'd0;
    #20 x = 13'd0;
    #20 x = 13'd1;
    */
    #20 x=13'd0; clr=1;
    #20 x=13'd0; clr=0;
    #20 x=13'd0; clr=0;
    #20 x=13'd0; clr=0;
    #20 x=13'd0; clr=0;
    #20 x= 1500; oe=1;
    for (i=0; i<25; i=i+1)
      #20 x= x/1.2;
    
    $finish;
  end

  always begin
       #10 clk = ~clk; // Toggle clock every 5 ticks
  end
endmodule
