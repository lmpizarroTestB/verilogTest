`include "mux4.v"
//Test bench for 4-input multiplexor.
// Tests all possible input combinations.

module tb_mux4;
  reg [5:0] count = 6'b000000;
  reg a, b, c, d;
  reg [1:0] s;
  reg expected;
  wire f;

  mux4 myMux (.select(s), .in0(a), .in1(b), .in2(c), .in3(d), .out(f));

  initial
  begin
    repeat(64)
      begin
	  a = count[0];
	  b = count[1];
	  c = count[2];
	  d = count[3];
	  s = count[5:4];
	  case (s)
	    2'b00:
	      expected = a;
	    2'b01:
	      expected = b;
	    2'b10:
	      expected = c;
	    2'b11:
	     expected = d;
	  endcase // case(s)
	  #8 $strobe("select=%b in0=%b in1=%b in2=%b in3=%b out=%b, expected=%b time=%d",
	       s, a, b, c, d, f, expected, $time);
	  #2 count = count + 1'b1;
  end
  $finish;
  end

endmodule

