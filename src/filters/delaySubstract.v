module delaySubstract #(parameter Nbits = 14,
                parameter ADDR_WIDTH = 8
                )(X, Y, delay, clk, sclk, clr);


  input clk;
  input clr;
  input sclk;

  input signed [Nbits-1:0] X;
  output signed [Nbits-1:0] Y;
  wire signed [Nbits-1:0] Ydel;

  input [ADDR_WIDTH - 1:0] delay; 

  localparam MAX_DELAY = 1 << ADDR_WIDTH;
  reg [ADDR_WIDTH-1:0] DelayK [MAX_DELAY:0];

  integer i;

  

  delayK  #(.Nbits(Nbits), .ADDR_WIDTH(ADDR_WIDTH)) DUT (.X(X), .Y(Ydel), .clk(clk), .sclk(sclk), .clr(clr), .delay(delay));
  assign Y = X - (Ydel>>>1);

endmodule
