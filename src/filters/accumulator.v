module accumulator #(parameter Nbits = 14)
             (X, Y, CLK, CLR, OE);

  input CLK;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] accum=0; 

  //reg Y;

  always @(posedge CLK or posedge CLR)
  begin
     if (CLR)
      accum[Nbits-1:0] <= 0;
     else
       accum[Nbits-1:0] <= accum[Nbits-1:0] + (X[Nbits-1:0]);
  end

  assign Y = OE?accum:z;

endmodule
