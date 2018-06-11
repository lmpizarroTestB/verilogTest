from myhdl import block, always, instance, Signal, \
    ResetSignal, modbv, delay, StopSimulation, \
    intbv

import biggles

from srl import delay_var

def convert (hdl, name):
  Nbits = 8
  NbDelay = 5
  depth = 2**NbDelay

  clk  = Signal(bool(0))
  dout = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  delay_ = Signal(intbv(0)[NbDelay:])


  dut = delay_var(dout, din, clk, delay_, Nbits, depth)
  dut.convert(hdl=hdl, name=name)

ddout=[]
@block
def tb(del_, ddin):
  HALF_PERIOD = delay(10)

  Nbits = 8
  NbDelay = 5
  depth = 2**NbDelay


  clk  = Signal(bool(0))
  dout = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  delay_ = Signal(intbv(0)[NbDelay:])


  dut = delay_var(dout, din, clk, delay_, Nbits, depth)

  @always(HALF_PERIOD)
  def clockGen():
    clk.next = not clk

  @instance
  def stimulus():
        for i in range(len(ddin)):
            delay_.next = del_ 
            din.next = ddin[i]
            yield clk.posedge

        raise StopSimulation()

  @instance
  def monitor():
      print("clk  din  dout")
      while 1:
        yield clk.posedge
        yield delay(1)
        print(" pos %s   %s   %s  %s" % (int(clk), int(din), int(dout), int(delay_)))
        ddout.append(int(dout))
        #yield clk.negedge
        #yield delay(1)
        #print(" neg %s   %s      %s" % (int(clk), int(d), int(q)))


  return clockGen, stimulus, monitor, dut

def main():
  aone = Signal(intbv(1)[8:])  

  ddin=[1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1]
  x = [i for i in range(len(ddin))]
  tbr = tb(6, ddin)
  tbr.run_sim()
  convert('Verilog', "delay_var")

  print len(ddin), len(ddout)

  ddout.append(0)
  p = biggles.FramedPlot()
  p.add( biggles.Curve(x, ddout, color="red") )
  p.add( biggles.Curve(x, ddin, color="blue") )
  p.write_img( 400, 400, "example2.png" )
  p.show()



from myhdl import Simulation
if __name__ == '__main__':
    main()


