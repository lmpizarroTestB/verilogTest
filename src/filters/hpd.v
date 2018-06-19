module hpd #(parameter Nbits = 14,
                parameter ADDR_WIDTH = 8
                )(X, Y m1, m2, clk, sclk, clr);

  input clk;
  input clr;
  input sclk;

  input signed [Nbits-1:0] X;
  input signed [Nbits-1:0] m1;
  input signed [Nbits-1:0] m2;

  output signed [Nbits-1:0] Y;

  wire signed [Nbits-1:0] Ym1;
  wire signed [Nbits-1:0] Ym2;
  wire signed [Nbits-1:0] Rn;

  reg signed [Nbits-1:0] accum1;
  reg signed [Nbits-1:0] accum2;


  assign Ym1 = m1 * X; 
  assign Ym2 = m2 * X;
  assign Rn = Ym1 + accum1;
  assign Y = accum2;

  always @(posedge clk)
  begin
   if (clr) begin
    accum1 = 0;
    accum2 = 0;
   end
  else
   begin
    accum1 = accum1 + X; // P(n)
    accum2 = accum2 + Rn;
   end
  end

endmodule
