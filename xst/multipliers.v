//`include "accumulators.v"


module mult4_bb(A,B,C);
input [3:0] A;
input [3:0] B;
output [7:0] C;

wire [7:0] d0, d1, d2, d3;

wire [7:0] pre1, pre2, tot;

assign d0 = B[0]?{4'b0000, A[3:0]}:8'b00000000;
assign d1 = B[1]?{3'b000, A[3:0], 1'b0}:8'b00000000;
assign d2 = B[2]?{2'b00, A[3:0], 2'b00}:8'b00000000;
assign d3 = B[3]?{1'b0, A[3:0], 3'b000}:8'b00000000;

adder_8_la  add81(.Cin(1'b0), .A(d0), .B(d1), .S(pre1), .Cout());
adder_8_la  add82(.Cin(1'b0), .A(d2), .B(d3), .S(pre2), .Cout());
adder_8_la  add83(.Cin(1'b0), .A(pre1), .B(pre2), .S(C), .Cout());
endmodule
