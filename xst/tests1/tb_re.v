//`include "counters.v"
//`include "uart.v"
`timescale 1ns/1ps


module XYZ (clk_br, data, rst, ready, tx, wr);
input  clk_br;
input  [7:0] data;
input  rst;
output ready;
output reg tx;
input  wr;

reg parity = 1'b0;
reg ready = 1'b0;
reg [7:0] buffer;
reg [3:0] counter = 4'b0000;
reg end_tx;

//assign end_tx = (counter == 4'b1011);

always @(posedge clk_br)
begin
   if (~ready) begin
    counter = counter + 1;
    case (counter)
      1: tx <= 1'b1;	    
      2: tx <= data[0];
      3: tx <= data[1];
      4: tx <= data[2];
      5: tx <= data[3];
      6: tx <= data[4];
      7: tx <= data[5];
      8: tx <= data[6];
      9: tx <= data[7];
      10: tx <= parity;
      11: tx <= 1'b1;
      12: end_tx = 1'b1;
      default: tx <= 1'b1;
   endcase
   end
end

always @(negedge wr)
begin
  buffer = data;
  ready = 1'b0;
  counter = 4'b0000;
  //parity = ^data;
  parity = (data[0] ^ data[1]) ^  
                     (data[2] ^ data[3]) ^ 
                     (data[4] ^ data[5]) ^  
                     (data[6] ^ data[7]);

  end_tx = 1'b0;
  tx = 1'b1;
end

always @(negedge rst or posedge end_tx)
begin
  ready <= 1'b1;
  tx <= 1'b1;
  counter <= 4'b0000;
  end_tx <= 1'b1;
  buffer <= 8'b00000000;
  parity <= 1'b0;
end

endmodule



/*---------------------------------------------
 test
---------------------------------------------*/
module tb_re();
reg clk, wr, rst; 
wire ready, tx;
integer i;

reg [7:0] data;

wire out;

//module XYZ (clk_br, data, rst, ready, tx, wr);
XYZ DUT1 (clk, data, rst, ready, tx, wr);

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT1);

      $monitor ( "time: %2g   clk: %b data: %b rst: %b ready: %b tx: %b wr: %b" , $time, clk, data, rst, ready, tx, wr);
      clk = 1'b1;
      data = 8'b10101010;
      wr = 1'b1;
      #10.4 rst = 1;
      #10.4 rst = 1;
      #10.4 rst = 1;
      #10.4 rst = 1;
      #10.4 rst = 0;
      #10.4 rst = 0; 
      #10.4 rst = 1; 
      #10.4 rst = 1; 
      #10.4 rst = 1; 
      #10.4 rst = 1; 
      #10.4 rst = 1; 
      #10.4 wr = 0; 
      #10.4 wr = 0; 
      #10.4 wr = 0; 
      #10.4 wr = 0; 
      #10.4 wr = 0; 
      #10.4 wr = 1; 
      #10.4 wr = 1; 
      #10.4 wr = 1; 
      #10.4 wr = 1; 
      #10.4 wr = 1; 
      #10.4 wr = 1; 
      for( i = 0; i < 20; i = i + 1)
         #10 wr = 1; 
      #10 wr = 0; data = 8'b10110011;
      #10 wr = 0; 
      #10 wr = 0; 
      for( i = 0; i < 20; i = i + 1)
         #10 wr = 1; 
      #10 wr = 1; 
      $finish;

    end

   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
