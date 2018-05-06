module mux2 (in0, in1, select, out);
  input in0, in1, select;
  output out;
  wire s0, w0, w1;

  not
    #1(s0, select);
  and
    #1(w0, s0, in0);
  and   
    (w1, select, in1);
  or
    #1(out, w0, w1);
endmodule // mux2
