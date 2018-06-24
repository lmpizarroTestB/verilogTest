module simADC (Y, clk, sel,load,val);
output [13:0] Y;
input [3:0] sel;
input clk, load;
input [13:0] val;

reg signed [31:0] yc;
reg signed [31:0] ymem; 

always @(posedge clk)
begin
 case(sel)
  0: yc <= 0;
  1: begin
     yc = 8115*(ymem>>>13); // 1
     ymem = yc;
     end
  2: begin
     yc = 8156*(ymem>>>13); // 2
     ymem = yc;
     end
  3: begin
     yc = 8172*(ymem>>>13); // 
     ymem = yc;
     end

  4: begin
     yc = 8182*(ymem>>>13); //
     ymem = yc;
     end

  5: begin
     yc = 8187*(ymem>>>13); // 
     ymem = yc;
     end

  6: begin
     yc = 8188*(ymem>>>13); //
     ymem = yc;
     end

  7: begin
     yc = 8190*(ymem>>>13); // 9.5
     ymem = yc;
     end




  default: yc<={val,{18{1'b0}}};
 endcase
end
assign Y = (yc[31:18]);

always @(posedge load)
begin
 if(load) ymem = {val,{18{1'b0}}};
end
endmodule
