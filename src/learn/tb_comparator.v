`include "comparator.v"

module tb_comparator;
  parameter N = 8;
  reg [N:0] a = 8'b00000000;
  reg [N:0] b = 8'b00000111;
  wire o;
  integer i = 0;

  comparator myComp (.inA(a), .inB(b), .out(o) );

  initial
    begin
      $display ( "time A B out" );
      $monitor ( "%g %b %b %b %d" , $time, a, b, o, i);
      for (i=0; i< 255; i = i + 1)
      #5 a = a + 1;
    end
endmodule
