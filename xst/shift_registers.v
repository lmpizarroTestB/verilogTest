/*

 y = x + y(n-1) - y(n-2) / 32 - y(n-3) / 8 - x(n-1)/32 

 A6+B5-B4/32-B3/8-A5/32

 shit registers

 Xilinx Synthesis Technology
(XST) User Guide

 https://www.electronicshub.org/shift-registers/

search: 4 bit shift register
*/

/*
Following is the Verilog code for an 8-bit shift-left register with a
positive-edge clock, serial in, and serial out.
*/

/*
8-bit Shift-Left Register with 

Positive-Edge Clock,
Serial In, and 
Serial Out

IO Pins Description
-------------------
C  Positive-Edge Clock
SI Serial In
SO Serial Output

*/
module shift_0 (C, SI, SO);
  input C,SI;
  output SO;
  reg [7:0] tmp;

  always @(posedge C)
    begin
    tmp = tmp << 1;
    tmp[0] = SI;
  end
  assign SO = tmp[7];
endmodule

/*
8-bit Shift-Left Register with 

Negative-Edge Clock,
Clock Enable, 
Serial In, and 
Serial Out

IO Pins Description
C  Negative-Edge Clock
SI Serial In
CE Clock Enable (active High)
SO Serial Output
*/

module shift_1 (C, CE, SI, SO);
  input C,SI, CE;
  output SO;
  reg [7:0] tmp;

  always @(negedge C)
  begin
    if (CE)
    begin
      tmp = tmp << 1;
      tmp[0] = SI;
    end
  end
  assign SO = tmp[7];
endmodule

/*
8-bit Shift-Left Register with 

Positive-Edge Clock,
Asynchronous Clear, 
Serial In, and 
Serial Out

IO  Pins Description
C   Positive-Edge Clock
SI  Serial In
CLR Asynchronous Clear (active High)
SO  Serial Output
*/
module shift_2 (C, CLR, SI, SO);
  input C,SI,CLR;
  output SO;
  reg [7:0] tmp;
  always @(posedge C or posedge CLR)
  begin
  if (CLR)
    tmp = 8'b00000000;
  else
    begin
     tmp = {tmp[6:0], SI};
    end
  end
  assign SO = tmp[7];
endmodule


/*
8-bit Shift-Left Register with 

Positive-Edge Clock,
Synchronous Set, 
Serial In, and 
Serial Out

Pag 84

IO Pins Description
C Positive-Edge Clock
SI Serial In
S Synchronous Set (active High)
SO Serial Output
*/


module shift_3 (C, S, SI, SO);
 input C,SI,S;
 output SO;
 reg [7:0] tmp;

 always @(posedge C)
 begin
  if (S)
   tmp = 8'b11111111;
  else
  begin
   tmp = {tmp[6:0], SI};
  end
 end

 assign SO = tmp[7];
endmodule

/*
8-bit Shift-Left Register with 
Positive-Edge Clock,
Serial In, and 
Parallel Out
Pag 86

IO Pins Description
C Positive-Edge Clock
SI Serial In
PO[7:0] Parallel Output
*/
module shift_4 (C, SI, PO);
 input C,SI;
 output [7:0] PO;
 reg [7:0] tmp;
 always @(posedge C)
 begin
  tmp = {tmp[6:0], SI};
 end
 assign PO = tmp;
endmodule

/*
8-bit Shift-Left Register with 
Positive-Edge Clock,
Asynchronous Parallel Load, 
Serial In, and 
Serial Out
Pag 88

IO Pins Description
C      Positive-Edge Clock
SI     Serial In
ALOAD  Asynchronous Parallel Load (active High)
D[7:0] Data Input
SO     Serial Output
*/

module shift_5 (C, ALOAD, SI, D, SO);
 input C,SI,ALOAD;
 input [7:0] D;
 output SO;
 reg [7:0] tmp;

 always @(posedge C or posedge ALOAD)
 begin
  if (ALOAD)
   tmp = D;
  else
  begin
   tmp = {tmp[6:0], SI};
  end
 end
 assign SO = tmp[7];
endmodule

/*
8-bit Shift-Left Register with 
Positive-Edge Clock,
Synchronous Parallel Load, 
Serial In, and 
Serial Out
Pag 89

IO     Pins Description
C      Positive-Edge Clock
SI     Serial In
SLOAD  Synchronous Parallel Load (active High)
D[7:0] Data Input
SO     Serial Output
*/
module shift_6 (C, SLOAD, SI, D, SO);
 input C,SI,SLOAD;
 input [7:0] D;
 output SO;
 reg [7:0] tmp;
 always @(posedge C)
 begin
  if (SLOAD)
   tmp = D;
  else
 begin
  tmp = {tmp[6:0], SI};
 end
 end
 assign SO = tmp[7];
endmodule


/*
8-bit Shift-Left/Shift-Right Register with 
Positive-Edge Clock, 
Serial In, and 
Parallel Out

Pag 91

IO         Pins Description
C          Positive-Edge Clock
SI         Serial In
LEFT_RIGHT Left/right shift mode selector
PO[7:0]    Parallel Output
*/

module shift_7 (C, SI, LEFT_RIGHT, PO);
 input C,SI,LEFT_RIGHT;
 output PO;
 reg [7:0] tmp;
 always @(posedge C)
 begin

  if (LEFT_RIGHT==1'b0)
   begin
    tmp = {tmp[6:0], SI};
   end
  else
   begin
    tmp = {SI, tmp[6:0]};
   end
 end
 assign PO = tmp;
endmodule

/*
8-bit Shift-Left/Shift-Right Register with 
Positive-Edge Clock, 
Paralell In 
Parallel Out, and
SI         Serial In

*/

/*
8-bit Shift-Left Register with 
Positive-Edge Clock,
Asynchronous Parallel Load, 
Serial In, and 
Serial Out
Pag 88

IO Pins Description
C      Positive-Edge Clock
SI     Serial In
ALOAD  Asynchronous Parallel Load (active High)
D[7:0] Data Input
SO     Serial Output
*/

module shift_8 #(parameter Nbits = 8) 
 (C, ALOAD, D, Q, LEFT_RIGHT);
 
 input C, ALOAD, LEFT_RIGHT;
 input [Nbits-1:0] D;
 output [Nbits-1:0] Q;
  
 reg [Nbits-1:0] tmp;

 always @(posedge C or posedge ALOAD)
 begin
  if (ALOAD)
   tmp <= D;
  else begin
  if (C)
   tmp <= LEFT_RIGHT? tmp<<1: tmp>>1;
  end
 end
 assign Q = tmp;
endmodule

/*
16-bit dynamic shift register.

The following table shows pin definitions for a dynamic register. The
register can be either serial or parallel; be left, right or parallel; have a
synchronous or asynchronous clear; and have a width up to 16 bits.
Pag 93 2-69 XST User Guide

IO Pins Description
---------------------
Clk   Positive-Edge Clock
SI    Serial In
AClr  Asynchronous Clear (optional)
SClr  Synchronous Clear (optional)
SLoad Synchronous Parallel Load (optional)

Data           Parallel Data Input Port (optional)
ClkEn          Clock Enable (optional)
LeftRight      Direction selection (optional)
SerialInRight  Serial Input Right for Bidirectional Shift Register (optional)
PSO[x:0]       Serial or Parallel Output

*/
module dynamic_srl (Q,CE,CLK,D,A);
input CLK, D, CE;
input [3:0] A;
output Q;
reg [15:0] data;
assign Q = data[A];
always @(posedge CLK)
begin
if (CE == 1'b1)
{data[15:0]} <= {data[14:0], D};
end
endmodule
