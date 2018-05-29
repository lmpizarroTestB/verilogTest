module counter10(clk, pulse, rst);
input clk, rst;
output pulse;

reg pulse = 0;
reg [3:0] counter = 0;

always @(posedge clk)
begin
   if (rst) begin
	   counter = 0;
           pulse = 0;
   end
   else begin
	   if (counter == 4'b1010) begin
		   pulse = 1;
		   counter = 0;
	   end
   else pulse = 0;
   counter = counter + 1;
   end
end
endmodule

module counter20(clk, pulse, rst);
input clk, rst;
output pulse;

reg pulse = 0;
reg [5:0] counter = 0;

always @(posedge clk)
begin
   if (rst) begin
	   counter = 0;
           pulse = 0;
   end
   else begin
	   if (counter == 5'b10100) begin 
		   pulse = 1;
		   counter = 0;
	   end
   else pulse = 0;
   counter = counter + 1;
   end
end
endmodule

module counter_8(clk, pulse, rst, load);
input clk, rst;
output pulse;
input [7:0] load;

reg pulse = 0;
reg [7:0] counter = 0;

always @(posedge clk)
begin
   if (rst) begin
	   counter = 0;
           pulse = 0;
   end
   else begin
    counter = counter + 1;
   if (counter == load) pulse = 1;
   else pulse = 0;
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


