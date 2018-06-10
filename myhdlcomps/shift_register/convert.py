import myhdl
from myhdl import *

import srl
from srl import *

def convert_srl(hdl):
    """Convert srl block to Verilog or VHDL."""

    so = Signal(bool(0))
    si = Signal(bool(0))
    clk  = Signal(bool(0))

    srlq = srl(clk, si, so)

    srlq.convert(hdl=hdl, name='srl')

def convert_srlpiso(hdl):
    """Convert srl block to Verilog or VHDL."""

    pi = Signal(intbv(0)[8:])
    so = Signal(bool(0))
    clk  = Signal(bool(0))
    load  = Signal(bool(0))


    srlpisoq = srlpiso(clk, pi, load, so)
    srlpisoq.convert(hdl=hdl, name='srlpiso')


def convert_ram(hdl):

  dout = Signal(intbv(0)[8:])
  dout_v = Signal(intbv(0)[8:])
  din = Signal(intbv(0)[8:])
  addr = Signal(intbv(0)[7:])
  we = Signal(bool(0))
  clk = Signal(bool(0))

  ramq = ram(dout, din, addr, we, clk)
  ramq.convert(hdl=hdl, name='ram')

def convert_delay_1(hdl):
  

  Nbits = 16
  dout = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  clk = Signal(bool(0))

  delayq = delay_1(dout, din, clk, Nbits)
  delayq.convert(hdl=hdl, name='delay_1')


def main():   
    convert_srl(hdl='Verilog')
    convert_srlpiso(hdl='Verilog')
    convert_ram(hdl='Verilog')
    convert_delay_1(hdl='Verilog')
    
    
if __name__ == '__main__':
    main()
