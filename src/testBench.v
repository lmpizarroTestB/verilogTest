`include "RisingEdge_DFlipFlop_SyncReset.v"

// `timescale 1ns/1ps;
// FPGA projects using Verilog/ VHDL 
// fpga4student.com
// Verilog code for D Flip FLop
// Testbench Verilog code for verification

module tb_DFF();
reg D;
reg clk;
reg reset;
wire Q;

RisingEdge_DFlipFlop_SyncReset dut(D,clk,reset,Q);


initial 
 begin
   //$display ( "ti   c D Q R" );
   // vcd dump
   $dumpfile("simple.vcd");
   // the variable 's' is what GTKWave will label the graphs with
   $dumpvars(0, dut);
   $monitor ( "%2g   %b %b %b %b" , $time, clk, D, Q, reset);
  clk=1;
  reset = 0;
  D=0;
  #5 reset=1;
  #10 reset=~reset;
  #0 D=1;
  #10 reset=~reset;
  #10 reset=~reset;
  #20 D = 0;
  #45 $finish;  
 end 
 
 // Clock generator
always begin
#5 clk = ~clk; // Toggle clock every 5 ticks
end

endmodule 
