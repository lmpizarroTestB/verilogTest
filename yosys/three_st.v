module three_st (T, I, O);
input T, I;
output O;
assign O = (~T) ? I: 1'bZ;
endmodule
