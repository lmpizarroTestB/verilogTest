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

reg  [45:0] old_tag;

wire sig_transfer;

assign sig_transfer = ~new_tag;


time_tags tt (.logic_pulse(logic_pulse), 
	           .clk(clk), 
		   .reset(reset),
	          .tag_time(tag_time),
	          .new_tag(new_tag));

always @(posedge new_tag)
begin
    diff_time <= tag_time - old_tag;
    new_diff = 1;
end

always @(posedge sig_transfer)
begin
    old_tag <= tag_time;
    new_diff = 0;
end

always @(reset)
begin
  diff_time = 0;
  old_tag = 0;
end

endmodule
