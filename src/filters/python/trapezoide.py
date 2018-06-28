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
def gaussian (s):

    sd2 = np.append(s[2:],np.zeros(2))
    sd1 = np.append(s[1:],np.zeros(1))
    y = s + sd2 + sd1*2 
    plt.plot(sd2[10:40])
    plt.plot(sd1[10:40])
    plt.plot(y[10:40])
    plt.show()



    return y

def test():
  N = 500
  d=10
  c = .2

  s1 = np.ones(N-d)
  v = np.zeros(N)

  v[d:] = s1 * 3000

  for i in range(1,v.shape[0]):
      v[i] = v[i] - 4.0*i

  d = c*v

  delay = 5

  d_delay = np.zeros(d.shape[0]+delay)
  d_delay[delay:] = d
  v_delay = np.zeros(d.shape[0]+delay)
  v_delay[delay:] = d

  d = np.append(d, np.zeros(delay))
  v = np.append(d, np.zeros(delay))

  k = np.asarray([i for i in range(d.shape[0])]) 
  diff = d - d_delay

  Dn=np.zeros(diff.shape[0])
  un=np.zeros(diff.shape[0])
  sn=np.zeros(diff.shape[0])
  
  for i in range (1,Dn.shape[0]):
      Dn[i]=Dn[i-1] + diff[i]
      un[i] = v[i] + Dn[i-1]


  for i in range (1,Dn.shape[0]):
      sn[i] = un[i] - v_delay[i]

  try:
   plt.plot(Dn)
   plt.plot(v, '.', color='black')
   plt.show()
  except NameError:
      pass

def main(signal, paddi, delayL):
  delayLS =[0.0]*(paddi+delayL) 
  delayLS.extend(signal)
  diff_len = len(delayLS) - len(signal)
  signal.extend([0.0]*diff_len)
  dsL = np.asarray(signal) - np.asarray(delayLS)
  print dsL[:-50].shape[0]
  return dsL


def modDS(signal, delayL):
  del_  = np.zeros(delayL)

  delayLS = np.append(del_, signal)
  signal = np.append(signal, del_)

  dsL = signal - delayLS
  return dsL[:-delayL]

def HPD(dsk, m1, m2):
  acc1 = np.zeros(dsK.shape[0])
  mult = np.zeros(dsK.shape[0])

  for i in range(1, dsK.shape[0]):
    acc1[i] = acc1[i-1] + .125*dsK[i]/4
  acc1 = np.floor(acc1)

  for i in range(dsK.shape[0]):
    mult[i] = np.floor(m1*dsK[i])
  mult = np.floor(mult)

  rn= acc1 + mult

  sn = np.zeros(rn.shape[0])

  for i in range(1, sn.shape[0]):
      sn[i] = sn[i-1] + m2*rn[i]
  sn = np.floor(sn)
  return rn, sn

def Signal(N, padd, Ts, Tao, amp=1000):

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
'''
Tao    M            m1       m2
5E-6 499.500167 14.985005 0.030000 -> noise .5
3E-6 299.500278 8.985008 0.030000 -> noise .875
10E-6 999.500083 29.985002 0.030000 -> noise 0.25
50E-6 4999.500017 249.975001 0.050000 
'''

def poleZero(s,Tao, Ts):
    I=np.zeros(s.shape[0])
    for i in range (1,s.shape[0]):
      I[i] = I[i-1] + s[i]

    I=I*Ts/Tao

    return s +I

def noise(s,u):
    #n = np.floor(np.random.normal(0, u, s.shape[0]))
    n = np.floor(np.random.random_integers(-u, u, s.shape[0]))
    return s + n

if __name__ == "__main__":
  paddi = 20
  N = 500
  amp = 16000
  plot = False

  delayL = 15
  delayK = 30
  Ts = 1/100E6
  Tao = 3E-6

  print Tao/Ts, 2**23
  m2 =  .82 

  M,m1 = calcM(Tao = Tao, Tclk = Ts, m2=m2)
  print "%f %f %f"%(M, m1, m2)


  amps =[160, 320, 640, 1280, 1600, 2560, 5120, 8000, 10240, 16000]
  #noises = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,20]
  noises = [20]
  max_ss = {} 
  for noi in noises:
     max_s = []
     sum_max = 0
     for amp in amps:
       t,s = Signal(N, paddi, Ts, Tao, amp=amp)

       snoise = noise(s,noi)
       spz = poleZero(snoise, Tao, Ts)

       dsL = modDS (spz, delayL)
       dsK = modDS(dsL, delayK)

       rn,sn = HPD(dsK, m1, m2)
       max_ = PHA(rn)
       pc = int(10000.0 * (max_ - amp)/amp)/100.0
       max_s.append(pc)
       pc = pc*pc
       sum_max = sum_max + pc
     print m2, np.sqrt(sum_max)
     max_ss[str(noi)] = (max_s)

  for noi in noises:
      print noi, max_ss[str(noi)]

  if (plot):
   R = 100
   try:
    plt.plot(t[:R],sn[:R])
    plt.plot(t[:R],sn[:R])
    plt.show()
   except NameError:
      pass
