module subtractor #(parameter Nbits = 14)
  (x1, x2, y, clk);

  input wire clk;

  input wire [Nbits-1:0] x1;
  input wire [Nbits-1:0] x2;

  output [Nbits-1:0] y;

endmodule
