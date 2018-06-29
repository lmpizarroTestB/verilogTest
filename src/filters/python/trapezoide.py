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
  return np.floor(max_ / 256)

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

  noi= 0


  M,m1 = calcM(Tao = Tao, Tclk = Ts, m2=m2)


  for am in amps:

    t,s = Signal(Ts, Tao, amp=am)
    snoise = noise(s,noi)

    spz = poleZero(snoise, Tao, Ts)
    rn,sn = trapez(spz, m1, m2)

    max_ = PHA(rn)
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

  Tao =50E-6
  for m2 in np.linspace(.04, 0.06, 20):
    m1, max_s = calcAmps(amps, m2, Tao)
    devs = calcDevs(amps, max_s)
    print m1, m2, devs 

def main50():
    amp =8000
    Tao =50E-6
    Ts = 1E-8
    m1 = 256
    m2 = 1/32.0#0.0515
    noi = 0

    t,s = Signal(Ts, Tao, amp=amp)
    snoise = noise(s,noi)

    spz = poleZero(snoise, Tao, Ts)
    rn,sn = trapez(spz, m1, m2)
    max_ = PHA(rn)

    print rn[0:100]

    print max_
if __name__ == "__main__":
    main50()
