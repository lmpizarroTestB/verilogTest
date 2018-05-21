module subtractor #(parameter Nbits = 14)
  (x1, x2, y, clk);

  input wire clk;

  input wire signed [Nbits-1:0] x1;
  input wire signed [Nbits-1:0] x2;

  output signed [Nbits-1:0] y;

  assign y = x1 - x2;

endmodule
