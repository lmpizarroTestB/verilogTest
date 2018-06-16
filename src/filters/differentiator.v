module differentiator #(parameter Nbits = 16)
             (X, Y, CLK, Sclk, CLR, OE);

  input CLK, Sclk;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] yy=0;
  reg signed [Nbits-1:0] X1=0; 

always @(posedge CLK or posedge CLR or X)
  begin
     if (CLR)
      begin
      yy[Nbits-1:0] <= 0;
      X1[Nbits-1:0] <= 0;
      end
     else
       begin
       if (CLK) begin
       yy=$signed(X-X1);

       X1[Nbits-1:0] <= X[Nbits-1:0];
       end
       end
  end

  assign Y = yy;

endmodule
