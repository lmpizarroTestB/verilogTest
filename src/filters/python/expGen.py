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


def expSignal(amp=1024, tau=100, size=4096,TS=1E-8):
  signal =[]
  t =[]
  for i in range(size):
    ti = TS*i
    data = int(amp*math.exp(-ti/tau))
    t.append(ti)
    signal.append(data)

  return t,signal


def integrator75(x):
    
    y=[]
    y1=0
    for e in x:
        yy =int(e+ int((y1 + int(y1/2.0))/2.0))
        y.append(yy)
        y1=yy

    return y

def genPre():
    fs=100E6
    TS=1/fs
    tau = .1E-6

    t,x=expSignal(amp=500,tau=tau,TS=TS)

    y=[]
    y1=0
    for i,e in enumerate(x):
        yy =e+ 0.9999*y1 
        y.append(yy)
        y1=yy

    return t,y


def gen_signal_verilog(amp=1024, tau=.01, size=4096):
  signal =""
  s= expSignal(amp, tau,size)
  for i in range(size):
    data = s[i] 
    signal = signal +  "   #5 data =" + str(int(data)) + ";\n"

  return signal[:-1]

def main():

  tb_gen=header % "../shapeInt.v"
  tb_gen = tb_gen+modulev
  tb_file_name="tb_shapeIntTest.v"

  
  tb_gen = tb_gen + gen_signal_verilog() + footer

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
    fs=100E6
    TS=1/fs
    tau = .1E-6
    t,x=expSignal(amp=500,tau=tau,TS=TS)
    t,s=genPre()
    p = biggles.FramedPlot()
    p.add( biggles.Curve(t,s, color="blue") )
    #p.add( biggles.Curve(t,x, color="red") )
    p.show()


