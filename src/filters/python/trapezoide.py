import numpy as np

try:
  import matplotlib.pyplot as plt
except ImportError:
    pass

'''
[Radiation Detection and Analysis System](http://iuac.res.in/~elab/das/ppdas/ppdas.html)
'''

'''
?????
'''
Ts = 1/100E6
Tao = 1E-6
plot = False


def modDS(signal, delayL):
  del_  = np.zeros(delayL)

  delayLS = np.append(del_, signal)
  signal = np.append(signal, del_)

  dsL = np.floor(signal - delayLS)
  return dsL[:-delayL]

def HPD(dsK, m1, m2):
  acc1 = np.zeros(dsK.shape[0])
  mult = np.zeros(dsK.shape[0])

  for i in range(1, dsK.shape[0]):
    acc1[i] = acc1[i-1] + m2*dsK[i]/4
  acc1 = np.floor(acc1)

  for i in range(dsK.shape[0]):
    mult[i] = np.floor(m1*dsK[i])
  mult = np.floor(mult)

  rn= acc1 + mult

  sn = np.zeros(rn.shape[0])

  for i in range(1, sn.shape[0]):
      sn[i] = sn[i-1] + rn[i]
  sn = np.floor(sn)
  return rn, sn

def Signal( Ts, Tao, amp=1000, padd = 20,N=500 ):

    t= np.linspace(-padd*Ts, N*Ts, num=N+padd)

    s = amp * np.exp(-(t)/Tao)

    s[0:padd] =0.0

    return t,s 

def PHA(rn, thres=100):
  max_ = 0
  for i in range(rn.shape[0]):
     if rn[i] > thres:
         if rn[i] > max_:
             max_ = rn[i]
  return np.floor(max_ )

def calcM(Tao=50E-6, Tclk=1E-8, m2=1):
    M= 1 / (np.exp(Tclk/Tao) - 1)
    m1 = M * m2
    return M, m1

def poleZero(s,Tao, Ts):
    I=np.zeros(s.shape[0])
    for i in range (1,s.shape[0]):
      I[i] = I[i-1] + s[i]

    I=I*Ts/Tao

    return s +I

def noise(s,u, seed=3):
    #n = np.floor(np.random.normal(0, u, s.shape[0]))
    np.random.seed(seed)
    n = np.floor(np.random.random_integers(-u, u, s.shape[0]))
    return s + n


def trapez(spz, m1, m2, delayL=15, delayK=30 ):
       dsL = modDS (spz, delayL)
       dsK = modDS(dsL, delayK)

       rn,sn = HPD(dsK, m1, m2)
       return rn, sn

def calcAmps(amps, m2, Tao):
  max_s = []
  sum_max = 0

  noi= 1


  M,m1 = calcM(Tao = Tao, Tclk = Ts, m2=m2)


  for am in amps:

    t,s = Signal(Ts, Tao, amp=am)
    snoise = noise(s,noi)

    spz = poleZero(snoise, Tao, Ts)
    rn,sn = trapez(spz, m1, m2)

    max_ = PHA(sn)
    max_s.append(max_)

  return m1, np.asarray(max_s)


def calcDevs(max_s, amps):
    if (plot):
      R = 100
    try:
      plt.plot(t[:R],sn[:R])
      plt.plot(t[:R],sn[:R])
      plt.show()
    except NameError:
      pass

    pc = np.abs(np.floor(10000.0 * (max_s - amps)/amps)/100.0)

    return  pc.sum()/amps.shape[0]


'''
Tao   m1       m2
1E-6  255.0363  2.5631 
3E-6  250.6 0.836 
5E-6  262.894824561 0.52631578947
10E-6 241.984230702 0.242105263158
50E-6 246.028027136 0.0492105 
'''
def main1():
  amps =np.asarray([160, 320, 640, 1280, 1600, 2560, 5120, 8000, 10240, 16000])
  #amps = np.random.random_integers(160, 160*100, 10)
  #noises = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,20]

  Tao =10E-6
  for m2 in np.linspace(0.25, 0.380, 20):
    m1, max_s = calcAmps(amps, m2, Tao)
    devs = calcDevs(amps, max_s/4492)
    print m1, m2, devs
    #print np.floor(max_s/4492)

def main50():
    amp =16000
    Tao =50E-6
    Ts = 1E-8
    m1 = 256
    m2 = 1/32.0#0.0515
    noi = 0

    t,s = Signal(Ts, Tao, amp=amp)
    snoise = noise(s,noi)

    spz = poleZero(snoise, Tao, Ts)
    rn,sn = trapez(spz, m1, m2)
    max_ = PHA(sn)

    print rn[0:100]

    print max_

