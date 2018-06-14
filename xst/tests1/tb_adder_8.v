//`include "accumulators.v"


module tb_adder_8_la();
 
  reg [7:0] a, b;
  wire [7:0] out;
  reg cin; 
  wire cout; 
  wire [7:0] p; 
  wire [7:0] g;
 
  adder_8_la  DUT (
    .Cin(cin),
    .A(a),
    .B(b),
    .S(out),
    .Cout(cout)
  );
 
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %b   B %b   C %b   Cin %b Cout %b",$time, a, b, out, cin, cout);
    $dumpvars(0, DUT);
    #20
    
    a = 8'b00000000; cin = 1'b1;
    b = 8'b00000000; 
    #20
    a = 8'b00000111; cin = 1'b0;
    b = 8'b00000001; //  1000
    #20
    a = 8'b00001100;
    b = 8'b00000011;
    #20
    a = 8'b00001100;
    b = 8'b00000011;
    #20
    a = 8'b00001100; cin = 0;
    b = 8'b00001010; cin = 0;
    #20
    a = 8'b00001111; cin = 0;
    b = 8'b00001111;
    #20
    a = 8'b00001111; cin = 0;
    b = 8'b00000001;
    #20
    a = 8'b00001110; cin = 1;
    b = 8'b00000001;
    #20
   $finish;
  end
 
endmodule
