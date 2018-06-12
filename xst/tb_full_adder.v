`include "accumulators.v"


module tb_full_adder();
 
  reg  a, b;
  wire  out;
  reg cin; 
  wire cout; 
 
  full_adder  DUT (
    .Cin(cin),
    .A(a),
    .B(b),
    .S(out),
    .Cout(cout)//,
    //.p(p),
    //.g(g)
  );
 
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %b   B %b   Cin %b   C %b Cout %b ",$time, a, b, cin, out, cout);
    $dumpvars(0, DUT);
    #20
    b = 1'b0; a = 1'b0; cin = 1'b0;
    #20
    b = 1'b0; a = 1'b0; cin = 1'b1;
    #20
    b = 1'b0; a = 1'b1; cin = 1'b0;
    #20
    b = 1'b0; a = 1'b1; cin = 1'b1;
    #20
    b = 1'b1; a = 1'b0; cin = 1'b0;
    #20
    b = 1'b1; a = 1'b0; cin = 1'b1;
    #20
    b = 1'b1; a = 1'b1; cin = 1'b0;
    #20
    b = 1'b1; a = 1'b1; cin = 1'b1;
    $finish;
  end
 
endmodule
