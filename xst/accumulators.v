/*
[The 74381/74382](http://www.6502.org/users/dieter/a7/a7_1.htm)
[74182 Carry Look-Ahead Circuit](http://web.eecs.umich.edu/~jhayes/iscas.restore/74182.html)
*/
/*
4-bit unsigned up accumulator
with asynchronous clear.

IO Pins Description
--------------------
C Positive-Edge Clock
CLR Asynchronous Clear (active High)
D[3:0] Data Input
Q[3:0] Data Output

*/
module accum (C, CLR, D, Q);
 input C, CLR;
 input [3:0] D;
 output [3:0] Q;
 reg [3:0] tmp;

 always @(posedge C or posedge CLR)
  begin
   if (CLR)
    tmp = 4'b0000;
   else
    tmp = tmp + D;
  end
 assign Q = tmp;
endmodule

/*
N-bit unsigned up accumulator
with asynchronous clear.

IO Pins Description
--------------------
C Positive-Edge Clock
CLR Asynchronous Clear (active High)
D[Nbit -1:0] Data Input
Q[Nbit - 1:0] Data Output

*/
module accumB #(parameter Nbit =8)(C, CLR, D, Q);
 input C, CLR;
 input [Nbit -1:0] D;
 output [Nbit-1:0] Q;
 reg [Nbit-1:0] tmp;

 always @(posedge C or posedge CLR)
  begin
   if (CLR)
    tmp = 0;
   else
    tmp = tmp + D;
  end
 assign Q = tmp;
endmodule

/*
unsigned 8-bit adder with carry
in.

IO pins Description
--------------------
A[7:0], B[7:0] Add Operands
CI       Carry In
SUM[7:0] Add Result
*/

module adder_unsigned_8 (A, B, CI, SUM);
input [7:0] A;
input [7:0] B;
input CI;
output [7:0] SUM;

assign SUM = A + B + CI;
endmodule

module divide_by_2_8 (A, Q, R);
 input [7:0] A;
 output [7:0] Q;
 output R;

 //assign Q = {0,A[7:1]};
 assign Q[7] = 0;
 assign Q[6] = A[7];
 assign Q[5] = A[6];
 assign Q[4] = A[5];
 assign Q[3] = A[4];
 assign Q[2] = A[3];
 assign Q[1] = A[2];
 assign Q[0] = A[1];
 assign R = A[0];
endmodule


module divide_by_4_8 (A, Q, R);
 input [7:0] A;
 output reg [7:0] Q;
 output reg [1:0] R;

  reg [7:0] Q2;
  reg [1:0] R2;


always @(A)
begin
  Q2={1'b0,1'b0, A[7:2]};
  R2 = A[1:0];
end 

endmodule


module divide_by_2 #(parameter Nbits = 16) (A, Q, R);
 input [Nbits -1:0] A;
 output [Nbits-1:0] Q;
 output R;

 assign Q = {1'b0,A[Nbits-1:1]};
 assign R = A[0];
endmodule



module divide_by_4 #(parameter Nbits = 16) (A, Q, R);
 input [Nbits -1:0] A;
 output reg [Nbits -1:0] Q;
 output reg [1:0] R;

always @(A)
begin
  Q = {1'b0,1'b0,A[Nbits - 1:2]};
  R = A[1:0];
end

endmodule


module divide_by_8 #(parameter Nbits = 16) (A, Q, R);
 input [Nbits -1:0] A;
 output [Nbits -1:0] Q;
 output [2:0] R;

 assign Q = {1'b0,1'b0,1'b0,A[Nbits - 1:3]};
 assign R = A[2:0];
endmodule



module mult_4 (A,B,C);
input [3:0] A;
input [3:0] B;
output[7:0] C;

reg [7:0] a0;
reg [7:0] a1;
reg [7:0] a2;
reg [7:0] a3;

always @(A,B)
begin
 a0[7:0]  = {1'b0, 1'b0, 1'b0, 1'b0, A[3:0]} & {8{B[0]}};
 a1[7:0]  = {1'b0,1'b0,1'b0,A[3:0],1'b0} & {8{B[1]}};
 a2[7:0]  = {1'b0,1'b0,A[3:0],1'b0,1'b0} & {8{B[2]}};
 a3[7:0]  = {1'b0,A[3:0],1'b0,1'b0,1'b0} & {8{B[3]}};
 
end
assign C = a0 + a1 + a2 + a3;

endmodule

