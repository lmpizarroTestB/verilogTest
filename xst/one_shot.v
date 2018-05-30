//
//
//
//
module one_shot (clk, in, out, data, load, rst);

input clk, in, load, rst;
output  out;

input  [7:0] data;
reg [7:0] length = 8'b00000000;
reg [7:0] curr_length = 8'b00000000;

reg out = 1'b0;
reg run = 1'b0;

always @(posedge clk)
begin
 if (run == 1'b1) 
 begin
  out <= 1'b1;
  curr_length <= curr_length + 1; 
  if (curr_length ==  length + 1) begin
   run <= 1'b0;
   curr_length <= 8'b00000000;
   out <= 1'b0; end 
 end
end


always @(posedge in)
begin
 run <= 1'b1;
 curr_length <= 8'b00000000;
end

always @(posedge load)
begin
 length <= data;
end

always @(posedge rst)
begin
  if (rst) 
  begin
   run <= 1'b0;
   curr_length <= 8'b00000000;
   out <= 1'b0;
   length <= 8'b00000000;
  end
end

endmodule

//
//
//
//
module level_to_pulse(clk, level, pulse);
input clk, level;
output pulse;

reg pulse = 1'b0;
reg c = 1'b0;

 always @(posedge level or posedge clk or negedge clk)
 begin
  if (level) 
  begin
    if (~c) begin 
     pulse <= 1'b1; 
     c <= 1'b1; end
    else pulse <= 1'b0; end
  else begin
   c <= 1'b0;
   pulse <= 1'b0;
  end
 end

endmodule


module periodic_pulse (clk, start, out, data, load, rst);

input clk, start, load, rst;
output  out;

input  [7:0] data;
reg [7:0] length = 8'b00000000;
reg [7:0] curr_length = 8'b00000000;

reg out = 1'b0;
reg run = 1'b0;

always @(posedge clk)
begin
 if (run == 1'b1) 
 begin
  curr_length <= curr_length + 1; 
  if (curr_length ==  length + 1) begin
   out <= 1'b1;
   curr_length <= 8'b00000000; end
 end
end

always @(negedge clk)
begin
 if (out == 1'b1) out <= 1'b0; 
end

always @(posedge start)
begin
 run <= 1'b1;
 curr_length <= 8'b00000000;
end

always @(posedge load)
begin
 length <= data;
end

always @(posedge rst)
begin
  if (rst) 
  begin
   run <= 1'b0;
   curr_length <= 8'b00000000;
   out <= 1'b0;
   length <= 8'b00000000;
  end
end

endmodule

module pwmN #(parameter Nbits = 8)
  (clk, start, outw, data, load, rst);

input clk, start, load, rst;
output  out, outw;

input  [Nbits - 1:0] data;
reg [Nbits - 1:0] length = 10'b11111111;
reg [Nbits - 1:0] curr_length = 0;
reg [Nbits - 1:0] pulse_width = 0;
reg [Nbits - 1:0] curr_width = 0;

reg out = 1'b0;
reg outw = 1'b0;
reg run = 1'b0;

always @(posedge clk)
begin
 if (run == 1'b1) 
 begin
  curr_length <= curr_length + 1; 
  if (curr_length ==  length) begin
   out <= 1'b1;
   outw <= 1'b1;
   curr_length <= 0; end
 end
end

always @(posedge clk)
begin
 curr_width = curr_width + 1;
 if (curr_width == pulse_width) outw = 1'b0;
end


always @(negedge clk)
begin
 if (out == 1'b1) out <= 1'b0; 
end

always @(posedge start)
begin
 run <= 1'b1;
 curr_length <= 0;
end

always @(posedge load)
begin
 pulse_width <= data;
end

always @(posedge rst)
begin
  if (rst) 
  begin
   run <= 1'b0;
   curr_length <= 0;
   out <= 1'b0;
  end
end

endmodule


