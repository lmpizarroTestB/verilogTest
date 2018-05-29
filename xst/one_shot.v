`include "flipFlops.v"

module one_shot (clk, in, out, dur, rst);
input clk, in, rst;
output  out;
input  [7:0] dur;

reg out = 1;
reg c = 0;
reg [7:0] tmp = 0;

always @(posedge clk)
begin

        if (in && c == 1'b0) begin
	    c = 1;
	    out = ~out;
            tmp = tmp + 1; end
	    else if (c == 1'b1) begin
	   
	   if (tmp == dur) begin
	     c = 1'b0;
	     tmp = 1'b0;
             out = 1'b1; end 
           else tmp = tmp + 1;
           end
end

always @(posedge rst)
begin
  if (rst) begin
   c = 0;
   tmp = 0;
   out = 0; end
end

endmodule

module level_to_pulse(clk, level, pulse);
input clk, level;
output pulse;

reg pulse =0;
reg c = 0;

 always @(posedge clk)
 begin
  if (level) 
  begin
    if (~c) begin 
     pulse = 1; 
     c = 1; end
    else pulse = 0; end
  else begin
   c = 0;
   pulse = 0;
  end
 end

endmodule


