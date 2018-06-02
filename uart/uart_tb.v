//`include "uart.v"
`timescale 1ns/1ps

module uart_tb();

reg clk, rx, rst;
wire out10, out20, outf;


integer i;


uart DUT (clk, rx, rst, out10, out20, outf);

  initial 
    begin
    // vcd dump
    $dumpfile("uart_tb.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, uart_tb);

      $monitor ( "time: %2g   clk: %b  rx: %b rst: %b out10: %b out20 %b outf %b" , $time, clk, rx, rst, out10, out20, outf);
      clk = 1;
      rx = 1'b1;
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 1;//
      #10 rst = 0;//
      #10 rst = 0;//
      #10 rst = 0;//
      #10 rst = 0;//
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      #10 rst = 1;rx = 1'b1; // 
      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b0;// stbit

      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b1;//bit0

      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b0;//bit1

      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b1;// bit2

      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b0;// bit3

      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b1;// bit4

      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b0;// bit5

      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b1;// bit6

      for (i=0; i<41;i=i+1)
        #10 rst = 1; rx = 1'b0;// bit7

      for (i=0; i<60;i=i+1)
        #10 rst = 1; rx = 1'b1;//stop bit + iddle

      for (i=0; i<30;i=i+1)
        #10 rst = 1; rx = 1'b0;// stbit



      #10 rst = 1; rx = 1'b1;//
      for (i=0; i<15;i=i+1)
        #10 rst = 1; rx = 1'b1;//
       $finish;
    end


   always begin
     #10 clk = ~clk; // Toggle clock every 10 ticks
   end

endmodule
