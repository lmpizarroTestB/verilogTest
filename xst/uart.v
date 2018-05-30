`include "three_st.v"


/*
http://vlsi-design-engineers.blogspot.com.ar/2015/09/three-state-devices-ic74x541-ic74x245.html
*/
module bidir8 (X, Y, dir);
  inout [7:0] X;
  inout [7:0] Y;
  input dir;

  three_st_c8 x (~dir,X, Y);
  three_st_c8 y (dir, Y, X); 
  
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
/*
module init_counter (clk, init, rst, out);
 input clk, init, rst;
 output out;

 always @(posedge clk or negedge init)


endmodule
*/
module rx_byte (clk, // baud rate clock X N
	        dr,  // data ready
		d,   // data
		pb,  // parity bit
		rx   // receive line
	       );

  input clk, rx;
  output dr, pb;
  output [7:0] d;

  always @(clk)
  begin
    if (rx == 0) begin
    end
  end
endmodule

module ABC (clk, rx, out);
 input clk, rx;
 output out;

 reg [3:0] cnt10 = 4'b0000;
 reg [4:0] cntbit = 5'b00000;
 reg [7:0] cntFrame = 8'b00000000;

 reg delayBitStart = 1'b0;
 reg centerStartBitPulse = 1'b0;
 reg validFrame = 1'b0;
 reg clkBit = 1'b0;
 reg cd = 0; 

 always @(negedge (rx|validFrame))
 begin
  delayBitStart <= 1'b1;
 end

 always @(negedge delayBitStart)
 begin
   centerStartBitPulse = 1'b1 & ~rx;
   cd = 1'b1;
   cntbit = 5'b00000;
 end

 always @(posedge clk)
 begin
  if (delayBitStart == 1'b1)
  begin
    cnt10 <= cnt10 + 1;
    if (cnt10 == 4'b1001) 
    begin
     delayBitStart <= 1'b0;
     cnt10 <= 4'b0000;
    end
  end
 end

 always @(posedge clk)
 begin
  if (cd==1'b1) begin
   centerStartBitPulse = 1'b0;
   cd = 1'b0;
  end
 end

 always @(negedge centerStartBitPulse)
 begin
   validFrame <= 1'b1;
 end


 // generate clkBit
 always @(posedge (clk))
 begin
  if ( validFrame) begin
   cntbit = cntbit + 5'b00001;
   if (cntbit == 5'b10100) 
   begin 
    cntbit <= 5'b00000;
    clkBit <= 1'b1;
   end
   else clkBit <= 1'b0;
  end
 end

 // generate  frame valid
 always @(posedge (clk))
 begin
  if ( validFrame) begin
   cntFrame = cntFrame + 1;
   if (cntFrame == 8'b11010011) 
   begin 
    cntFrame <= 8'b00000000;
    validFrame = 1'b0;
   end
  end
 end

 assign out = centerStartBitPulse;

endmodule


