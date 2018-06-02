//`include "components.v"

module main (clk_br, rx, rst, out10, out20, outf);

  input clk_br, rx, rst;
  output out10, out20, outf;

  wire clk1, cnt10Out, rst1, bitClk, cnt9Out, bitVal; 
  wire q1, q2;

  wire [4:0] cnt10; 
  wire [4:0] cnt20; 
  wire [7:0] cnt9;

  assign clk1 = ~(rx | q2);
  assign stbitok = cnt10Out & (~rx);
  
  assign bitClk = cnt20 == 5'd20; 
  assign cnt9Out = cnt9 == 8'd190; 
  assign cnt10Out = cnt10 == 5'd10;
  assign bitVal = bitClk & rx;
  assign rst1 = ~cnt10Out;
  
  dffa1   dffq1(.clk(clk1), .arst(rst1), .d(1'b1), .q(q1));
  counter5 cnt51(.clk(clk_br), .rst(~rst | cnt10Out), .en(q1), .count(cnt10));
  
  dffa1   dffq2(.clk(stbitok), .arst(~rst | ~cnt9Out), .d(1'b1), .q(q2));
  
  counter5 cnt5(.clk(clk_br), .rst(~rst | bitClk), .en(q2), .count(cnt20));
  counter8 cnt61(.clk(clk_br), .rst(~rst | stbitok), .en(q2), .count(cnt9));

endmodule
