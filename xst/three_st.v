`include "flipFlops.v"
/*
  IO Pins Description
  di Data Input
  en Output Enable (active Low)
  do Data Output
Pag. 56
*/
module three_st (en, di, do);
  input en, di;
  output do;
  reg do;

  always @(en or di)

  begin
    if (~en)
      do = di;
    else
      do = 1'bZ;
    end
endmodule

/*
BUFT

tristate element using a concurrent
assignment

IO Pins Description
-------------------
I Data Input
T Output Enable (active Low)
O Data Output
*/
module three_st_c (T, I, O);
 input T, I;
 output O;
 assign O = (~T) ? I: 1'bZ;
endmodule

module three_st_c8 (en, D, Q);
 input en;
 output [7:0] D;
 output [7:0] Q;

 three_st_c  tsc0 (.T(en), .I(D[0]), .O(Q[0]));
 three_st_c  tsc1 (.T(en), .I(D[1]), .O(Q[1]));
 three_st_c  tsc2 (.T(en), .I(D[2]), .O(Q[2]));
 three_st_c  tsc3 (.T(en), .I(D[3]), .O(Q[3]));
 three_st_c  tsc4 (.T(en), .I(D[4]), .O(Q[4]));
 three_st_c  tsc5 (.T(en), .I(D[5]), .O(Q[5]));
 three_st_c  tsc6 (.T(en), .I(D[6]), .O(Q[6]));
 three_st_c  tsc7 (.T(en), .I(D[7]), .O(Q[7]));
endmodule

module ffd8z (C, D, S, Q, en);
 input C, S, en;
 input [7:0] D;
 output [7:0] Qi;
 output [7:0] Q;

 fds8 fd (C, D, S, Qi);
 three_st_c8  tz (en, Qi, Q);

endmodule


module freq_div_2 ( clk ,out );
output reg out;
input clk ;

always @(posedge clk)
begin
     out <= ~out;	
end
endmodule


//-----------------------------------------------------
// Design Name : parity_using_assign
// File Name   : parity_using_assign.v
// Function    : Parity using assign
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module parity_using_assign (
data_in    , //  8 bit data in
parity_out   //  1 bit parity out
);
output  parity_out ;
input [7:0] data_in ; 
     
wire parity_out ;
      
assign parity_out =  (data_in[0] ^ data_in[1]) ^  
                     (data_in[2] ^ data_in[3]) ^ 
                     (data_in[4] ^ data_in[5]) ^  
                     (data_in[6] ^ data_in[7]);

endmodule 
