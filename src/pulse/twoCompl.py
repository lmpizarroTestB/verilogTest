import numpy as np

# S: 2 complement
# https://www.cs.cornell.edu/~tomf/notes/cps104/twoscomp.html
#
# https://en.wikipedia.org/wiki/Two%27s_complement
#
# TODO
def twos_complement (input_value, num_bits):
    mask = 2**(num_bits - 1)
    return -(input_value & mask) + (input_value & ~mask)

# TODO
def two_complement_b(e):
  for e in pulseOut:
    if e < 0:
        s = 1
    else:
        s= 0
    a = str(s) + str(bin(abs(e))[2:].zfill(14))
    print a

#for e in pulseOut:
#    a = np.binary_repr(e, 16)
#    print a, e


