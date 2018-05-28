`include "one_shot.v"

module one_shot_tb();
reg clk, in, rst;
reg [7:0] dur;

wire out;
// one_shot (clk, in, out, dur, rst);

one_shot DUT (clk, in, out, dur, rst);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b in: %b out: %b dur: %b rst: %b" , $time, clk, in, out, dur, rst);
      rst = 1'b0;
      dur = 8'b00001010;
      clk = 1;
      #5 in = 0;
      #5 in = 1;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 1;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0; 
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;
      #5 in = 0;

      $finish;
    end

   always begin
     #5 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
