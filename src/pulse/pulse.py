import random
import math 

# S: 2 complement
# https://www.cs.cornell.edu/~tomf/notes/cps104/twoscomp.html
#
# https://en.wikipedia.org/wiki/Two%27s_complement
#
def twos_complement (input_value, num_bits):
    mask = 2**(num_bits - 1)
    return -(input_value & mask) + (input_value & ~mask)

pulse = []
RINIT = 1028
RPULSE = 4096 * 2 - RINIT
FS = 100E6 
TS = 1.0 / FS


RES = 1000
CAP = 1E-9
IMAX = 0.005
LAMBDA = 0.01
NOiSE = LAMBDA / 100.0
TAO = CAP * RES
VADC = 5.0
NBITS = 14
RADC = math.pow(2, NBITS)

K2 = CAP / TS
K1 = TS * RES /(TAO  + TS)

for i in range(RINIT):
    pulse.append((.5 - random.random())*NOiSE)

for i in range(RPULSE):
    pulse.append(IMAX*math.exp(-i*LAMBDA) + (.5- random.random())*NOiSE)

pulseOut = []
pulseOut.append(0)
pulse.append(0)

for i in range(RINIT + RPULSE - 1):
    pulseOut.append((pulse[i+1] + K2* pulseOut[i])*K1)

#print K1, K2

for i,e in enumerate(pulseOut):
    pulseOut[i] = int(pulseOut[i] * RADC / VADC + random.randint(-30,30))

for e in pulseOut:
    if e < 0:
        s = 1
    else:
        s= 0
    a = str(s) + str(bin(abs(e))[2:].zfill(14))
    print a

for e in pulseOut:
    a = twos_complement(e, 14)
    print a
