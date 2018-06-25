`timescale 1ns/1ps


module rand16 (Y, n, init);
output [15:0] Y;
input n, init;
reg [31:0] tmp, outi,tmp2;

reg [31:0] SN = 32'd1103515245;
reg [31:0] next;

always @(posedge n)
begin
 if(n) begin
   tmp = next>>16;
   next = (SN>>next[3:0]) ^ (SN*tmp + 12345);
 end
end
assign Y = next[31:16];

always @(posedge init)
begin
 if(init) begin
   next = SN+12345;
 end
end

endmodule

module rand16B (Y, n, init, seed);
output [15:0] Y;
input n, init;
input [15:0] seed;

reg [31:0] SN = 32'd1103515245;
reg [31:0] next = 1;

always @(posedge n)
begin
 if(n) begin
   next = SN*next + seed;
 end
end
assign Y = next[31:16];

always @(posedge init)
begin
 if(init) begin
   next =1;// SN+12345;
 end
end

endmodule


module pdf(X,Y);
input [15:0] X;
output reg signed [3:0] Y;

always @(*)
begin
     if (Y <= 65535 && Y > 65049) Y = 7;
else if (X <= 65049 && X > 63593) Y = 6;
else if (X <= 63593 && X > 61166) Y = 5;
else if (X <= 61166 && X > 57282) Y = 4;
else if (X <= 57282 && X > 51942) Y = 3;
else if (X <= 51942 && X > 45146) Y = 2;
else if (X <= 45146 && X > 37739) Y = 1;
else if (X <= 37739 && X > 28155) Y = 0;
else if (X <= 28155 && X > 20388) Y = -1;
else if (X <= 20388 && X > 13592) Y = -2;
else if (X <= 13592 && X > 8252)  Y = -3;
else if (X <= 8252  && X > 4369)  Y = -4;
else if (X <= 4369  && X > 1941)  Y = -5;
else if (X <= 1941  && X > 485)   Y = -6;
else if (X <= 485   && X > 200)     Y = -7;
else if (X <= 200   && X > 0)     Y = -8;
end

endmodule

module lfsr16 (Y, n, init, seed);
output [15:0] Y;
input n, init;
input [15:0] seed;
reg [15:0] lfsr16; 

reg tmp1, tmp2, tmp3;

always @(posedge n)
begin
 tmp1 = lfsr16[15];
 tmp2 = lfsr16[14];
 tmp3 = lfsr16[3];
 lfsr16[15:1] = lfsr16[14:0];
 lfsr16[0] = tmp1 ^ tmp2 ^ tmp3;

end

assign Y = lfsr16[15:0];

always @(init)
begin
  lfsr16[15:0] =seed;// seed[15:0];
end
endmodule

module tb_simadc();
 
  reg [31:0] x;
  reg clk; 
  reg [3:0] sel;
  integer i;
  wire [15:0] val;
  reg load,init;
  reg [7:0] delay;
  wire signed [3:0] rndNorm;
 
  wire signed [4:0] pass;

  reg [15:0] seed;

  assign pass = {val[15:13], val[8:6]};//val[15:12];val[15:0]>>>12; 

  lfsr16 r16 (.Y(val),.n(load), .init(init), .seed(seed));
  pdf pd(.X(val), .Y(rndNorm));
  initial begin
    $dumpfile("simple.vcd");
    $monitor (" %d    %d", val, rndNorm);
    $dumpvars(0,  r16);
    #200 sel = 1; load = 1; delay=255; seed=16'b1011_0000_1111_0000;
    #200 x = 1<<31;
    #200; init =0; //x=1103515245;
    #200; init =0; //x=1103515245;
    #200; init =1; //x=1103515245;
    #200; init =1; //x=1103515245;
    #200; init =0; //x=1103515245;
    #200; init =0; //x=1103515245;


    for (i=0; i<65535; i=i+1)
    begin
      #100; load =0; //x=1103515245;
      #100; load =1; //seed = val; x=1103515245; 
    end

    $finish;
  end
  always begin
       clk = 1'b0;
       forever #100 clk = ~clk; // Toggle clock every 5 ticks
  end

endmodule
