/*
 Flip-flop with Positive-Edge Clock
Pag 39
IO Pins Description
-------------------
D Data Input
C Positive Edge Clock
Q Data Output

*/

module flop_0 (C, D, Q);
 input C, D;
 output Q;
 reg Q;
 always @(posedge C)
 begin
  Q = D;
 end
endmodule

/*
Flip-flop with Negative-Edge Clock and
Asynchronous Clear
Pag. 40

IO Pins Description
-------------------
D Data Input
C Negative-Edge Clock
CLR Asynchronous Clear (active High)
Q Data Output
*/

module flop_1 (C, D, CLR, Q);
 input C, D, CLR;
 output Q;
 reg Q;
 always @(negedge C or posedge CLR)
 begin
 if (CLR)
  Q = 1'b0;
 else
  Q = D;
 end
endmodule

/*
Flip-flop with Positive-Edge Clock and Synchronous
Set
pag 42
IO Pins Description
-------------------
D Data Input
C Positive-Edge Clock
S Synchronous Set (active High)
Q Data Output

*/

module fds (C, D, S, Q);
 input C, D, S;
 output Q;
 reg Q;
 always @(posedge C)
 begin
 if (S)
  Q = 1'b1;
 else
  Q = D;
 end
endmodule

module fds8 (C, D, S, Q);
 input C,S;
 input [7:0] D;
 output [7:0] Q;
 
 fds ff0(C, D[0], S, Q[0]);
 fds ff1(C, D[1], S, Q[1]);
 fds ff2(C, D[2], S, Q[2]);
 fds ff3(C, D[3], S, Q[3]);
 fds ff4(C, D[4], S, Q[4]);
 fds ff5(C, D[5], S, Q[5]);
 fds ff6(C, D[6], S, Q[6]);
 fds ff7(C, D[7], S, Q[7]);

endmodule

module fds16 (C, D, S, Q);
 input C,S;
 input [15:0] D;
 output [15:0] Q;
 
 fds8 ff0(C, D[7:0], S, Q[7:0]);
 fds8 ff1(C, D[15:8], S, Q[15:8]);
 
endmodule


module fdsz (C, D, S, Q, OE);
 input C, D, S, OE;
 output Q;
 reg QQ;

 always @(posedge C)
 begin
 if (S)
  QQ = 1'b1;
 else
  QQ = D;
 end
 
 assign Q = OE?QQ:1'bz;// 
endmodule

module fdsz8 (C, D, S, Q, OE);
 input C,S, OE;
 input [7:0] D;
 output [7:0] Q;
 
 fdsz ff0(C, D[0], S, Q[0], OE);
 fdsz ff1(C, D[1], S, Q[1], OE);
 fdsz ff2(C, D[2], S, Q[2], OE);
 fdsz ff3(C, D[3], S, Q[3], OE);
 fdsz ff4(C, D[4], S, Q[4], OE);
 fdsz ff5(C, D[5], S, Q[5], OE);
 fdsz ff6(C, D[6], S, Q[6], OE);
 fdsz ff7(C, D[7], S, Q[7], OE);

endmodule

/*
 FIFO: https://eewiki.net/pages/viewpage.action?pageId=20939499
*/

