`include "time_tags.v"
//
//
//
module timeTodigital(input logic_pulse, 
	             input clk, 
		     input reset,
		     input read,
	             output reg [45:0] diff_time,
	             output reg new_diff);

wire [45:0] tag_time;
wire new_tag;

reg  [45:0] new_time;
reg  [45:0] old_time;


time_tags tt (.logic_pulse(logic_pulse), 
	           .clk(clk), 
		   .reset(reset),
	          .tag_time(tag_time),
	          .new_tag(new_tag));

always @(posedge new_tag)
begin
   if (new_time) begin
	new_time <= tag_time;
   end
end

always @(posedge clk)
begin
  if (~new_tag)
  begin
    diff_time <= new_time - old_time;
    old_time <= new_time;
    new_diff = 1;
  end
end

always @(reset)
begin
  diff_time = 0;
  new_time = 0;
  old_time = 0;
end

endmodule
