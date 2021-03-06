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

module freq_div_256 (clk, out);
input clk;
output   [7:0] out; 

freq_div_2 f0(clk, out[0]);
freq_div_2 f1(out[0],  out[1]);
freq_div_2 f2(out[1],  out[2]);
freq_div_2 f3(out[2],  out[3]);
freq_div_2 f4(out[3],  out[4]);
freq_div_2 f5(out[4],  out[5]);
freq_div_2 f6(out[5],  out[6]);
freq_div_2 f7(out[6],  out[7]);
endmodule

module freq_div_8k (clk, out);
input clk;
output   [12:0] out; 

freq_div_256 f0(clk, out[7:0]);
freq_div_2 f1(out[7], out[8]);
freq_div_2 f2(out[8], out[9]);
freq_div_2 f3(out[9], out[10]);
freq_div_2 f4(out[10], out[11]);
freq_div_2 f5(out[11], out[12]);
endmodule

module mux13 (f, s, o);
 input [12:0] f;
 input [3:0] s;
 output o;
 reg o;

always @(f or s)
begin
     if (s == 4'b0000) o = f[0];
else if (s == 4'b0001) o = f[1];
else if (s == 4'b0010) o = f[2];
else if (s == 4'b0011) o = f[3];
else if (s == 4'b0100) o = f[4];
     
else if (s == 4'b0101) o = f[5];
else if (s == 4'b0110) o = f[6];
else if (s == 4'b0111) o = f[7];
else if (s == 4'b1000) o = f[8];

else if (s == 4'b1001) o = f[9];
else if (s == 4'b1010) o = f[10];
else if (s == 4'b1011) o = f[11];
else if (s == 4'b1100) o = f[12];
else o = f[12];
end
endmodule

module freq_sel (clk, s, o);
input clk;
input [3:0] s;
output o;
output   [12:0] out;

 freq_div_8k f8(clk, out);
 mux13 m(out, s, o);

endmodule


