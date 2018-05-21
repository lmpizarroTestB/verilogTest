module delayK #(parameter Nbits = 14,
                parameter ADDR_WIDTH = 8
                )(x, y, clk, clr, delay);

  parameter MAX_DELAY = 1 << ADDR_WIDTH;

  input wire clk;
  input wire clr;

  input wire [Nbits-1:0] x;

  input wire [ADDR_WIDTH - 1:0] delay; 

  output [Nbits-1:0] y;

  reg [Nbits-1:0] DelayK [MAX_DELAY:0];

  integer i;

  always @(posedge clk or posedge clr)
    begin
      if(clr) 
      begin
	for (i=0; i < delay; i= i + 1) 
	begin
	  DelayK[i] = 0;
	end
      end 
      else if (clk == 0) 
      begin
	for (i=0; i < delay - 1; i= i + 1) 
	begin
	  DelayK[i+1] = DelayK[i];
	end
	DelayK[0] = x;
      end
    end
    assign y = DelayK[delay - 1];
endmodule
