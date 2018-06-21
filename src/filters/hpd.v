module hpd #(parameter Nbits = 14)
  (X, Y, m1, m2, clk, sclk, clr);

  input clk;
  input clr;
  input sclk;

  input signed [Nbits-1:0] X;

  input signed [7:0] m1;
  input signed [7:0] m2;

  output signed [2*Nbits-1:0] Y;

  wire signed [2*Nbits-1:0] Ym1;
  wire signed [2*Nbits-1:0] Ym2;

  wire signed [2*Nbits-1:0] accum1;

  accumS #(.Nbits(2*Nbits)) acc1 (.clk(sclk), .D(Ym2), .Q(accum1), .clr(clr));

  assign Ym1 = (X<<<m1); 
  assign Ym2 =  X>>>m2;
  assign Y = accum1 + Ym1; 

endmodule
