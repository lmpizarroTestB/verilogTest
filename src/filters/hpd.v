module hpd #(parameter Nbits = 14)
  (X, Y, m1, m2, clk, sclk, clr);

  input clk;
  input clr;
  input sclk;

  input signed [Nbits-1:0] X;

  input signed [Nbits-1:0] m1;
  input signed [Nbits-1:0] m2;

  output signed [Nbits-1:0] Y;

  wire signed [Nbits-1:0] Ym1;
  wire signed [Nbits-1:0] Ym2;

  wire signed [Nbits-1:0] accum1;

  accumS #(.Nbits(Nbits)) acc1 (.clk(sclk), .D(Ym2), .Q(accum1), .clr(clr));

  assign Ym1 = m1 * X; 
  assign Ym2 = m2 * X;
  assign Y = accum1 + Ym1; 


endmodule
