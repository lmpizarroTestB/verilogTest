//
//
module RisingEdge_DFlipFlop(D, clk,Q);
 input D; // Data input 
 input clk; // clock input 
 output reg Q; // output Q 
 always @(posedge clk) 
 begin
  Q <= D; 
 end 
endmodule 


module tb_vector();
  reg d; 
  reg ck;
  output q;
  reg [14:0] t_vector[10000:0];

  RisingEdge_DFlipFlop dut(.D(d), .clk(ck), .Q(q));

  always
   begin
     ck = 1; #5; ck=0; #5;
   end

  initial
    begin
      $readmemb("pulse1B.tv", t_vector);
    end
endmodule
