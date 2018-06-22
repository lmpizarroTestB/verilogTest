module ACC32(X, Y, clk, clr);
  input signed [31:0] X;
  output signed [31:0] Y;
  reg signed [31:0] accum;

  input clk, clr;
 
  assign Y[31:0] = accum[31:0];
  always @(posedge clk)
  begin
    if (clr) accum <= 0;
    else accum <= $signed(accum + X);
  end
endmodule


module ABC(X, Y, clk, delay, clr);

  input [7:0] delay;

  input signed [31:0] X;
  output signed [31:0] Y;

  input clk, clr;

  reg signed  [31:0] Delay [255:0];

  integer i;

  assign Y =X-Delay[delay];

  always @(posedge clk or posedge clr)
    begin
      if(clr) 
      begin
	for (i=0; i < 256; i= i + 1) 
	begin
	  Delay[i] = 0;
	end
      end 
      else if (clk) 
      begin
	for (i=delay; i > 0; i= i - 1) 
	begin
	  Delay[i] = Delay[i-1];
	end
	Delay[0] = X;
      end
    end

endmodule
