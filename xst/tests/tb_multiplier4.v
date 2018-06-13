`include "../accumulators.v"

module mult (B,C);
input [3:0] B;
output [7:0] C;


function [7:0] mult_4x3;
input [3:0] AA;

case (AA)
  4'h0: mult_4x3=8'h00;
  4'h1: mult_4x3=8'h03;
  4'h2: mult_4x3=8'h06;
  4'h3: mult_4x3=8'h09;
  4'h4: mult_4x3=8'h0C;
  4'h5: mult_4x3=8'hFF;
  4'h6: mult_4x3=8'h12;
  4'h7: mult_4x3=8'h15;
  4'h8: mult_4x3=8'h18;
  4'h9: mult_4x3=8'h1B;
  4'hA: mult_4x3=8'h1E;
  4'hB: mult_4x3=8'h21;
  4'hC: mult_4x3=8'h24;
  4'hD: mult_4x3=8'h27;
  4'hE: mult_4x3=8'h2A;
  4'hF: mult_4x3=8'h2D;
endcase
endfunction

assign C = mult_4x3(B);
endmodule

module tb_multiplier4();
 
  reg [3:0] a, b;
  wire [7:0] out;
  reg cin; 
  wire cout; 
  wire [3:0] p; 
  wire [3:0] g;

  integer i,j;
 
  multiplier_4  DUT (
    .A(a),
    .B(b),
    .C(out)
  );
 
  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %d   B %d   C %d  ",$time, a, b, out);
    $dumpvars(0, DUT);
    #20
    /*    
    a = 0; cin = 1'b1; b = 4'b0000; 
    #20
    a = 1; cin = 1'b0; b = 4'b0001; //  1000
    #20
    a = 2; b = 4'b0001;
    #20
    a = 3; b = 4'b0001;
    #20
    a = 4; cin = 0; b = 4'b0001; cin = 0;
    #20
    a = 5; cin = 0; b = 4'b0001;
    #20
    a = 6; cin = 0; b = 4'b0001;
    #20
    a = 7; cin = 1; b = 4'b0001;
    #20
    a = 8; cin = 1; b = 4'b0001;
    #20
    a = 9; cin = 1; b = 4'b0001;
    #20
    a = 10; cin = 1; b = 4'b0001;
    #20
    a = 11; cin = 1; b = 4'b0001;
    #20
    a = 12; cin = 1; b = 4'b0001;
    #20
    a = 13; cin = 1; b = 4'b0001;
    #20
    a = 14; cin = 1; b = 4'b0001;
    #20
    a = 15; cin = 1; b = 4'b0001;
    #20
    b = 4'b0010;
    */
    a=0;
    b=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;
    #20 b=1; a=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;
    #20 b=2; a=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;
    #20 b=3; a=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;
    #20 b=4; a=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;
    #20 b=5; a=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;
    #20 b=6; a=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;
    #20 b=7; a=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;
    #20 b=8; a=0;
    for (i = 0; i < 16; i = i + 1)
        #20 a = i; cin = 1;




















   $finish;
  end
 
endmodule
