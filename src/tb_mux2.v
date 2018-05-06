`include "mux2.v"

module tb_mux2;
  reg a, b, select;
  wire f;
  reg expected;

  mux2 myMux (.select(select), .in0(a), .in1(b), .out(f));

  initial
    begin
      #0 select=0; a=0; b=1; expected = 0;
      #10 a=1; b=0; expected=1;
      #10 select=1; a=0; b=1; expected=1;
      #10 $finish;
    end
  initial
    $monitor(
      "select=%b in0=%b in1=%b out=%b, expected out=%b time=%d",
         select, a, b, f, expected, $time);
endmodule // tb_mux2
