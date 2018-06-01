module counter_load (clk, rst, en, count, data, load, out);

   input clk, rst, en, load; 
   output out;
   output reg [3:0] count;
   input [3:0] data;
   reg [3:0] mem;
   
   always @(posedge clk)
      if (rst)
         count <= 4'd0;
      else if (en)
         count <= count + 4'd1;

   always @(out)
      if (count == mem) count <= 4'd0;


   always @(posedge load)
	 mem <= data;

   assign out = (count == mem)?1'b0:1'b1;

endmodule
