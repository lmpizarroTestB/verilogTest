from myhdl import block, always, instance, Signal, \
    ResetSignal, modbv, delay, StopSimulation, \
    intbv

@block
def delay_v(dout, din, clk, delay, Nbits = 8, depth = 16):
 
    mem = [Signal(intbv(0)[Nbits:]) for i in range(depth)]
   
    
    @always(clk.posedge)
    def write():
      dout.next = mem[delay]
      for i in range(delay):
          mem[i+1].next = mem[i]
      mem[0].next = din
    return write

def convert (hdl):
  Nbits = 8
  depth = 16
  clk  = Signal(bool(0))
  dout = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  delay_ = Signal(intbv(0)[4:])


  dut = delay_v(dout, din, clk, delay_, Nbits, depth)
  dut.convert(hdl=hdl, name='delay_v')



@block
def tb():
    HALF_PERIOD = delay(10)

    Nbits = 8
    depth = 16
    clk  = Signal(bool(0))
    dout = Signal(intbv(0)[Nbits:])
    din = Signal(intbv(0)[Nbits:])
    delay_ = Signal(intbv(0)[4:])


    dut = delay_v(dout, din, clk, delay_, Nbits, depth)

    @always(HALF_PERIOD)
    def clockGen():
        clk.next = not clk

    @instance
    def stimulus():
        for i in range(10):
            delay_.next = 6 
            din.next = 68 
            yield clk.posedge

        for i in range(10):
            delay_.next = 6 
            din.next = 34 
            yield clk.posedge
        raise StopSimulation()

    @instance
    def monitor():
      print("clk  din  dout")
      while 1:
        yield clk.posedge
        yield delay(1)
        print(" pos %s   %s   %s  %s" % (int(clk), int(din), int(dout),
            int(delay_)))
        #yield clk.negedge
        #yield delay(1)
        #print(" neg %s   %s      %s" % (int(clk), int(d), int(q)))


    return clockGen, stimulus, monitor, dut


if __name__ == '__main__':
  tb = tb()
  tb.run_sim()
  convert('Verilog')
  print tb
