module genPulse (Y, clk, sel,load,val);
output [13:0] Y;
input [3:0] sel;
input clk, load;
input [13:0] val;

reg signed [13:0] yc;
reg signed [13:0] ymem; 
reg [7:0] delay = 8;
reg [7:0] counter = 0;
reg flagDelay = 0; 
reg flagLoad;

always @(posedge clk)
begin
     counter = counter + 1;
     if (counter == delay) flagDelay = 1'b1;
     if (flagDelay) begin
       if (flagLoad)begin
	       yc = ymem;
	       flagLoad = 0;
       end else begin
        yc = ymem - ((ymem+(1<<<sel))>>>sel); // 1
        ymem = yc;
       end
     end
     else yc = 0;
end
assign Y = yc[13:0];

always @(posedge load)
begin
  if(load) begin 
	ymem <= val;
	flagLoad = 1;
  end
end
endmodule
