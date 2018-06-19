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
  input signed [Nbits-1:0] m1;
  input signed [Nbits-1:0] m2;

  output signed [Nbits-1:0] Y;

  input [ADDR_WIDTH - 1:0] delayL; 
  input [ADDR_WIDTH - 1:0] delayK; 


  wire signed [Nbits-1:0] Ydel;
  wire signed [Nbits-1:0] Ydel2;

  reg signed [Nbits-1:0] accum1;
  reg signed [Nbits-1:0] accum2;

  //localparam MAX_DELAY = 1 << ADDR_WIDTH;
  //reg [ADDR_WIDTH-1:0] DelayK [MAX_DELAY:0];

  //integer i;

  

  delaySubstract  #(.Nbits(Nbits), .ADDR_WIDTH(ADDR_WIDTH)) DUT1 
           (.X(X), .Y(Ydel), .delay(delayK), .clk(clk), .sclk(sclk), .clr(clr));
  delaySubstract  #(.Nbits(Nbits), .ADDR_WIDTH(ADDR_WIDTH)) DUT2 
         (.X(Ydel), .Y(Ydel2), .delay(delayL), .clk(clk), .sclk(sclk), .clr(clr));

  assign Y = accum2;

  always @(posedge clk)
  begin
     if (clr) begin
	accum1 = 0;
	accum2 = 0;
     end

     accum1 = accum1 + (m2 * Ydel2);
     accum2 = accum2 + accum1 + (m1 *Ydel2);
  end

endmodule
