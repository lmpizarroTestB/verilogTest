import random
from myhdl import block, always, instance, Signal, \
    ResetSignal, modbv, delay, StopSimulation

from srl import srl

random.seed(1)
randrange = random.randrange

ACTIVE_LOW, INACTIVE_HIGH = 0, 1

@block
def testbench():

    so = Signal(bool(0))
    si = Signal(bool(0))
    clk  = Signal(bool(0))

    srlq = srl(clk, si, so)


    HALF_PERIOD = delay(10)

    @always(HALF_PERIOD)
    def clockGen():
        clk.next = not clk

    @instance
    def stimulus():
 
        for i in range(32):
            si.next = min(1, randrange(3))
            yield clk.posedge
        raise StopSimulation()

    @instance
    def monitor():
        print("clk  si  so")
        while 1:
            yield clk.posedge
            yield delay(1)
            print(" pos %s   %s      %s" % (int(clk), int(si), int(so)))
            #yield clk.negedge
            #yield delay(1)
            #print(" neg %s   %s      %s" % (int(clk), int(d), int(q)))


    return clockGen, stimulus, srlq, monitor

tb = testbench()
tb.run_sim()
