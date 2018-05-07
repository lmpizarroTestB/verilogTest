`include "segmentos.v"


module tb_segmentos();
wire [7:0] q3;
reg [7:0] d;
reg clk;
reg reset;

segmentos dut (q3, d, clk, reset);
initial 
 begin
   // vcd dump
   $dumpfile("simple.vcd");
   // the variable 's' is what GTKWave will label the graphs with
   $dumpvars(0, dut);
   $monitor ( "time: %2g   clk: %b d: %b q3: %b reset: %b" , $time, clk, d, q3, reset);
  clk=1;
  reset = 0;
  d=0;
  #5 reset=1;
  #10 reset=~reset;
  #20 d=8'b10010101;
  #45 $finish;  
 end
 // Clock generator
always begin
#5 clk = ~clk; // Toggle clock every 5 ticks
end

endmodule 
