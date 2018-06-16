
module conforming #(parameter Nbits = 16)
             (X, Y, CLK, Sclk, CLR, OE);

  input CLK, Sclk;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] yy=0;
  reg signed [Nbits-1:0] X1=0; 
  reg signed [Nbits-1:0] Y1=0; 
  reg signed [Nbits-1:0] Y2=0; 
  reg signed [Nbits-1:0] Y3=0; 
  reg signed [Nbits-1:0] Y4=0; 

always @(posedge CLK or posedge CLR or X)
  begin
     if (CLR)
      begin
      yy[Nbits-1:0] <= 0;
      Y1<=0;
      end
     else
       begin
       if (CLK) begin
       //yy[Nbits-1:0] <= $signed((X + X1 + X2 + X3 + X4)>>2);
       yy=$signed(X-X1 + ((Y1+Y1>>>1)>>>1) + Y2>>>4 + Y3>>>4+Y4>>>4);

       X1 = X;
       Y4 = Y3;
       Y3 = Y2;
       Y2 = Y1;
       Y1[Nbits-1:0] = yy[Nbits-1:0];
       end
       end
  end

  assign Y = yy;

endmodule
