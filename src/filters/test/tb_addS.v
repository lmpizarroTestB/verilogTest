
module tb_addS();
reg signed [3:0] a, b;
wire signed  [3:0] c;
wire  pos, neg;
integer i;

addS DUT (.A(a), .B(b), .C(c));

  initial begin
    $dumpfile("simple.vcd");
    $monitor ("time %g   A %d %b  B %d %b   C %d  %b pos %b neg %b",$time, a, a, b, b, c,c,  pos, neg );
    $dumpvars(0, DUT);
    #20
    /*    
    a = 4'b1001;
    b = 4'b0111; $display("-7 + 7");
    #20
    a = 4'b1000;
    b = 4'b1000;  $display("-8 + -8");
    #20
    a = 4'b0110; $display ("5 + 6");
    b = 4'b0101;
    #20
  
    a = 4'b1111;$display ("-1 + 1 zero");
    b = 4'b0001;
    #20

    a = 4'b0100;$display ("4 + 2 zero");
    b = 4'b0010;
    #20
    a = 4'b0100;$display ("4 + 3 zero");
    b = 4'b0011;
    #20
    a = 4'b1100;$display ("-4 + -3 zero");
    b = 4'b1101;
    */
    #20 a = 4'b0111;
    //#20 a = 4'b1110;
    for (i=0; i<16; i = i+1)
	  #20   b=7-i;

   /*
    #20
    a = 5'b11100;
    b = 5'b00010;
    #20
    */
   $finish;
  end
endmodule
