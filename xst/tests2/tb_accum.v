module tb_accum();
  reg [3:0] x;
  wire [3:0] out;
  reg clk, clr;
 
  accum  DUT (.C(clk), .CLR(clr), .D(x), .Q(out));

  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   x %b   y %b   clk %b   clr %b ",$time, x, out, clk, clr);
    $dumpvars(0, DUT);

    #10 x=0;clk=1'b1; clr=1'b0;
    #10 clr=1'b0;
    #10 clr=1'b1;
    #10 clr=1'b1;
    #10 clr=1'b0;
    #10 clr=1'b0;
    #10 x = 4'b0010;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    #10 x = 4'b0001;
    
    #10 $finish;

  end
  always begin
	clk = 1;  
       forever #10 clk = ~clk; // Toggle clock every 5 ticks
  end

endmodule
