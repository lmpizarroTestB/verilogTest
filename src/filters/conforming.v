module conforming #(parameter Nbits = 14)
             (X, Y, CLK, CLR, OE);

  input CLK;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] yy=0;
  reg signed [Nbits-1:0] X1=0; 
  reg signed [Nbits-1:0] X2=0; 
  reg signed [Nbits-1:0] Y2=0; 
  reg signed [Nbits-1:0] Y1=0; 

  always @(posedge CLK or posedge CLR)
  begin
     if (CLR)
      begin
      yy[Nbits-1:0] = 0;
      Y2[Nbits-1:0] = 0;
      Y1[Nbits-1:0] = 0;
      X2[Nbits-1:0] = 0;
      X1[Nbits-1:0] = 0;
      end
     else
       begin
       yy[Nbits-1:0] = X + Y1 - Y2>>>1;// + X2[Nbits-1:0]>>1 + Y1[Nbits-1:0] + Y2[Nbits-1:0]>>1;

       Y2[Nbits-1:0] = Y1[Nbits-1:0];
       Y1[Nbits-1:0] = yy[Nbits-1:0];
       X2[Nbits-1:0] = X1[Nbits-1:0];
       X1[Nbits-1:0] = X[Nbits-1:0];
       end
  end

  assign Y = OE?yy:z;

endmodule
