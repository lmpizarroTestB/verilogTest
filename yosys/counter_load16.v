module counter_load16 (clk, rst, en, data, load, out);

   input clk, rst, en, load; 
   output out;
   reg [15:0] count;
   input [15:0] data;
   reg [15:0] mem;
   
   always @(posedge clk)
      if (rst)
         count <= 16'd0;
      else if (en)
         count <= count + 16'd1;

   always @(count)
      if (count == mem) count <= 16'd0;


   always @(posedge load)
	 mem <= data;

   assign out = (count == mem)?1'b0:1'b1;

endmodule
