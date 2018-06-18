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
  Nbits = 8
  WidthAddr = 7
  dout = Signal(intbv(0)[Nbits:])
  dout_v = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  addr = Signal(intbv(0)[WidthAddr:])
  we = Signal(bool(0))
  clk = Signal(bool(0))

  ramq = ram(dout, din, addr, we, clk, Nbits =8, 2**WidthAddr)
  ramq.convert(hdl=hdl, name='ram')

def convert_delay_1(hdl):
  

  Nbits = 16
  dout = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  clk = Signal(bool(0))

  delayq = delay_1(dout, din, clk, Nbits)
  delayq.convert(hdl=hdl, name='delay_1')

def convert_diff_disp(hdl):

  Nbits = 16
  dout = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  disp = Signal(intbv(0)[3:])
  clk = Signal(bool(0))

  diff_dispq = diff_disp(dout, din, clk, disp, Nbits)
  diff_dispq.convert(hdl=hdl, name='diff_disp')

def convert_logical_slr(hdl):

  Nbits = 16
  dout = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  disp = Signal(intbv(0)[2:])

  logical_slrq = logical_slr(din, disp, dout)
  logical_slrq.convert(hdl=hdl, name='logical_slr')

def convert_logical_slr_b(hdl):

  Nbits = 16
  dout = Signal(intbv(0)[Nbits:])
  din = Signal(intbv(0)[Nbits:])
  disp = Signal(intbv(0)[2:])

  logical_slr_bq = logical_slr_b(din, disp, dout)
  logical_slr_bq.convert(hdl=hdl, name='logical_slr_b')


def convert_comparator(hdl):
  Nbits = 16
  gt = Signal(bool(0))
  eq = Signal(bool(0))
  lt = Signal(bool(0))
  A = Signal(intbv(0)[Nbits:])
  B = Signal(intbv(0)[Nbits:])

  comparatorq = comparator(A, B, gt, eq, lt)
  comparatorq.convert(hdl=hdl, name='comparatorq')

def convert_discriminator(hdl):
  Nbits = 16
  wll = Signal(bool(0))
  wul = Signal(bool(0))
  out = Signal(bool(0))
  sig = Signal(intbv(0)[Nbits:])
  sig_out = Signal(intbv(0)[Nbits:])
  data = Signal(intbv(0)[Nbits:])

  discriminatorq = discriminator(sig, data, wll, wul, out, sig_out, Nbits)
  discriminatorq.convert(hdl=hdl, name='discriminatorq')

def convert_attenuator(hdl):
  Nbits = 16
  sig = Signal(intbv(0)[Nbits:])
  sig_out = Signal(intbv(0)[Nbits:])
  att = Signal(intbv(0)[4:])

  attenuatorq = attenuator(sig, att, sig_out)
  attenuatorq.convert(hdl=hdl, name='attenuator')


def convert_partial_mult(hdl):
  Nbits = 4

  A = Signal(intbv(0)[Nbits:])
  B = Signal(intbv(0)[Nbits:])
  mem0 = Signal(intbv(0)[2*Nbits:])
  mem1 = Signal(intbv(0)[2*Nbits:])
  mem2 = Signal(intbv(0)[2*Nbits:])
  mem3 = Signal(intbv(0)[2*Nbits:])

  dut = partial_mult(B, A, mem0, mem1, mem2, mem3)
  dut.convert(hdl=hdl, name='partial_mult')

def convert_mult_4bits(hdl):
  Nbits = 4

  A = Signal(intbv(0)[Nbits:])
  B = Signal(intbv(0)[Nbits:])
  C = Signal(intbv(0)[2*Nbits:])

  dut = multiplier_4bits(B, A, C, Nbits)
  dut.convert(hdl=hdl, name='multiplier_4bits')


def convert_full_adder(hdl):
    Cin = Signal(bool(0))
    A = Signal(bool(0))
    B = Signal(bool(0))
    S = Signal(bool(0))
    Cout = Signal(bool(0))

    dut = full_adder(Cin, A, B, S, Cout)
    dut.convert(hdl=hdl, name="full_adder")

def convert_adder(hdl):
    Cin = Signal(bool(0))
    A = Signal(intbv(0)[2:])
    B = Signal(intbv(0)[2:])
    S = Signal(intbv(0)[2:])
    Cout = Signal(bool(0))

    dut = adder(Cin, A, B, S, Cout)
    dut.convert(hdl=hdl, name="adder")

def convert_register(hdl='Verilog', Nbits=8):
    q = Signal(intbv(0)[Nbits:])
    d = Signal(intbv(0)[Nbits:])
    clk = Signal(bool(0))
    dut = register(q, d, clk, Nbits)
    dut.convert(hdl=hdl, name="register")


def convert_addSat(hdl='Verilog'):
    Nbits = 16

    A =Signal(intbv(0)[Nbits:])
    B =Signal(intbv(0)[Nbits:])
    C =Signal(intbv(0)[Nbits:])

    dut = addSat(A,B,C,Nbits)
    dut.convert(hdl=hdl, name="addSat")

def main():   
    convert_srl(hdl='Verilog')
    convert_srlpiso(hdl='Verilog')
    convert_ram(hdl='Verilog')
    convert_delay_1(hdl='Verilog')
    convert_diff_disp(hdl='Verilog')
    convert_logical_slr(hdl='Verilog')
    convert_logical_slr_b(hdl='Verilog')
    convert_comparator(hdl='Verilog')
    convert_discriminator(hdl='Verilog')
    convert_attenuator(hdl='Verilog')
    convert_partial_mult(hdl='Verilog')
    convert_mult_4bits(hdl='Verilog')
    convert_full_adder(hdl='Verilog')
    convert_adder(hdl='Verilog')
    
if __name__ == '__main__':
    #main()
    convert_register(Nbits=14)

