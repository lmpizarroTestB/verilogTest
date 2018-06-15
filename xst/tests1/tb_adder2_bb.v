//`include "accumulators.v"


module tb_adder();
 
  reg [1:0] a, b;
  wire [1:0] out;
  reg cin; 
  wire cout; 
 
  adder2_b  DUT (
    .Cin(cin),
    .A(a),
    .B(b),
    .S(out),
    .Cout(cout)//,
  );
 
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %b   B %b   S %b   Cin %b Cout %b ",$time, a, b, out, cin, cout);
    $dumpvars(0, DUT);
    cin=1'b0; 
    #20
    a = 2'b00; cin = 1'b0;
    b = 2'b00; 
    #20
    a = 2'b01; cin = 1'b0;
    b = 2'b00; //  1000
    #20
    a = 2'b10;
    b = 2'b00;
    #20
    a = 2'b11;
    b = 2'b00;
    #20
    a = 2'b00; cin = 0;
    b = 2'b01; cin = 0;
    #20
    a = 2'b01; cin = 0;
    b = 2'b01;
    #20
    a = 2'b10; cin = 0;
    b = 2'b01;
    #20
    a = 2'b11; cin = 0;
    b = 2'b01;
    #20
    #20
    a = 2'b00; cin = 0;
    b = 2'b10; cin = 0;
    #20
    a = 2'b01; cin = 0;
    b = 2'b10;
    #20
    a = 2'b10; cin = 0;
    b = 2'b10;
    #20
    a = 2'b11; cin = 0;
    b = 2'b10;
    #20
    a = 2'b00; cin = 0;
    b = 2'b11; cin = 0;
    #20
    a = 2'b01; cin = 0;
    b = 2'b11;
    #20
    a = 2'b10; cin = 0;
    b = 2'b11;
    #20
    a = 2'b11; cin = 0;
    b = 2'b11;
    #20

    cin=1'b1; 
    #20
    a = 2'b00; cin = 1'b1;
    b = 2'b00; 
    #20
    a = 2'b01; cin = 1'b1;
    b = 2'b00; //  1000
    #20
    a = 2'b10;
    b = 2'b00;
    #20
    a = 2'b11;
    b = 2'b00;
    #20
    a = 2'b00; cin = 1;
    b = 2'b01; cin = 1;
    #21
    a = 2'b01; cin = 1;
    b = 2'b01;
    #20
    a = 2'b10; cin = 1;
    b = 2'b01;
    #20
    a = 2'b11; cin = 1;
    b = 2'b01;
    #20
    #20
    a = 2'b00; cin = 1;
    b = 2'b10; cin = 1;
    #20
    a = 2'b01; cin = 1;
    b = 2'b10;
    #20
    a = 2'b10; cin = 1;
    b = 2'b10;
    #20
    a = 2'b11; cin = 1;
    b = 2'b10;
    #20
    a = 2'b00; cin = 1;
    b = 2'b11; cin = 1;
    #20
    a = 2'b01; cin = 1;
    b = 2'b11;
    #20
    a = 2'b10; cin = 1;
    b = 2'b11;
    #20
    a = 2'b11; cin = 1;
    b = 2'b11;
    #20





   $finish;
  end
 
endmodule
