from myhdl import always, instance, Signal, \
    ResetSignal, modbv, delay, StopSimulation, \
    intbv, Simulation, instances

from srl import delay_var

import biggles

class Delay_Var():
  def __init__(self, Nbits=8, NbDelay = 5):
    self.HALF_PERIOD = delay(10)

    self.Nbits = Nbits
    self.NbDelay = NbDelay
    self.depth = 2**self.NbDelay


    self.clk  = Signal(bool(0))
    self.dout = Signal(intbv(0)[self.Nbits:])
    self.din = Signal(intbv(0)[self.Nbits:])
    self.delay_ = Signal(intbv(0)[self.NbDelay:])


    self.dut = delay_var(self.dout, self.din, \
            self.clk, self.delay_, self.Nbits,\
            self.depth)

    self.ddout=[]


  def convert (self, hdl='Verilog', name='delay_var'):
    self.dut.convert(hdl=hdl, name=name)

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

    @instance
    def monitor():
      print("clk  din  dout")
      while 1:
        yield self.clk.posedge
        yield delay(1)
        print(" pos %s   %s   %s  %s" % (int(self.clk), int(self.din),
            int(self.dout), int(self.delay_)))
        self.ddout.append(int(self.dout))
        #yield clk.negedge
        #yield delay(1)
        #print(" neg %s   %s      %s" % (int(clk), int(d), int(q)))


    return  instances()

def genSignal():
  a = [1]*5
  b = [0]*7
  c = [2] * 4

  sig=a +  b +  c + b

  return sig


def main():
  ddin= genSignal()
  x = [i for i in range(len(ddin))]

  dv = Delay_Var()
  dv.convert()

  tbr = dv.tb(ddin)
  sim = Simulation(tbr)
  sim.run()

  dv.ddout.append(0)
  p = biggles.FramedPlot()
  p.add( biggles.Curve(x, dv.ddout, color="red") )
  p.add( biggles.Curve(x, ddin, color="blue") )
  p.show()

if __name__ == '__main__':
    main()


