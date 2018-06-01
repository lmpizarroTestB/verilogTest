module ABCD (clk, rx, out);

input clk, rx;
output out;

reg start_;
reg mid_start_bit;
reg end_cnt10;
reg bit_pulse;
reg [3:0] cnt10;
reg [4:0] cnt20;
reg [7:0] cntFrame; 

initial
begin
  start_ = 1'b0;
  mid_start_bit = 1'b0;
  end_cnt10 = 1'b0;
  bit_pulse = 1'b0;
  cnt10 = 4'b0000;
  cnt20 = 5'b0000;
  cntFrame = 8'b00000000; 
end

always @(negedge rx)
begin
  start_<=1'b1;
  bit_pulse <= 0;
end

always @(posedge clk)
begin
  if (start_) cnt10 = cnt10 + 4'b0001;
  else cnt10 = 4'b0000;
  if (cnt10 == 4'b1010) begin
   end_cnt10 <= 1'b1;
   start_ <= 1'b0;
  end
end

always @(posedge clk)
begin
 if (end_cnt10 == 1'b1) begin 
  end_cnt10 <= 1'b0;
  cnt10 <=  4'b0000;
 end	
end

always @(posedge end_cnt10)
begin
  mid_start_bit <=~rx?1'b1:1'b0;
end

always @(posedge clk)
begin
  if (mid_start_bit) begin
   cntFrame <= cntFrame + 8'b00000001;
   cnt20 <= cnt20 + 5'b00001;
   if (cntFrame == 220) begin
     cntFrame <= 5'b00000;
     mid_start_bit <= 1'b0;
     bit_pulse <= 1'b0;
   end

   if (cnt20==5'b10100)begin
      cnt20 <= 5'b00000;
      bit_pulse <= 1'b1;
   end

  end
end


always @(posedge clk)
begin
  if (mid_start_bit) begin
    if (bit_pulse) bit_pulse <= 0;
end
end

assign out = bit_pulse;
endmodule


