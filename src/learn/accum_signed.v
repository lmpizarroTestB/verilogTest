module accum_signed (C, // Positive-Edge Clock
                   CLR, // CLR Asynchronous Clear 
                     D, // Data Input
                     Q); // Data Output

  parameter N = 16;
  input C, CLR;
  input signed [N-1:0] D;
  output signed [N-1:0] Q;
  reg signed [N:0] tmp = 0; //9'b000000000;
  reg signed [N-1:0] Mpos=(1<<(N-1)) - 1;
  reg signed [N-1:0] Mneg=(1<<(N-1));

  always @(posedge C or posedge CLR)
  begin
    //$monitor ( "%g\t %d" , $time, tmp);
    if (CLR) begin
      tmp = 0; //9'b000000000;
    end
    else begin
      tmp = tmp + D;
       
      if (tmp < Mneg) tmp = Mneg; // signed less than
        else if (tmp > Mpos) tmp = Mpos; // signed greater than
    end
  end
  assign Q = tmp[N-1:0];
endmodule
