`include "flipFlops.v"

module one_shot_tb();
reg clk, level;

wire pulse;

flop_0 DUT (clk, level, pulse);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b level: %b pulse: %b " , $time, clk, level, pulse);
      clk = 1;
      #5 level = 0;
      #5 level = 0;
      #5 level = 0;
      #5 level = 0;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 0;
      #5 level = 0;
      #5 level = 0;
      #5 level = 0;
      #5 level = 0;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 1;
      #5 level = 0;
      #5 level = 0;
      #5 level = 0;
      #5 level = 0;
      #5 level = 0;
       $finish;
    end


   always begin
     #5 clk = ~clk; // Toggle clock every 5 ticks
   end

endmodule
