//
//
//
//
module pulse_to_level 
  (clk, 
   trigger, 
   out, 
   data, 
   load, 
   rst);

input clk, trigger, load, rst;
output  out;


input [7:0] data;
reg [7:0] length = 8'b00000000;
reg [7:0] curr_length = 8'b00000000;

reg run = 1'b0;

assign out = run;

always @(posedge clk)
begin
 if (run) 
 begin
  curr_length <= curr_length + 1; 
  if (curr_length ==  length) begin
   run <= 1'b0;
   curr_length <= 8'b00000000;
   end 
 end
end


always @(posedge trigger)
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

reg c = 1'b0;

assign pulse = c;

always @(posedge level)
begin
    if (!c) c <= 1'b1; 
end

always @(negedge clk)
begin
 if (c==1'b1) c=1'b0;
end
endmodule

//
//
//
//
module periodic_pulse (clk, start, out, data, load, rst);

input clk, start, load, rst;
output  out;

input  [7:0] data;
reg [7:0] length = 8'b00000000;
reg [7:0] curr_length = 8'b00000000;

reg run = 1'b0;

assign out = run;

always @(posedge clk)
begin
 begin
  curr_length <= curr_length + 1; 
  if (curr_length ==  length) begin
   run <= 1'b1;
   curr_length <= 8'b00000000; end
 end
end

always @(negedge clk)
begin
 if (run == 1'b1) run = 1'b0; 
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
   length <= 8'b00000000;
  end
end

endmodule


//
//
//
//
module pwmN #(parameter Nbits = 8)
  (clk, start, outw, data, load, rst);

 input clk, start, load, rst;
 output outw;

 input  [Nbits - 1:0] data;

 reg outw = 1'b0;
 reg run = 1'b0;

 reg [Nbits - 1:0] length = 8'b11111111;
 reg [Nbits - 1:0] curr_length = 0;
 reg [Nbits - 1:0] pulse_width = 0;
 reg [Nbits - 1:0] curr_width = 0;

 always @(posedge clk)
 begin
  if (run == 1'b1) 
  begin
   curr_length = curr_length + 1;
   if (curr_length ==  length) 
   begin
    outw <= 1'b1;
    curr_width = 0;
   end
  end  
 end

 always @(posedge clk)
 begin
  curr_width = curr_width + 1;
  if (curr_width == pulse_width) 
  begin
   curr_width = 0;
   outw = 1'b0; 
  end
  else begin
   curr_width = curr_width; 
  end
 end

 always @(posedge start)
 begin
  if (start) 
   run <= 1'b1;
 end

 always @(posedge load)
 begin
  if (load) 
    pulse_width <= data;
 end

 always @(posedge rst)
 begin
   if (rst) 
   begin
    run <= 1'b0;
   end
 end
endmodule
//
//
//
//
module pwm(clk, outpwm, pulse_width, load);
 input load, clk;
 input [7:0] pulse_width;
 reg [7:0] curr_width;
 reg [7:0] counter = 0;
 wire outpulse;
 output outpwm;

 reg init_count = 0;

 assign outpulse = (counter == 1'd0);
 assign outpwm = init_count;


 always @(posedge clk) 
 begin
   counter <= (counter + 1'd1);
   curr_width <= (curr_width + 1'd1);
   if (curr_width == pulse_width) init_count = 0; 
 end

 always @(posedge outpulse)
 begin
   init_count <= 1'b1; 
   curr_width = 0;
 end

endmodule

