from myhdl import *
import numpy as np
import biggles


@block
def test_signed(din, dout, clk, Nbits = 8):
 
    a1= Signal(intbv(-1, min=-2**(Nbits-1), max=2**(Nbits-1)-1)[Nbits:])
    mem = Signal(intbv(0, min=-2**(Nbits-1), max=2**(Nbits-1)-1)[Nbits:])
    
    @always(clk.posedge)
    def delay_v():
      
      dout.next = a1*mem 
      mem.next = din.signed()
    return delay_v


class TestSigned():

  def __init__(self, Nbits=16, Ndelay=4):
    self.Nbits = Nbits


    
    self.sMin =-2**(Nbits-1)
    self.sMax = 2**(Nbits-1)-1

    self.din = Signal(intbv(0, min=self.sMin, max=self.sMax)[self.Nbits:])
    self.dout = Signal(intbv(0, min=self.sMin, max=self.sMax)[self.Nbits:])
    
    
    self.clk  = Signal(bool(0))

    self.ddout=[]
    self.dut = test_signed(self.din,  
                             self.dout, 
                             self.clk,
                             self.Nbits)


  def convert (self, hdl='Verilog', name='delay'):
    self.dut.convert(hdl=hdl, name='delayq')

  def padding(self, s):
    s.insert(0,0)
    s.append(0)

  def genSignal(self, N, padinit,padend=100, TS=1):
      s=[1]*N
      [s.insert(0,0) for i in range(padinit)]
      [s.append(0) for i in range(padend)]
      sss = [Signal(intbv(s[i], min=self.sMin, max=self.sMax)[self.Nbits:]) for i in range(len(s))]
      TT = np.linspace(0,TS*(N+padinit+padend), (N+padinit+padend))
      return TT,np.asarray(s), sss

  def tb(self, ddin):
    @instance
    def stimulus():
      for i in range(len(ddin)):
        self.din.next  = ddin[i]
        yield self.clk.posedge

      raise StopSimulation()

    @instance
    def monitor():
      print("sig  data wll wul out sig_out ")
      while 1:
        yield self.clk.posedge
        yield delay(1)
        print("%s     %s   " %  (int(self.din), int(self.dout)))
        self.ddout.append(int(self.dout))

    HALF_PERIOD = delay(10)

    @always(HALF_PERIOD)
    def clockGen():
      self.clk.next = not self.clk

    return clockGen, monitor, self.dut, stimulus

def t2comp(d):
    c=[]
    for e in d:
        if e!=0:
            e=e-65536
        c.append(e)
    return c

def main():
  
  disc = TestSigned()
  disc.convert()
  t,ddin, ddin2 = disc.genSignal(10,10,10)

  tbr = disc.tb(ddin2)
  sim = Simulation(tbr)
  sim.run()

  p = biggles.FramedPlot()
  p.yrange=-5,5
  
  disc.ddout.append(0)
  tcomp=t2comp(disc.ddout)
  p.add( biggles.Curve(t,ddin, color="blue") )
  p.add( biggles.Curve(t,tcomp, color="red") )
  p.show()
  print tcomp


if __name__ == '__main__':
    main()
