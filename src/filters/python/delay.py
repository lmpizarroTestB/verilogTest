from myhdl import always, instance, Signal, \
    ResetSignal, modbv, delay, StopSimulation, \
    intbv, Simulation, instances, block

import numpy as np
import biggles


@block
def delay_var(dout, din, clk, delay, Nbits = 8, depth = 16):
 
    mem = [Signal(intbv(0)[Nbits:]) for i in range(depth)]
   
    
    @always(clk.posedge)
    def delay_v():
      dout.next = mem[delay]
      for i in range(delay):
          mem[i+1].next = mem[i]
      mem[0].next = din
    return delay_v


class Delay():

  def __init__(self, Nbits=16, Ndelay=4):
    self.Nbits = Nbits
    self.Ndelay = Ndelay
    self.depth = 2**self.Ndelay


    self.din = Signal(intbv(0)[self.Nbits:])
    self.dout = Signal(intbv(0)[self.Nbits:])
    self.dout2 = Signal(intbv(0)[self.Nbits:])
    self.clk  = Signal(bool(0))
    self.delay = Signal(intbv(0)[self.Ndelay:])

    self.ddout=[]

    self.dut = delay_var(self.dout,  
                             self.din, 
                             self.clk,
                             self.delay,
                             self.Nbits,
                             self.depth)

    self.dut2 = delay_var(self.dout2,  
                             self.dout, 
                             self.clk,
                             self.delay,
                             self.Nbits,
                             self.depth)



  def convert (self, hdl='Verilog', name='delay'):
    self.dut.convert(hdl=hdl, name='delayq')

  def padding(self, s):
    s.insert(0,0)
    s.append(0)

  def genSignal(self, N, pad, TS=1):
      s=[1]*N
      [self.padding(s) for i in range(pad)]
      TT = np.linspace(0,TS*(N+2*pad), (N+2*pad))
      return TT,np.asarray(s)

  def tb(self, ddin):
    @instance
    def stimulus():
      self.delay.next = 4;
      for i in range(len(ddin)):
        self.din.next  = ddin[i]
        yield self.clk.posedge

      raise StopSimulation()

    @instance
    def monitor():
      #print("sig  data wll wul out sig_out ")
      while 1:
        yield self.clk.posedge
        yield delay(1)
        #print("%s     %s   " %  (int(self.din), int(self.dout)))
        self.ddout.append(int(self.dout2))

    HALF_PERIOD = delay(10)

    @always(HALF_PERIOD)
    def clockGen():
      self.clk.next = not self.clk

    return clockGen, monitor, self.dut, stimulus, self.dut2


def main():
  
  disc = Delay()
  disc.convert()
  t,ddin = disc.genSignal(100,10)

  tbr = disc.tb(ddin)
  sim = Simulation(tbr)
  sim.run()

  p = biggles.FramedPlot()

  disc.ddout.append(0)
  p.add( biggles.Curve(t,ddin, color="blue") )
  p.add( biggles.Curve(t,disc.ddout, color="red") )
  p.show()


if __name__ == '__main__':
    main()

