module mov_aver2 #(parameter Nbits = 16)
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
      yy[Nbits-1:0] = 0;
      X1 = 0;
      end
     else
       begin
       if (CLK) begin
         yy[Nbits-1:0] = $signed((X + X1 )>>1);
         X1[Nbits-1:0] = X[Nbits-1:0];
       end
       end
  end

  assign Y = yy;

endmodule



module mov_aver4 #(parameter Nbits = 16)
             (X, Y, CLK, Sclk, CLR, OE);

  input CLK, Sclk;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] yy=0;
  reg signed [Nbits-1:0] X1=0; 
  reg signed [Nbits-1:0] X2=0; 
  reg signed [Nbits-1:0] X3=0; 

always @(posedge CLK or posedge CLR or X)
  begin
     if (CLR)
      begin
      yy[Nbits-1:0] = 0;
      X1 = 0;
      X2 = 0;
      X3 = 0;
      end
     else
       begin
       if (CLK) begin
       yy[Nbits-1:0] = $signed((X + X1 + X2 + X3)>>2);

       X3[Nbits-1:0] = X2[Nbits-1:0];
       X2[Nbits-1:0] = X1[Nbits-1:0];
       X1[Nbits-1:0] = X[Nbits-1:0];
       end
       end
  end

  assign Y = yy;

endmodule

module mov_aver8 #(parameter Nbits = 16)
             (X, Y, CLK, Sclk, CLR, OE);

  input CLK, Sclk;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] yy=0;
  reg signed [Nbits-1:0] X1=0; 
  reg signed [Nbits-1:0] X2=0; 
  reg signed [Nbits-1:0] X3=0; 
  reg signed [Nbits-1:0] X4=0; 
  reg signed [Nbits-1:0] X5=0; 
  reg signed [Nbits-1:0] X6=0; 
  reg signed [Nbits-1:0] X7=0; 

always @(posedge CLK or posedge CLR or X)
  begin
     if (CLR)
      begin
      yy[Nbits-1:0] = 0;
      X1 = 0;
      X2 = 0;
      X3 = 0;
      X4 = 0;
      X5 = 0;
      X6 = 0;
      X7 = 0;
      end
     else
       begin
       if (CLK) begin
       yy[Nbits-1:0] = $signed((X + X1 + X2 + X3 + X4+X5+X6+X7)>>3);

       X7[Nbits-1:0] = X6[Nbits-1:0];
       X6[Nbits-1:0] = X5[Nbits-1:0];
       X5[Nbits-1:0] = X4[Nbits-1:0];
       X4[Nbits-1:0] = X3[Nbits-1:0];
       X3[Nbits-1:0] = X2[Nbits-1:0];
       X2[Nbits-1:0] = X1[Nbits-1:0];
       X1[Nbits-1:0] = X[Nbits-1:0];
       end
       end
  end

  assign Y = yy;

endmodule
