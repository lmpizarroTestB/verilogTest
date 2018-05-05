module segmentos (q3, d, clk, reset);
  input reset;
  output [7:0] q3;
  input [7:0] d;
  input clk;
  reg [7:0] q3, q[2:0];
  integer i;
  always @(negedge clk or posedge reset)
    begin
      if (reset) begin
		q3 = 0;
		for (i=0; i < 3; i= i + 1) begin
			q[i] = 0;
		end
	        //q[1] = 0;
		//q[0] = 0;
      end else if (clk == 0) begin
		q3 <= d + q[2];
		q[2] <= q[1];
		q[1] <= q[0];
		q[0] <= d/2;
	  end
  end
endmodule

