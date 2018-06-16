`timescale 1ns/1ps

module tb_conforming();
 
  reg signed [15:0] x, ss;
  wire signed  [15:0] out, out1, out2, out3, out4,out5, out6;
  reg clk, sclk; 
  reg clr;
  reg oe;
  integer i;
  integer N =16;
 
  mov_aver4  #(.Nbits(16)) DUT (.X(x), .Y(out), .CLK(clk), .Sclk(sclk), .CLR(clr), .OE(oe));

  integratorD #(.Nbits(16)) DUT5 (.X(x), .Y(out1), .CLK(clk), .Sclk(sclk), .CLR(clr), .OE(oe));
  //mov_aver8  #(.Nbits(16)) DUT1 (.X(out3), .Y(out4), .CLK(clk), .Sclk(sclk), .CLR(clr), .OE(oe));
  integrator75  #(.Nbits(16)) DUT4 (.X(x), .Y(out2), .CLK(clk), .Sclk(sclk), .CLR(clr), .OE(oe));
  //conforming  DUT (.X(out5), .Y(out), .CLK(clk), .Sclk(sclk), .CLR(clr), .OE(oe));
  //mov_aver4  #(.Nbits(16))DUT3 (.X(out), .Y(out1), .CLK(clk), .Sclk(sclk), .CLR(clr), .OE(oe));
  //mov_aver4  #(.Nbits(16))DUT2 (.X(out1), .Y(out2), .CLK(clk), .Sclk(sclk), .CLR(clr), .OE(oe));

  
  //assign out2 = out + out1; 
  initial begin
    $dumpfile("simple.vcd");
    //$monitor ("time %g   x %d   y %d    clr %b %d",$time, x, out,  clr,i);
    $dumpvars(0, DUT);
    #200 x=13'd0; clr=1;
    #200 x=13'd0; clr=0;
    #200 x=13'd0; clr=0;
    #200 x=13'd0; clr=0;
    #200 x=13'd0; clr=0;
    #200 x= 1900; oe=1;$display(x,out);
    //for (i=0; i<93; i=i+1)
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
    #200 x= x/1.1; $display("%d   %d %d",x, out, out1, out2);
  
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
