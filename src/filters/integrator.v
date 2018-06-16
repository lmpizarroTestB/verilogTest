module integrator75 #(parameter Nbits = 16)
             (X, Y, CLK, Sclk, CLR, OE);

  input CLK, Sclk;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] yy=0;
  reg signed [Nbits-1:0] Y1=0; 

always @(posedge CLK or posedge CLR or X)
  begin
     if (CLR)
      begin
      yy[Nbits-1:0] <= 0;
      Y1[Nbits-1:0] <= 0;
      end
     else
       begin
       if (CLK) begin
       yy=$signed(X+(Y1+(Y1>>>1))>>>1);

       Y1[Nbits-1:0] = yy[Nbits-1:0];
       end
       end
  end

  assign Y = yy;

endmodule



module integrator #(parameter Nbits = 16)
             (X, Y, CLK, Sclk, CLR, OE);

  input CLK, Sclk;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] yy=0;
  reg signed [Nbits-1:0] Y1=0; 

always @(posedge CLK or posedge CLR or X)
  begin
     if (CLR)
      begin
      yy[Nbits-1:0] <= 0;
      Y1[Nbits-1:0] <= 0;
      end
     else
       begin
       if (CLK) begin
       yy=$signed(X+Y1);

       Y1[Nbits-1:0] = yy[Nbits-1:0];
       end
       end
  end

  assign Y = yy;

endmodule

module integratorD #(parameter Nbits = 16)
             (X, Y, CLK, Sclk, CLR, OE);

  input CLK, Sclk;
  input CLR;
  input OE;

  input  signed [Nbits-1:0] X;
  output signed  [Nbits-1:0] Y;
  reg signed [Nbits-1:0] yy=0;
  reg signed [Nbits-1:0] Y1=0; 
  reg signed [Nbits-1:0] Y2=0; 

always @(posedge CLK or posedge CLR or X)
  begin
     if (CLR)
      begin
      yy[Nbits-1:0] <= 0;
      Y1[Nbits-1:0] <= 0;
      Y2[Nbits-1:0] <= 0;
      end
     else
       begin
       if (CLK) begin
       yy=$signed(X+Y1-(Y2>>>2));
       
       Y2 = Y1;
       Y1[Nbits-1:0] = yy[Nbits-1:0];
       end
       end
  end

  assign Y = yy;

endmodule
