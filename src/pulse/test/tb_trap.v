`timescale 1ns/1ps
module ACC1632(X, Y, clk, clr);
  input signed [15:0] X;
  output signed [31:0] Y;
  reg signed [31:0] accum;

  input clk, clr;
 
  assign Y[31:0] = accum[31:0];
  always @(posedge clk)
  begin
    if (clr) accum <= 0;
    else accum <= $signed(accum + {{16{X[15]}},X});
  end
endmodule


module tb_trap();
 
  reg signed [31:0] x;
  wire signed [31:0] x1;
  wire signed [31:0] x2;
  wire signed [31:0] x3;
  wire signed [31:0] x4;
  wire signed  [31:0] out;

  reg [15:0] m1;
  reg [15:0] m2;

  reg [7:0] delayK;
  reg [7:0] delayL;
  reg clk, sclk; 
  reg clr;
  integer i;
  reg delay;

  //trapezoid  #(.Nbits(16)) DUT (.X(x), .Y(out), .delayK(delayK), .delayL(delayL),
  //.m1(m1), .m2(m2), .clk(clk), .sclk(sclk), .clr(clr));

  ABC Delayk (.X(x), .Y(x1), .clk(clk), .delay(delayK), .clr(clr));
  ABC Delayl (.X(x1), .Y(x2), .clk(clk), .delay(delayL), .clr(clr));
  //accumS #(.Nbits(32)) Accum (.D(x2>>>m2), .Q(x3), .clk(clk), .clr(clr));
  ACC32  Accum1 (.X(x2>>>m2), .Y(x3), .clk(clk), .clr(clr));
  assign x4 = x3 + (x2<<<m1);
  ACC32  Accum2 (.X(x4), .Y(out), .clk(clk), .clr(clr));
  //accumS #(.Nbits(32)) Accum2 (.D(x4), .Q(out), .clk(clk), .clr(clr));

  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   x %d   y %d    clr %b %d",$time, x, out,  clr,i);
    //$dumpvars(0, Delayk, Delayl, Accum);
    $dumpvars(0, Accum1);
    m1 = 2;
    m2 = 8;
    delayK = 4;
    delayL = 10;
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
    /*
    #200 x= 1000; $display("%d   %d ",x, out, delay);
    for (i=0; i<100; i=i+1)
        #200 x= x/1.01; 
    for (i=0; i<100; i=i+1)
        #200 x= 0; 
    */
    #200 x= 1000;
    for (i=0; i<100; i=i+1)
        #200 x= x/1.00001; 
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
