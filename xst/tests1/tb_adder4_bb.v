
module tb_adder4_bb();
 
  reg [3:0] a, b;
  wire [3:0] out;
  reg cin; 
  wire cout; 
  integer i;

 
  adder4_b  DUT (
    .Cin(cin),
    .A(a),
    .B(b),
    .S(out),
    .Cout(cout)
  );
 
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %b   B %b   S %b   Cin %b Cout %b ",$time, a, b, out, cin, cout);
    $dumpvars(0, DUT);
    cin=1'b0; 
    #20
    b = 4'b0000; cin = 1'b0;
    a = 4'b0000; cin = 1'b0;
    /*
    for (i=0; i<16; i=i+1)
	#20 a=i;
    b = 4'b0001; cin = 1'b0;
    for (i=0; i<16; i=i+1)
	#20 a=i;

    b = 4'b0010; cin = 1'b0;
    for (i=0; i<16; i=i+1)
	#20 a=i;

    b = 4'b0101; cin = 1'b0;
    for (i=0; i<16; i=i+1)
	#20 a=i;

    b = 4'b0110; cin = 1'b0;
    for (i=0; i<16; i=i+1)
	#20 a=i;

    b = 4'b0111; cin = 1'b0;
    for (i=0; i<16; i=i+1)
	#20 a=i;


    b = 4'b1001; cin = 1'b0;
    for (i=0; i<16; i=i+1)
	#20 a=i;

    b = 4'b1010; cin = 1'b0;
    for (i=0; i<16; i=i+1)
	#20 a=i;

    */
    b = 4'b1111; cin = 1'b0;
    for (i=0; i<16; i=i+1)
	#20 a=i;



   $finish;
  end
 
endmodule
