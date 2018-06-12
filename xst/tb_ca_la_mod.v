`include "accumulators.v"


module tb_ca_la_mod();
 
  reg [15:0] a; 
  reg [15:0] b;
  wire [3:0] out;
  reg cin; 
  wire cout, p, g;
 
  carry_la_mod   DUT (
    .Cin(cin),
    .P(a),
    .G(b),
    .C(out)
  );
 
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %b   B %b   C %b   Cin %b",$time, a, b, out, cin);
    $dumpvars(0, DUT);
    cin = 1;
    a = 16'b0000000000000000;
    b = 16'b0000000000000000; cin = 0;
    #20
    a = 16'b0000000000000111;
    b = 16'b0000000000000001; //  1000
    #20
    a = 16'b0000000000001100;
    b = 16'b0000000000000011;
    #20
    a = 16'b0000000000001100;
    b = 16'b0000000000000011;
    #20
    a = 16'b0000000000001100; cin = 0;
    b = 16'b0000000000001010;
    #20
    a = 16'b0000000000001111; cin = 0;
    b = 16'b0000000000001111;
    #20
    a = 16'b0000000000001111; cin = 0;
    b = 16'b0000000000000001;
    #20
    $finish;
  end
 
endmodule
