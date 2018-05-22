header='''
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
 
  shapeInt uut (
    .Clk(clock),
    .CLR(reset),
    .D(data),
    .Q(out)
  );
 

// Initialize all variables
initial 
  begin
   //$display ( "time, ck, clr, data, out" );
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

import math
import biggles
import subprocess

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


  simu = subprocess.check_output(['iverilog', '-osimu', tb_file_name])
  simu = subprocess.check_output(['./simu'])
  
  simu = simu.split('\n')
  
  out_sim = []
  x = []
  i = 0
  for l in simu:
    if len(l) > 2:
      x.append(i)
      da = float(l.split(',')[4].lstrip())
      print da
      out_sim.append(da)
      i=i+1
 
 
  p = biggles.FramedPlot()
  p.add( biggles.Curve(x,out_sim, color="red") )

  
  p.write_img( 400, 400, "example2.png" )
 
if __name__ == "__main__":
  main()
