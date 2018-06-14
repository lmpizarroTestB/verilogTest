//`include "accumulators.v"


module tb_adder();
 
  reg [3:0] a, b;
  wire [3:0] out;
  reg cin; 
  wire cout; 
  wire [3:0] p; 
  wire [3:0] g;
 
  adder_4  DUT (
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
    $monitor ("time %g   A %b   B %b   C %b   Cin %b Cout %b p %b g %b",$time, a, b, out, cin, cout, p, g);
    $dumpvars(0, DUT);
    #20
    
    a = 4'b0000; cin = 1'b1;
    b = 4'b0000; 
    #20
    a = 4'b0111; cin = 1'b0;
    b = 4'b0001; //  1000
    #20
    a = 4'b1100;
    b = 4'b0011;
    #20
    a = 4'b1100;
    b = 4'b0011;
    #20
    a = 4'b1100; cin = 0;
    b = 4'b1010; cin = 0;
    #20
    a = 4'b1111; cin = 0;
    b = 4'b1111;
    #20
    a = 4'b1111; cin = 0;
    b = 4'b0001;
    #20
    a = 4'b1110; cin = 1;
    b = 4'b0001;
    #20
   $finish;
  end
 
endmodule
