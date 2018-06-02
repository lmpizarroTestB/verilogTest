//`include "dffa.v"

module shift (clk, arst, d, q, s);
input clk, arst, d;
output [1:0] q;
output s;

assign s = q[1];

dffa dff1 (.clk(clk), .arst(arst), .d(d), .q(q[0]));
dffa dff2 (.clk(clk), .arst(arst), .d(q[0]), .q(q[1]));

endmodule


