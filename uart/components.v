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

module counter5 (clk, rst, en, count);

   input clk, rst, en;
   output reg [4:0] count;
   
   always @(posedge clk)
      if (rst)
         count <= 4'd0;
      else if (en)
         count <= count + 4'd1;

endmodule

module counter8 (clk, rst, en, count);

   input clk, rst, en;
   output reg [7:0] count;
   
   always @(posedge clk)
      if (rst)
         count <= 7'd0;
      else if (en)
         count <= count + 7'd1;

endmodule