def main10():
    amp =16385
    Tao =10E-6
    Ts = 1E-8
    m1 = 297
    m2 = 0.297 #0.0515
    noi = 0

    t,s = Signal(Ts, Tao, amp=amp)
    snoise = noise(s,noi)

    spz = poleZero(snoise, Tao, Ts)
    rn,sn = trapez(spz, m1, m2)
    max_ = PHA(sn)

    print np.floor(sn[0:100])

    print max_

    import biggles
    p = biggles.FramedPlot()
    p.add( biggles.Curve(np.arange(sn.shape[0])[20:70], sn[20:70], color='blue'))
    p.add(biggles.Slope( 0, color='green' ))
    p.show()


def lessThanZeroToHex(n=.90003):

  ang=[np.power(16.0,-i) for i in range(1,5)]
  nc=0
  for e in ang:
    a= n/e
    b = int(a)
    #print b, bin(b)[2:]
    n=(a-b)*e
    nc = nc + b*e

  return nc

def testLTZ():
    nl=[.9,.99,.999,.9999,.99999]
    for n in nl:
      nc = lessThanZeroToHex(n=n)
      print nc, n, nc*16384, n*16384

import math
def test2LTZ():
    ml =[0]*20
    ml.extend([1000]*100)
    ml.extend([0]*10)
    t=[i for i in range(len(ml))]

    nc = lessThanZeroToHex(n=.5)
    nc_x = lessThanZeroToHex(n=.99999)
    mem_y = 0
    mem_x = 0
    o=[]
    for m in ml:
        err = int(m + math.floor(nc*mem_y) - math.floor(nc_x*mem_x))
        mem_y = err
        mem_x = m
        o.append(err)
    return ml, o,t


def test3LTZ(s, att=.56):

    nc = lessThanZeroToHex(n=.75)
    c = lessThanZeroToHex(n=att)

    mem_y = 0
    o=[]
    for m in s:
        y = int(m + math.floor(nc*mem_y))
        mem_y = y
        o.append(math.floor(c*y))
    return o



def f1():
  in_, out1, t = test2LTZ()
  out2 = test3LTZ(out1, .65)
  out3 = test3LTZ(out2, .5)
  out4 = test3LTZ(out3, .5)
  out5 = test3LTZ(out4, .45)
  out6 = test3LTZ(out5, .45)

def draw(t, in_, out):

  import biggles

  p = biggles.FramedPlot()
  p.add( biggles.Curve(t, out, color='blue'))
  p.add( biggles.Curve(t, in_, color='red'))
  p.add(biggles.Slope( 0, color='green' ))
  p.show()


def int_1(s):
    nc = lessThanZeroToHex(n=.2)
    c = lessThanZeroToHex(n=.6)

    mem_y = 0
    mem_x = 0
    o=[]
    for m in s:
        y = int(nc*m + nc*mem_x + math.floor(c*mem_y))
        mem_y = y
        mem_x = m
        o.append(math.floor(y))
    return o

def int_2(s):
    b1 = lessThanZeroToHex(n=.1)
    b2 = lessThanZeroToHex(n=.01)
    b3 = lessThanZeroToHex(n=.92)
    b4 = lessThanZeroToHex(n=.02)

    mem_y2 = 0
    mem_y1 = 0
    mem_x2 = 0
    mem_x1 = 0
    o=[]
    for m in s:
        y = int(m - b1*mem_x1 + b2*mem_x2 + math.floor(b3*mem_y1) - b4*mem_y2)
        mem_y2 = mem_y1
        mem_x2 = mem_x1
        mem_y1 = y
        mem_x1 = m
        o.append(math.floor(y))
    return o




def cross_zero(s):
    nc = lessThanZeroToHex(n=.2)
    c = lessThanZeroToHex(n=.6)

    mem_y = 0
    mem_x = 0
    o=[]
    for m in s:
        y = 3*(nc*m - nc*mem_x ) - int(nc*m + nc*mem_x + math.floor(c*mem_y))
        mem_y = y
        mem_x = m
        o.append(math.floor(y))
    return o

def cross_zero2(s):
    nc = lessThanZeroToHex(n=.8)

    mem_y = 0
    mem_x = 0
    o=[]
    for m in s:
        y = int(m - mem_x + math.floor(nc*mem_y))
        mem_y = y
        mem_x = m
        o.append(math.floor(y))
    return o




def f2():
  in_, out1, t = test2LTZ()
  out2 = int_2(out1)
  out3 = cross_zero2(out2)
  return t, in_, out3

if __name__ == "__main__":
    t, in_, o=f2()
    draw(t,o, o)
