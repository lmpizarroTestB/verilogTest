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

@block
def attenuator(sig, att, sig_out):

    @always(sig)
    def atte():
        if att == 0:
            sig_out.next = sig
        elif att == 1:
            sig_out.next = (sig>>1) + (sig>>2)
        elif att == 2:
            sig_out.next = sig>>1
        elif att == 3:
            sig_out.next = ((sig>>1) + (sig>>2))>>2
        elif att == 4:
            sig_out.next = sig>>2
        elif att == 5:
            sig_out.next = ((sig>>2) + (sig>>3))>>2
        elif att == 6:
            sig_out.next = sig>>3
        elif att == 7:
            sig_out.next = ((sig>>4) + (sig>>3))>>2
        elif att == 8:
            sig_out.next = sig>>4
        elif att == 9:
            sig_out.next = ((sig>>4) + (sig>>5))>>2
        elif att == 10:
            sig_out.next = sig>>5
        elif att == 11:
            sig_out.next = ((sig>>6) + (sig>>5))>>2
        elif att == 12:
            sig_out.next = sig>>6
        elif att == 13:
            sig_out.next = ((sig>>6) + (sig>>7))>>2
        elif att == 14:
            sig_out.next = sig>>7
        elif att == 15:
            sig_out.next = ((sig>>8) + (sig>>7))>>2
    return atte

@block
def delay_var(dout, din, clk, delay, Nbits = 8, depth = 16):
 
    mem = [Signal(intbv(0)[Nbits:]) for i in range(depth)]
   
    
    @always(clk.posedge)
    def delay_v():
      dout.next = mem[delay]
      for i in range(delay):
          mem[i+1].next = mem[i]
      mem[0].next = din
    return delay_v

@block
def multiplier_4bits(clk, B, A, out, Nbits=4):
    '''
      out = B * A

            B
           *A
           --
           out
    '''

    mem = [Signal(intbv(0)[2*Nbits:]) for i in range(Nbits)]


    @always(clk.posedge)
    def mult_():
        C = (mem[0] + mem[1]) + (mem[2] + mem[3])

    @always_comb
    def calcs():
       mem[0][5:].next = A[0]&B
       mem[1][6:].next =  A[1]&B
       mem[2][7:].next =  A[3]&B
       mem[3][8:].next =  A[4]&B

       mem[0][8:4].next = 0
       mem[1][8:5].next = 0
       mem[1][0].next = 0
       mem[2][8:6].next = 0
       mem[2][2:0].next = 0
       mem[3][3:0].next = 0

    return mult_, calcs 

@block
def partial_mult( B, A, mem0, mem1, mem2, mem3):

   @always(A,B)
   def calcs():
    while(1):
       mem0[5:].next = A[0]&B
       mem1[6:].next =  A[1]&B
       mem2[7:].next =  A[3]&B
       mem3[8:].next =  A[4]&B

       mem0[8:4].next = 0
       mem1[8:5].next = 0
       mem1[0].next = 0
       mem2[8:6].next = 0
       mem2[2:0].next = 0
       mem3[3:0].next = 0

   return calcs 

@block
def full_adder(Cin, A,B, S, Cout):

   @always(A,B)
   def calcs():
        axorb = A^B
        S.next = axorb^Cin
        Cout.next = A&B | axorb&Cin

   return calcs 

@block
def adder(Cin, A,B, S, Cout):

   @always(A,B)
   def calcs():
      C1 = 0
      full_adder(Cin, A[0], B[0], S[0], C1)
      full_adder(C1, A[1], B[1], S[1], Cout)
   return calcs 
