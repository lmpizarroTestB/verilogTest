`include "diferentiatorB.v"


module tb_diferentiator();
  reg [7:0] d = 0;
  reg clk, reset;
  integer i = 0;
  wire [7:0] q3;

  //diferentiator dut (.data_out(q3), .data_in(d), .clk(clk), .rst_n(reset));
  diferentiator dut (.out(q3), .in(d), .clk(clk), .reset(reset));
  //firDiff dut (.out(q3), .in(d), .clk(clk), .reset(reset));
  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, dut);
    $monitor ( "time: %2g   clk: %b d: %b q3: %b reset: %b" , $time, clk, d, q3, reset);
    clk = 1;
    d = 0;
    #5 reset = 1;
    #5 reset =0;
      for (i=0; i< 125; i = i + 1)
      begin
      #5 d = d + 3;
      end
      $finish;
   end
   // Clock generator
   always begin
     #5 clk = ~clk; // Toggle clock every 5 ticks
   end

endmodule 
