from myhdl import always, instance, Signal, \
    ResetSignal, modbv, delay, StopSimulation, \
    intbv, Simulation, instances

from srl import discriminator
import genSignal
from genSignal import *

class Discriminator():

  def __init__(self, Nbits=16):
    self.Nbits = Nbits

    self.wll = Signal(bool(0))
    self.wul = Signal(bool(0))
    self.out = Signal(bool(0))
    self.sig = Signal(intbv(0)[Nbits:])
    self.sig_out = Signal(intbv(0)[Nbits:])
    self.data = Signal(intbv(0)[Nbits:])

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
    HALF_PERIOD = delay(10)

    @always(HALF_PERIOD)
    def clockGen():
      self.clk.next = not self.clk

    @instance
    def stimulus():
      for i in range(len(ddin)):
        self.delay_.next = self.NbDelay 
        self.din.next = ddin[i]
        yield self.clk.posedge

      raise StopSimulation()

import biggles

def main():
  ddin = genSignal()
  disc = Discriminator()
  disc.convert()
  disc.tb(ddin)

if __name__ == '__main__':
    main()


