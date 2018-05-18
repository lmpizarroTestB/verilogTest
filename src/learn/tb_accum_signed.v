/* 
Full Adder Module for bit Addition 
Written by referencedesigner.com 
*/
`timescale 1ns / 100ps 
`include "accum_signed.v"
module tb_accum_signed; 
  // Declare inputs as regs and outputs as wires
  parameter N = 16;
  reg clock, reset;
  reg signed [N-1:0] data;
  wire signed [N-1:0] out;
  reg signed [N-1:0] Mpos=(1<<(N-1)) - 1;
  reg signed [N-1:0] Mneg=(1<<(N-1));
 
  accum_signed uut (
    .C(clock),
    .CLR(reset),
    .D(data),
    .Q(out)
  );
 

// Initialize all variables
initial 
  begin
   $display ( "time, ck, clr, data, out" );
   $monitor ( "%g, %b, %b, %d, %d" , $time, clock, reset, data, out);
   clock = 1; // initial value of clock
   reset = 0; // initial value of reset
   data = 0; // initial value of enable
   #5 reset = 1; // Assert the reset
   #10 reset = 0; // De−assert the reset
   #5 data = 400; //8'b00000010; // Assert enable
   #30 data = 0; //8'b00010000;
   #100 data = -400; // De−assert enable
   #1400 $finish; // Terminate simulation
  end

// Clock generator
always begin
#5 clock = ~clock; // Toggle clock every 5 ticks
end
 
endmodule
