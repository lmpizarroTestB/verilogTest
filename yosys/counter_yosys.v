module counter (clk, rst, en, count);

   input clk, rst, en;
   output reg [15:0] count;
   
   always @(posedge clk)
      if (rst)
         count <= 16'd0;
      else if (en)
         count <= count + 16'd1;

endmodule
