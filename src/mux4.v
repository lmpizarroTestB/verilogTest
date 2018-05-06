`include "mux2.v"
//4-input multiplexor built from 3 2-input multiplexors
module mux4 (in0, in1, in2, in3, select, out);
  input in0,in1,in2,in3;
  input [1:0] select;
  output out;
  wire w0,w1;
  mux2
        m0 (.select(select[0]), .in0(in0), .in1(in1), .out(w0)),
	m1 (.select(select[0]), .in0(in2), .in1(in3), .out(w1)),
	m3 (.select(select[1]), .in0(w0), .in1(w1), .out(out));
endmodule // mux4



