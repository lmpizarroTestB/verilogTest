/*
/*http://www.dnp.fmph.uniba.sk/~kollar/je_w/el2.htm#3
*/
module CRShapping #(parameter Nbits = 16)
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
      Y2<=0;
      Y3<=0;
      Y4<=0;
      X1<=0;
      end
     else
       begin
       if (CLK) begin
       yy=$signed((X-X1)+ (((Y1+(Y1>>>1))>>>1) + (Y2>>>4))+ ((Y3>>>6)+(Y4>>>4)) );

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
