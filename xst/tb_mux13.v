`include "uart.v"
`timescale 1ns/1ps

/*---------------------------------------------
 test
---------------------------------------------*/
module tb_te();
reg clk, in, rx;
integer i,j;
reg [3:0] sel;

wire out;

freq_sel DUT (clk, sel, out);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b rx: %b out: %b " , $time, clk, sel, out);
      clk = 1'b1;
      rx = 1'b1;
      for (i =0; i < 40*j; i = i + 1)
         #10 in = 0; sel =  4'b0000;
       for (i =0; i < 80; i = i + 1)
         #10 in = 0; sel = 4'b0001;
      for (i =0; i < 160; i = i + 1)
         #10 in = 0; sel = 4'b0010;
      #10 in = 0; rx=1;
      for (i =0; i < 320; i = i + 1)
         #10 in = 0; sel = 4'b0011;
      #10 in = 0; rx=0;
      for (i =0; i < 640; i = i + 1)
         #10 in = 0; sel = 4'b0100;
      #10 in = 0; rx=1;
      for (i =0; i < 1280; i = i + 1)
         #10 in = 0; sel = 4'b0101;
      for (i =0; i < 1280*2; i = i + 1)
         #10 in = 0; sel = 4'b0110;
      for (i =0; i < 1280*4; i = i + 1)
         #10 in = 0; sel = 4'b0111;
      /*
      for (i =0; i < 1280*8; i = i + 1)
         #10 in = 0; sel = 4'b1000;
      for (i =0; i < 1280*16; i = i + 1)
         #10 in = 0; sel = 4'b1001;
      for (i =0; i < 1280*32; i = i + 1)
         #10 in = 0; sel = 4'b1010;
      for (i =0; i < 1280*64; i = i + 1)
         #10 in = 0; sel = 4'b1011;
      for (i =0; i < 1280*128; i = i + 1)
         #10 in = 0; sel = 4'b1100;
      for (i =0; i < 1280*256; i = i + 1)
         #10 in = 0; sel = 4'b1101;
      */


      $finish;
    end

   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
