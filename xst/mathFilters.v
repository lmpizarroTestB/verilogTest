module addS #(parameter Nbits=4)(A,B,C, satpos, satneg);
input signed [Nbits-1:0] A, B;
output signed [Nbits:0] C;
output satneg, satpos;

localparam  maxNeg = -2**(Nbits-1);
localparam  maxPos = 2**(Nbits-1) - 1;

reg signed [Nbits:0] tmp;

 always @(A,B)
  begin
        tmp=A+B;
	if (tmp<maxNeg) tmp=maxNeg;
	if (tmp>maxPos) tmp=maxPos;
  end
  assign C = tmp[4:0];
endmodule

module addSB #(parameter Nbits=4)(A,B,C, satpos, satneg);
input [Nbits-1:0] A, B;
output [Nbits-1:0] C;
output reg satneg, satpos;


reg [Nbits:0] tmp;

 always @(A,B)
  begin
    tmp=A+B;
      if (A[3] == B[3])
	 if (tmp[3]!=B[3])
	    if (tmp[3]==1'b0)
	         tmp=5'b01000;
	         else
	         tmp=5'b00111;
  end
  assign C = tmp[3:0];
endmodule




module tb_addS();
reg signed [3:0] a, b;
wire signed  [3:0] c;
wire  pos, neg;
integer i;

addSB DUT (.A(a), .B(b), .C(c), .satneg(neg), .satpos(pos));

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
