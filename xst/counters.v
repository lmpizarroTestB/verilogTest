module counter_8(clk, pulse, rst, limit);
input clk, rst;
output pulse;

input [7:0] limit;

assign pulse = (counter == limit);

reg [7:0] counter = 0;

always @(posedge clk)
begin
   if (rst) begin
	   counter = 8'b00000000;
   end
   else begin
    counter = counter + 1;
    if (counter == limit+1) begin
	    counter = 8'b00000000;
    end
   end
end
endmodule

module divider (clk, out, divisor);
input clk; 
output out;

reg pulse = 0;
reg [7:0] counter = 0;

input [7:0] divisor;
reg [7:0] tmp;

assign out = pulse;

always @(posedge clk)
  begin
   tmp = divisor>>1;
   counter = counter + 1;
   if (counter == divisor) begin
	   counter = 0;
	   pulse = 0;
   end
   if (counter == tmp)
	   pulse = ~pulse;
  end
endmodule

module dividerAsPWM 
 #(parameter Nbits = 8) 
 (clk, out, width);

parameter [Nbits-1:0] divisor = (1<<Nbits) - 1;//8'b11111111;
input [Nbits-1:0] width;
input clk; 
output out;

reg [Nbits-1:0] counter = 0;

reg pulse = 1;

assign out = pulse;

always @(posedge clk)
  begin
   counter = counter + 1;
   if (counter == divisor) begin
	   counter = 0;
	   pulse = 1;
   end
   if (counter == width)
	   pulse = ~pulse;
  end
endmodule


module counter10(clk, pulse, rst);
input clk, rst;
output pulse;

assign pulse = (counter == 4'b1010);

reg [3:0] counter = 0;

always @(posedge clk)
begin
  if (rst) begin
    counter = 4'b0000;
  end
  else begin
  counter = counter + 1;
  if (counter == 4'b1010 + 1) begin
   counter = 0;
  end
  end
end
endmodule

module counter20(clk, pulse, rst);
input clk, rst;
output pulse;

assign pulse = (counter == 5'b10100);
reg [5:0] counter = 0;

always @(posedge clk)
begin
   if (rst) begin
	   counter = 0;
   end
   else begin
   counter = counter + 1;
	   if (counter == 5'b10100 + 1) begin 
		   counter = 0;
	   end
   end
end
endmodule



module freq_div_2 ( clk ,out );
output reg out =0;
input clk ;

always @(posedge clk)
begin
     out <= ~out;	
end
endmodule

module bit_clk ( clk ,out, rx );
 output out;
 input clk, rx;

 reg rst =0; 

 wire p;

 assign out = p & pulse;

 counter10 c10(clk, pulse, rst);
 freq_div_2 f2(pulse , p );

endmodule


module top(input sys_rst, input sys_clk, output o);
 reg [3:0] counter;

 assign o = (counter == 1'd0);

 always @(posedge sys_clk) 
 begin
 if (sys_rst) begin
  counter <= 1'd0;
 end else begin
   counter <= (counter + 1'd1);
 end
 end
endmodule

