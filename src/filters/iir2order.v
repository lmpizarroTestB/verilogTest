/*
  y(n) = (a0x(n) + a1x(n-1) + a2x(n-2) - b1y(n-1) - b2y(n-2)) / b0
*/
module iir2order (Clk, // Positive-Edge Clock
                CLR, // CLR Asynchronous Clear 
                  D, // Data Input
                  Q, // Data Output
              PARAM,
             SELPAR,
             MEMSEL);

  parameter Nbits = 16;
  parameter NbitsParam = 4;
  input Clk, CLR, MEMSEL;

  input signed [Nbits-1:0] D;
  output signed [Nbits-1:0] Q;

  input [2:0] SELPAR;
  input signed [NbitsParam - 1:0] PARAM;
  reg signed [Nbits:0] tmp = 0;
  reg signed [Nbits-1:0] Mpos=(1<<(Nbits-1)) - 1;
  reg signed [Nbits-1:0] Mneg=(1<<(Nbits-1));
  
  reg signed [NbitsParam - 1:0] a0, a1, a2, b0, b1, b2, attIn, attOut; 
  reg signed [Nbits-1:0] x1, x2, y1, y2; 
 
  always @(posedge MEMSEL)
  begin
     case (SELPAR)
       3'b000: a0 = PARAM;
       3'b001: a1 = PARAM;
       3'b010: a2 = PARAM;
       3'b011: b0 = PARAM;
       3'b100: b1 = PARAM;
       3'b101: b2 = PARAM;
       3'b110: attIn = PARAM;
       3'b110: attOut = PARAM;
     endcase 
  end

  always @(posedge Clk or posedge CLR)
  begin
      //$monitor ( "%g\t %d %d %d" , $time, D, y1, tmp);
    if (CLR) begin
      tmp = 0;
    end
    else
    begin
      tmp = D;

      x2 = x1
      x1 = D
 
      if (tmp < Mneg) tmp = Mneg;
         else if (tmp > Mpos) tmp = Mpos;
      y2 = y1
      y1 = tmp
     
      tmp = tmp>>attIn;


 
      tmp = tmp>>attOut;
    end
  end
 assign Q = tmp[Nbits-1:0];
endmodule
