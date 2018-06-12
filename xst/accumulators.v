/*
[The 74381/74382](http://www.6502.org/users/dieter/a7/a7_1.htm)
[74182 Carry Look-Ahead Circuit](http://web.eecs.umich.edu/~jhayes/iscas.restore/74182.html)
[Inside the vintage 74181 ALU chip: how it works and why it's so strange](http://www.righto.com/2017/03/inside-vintage-74181-alu-chip-how-it.html)
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


module full_adder(Cin, A, B, S, Cout);
input Cin, A, B;
output S, Cout;

//assign S = (A^B)^Cin;
//assign Cout = (A&B) | ((A^B)&Cin);

assign S = (A^B)^Cin;
assign Cout = (A&B) | (A&Cin) | (B&Cin);
endmodule

module adder_4(Cin, A, B, S, Cout);
 input Cin; 
 input [3:0] A; 
 input [3:0] B;
 output [3:0] S; 
 output Cout;

 wire c0, c1, c2, c3;

 full_adder fa1(Cin, A[0], B[0], S[0], c1);
 full_adder fa2(c1, A[1], B[1], S[1], c2);
 full_adder fa3(c2, A[2], B[2], S[2], c3);
 full_adder fa4(c3, A[3], B[3], S[3], Cout);

endmodule


module adder_4_la(Cin, A, B, S, Cout);
input Cin; 
input [3:0] A;
input [3:0] B;
output [3:0] S; 
output Cout;

wire p[3:0];
wire g[3:0];
wire c[3:0];

assign p[0] = A[0] + B[0];
assign p[1] = A[1] + B[1];
assign p[2] = A[2] + B[2];
assign p[3] = A[3] + B[3];

assign g[0] = A[0] & B[0];
assign g[1] = A[1] & B[1];
assign g[2] = A[2] & B[2];
assign g[3] = A[3] & B[3];

assign c[0] = g[0] + p[0] & Cin;
assign c[1] = g[1] + p[1] & c[0];
assign c[2] = g[2] + p[2] & c[1];
assign c[3] = g[3] + p[3] & c[2];

assign S[0] = (A[0]^B[0]) ^ Cin;
assign S[1] = (A[1]^B[1]) ^ c[0];
assign S[2] = (A[2]^B[2]) ^ c[1];
assign S[3] = (A[3]^B[3]) ^ c[2];
assign Cout = c[3]; 

endmodule

module carry_la (Cin, A, B, C, p, g);
input Cin;
input [3:0] A;
input [3:0] B;
output [3:0] C;
output [3:0] p; 
output [3:0] g;

reg p0, p1, p2, p3;
reg g0, g1, g2, g3;


always @(*) begin
  p0 <= (A[0] + B[0]);
  p1 <= (A[1] + B[1]);
  p2 <= (A[2] + B[2]);
  p3 <= (A[3] + B[3]);

  g0 <= (A[0] & B[0]);
  g1 <= (A[1] & B[1]);
  g2 <= (A[2] & B[2]);
  g3 <= (A[3] & B[3]);
end

  assign C[0] = g0 + (p0&Cin); 
  assign C[1] = g1 + (p1&g0) + (p1&p0&Cin); 
  assign C[2] = g2 + (p2&g1) + (p2&p1&g0) + (p2&p1&p0&Cin); 
  assign C[3] = g3 + (p3&g2) + (p3&p2&g1) + (p3&p2&p1&g0) + (p3&p2&p1&p0&Cin); 
  assign p = {p0,p1,p2,p3};
  assign g = {g0,g1,g2,g3};

endmodule

module adder_4_la_b(Cin, A, B, S, Cout, p, g);
input Cin; 
output Cout;
output [3:0] p; 
output [3:0] g;

input [3:0] A;
input [3:0] B;
output [3:0] S; 
wire [3:0] C; 

carry_la cla(.Cin(Cin), .A(A),.B(B),.C(C), .p(p), .g(g));

assign S[0] = (A[0] ^ B[0]) ^ Cin;
assign S[1] = (A[1] ^ B[1]) ^ C[0];
assign S[2] = (A[2] ^ B[2]) ^ C[1];
assign S[3] = (A[3] ^ B[3]) ^ C[2];
assign Cout = C[3]; 

endmodule


/*
---------------------------------------
---------------------------------------
*/
module carry_la_mod (Cin, P, G, C);
input Cin;
input [15:0] P;
input [15:0] G;
output [3:0] C;

reg P0, P1, P2, P3;
reg G0, G1, G2, G3;

always @(*) begin
 P0<= &P[3:0];
 P1<= &P[7:4];
 P2<= &P[11:8];
 P3<= &P[15:12];

 G0<=G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];
 G1<=G[7] | P[7]&G[6] | P[7]&P[6]&G[5] | P[7]&P[6]&P[5]&G[4];
 G2<=G[11] | P[11]&G[10] | P[11]&P[10]&G[9] | P[11]&P[10]&P[9]&G[8];
 G3<=G[15] | P[15]&G[14] | P[15]&P[14]&G[13] | P[15]&P[14]&P[13]&G[12];
end


  assign C[0] = G0 + (P0&Cin); 
  assign C[1] = G1 + (P1&G0) + (P1&P0&Cin); 
  assign C[2] = G2 + (P2&G1) + (P2&P1&G0) + (P2&P1&P0&Cin); 
  assign C[3] = G3 + (P3&G2) + (P3&P2&G1) + (P3&P2&P1&G0) + (P3&P2&P1&P0&Cin); 

endmodule


module adder_16(Cin, A, B, S, Cout);
input Cin;
input [15:0] A;
input [15:0] B;
output [15:0] S;
output Cout;

wire Co;

wire [15:0] p;
wire [15:0] g;
wire [3:0] c;

carry_la_mod ca_la(.Cin(Cin), .P(p), .G(g), .C(c));
adder_4_la_b a41 (.Cin(Cin), .A(A[3:0]), .B(B[3:0]), .S(S[3:0]), .Cout(Co), .p(p[3:0]), .g(g[3:0]));
adder_4_la_b a42 (.Cin(c[0]), .A(A[7:4]), .B(B[7:4]), .S(S[7:4]), .Cout(Co), .p(p[7:4]), .g(g[7:4]));
adder_4_la_b a43 (.Cin(c[1]), .A(A[11:8]), .B(B[11:8]), .S(S[11:8]), .Cout(Co), .p(p[11:8]), .g(g[11:8]));
adder_4_la_b a44 (.Cin(c[2]), .A(A[15:12]), .B(B[15:12]), .S(S[15:12]), .Cout(Co), .p(p[15:12]), .g(g[15:12]));

assign Cout = c[3];

endmodule
