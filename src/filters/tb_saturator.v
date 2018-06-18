`include "saturator.v"

module tb_saturator ();

reg clk;
reg signed [4:0] D;
input signed [3:0] Q;
integer i;

sat #(3)dut (.D(D), .Q(Q));

initial
  begin
    D = 0;
    $monitor ( "%g, %d, %d" , $time, D, Q);
    for (i = 1; i < 28; i=i+1) begin
      #5 D = D + 1;
    end
    $finish;
  end
 // Clock generator
always begin
#5 clk = ~clk; // Toggle clock every 5 ticks
end
  
endmodule
