module simADC (Y, clk, sel);
output [13:0] Y;
input [3:0] sel;
input clk;

reg signed [31:0] yc;
reg signed [31:0] ymem = 32'b0111_1111_1111_1111_1111_1111_1111_1111;

always @(posedge clk)
begin
 case(sel)
  0: yc <= 0;
  1: begin
     yc = 8189*(ymem>>>13);
     ymem = yc;
     end
  default: yc<=1000;
 endcase
end
assign Y = (yc[31:18]+2)>>>1;
endmodule
