`include "saturator.v"

module tb_saturator ();

reg clk;
reg signed [8:0] D;
input signed [7:0] Q;
integer i;

saturator #(8)dut (.D(D), .Q(Q));

initial
  begin
    D = 0;
    $monitor ( "%g, %d, %d" , $time, D, Q);
    for (i = 1; i < 1024; i=i+1) begin
      #5 D = D + 1;
    end
  end
 // Clock generator
always begin
#5 clk = ~clk; // Toggle clock every 5 ticks
end
  
endmodule
