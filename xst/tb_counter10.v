`include "uart.v"

module one_shot_tb();
reg clk, level;

wire pulse;
reg rst;

counter10 DUT (clk, pulse, rst);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b  pulse: %b rst: %b" , $time, clk, pulse, rst);
      clk = 1;
      #5 level = 0; rst = 1;//
      #5 level = 0;
      #5 level = 0; // 
      #5 level = 0;
      #5 level = 1; rst = 0; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 0;
      #5 level = 0; //
      #5 level = 0;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 0;
      #5 level = 0; //
      #5 level = 0;
      #5 level = 0; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 0;
      #5 level = 0; //
      #5 level = 0;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 1; //
      #5 level = 1;
      #5 level = 0; //
      #5 level = 0;
      #5 level = 0; //
      #5 level = 0;
      #5 level = 0; //
       $finish;
    end


   always begin
     #5 clk = ~clk; // Toggle clock every 5 ticks
   end

endmodule
