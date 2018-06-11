from myhdl import always, instance, Signal, \
    ResetSignal, modbv, delay, StopSimulation, \
    intbv, Simulation, instances

from srl import discriminator
import genSignal
from genSignal import *

class Discriminator():

  def __init__(self, Nbits=16):
    self.Nbits = Nbits

    self.clk  = Signal(bool(0))
    self.wll = Signal(bool(0))
    self.wul = Signal(bool(0))
    self.out = Signal(bool(0))
    self.sig = Signal(intbv(0)[Nbits:])
    self.sig_out = Signal(intbv(0)[Nbits:])
    self.data = Signal(intbv(0)[Nbits:])

    self.ddout=[]

    self.dut = discriminator(self.sig, 
                             self.data, 
                             self.wll, 
                             self.wul, 
                             self.out, 
                             self.sig_out, 
                             self.Nbits)


  def convert (self, hdl='Verilog', name='discriminator'):
    self.dut.convert(hdl=hdl, name='discriminatorq')

  def tb(self, ddin):
    @instance
    def stimulus():
      for i in range(len(ddin)):
        self.sig.next  = ddin[i][0]
        self.data.next = ddin[i][1] 
        self.wul.next  = ddin[i][2]
        self.wll.next  = ddin[i][3]
        yield self.clk.posedge

      raise StopSimulation()

    @instance
    def monitor():
      print("sig  data wll wul out sig_out ")
      while 1:
        yield self.clk.posedge
        yield delay(1)
        print("%s     %s   %s      %s    %s    %s" % \
                                        (int(self.sig), int(self.data), \
                                         int(self.wul), int(self.wll), \
                                         int(self.out), int(self.sig_out)))
        self.ddout.append(int(self.out))

    HALF_PERIOD = delay(10)

    @always(HALF_PERIOD)
    def clockGen():
      self.clk.next = not self.clk

    return clockGen, monitor, self.dut, stimulus
import biggles

def main():
  #ddin = genSignal()
  #        sig data wll wul 
  ddin = genSig_discriminator() 
  
  disc = Discriminator()
  disc.convert()
  tbr = disc.tb(ddin)
  sim = Simulation(tbr)
  sim.run()


if __name__ == '__main__':
    main()


