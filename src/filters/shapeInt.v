module shapeInt (C, // Positive-Edge Clock
                   CLR, // CLR Asynchronous Clear 
                     D, // Data Input
                     Q); // Data Output

  parameter N = 16;
  input C, CLR;
  input signed [N-1:0] D;
  output signed [N-1:0] Q;
  reg signed [N:0] tmp = 0;
  reg signed [N-1:0] Mpos=(1<<(N-1)) - 1;
  reg signed [N-1:0] Mneg=(1<<(N-1));
  
  parameter b1 = 1;
  
  reg signed [N-1:0] y1 = 0;
  
  always @(posedge C or posedge CLR)
  begin
    //$monitor ( "%g\t %d %d %d" , $time, D, y1, tmp);
    if (CLR) begin
      tmp = 0;
      y1 = 0;
    end
    else begin
      if ((y1 == 0) && (tmp > 0)) y1 = 1;	    
      if ((y1 == 0) && (tmp < 0)) y1 = -1;	    
      tmp = tmp + D - y1;
        
      if (tmp < Mneg) tmp = Mneg;
         else if (tmp > Mpos) tmp = Mpos;

      y1 = tmp>>b1;

      if (y1 < Mneg) y1 = Mneg;
        else if (y1 > Mpos) y1 = Mpos;

    end
  end
  assign Q = tmp[N-1:0];
endmodule
