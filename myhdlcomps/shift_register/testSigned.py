from myhdl import *
import numpy as np
import biggles


@block
def test_signed(X, Y, clk, Nbits = 8):
    
    min_1 =-2**(Nbits-1)
    max_1 =-min_1

    a1= Signal(intbv(-1, min=min_1, max=max_1))
    mem = Signal(intbv(0, min=min_1, max=max_1))


    min_ =-2**(2*Nbits-1)
    max_ =-min_

    yc = Signal(intbv(0, min=min_, max=max_))

    @always(clk.posedge)
    def delay_v():
      if (clk): 
       mem.next = X
       Y.next = yc.signed() 

    @always_comb
    def rtl_acc():
       yc = X -  (a1*mem>>1)
      


    return delay_v, rtl_acc

class TestSigned():

  def __init__(self, Nbits=16, Ndelay=4):
    self.Nbits = Nbits


    
    self.sMin =-2**(Nbits-1)
    self.sMax = -self.sMin

    self.X = Signal(intbv(0, min=self.sMin, max=self.sMax)[self.Nbits:])

    Nbits = 2*Nbits
    
    sMin =-2**(Nbits-1)
    sMax = -sMin
    print ("%d %d")%(sMin, sMax)
    self.Y = Signal(intbv(0, min=sMin, max=sMax)[2*self.Nbits:])
    
    
    self.clk  = Signal(bool(0))

    self.ddout=[]
    self.dut = test_signed(self.X,  
                             self.Y, 
                             self.clk,
                             self.Nbits)

  def convert (self, hdl='Verilog', name='signed'):
    self.dut.convert(hdl=hdl, name='signed')

  def padding(self, s):
    s.insert(0,0)
    s.append(0)

  def genSignal(self, N, padinit,padend=100, TS=1):
    s=[4]*N
    [s.insert(0,0) for i in range(padinit)]
    [s.append(0) for i in range(padend)]
    sss = [Signal(intbv(s[i], min=self.sMin, max=self.sMax)[self.Nbits:]) for i in range(len(s))]
    TT = np.linspace(0,TS*(N+padinit+padend), (N+padinit+padend))
    return TT,np.asarray(s), sss

  def tb(self, ddin):
    @instance
    def stimulus():
      for i in range(len(ddin)):
        self.X.next  = ddin[i]
        yield self.clk.posedge

      raise StopSimulation()

    @instance
    def monitor():
      print("data  sig_out ")
      while 1:
        yield self.clk.posedge
        yield delay(1)
        print("%s     %s   " % (int(self.X), int(self.Y)))
        self.ddout.append(int(self.Y))

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
  p.add( biggles.Curve(t,disc.ddout, color="red") )
  p.show()
  print tcomp


if __name__ == '__main__':
    main()
