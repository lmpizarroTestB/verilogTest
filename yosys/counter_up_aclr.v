//Following is the Verilog code for a 4-bit unsigned up counter with
//asynchronous clear.
module counter (C, CLR, Q);
input C, CLR;
output [3:0] Q;
reg [3:0] tmp;
always @(posedge C or posedge CLR)
begin
if (CLR)
tmp = 4'b0000;
else
tmp = tmp + 1'b1;
end
assign Q = tmp;
endmodule
