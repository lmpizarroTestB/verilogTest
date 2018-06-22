//
//
// VHDL Simulation of Trapezoidal Filter for Digital
// Nuclear Spectroscopy systems
// Ms Kavita Pathak 
// Dr. Sudhir Agrawal
// International Journal of Scientific and Research Publications, Volume 5,
// Issue 8, August 2015
//
//
// Digital techniques for real-time pulse shaping
// in radiation measurements Valentin T. JordanoV
// Glenn F. Knoll b, Alan C. Huber John A. PantaziS
//
//  1994
//
//
module trapezoid #(parameter Nbits = 14,
                parameter ADDR_WIDTH = 8
                )(X, Y, delayK, delayL, m1, m2, clk, sclk, clr);

  input clk;
  input clr;
  input sclk;

  input signed [Nbits-1:0] X;
  input signed [7:0] m1;
  input signed [7:0] m2;

  output signed [2*Nbits-1:0] Y;

  input [ADDR_WIDTH - 1:0] delayL; 
  input [ADDR_WIDTH - 1:0] delayK; 


  wire signed [Nbits-1:0] Ydk;
  wire signed [Nbits-1:0] Ydl;
  wire signed [2*Nbits-1:0] Rn;

  delaySubstract  #(.Nbits(Nbits), .ADDR_WIDTH(ADDR_WIDTH)) DUT1 
           (.X(X), .Y(Ydk), .delay(delayK), .clk(clk), .sclk(sclk), .clr(clr));

  delaySubstract  #(.Nbits(Nbits), .ADDR_WIDTH(ADDR_WIDTH)) DUT2 
                  (.X(Ydk), .Y(Ydl), .delay(delayL), .clk(clk), .sclk(sclk), .clr(clr));
     
  hpd             #(.Nbits(2*Nbits)) hpd1
                  (.X({{16{Y[15]}},Ydl}), .Y(Rn), .m1(m1), .m2(m2), .clk(clk), .sclk(sclk), .clr(clr));
  
  accumS          #(.Nbits(2*Nbits)) acc1 
                  (.clk(sclk), .D(Rn), .Q(Y), .clr(clr));
endmodule
