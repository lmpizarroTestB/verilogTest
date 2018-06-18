module saturator #(parameter Nbits = 14)
                  (D, // Data Input
                     Q); // Data Output
  input signed [Nbits:0] D;

  output signed [Nbits-1:0] Q;

  // Constants value for filter saturation
  reg signed [Nbits-1:0] Mpos = (1<<(Nbits-1)) - 1;
  reg signed [Nbits-1:0] Mneg = (1<<(Nbits-1));

  reg signed [Nbits:0] tmp = 0;

  always @*
    begin
      tmp = D;
      if (tmp < Mneg) tmp = Mneg;
         else if (tmp > Mpos) tmp = Mpos;
   end
  assign Q = tmp[Nbits-1:0];
endmodule

/*
*
* Signed Arithmetic in Verilog 2001 – Opportunities and Hazards
* Dr. Greg Tumbush, Starkey Labs, Colorado Springs, CO
*	
*/
module sat #(parameter OUT_SIZE=4) (D, Q);
  parameter IN_SIZE = OUT_SIZE + 1; // Default is to saturate 22 bits to 21 bits

  input [IN_SIZE:0] D;
  output reg [OUT_SIZE:0] Q;
  
  wire [OUT_SIZE:0] max_pos = {1'b0,{OUT_SIZE{1'b1}}};
  wire [OUT_SIZE:0] max_neg = {1'b1,{OUT_SIZE{1'b0}}};

always @* begin
  // Are the bits to be saturated + 1 the same?
  if ((D[IN_SIZE:OUT_SIZE]=={IN_SIZE-OUT_SIZE+1{1'b0}}) ||
      (D[IN_SIZE:OUT_SIZE]=={IN_SIZE-OUT_SIZE+1{1'b1}}))
      
    Q = D[OUT_SIZE:0];
  else if (D[IN_SIZE]) // neg underflow. go to max neg
    Q = max_neg;
  else // pos overflow, go to max pos
    Q = max_pos;
  end
endmodule
