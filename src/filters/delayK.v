module delayK #(parameter Nbits = 14,
                parameter ADDR_WIDTH = 8,
		parameter NbitsDelay =8
                )(X, Y, clk, sclk, clr, delay);


  input clk;
  input clr;
  input sclk;

  input signed [Nbits-1:0] X;
  output signed [Nbits-1:0] Y;

  input [ADDR_WIDTH - 1:0] delay; 

  localparam MAX_DELAY = 1 << ADDR_WIDTH;
  reg [NbitsDelay-1:0] DelayK [MAX_DELAY:0];

  integer i;

  assign Y =DelayK[delay];
  always @(posedge clk or posedge clr)
    begin
      if(clr) 
      begin
	for (i=0; i < MAX_DELAY; i= i + 1) 
	begin
	  DelayK[i] = 0;
	end
      end 
      else if (clk) 
      begin
	for (i=delay; i > 0; i= i - 1) 
	begin
	  DelayK[i] = DelayK[i-1];
	end
	DelayK[0] = X;
      end
    end
endmodule
