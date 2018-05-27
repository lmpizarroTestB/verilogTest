/* 
  Following is the Verilog code for a single-port block RAM with
  enable. Pag. 170

  IO  pins Description
  clk Positive-Edge Clock
  en  Global Enable
  we  Synchronous Write Enable (active High)
  a   Read/Write Address
  di  Data Input
  do  Data Output
*/
module raminfr #(parameter NbitsAddr = 5,
                 parameter NbitsData = 8)  
  (clk, en, we, addr, di, do);
  input clk;
  input en;
  input we;
  input [NbitsAddr-1:0] addr;
  input [NbitsData-1:0] di;
  output [NbitsData-1:0] do;
  reg [NbitsData-1:0] ram [1<<NbitsAddr - 1:0];
  reg [NbitsAddr-1:0] read_a;

  always @(posedge clk) 
  begin
    if (en)
      begin
    if (we)
      ram[addr] <= di;
      read_a <= addr;
     end
  end
  assign do = ram[read_a];
endmodule
