`include "accumulators.v"


module tb_adder16_cla();
 
  reg [15:0] a, b;
  output [15:0] out;
  reg cin; 
  wire cout, p, g;
 
  adder_16  DUT (
    .Cin(cin),
    .A(a),
    .B(b),
    .S(out),
    .Cout(cout)
  );
 
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %b   B %b   C %b   Cin %b Cout %b ",$time, a, b, out, cin, cout);
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
    a = 16'b1111111111111111; cin = 0;
    b = 16'b0001000100010001;
    #20
    a = 16'b1111111111111111; cin = 0;
    b = 16'b1111111111111111;
    #20
    a = 16'b0000000000011100;
    b = 16'b0000000000010011;
    $finish;
  end
 
endmodule
