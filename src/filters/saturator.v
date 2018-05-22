module saturator #(parameter Nbits = 14)
                  (D, // Data Input
                     Q); // Data Output
  input signed [Nbits:0] D;

  output signed [Nbits-1:0] Q;

  // Constants value for filter saturation
  reg signed [Nbits-1:0] Mpos = (1<<(Nbits-1)) - 1;
  reg signed [Nbits-1:0] Mneg = (1<<(Nbits-1));

  reg signed [Nbits:0] tmp = 0;

  always @*
    begin
      tmp = D;
      if (tmp < Mneg) tmp = Mneg;
         else if (tmp > Mpos) tmp = Mpos;
   end
  assign Q = tmp[Nbits-1:0];
endmodule
