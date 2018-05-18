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
  
  parameter b1 = 8;
  
  reg signed [N-1:0] y1 = 0;
  

  always @(posedge C or posedge CLR)
  begin
    //$monitor ( "%g\t %d" , $time, y1);
    if (CLR) begin
      tmp = 0;
      y1 = 0;
    end
    else begin
      tmp = tmp + (D>>2) - (y1>>b1);
       
      if (tmp < Mneg) tmp = Mneg;
        else if (tmp > Mpos) tmp = Mpos;
      y1 = tmp;
    end
  end
  assign Q = tmp[N-1:0];
endmodule
