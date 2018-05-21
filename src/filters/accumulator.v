module accumulator #(parameter Nbits = 14)
  (x1, y, clk, clr);

  input wire clk;
  input wire clr;

  input wire signed [Nbits-1:0] x1;

  output signed [Nbits-1:0] y;

  wire signed [Nbits-1:0] accum; 

  assign accum = accum + x1;

  assign y = accum;

endmodule
