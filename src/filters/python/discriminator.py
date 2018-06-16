from myhdl import always, instance, Signal, \
    ResetSignal, modbv, delay, StopSimulation, \
    intbv, Simulation, instances, block


def genSig_discriminator():
  #        sig data wll wul 
  sig =  [0]*12 + [20]*3 + [70]*3 + [110]*3 + [0]*3
  data = [0]*3 + [100]*3 + [0]*3  + [50]*3 + [0]*12
  wul = [0]*3 + [1]*3 + [0]*3  +   [0]*3 + [0]*12
  wll = [0]*3 + [0]*3 + [0]*3  +   [1]*3 + [0]*12

  sig_discriminator = [[0,0,0,0],   [0,0,0,0],   [0,0,0,0], \
                       [0,100,0,1], [0,100,0,1], [0,100,0,1], \
                       [0,0,0,0], [0,0,0,0], [0,0,0,0],
                       [0,50,1,0], [0,50,1,0], [0,50,1,0],
                       [20,0,0,0], [20,0,0,0], [20,0,0,0],
                       [70,0,0,0], [70,0,0,0], [70,0,0,0],
                       [110,0,0,0], [110,0,0,0], [110,0,0,0],
                       [0,0,0,0], [0,0,0,0], [0,0,0,0],
                      ]
  d=[]
  for i,e in enumerate(sig):
      d.append([e, data[i], wll[i], wul[i]])
  #print d
  #return sig_discriminator
  return d


@block
def discriminator (sig, data, wll, wul, out, sig_out, Nbits):

    upper_level = Signal(intbv(0)[Nbits:])
    lower_level = Signal(intbv(0)[Nbits:])

    @always (sig)
    def disc():
        if sig > lower_level and sig < upper_level:
            out.next = 1
            sig_out.next = sig
        else:
            out.next = 0
            sig_out.next = 0

    @always (wll.posedge, wul.posedge)
    def setul():
        if wll:
            if data <= lower_level:
              upper_level.next = lower_level + 1
            else:
              upper_level.next = data
        elif wul:
            if data >= upper_level:
                lower_level.next = upper_level # - 1
            else:
                lower_level.next = data


    return disc, setul



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


