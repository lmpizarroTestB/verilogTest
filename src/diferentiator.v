module diferentiator (out, in, clk, reset);
  parameter N = 8;
  input [N-1:0] in;
  input reset;
  input clk;

  output[N-1:0] out;

  wire in;
  wire reset;
  wire clk;

  reg[N-1:0] out;

  reg[N-1:0] xn0 = 8'b00000000;
  reg[N-1:0] xn1 = 8'b00000000;

  //assign out = in - buffer; 

  always @(posedge clk)
    begin
    if (reset) begin 
	  xn0 = 0;
	  xn1 = 0;
     end
     else if (clk == 1) begin 
       out <= (xn0 - xn1) /  2;
       xn1 <= xn0;
       xn0 <= in;
     end
    end
endmodule

