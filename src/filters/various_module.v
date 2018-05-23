module Freq_Divider #(parameter Nbits = 8)
                    (clk, Q);
  input clk;
  output  Q;

  reg tmp = 0;

  reg [Nbits-1:0] counter = (1<<(Nbits-1));

  always @(posedge clk )
  begin
    counter = counter - 1;
    if (counter == 0)
      begin
       tmp <= ~tmp;
       counter = (1<<(Nbits-1));
      end
  end
  assign Q = tmp;
endmodule

module Shift_Register #(parameter Nbits = 16)
  (clk, D, Q, en, reset);

  input clk, reset, en, D;
  output [Nbits-1:0] Q;
  reg [Nbits-1:0] Q;

  always @(posedge reset or posedge clk )
    begin
      if (reset == 1)
	Q <=0;
      else if (en)
	Q <= {Q[Nbits-2:0], D};
    end

endmodule

module Discriminator #(parameter Nbits = 16)
       (DUL, LL, clk, xn, yn, mode, Q);

  input clk, mode;
  input [Nbits-1:0] DUL;
  input [Nbits-1:0] LL;
  input [Nbits-1:0] xn;
  output Q;
  output [Nbits-1:0] yn;

  reg [Nbits-1:0] tmp;
  reg [Nbits-1:0] UL;
  reg [Nbits-1:0] MAX_ = 1<<Nbits;
  reg Q_;

  always @(posedge clk)
    begin
      if (mode) begin
        UL = DUL + LL;
        if (UL < LL) UL = MAX_;
        if (xn > LL && xn < UL)
        begin
          tmp = xn;
	  Q_ = 1;
        end  
        else
        begin
	  tmp = 0;
	  Q_ = 0;
        end  
      end
      else begin
        if (xn > LL)
	begin
          tmp = xn;
	  Q_ = 1;
	end
        else
	begin
	  tmp = 0;
	  Q_ = 0;
        end
      end	      
    end
    assign yn = tmp;
    assign Q = Q_;
endmodule
