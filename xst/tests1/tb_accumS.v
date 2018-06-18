
module tb_addS();
parameter nbits = 16;
reg signed [nbits-1:0] a, b;
wire signed  [nbits-1:0] c;
wire  pos, neg;
integer i;

reg clk, clr;

accumS  #(.Nbits(nbits)) DUT (.clk(clk), .D(a), .Q(c), .clr(clr));

  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %d  C %d  clr %b",$time, a,  c,  clr);
    $dumpvars(0, DUT);
    #10
    clk = 1;
    a=0;
    #10 clr = 0;
    #10 clr = 0;
    #10 clr = 0;
    #10 clr = 1;
    #10 clr = 1;
    #10 clr = 1;
    #10 clr = 0;
    #10 clr = 0; a=100;
    for (i=0; i< 210; i = i+ 1)
       #10 clr = 0;
    #10 clr = 0; a=0;
    for (i=0; i< 110; i = i+ 1)
       #10 clr = 0;


   $finish;
  end
    always begin
     #5 clk = ~clk; // Toggle clock every 5 ticks
   end


endmodule
