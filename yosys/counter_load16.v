module counter_load16 (clk, rst, en, data, load, out);

   input clk, rst, en, load; 
   output out;
   reg [15:0] count;
   input [15:0] data;
   reg [15:0] mem;

   initial
   begin
    count = 16'd0;
    mem = 16'b1111_1111_1111_1111;
   end
   
   always @(posedge clk)
      if (rst)
         count <= 16'd0;

      else if (en)
         count <= count + 16'd1;

   always @(count)
      if (count == mem + 16'd1) count <= 16'd0;


   always @(posedge load)
	 mem <= data;

   assign out = (count == mem)?1'b1:1'b0;

endmodule
