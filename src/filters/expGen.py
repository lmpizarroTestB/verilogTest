import math

header='''
/* 
Full Adder Module for bit Addition 
Written by referencedesigner.com 
*/
`timescale 1ns / 100ps 
`include "%s"
'''
modulev='''
module tb_shapeInt; 
  // Declare inputs as regs and outputs as wires
  parameter N = 16;
  reg clock, reset;
  reg signed [N-1:0] data;
  wire signed [N-1:0] out;
  reg signed [N-1:0] Mpos=(1<<(N-1)) - 1;
  reg signed [N-1:0] Mneg=(1<<(N-1));
 
  shapeInt uut (
    .C(clock),
    .CLR(reset),
    .D(data),
    .Q(out)
  );
 

// Initialize all variables
initial 
  begin
   $display ( "time, ck, clr, data, out" );
   $monitor ( "%g, %b, %b, %d, %d" , $time, clock, reset, data, out);
   clock = 1; // initial value of clock
   reset = 0; // initial value of reset
   data = 0; // initial value of enable
   #5 reset = 1; // Assert the reset
   #10 reset = 0; // Deassert the reset
   #5 data = 0;
'''
footer='''
   #5 $finish;
  end

// Clock generator
always begin
#5 clock = ~clock; // Toggle clock every 5 ticks
end
 
endmodule
'''

def gen_signal(amp=1024, tau=.01, size=4096):
  signal =""
  for i in range(size):
    data = amp*math.exp(-i*tau)
    signal = signal +  "   #5 data =" + str(int(data)) + ";\n"

  return signal[:-1]

def main():

  tb_gen=header % "shapeInt.v"
  tb_gen = tb_gen+modulev
  tb_file_name="tb_shapeIntTest.v"

  
  tb_gen = tb_gen + gen_signal() + footer

  fo=open(tb_file_name, 'w')
  fo.write(tb_gen)
  fo.close()

if __name__ == "__main__":
  main()
