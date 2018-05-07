import random
import math 

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
    print e
