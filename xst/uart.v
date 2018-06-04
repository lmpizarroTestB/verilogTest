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


