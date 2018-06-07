`include "shift_registers.v"
`timescale 1ns/1ps

module tb_counter20();
reg clk, si, en;

wire [8:0] q;
reg clr, z;

SRS DUT (clk, si, q, clr, z, en);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT);

      $monitor ( "time: %2g   clk: %b  si: %b q: %b clr: %b z: %b en: %b" , $time, clk, si, q, clr, z, en);
      clk = 1;
      si = 0;
      z = 0;
      en = 0;
      #10 clr = 1;//
      #10 clr = 1;//
      #10 clr = 1;//
      #10 clr = 0;//
      #10 clr = 0; en = 1'b1;//
      #10 clr = 0;//
      #10 clr = 0;//
      #10 clr = 0; si = 1'b1;//
      #10 clr = 0; si = 1'b1;//

      #10 clr = 0; si = 1'b0;//
      #10 clr = 0; si = 1'b0;//

      #10 clr = 0; si = 1'b1;//
      #10 clr = 0; si = 1'b1;//

      #10 clr = 0; si = 1'b0;//
      #10 clr = 0; si = 1'b0;//

      #10 clr = 0; si = 1'b1;//
      #10 clr = 0; si = 1'b1;//

      #10 clr = 0; si = 1'b0;//
      #10 clr = 0; si = 1'b0;//

      #10 clr = 0; si = 1'b1;//
      #10 clr = 0; si = 1'b1;//

      #10 clr = 0; si = 1'b0;//
      #10 clr = 0; si = 1'b0;//

      #10 clr = 0; si = 1'b1;//
      #10 clr = 0; si = 1'b1; en = 1'b0;//

      #10 clr = 0; si = 1'b0;z = 1'b1; // 
      #10 clr = 0; si = 1'b0;z = 1'b1; //

      #10 clr = 0; si = 1'b1;z = 1'b1; // 
      #10 clr = 0; si = 1'b1;z = 1'b1; //
       $finish;
    end


   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end

endmodule
