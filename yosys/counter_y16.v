module counter_y16 (clk, rst, en, data, out);

   input clk, rst, en;
 
   input [15:0] data;
   reg [15:0] count;
   output reg out;

   
   always @(posedge clk)
      if (rst)
         count <= 16'd0;
      else if (en) 
         count <= count + 16'd1;

      
   always @(posedge clk)
   begin
      if (count == data + 1) out <= 16'd1;
      else out <= 16'd0; 
   end

   always @(negedge out)
   begin
      count <= 16'd0; 
   end


endmodule
