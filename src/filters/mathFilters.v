module addS #(parameter Nbits=4)(A,B,C);
input signed [Nbits-1:0] A, B;
output signed [Nbits-1:0] C;

localparam  maxNeg = -2**(Nbits-1);
localparam  maxPos = 2**(Nbits-1) - 1;

reg signed [Nbits:0] tmp;

 always @(A,B)
  begin
        tmp=A+B;
	if (tmp<maxNeg) tmp=maxNeg;
	if (tmp>maxPos) tmp=maxPos;
  end
  assign C = tmp[Nbits-1:0];
endmodule

module twocomplement #(parameter Nbits=4)(A,B);

input signed [Nbits-1:0] A;
output signed [Nbits-1:0] B;

assign B =(~A) + 1;

endmodule

module accumS #(parameter Nbits=4) (clk, D, Q, clr);
input clk, clr;

input [Nbits-1:0] D;
output [Nbits-1:0] Q;

reg [Nbits-1:0] accum; 
reg [Nbits-1:0] a, b;

addS  #(.Nbits(Nbits)) saturator(.A(a), .B(b), .C(Q));

always @(posedge clk)
  begin
    if (clr) accum = 0;
    else
	accum = Q;
	a = D;
        b = accum;
  end

endmodule


module addSB #(parameter Nbits=4)(A,B,C);
input [Nbits-1:0] A, B;
output [Nbits-1:0] C;


reg [Nbits:0] tmp;

 always @(A,B)
  begin
    tmp=A+B;
      if (A[3] == B[3])
	 if (tmp[3]!=B[3])
	    if (tmp[3]==1'b0)
	         tmp=5'b01000;
	         else
	         tmp=5'b00111;
  end
  assign C = tmp[3:0];
endmodule

