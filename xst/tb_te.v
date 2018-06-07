`include "counters.v"
`include "shift_registers.v"
`timescale 1ns/1ps

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


module ABCD_2 (clk_br, rst, rx, read, serialData);
input clk_br, rx, rst, read;
wire cnt10, cnt210, bit_clock;

reg [7:0] counter = 8'b00000000;
output [8:0] serialData;

SRS srs1(.clk(bit_clock), .si(bit_clock & rx), .q(serialData), .clr(rst), .z(read), .en(enable_shif_register));

parameter SIZE = 3;
reg   [SIZE-1:0] state;// Seq part of the FSM
reg   [SIZE-1:0] next_state;// combo part of FSM

reg enable_shif_register;

reg cen, ready = 1'b0;
reg int_reset = 1'b0;
assign cnt10 = counter == 8'b00001010;
assign cnt210 = counter == 8'b11010010;
assign bit_clock = (counter == BIT_2 | counter == BIT_0 
                   | counter == BIT_1 | counter == BIT_3
		   | counter == BIT_4 | counter == BIT_5
		   | counter == BIT_6 | counter == BIT_7
		   | counter == BIT_8);

localparam STATE_0 = 3'b000;
localparam STATE_1 = 3'b001;
localparam STATE_2 = 3'b010;
localparam STATE_3 = 3'b011;
localparam STATE_4 = 3'b100;

localparam BIT_0 = 8'b00011110; // 30
localparam BIT_1 = 8'b00110010; // 50
localparam BIT_2 = 8'b01000110; //70
localparam BIT_3 = 8'b01011010; //90
localparam BIT_4 = 8'b01101110; //110
localparam BIT_5 = 8'b10000010; //130
localparam BIT_6 = 8'b10010110; //150
localparam BIT_7 = 8'b10101010; //170
localparam BIT_8 = 8'b10111110; //150


always @(posedge clk_br)
  begin
  if (rst | int_reset) begin
    state = STATE_0;
    counter <= 8'b00000000;
    cen <= 1'b0;
    ready <= 1'b0;
  end else
   case (state)
    STATE_0:
	    if (rx)
	    state <= STATE_0;
            else begin
            cen = 1'b1;		    
	    state <= STATE_1;end
    STATE_1:
	    if (~rx & cnt10)
	      state <= STATE_2;
            else if (rx & cnt10) begin
	     state <= STATE_0;
	     int_reset <= 1'b1; end
    STATE_2:
	    if (cnt210 & rx == 1'b1) begin
	       state <= STATE_3;
	       ready = 1'b1; end 
	       else if (cnt210 & rx == 1'b0) begin
	         state <=STATE_0;
	         int_reset <= 1'b1; end
    STATE_3:
	    if (read) begin
	      state <= STATE_0;
	      int_reset <= 1'b1;
            end
    default: state <= STATE_0;
   endcase
  end

/*
inputs              |     states            |   out    | counter control
read    rst     rx     cnt      e	e+	dready	rstc	cen
x       1       x       0       0	0	0	 0	0
x       0       1       0       0	0	0	 0	0
x       0       0       0       0	1	0	 0	1
x       0       0       10      1	10	0	 0	1
x       0       1       10      1	0	0	 0	0
x       0       x       210     10	11	0	 1	0
x       0       0       210     10	0	0	 0	0
1       0       x       210     11	0	0	 1	0
*/

always @(posedge clk_br)
  if (cen) begin
   counter = counter + 1;
  end

endmodule



/*---------------------------------------------
 test
---------------------------------------------*/
module tb_te();
reg clk, rx, in, rst, read;

wire [8:0] serialData;

ABCD_2 DUT1 (clk, rst, rx, read, serialData);

integer i;

  initial 
    begin
    // vcd dump
    $dumpfile("simple.vcd");
    // the variable 's' is what GTKWave will label the graphs with
    $dumpvars(0, DUT1);

      $monitor ( "time: %2g   clk: %b rx: %b out: %b " , $time, clk, rx, serialData);
      clk = 1'b1;
      rx = 1'b1;
      read = 1'b0;
      #10 in = 1; rst = 0;
      #10 in = 1; rst = 0;
      #10 in = 1; rst = 1;
      #10 in = 1; rst = 1;
      #10 in = 1; rst = 1;
      #10 in = 1; rst = 1;
      #10 in = 0;
      #10 in = 0;
      #10 in = 1; rst = 0;
      #10 in = 1; rst = 0;
      #10 in = 1; rst = 0;
      #10 in = 0;
      #10 in = 0; 
      for (i =0; i < 40; i = i + 1)
         #10 rx = 0;   // bit 1 Start
      for (i =0; i < 40; i = i + 1)
         #10 rx = 1;   // bit 2
      for (i =0; i < 40; i = i + 1)
         #10 rx = 0;   // bit 3
      for (i =0; i < 40; i = i + 1)
         #10 rx = 1;   // bit 4
      for (i =0; i < 40; i = i + 1)
         #10 rx = 0;   // bit 5
      for (i =0; i < 40; i = i + 1)
         #10 rx = 1;   // bit 6
      for (i =0; i < 40; i = i + 1)
         #10 rx = 0;   // bit 7
      for (i =0; i < 40; i = i + 1)
         #10 rx = 1;   // bit 8
      for (i =0; i < 40; i = i + 1)
         #10 rx = 0;   // bit 9
      for (i =0; i < 40; i = i + 1)
         #10 rx = 1;   // bit paridad
      for (i =0; i < 40; i = i + 1)
         #10 rx = 1;  // stop bit
      for (i =0; i < 80; i = i + 1)
         #10 rx = 1;
      #10 read = 1;
      #10 read = 1;
      #10 read = 1;
      #10 read = 1;
      #10 read = 1;
      #10 read = 1;
      #10 read = 1;
      for (i =0; i < 80; i = i + 1)
         #10 read = 1;
         

      $finish;
    end

   always begin
     #10 clk = ~clk; // Toggle clock every 5 ticks
   end
endmodule
