module comparator (inA, inB, out);
  parameter N = 7;
  input [N:0] inA, inB;
  output reg out;

    always@(inA or inB)
    begin 
      if (inA > inB) 
        out <= 1'b1;
      else
	out <= 1'b0;
    end
endmodule // comparator
