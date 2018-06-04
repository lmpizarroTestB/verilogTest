`include "accumulators.v"
`timescale 1ns/1ps

module tb_mult_4();
reg [3:0] A;
reg [3:0] B;
wire [7:0] C;

reg level, clk;
 

mult_4 DUT (A, B, C);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b  A: %b B: %b, C: %b" , $time, clk, A,B, C);
      clk = 1;
      A = 4'b0000; B = 4'b0000;
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; // 
      #10 level = 0;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; A = 4'b0000; B = 4'b0001; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 0;
      #10 level = 0; A = 4'b0010; B = 4'b0001; //
      #10 level = 0;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 1; //
      #10 level = 1;
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; A = 4'b0010; B = 4'b0010; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b0011; B = 4'b0010; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b0010; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b0001; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b0010; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b0011; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b0100; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b0101; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b0110; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b0111; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b1000; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b1001; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b1010; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b1011; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b1100; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b1101; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; A = 4'b1111; B = 4'b1110; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; //
      #10 level = 0;
      #10 level = 0; //
      #10 level = 0; B = 4'b1111; A = 4'b1111; //
      #10 level = 0;
      #10 level = 0; //
      B10 level = 0; //
      #10 level = 0;
      #10 level = 0; //


















       $finish;
    end


   always begin
     #5 clk = ~clk; // Toggle clock every 5 ticks
   end

endmodule
