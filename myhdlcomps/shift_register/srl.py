'''
8-bit Shift-Left Register with 
Positive-Edge Clock,
Serial In, and 
Serial Out

IO Pins Description
-------------------
C Positive-Edge Clock
SI Serial In
SO Serial Output
'''

# Verilog Code

'''
Following is the Verilog code for an 8-bit shift-left register with a
positive-edge clock, serial in, and serial out.

module shift (C, SI, SO);
 input C,SI;
 output SO;
 reg [7:0] tmp;

 always @(posedge C)
  begin
   tmp = tmp << 1;
   tmp[0] = SI;
  end
 assign SO = tmp[7];
endmodule
'''
import myhdl
from myhdl import *

@block
def srl(clk, si, so):
    q = intbv(0)[8:] 
	
    @always(clk.posedge)
    def seq():
         so.next = q[7]
         q[8:1] = q[7:]
         q[0] = si

    return seq

@block
def srlpiso(clk, pi, load, so):
    q = intbv(0)[8:]
	
    @always(clk.posedge)
    def seq():  
      if load:
         q.next = pi
      else:
         so.next = q[7]
         q[8:1] = q[7:]

    return seq


 
@block
def ram(dout, din, addr, we, clk, depth=128):
    """  Ram model """
    
    mem = [Signal(intbv(0)[8:]) for i in range(depth)]
    
    @always(clk.posedge)
    def write():
        if we:
            mem[addr].next = din
                
    @always_comb
    def read():
        dout.next = mem[addr]

    return write, read

@block
def delay_1(dout, din, clk, Nbits = 8):
 
    mem = Signal(intbv(0)[Nbits:])
   
    
    @always(clk.posedge)
    def write():
            dout.next = mem
            mem.next = din
                
 
    return write

@block
def diff_disp(dout, din, clk, disp, Nbits = 8):
 
    mem = Signal(intbv(0)[Nbits:])
   
    
    @always(clk.posedge)
    def write():
            dout.next = din - mem >> disp
            mem.next = din
                
 
    return write

@block
def logical_slr(din, disp, dout):
    
    @always(din or disp)
    def proc():
        if disp == 0:
            dout.next = din
        elif disp == 1:
            dout.next = din << 1
        elif disp == 2:
            dout.next = din << 2
        elif disp == 3:
            dout.next = din << 3
 
    return proc

@block
def logical_slr_b(din, disp, dout):
    
    @always(din or disp)
    def proc():
            dout.next = din << disp
 
    return proc

@block
def comparator(A,B,gt, eq, lt):

  @always_comb
  def proc():
   if A > B:
      gt.next  = 1
      eq.next = 0
      lt.next = 0
   elif A < B:
      gt.next  = 0
      eq.next = 0
      lt.next = 1
   else:
      gt.next  = 0
      eq.next = 1
      lt.next = 0

  return proc
