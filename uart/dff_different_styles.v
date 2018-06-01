module dffa1(clk, arst, d, q);
input clk, arst, d;
output reg q;
always @(posedge clk or negedge arst) begin
	if (~arst)
		q <= 0;
	else
		q <= d;
end
endmodule

module dffa(clk, arst, d, q);
input clk, arst, d;
output reg q;
always @(posedge clk or posedge arst) begin
	if (arst)
		q <= 1;
	else
		q <= d;
end
endmodule


