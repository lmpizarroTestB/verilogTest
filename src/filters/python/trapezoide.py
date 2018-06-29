import numpy as np

try:
  import matplotlib.pyplot as plt
except ImportError:
    pass

'''
[Radiation Detection and Analysis System](http://iuac.res.in/~elab/das/ppdas/ppdas.html)
'''
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

def modDS(signal, delayL):
  del_  = np.zeros(delayL)

  delayLS = np.append(del_, signal)
  signal = np.append(signal, del_)

  dsL = signal - delayLS
  return dsL

def main(signal, paddi, delayL):

  delayLS =[0.0]*(paddi+delayL) 

  delayLS.extend(signal)

  diff_len = len(delayLS) - len(signal)

  signal.extend([0.0]*diff_len)

  dsL = np.asarray(signal) - np.asarray(delayLS)

  print dsL[:-50].shape[0]

  return dsL


if __name__ == "__main__":
  paddi = 20
  N = 500
  amp = 3000
  delayL = 10
  signal = [0.0]* paddi
  signal.extend([amp - 60.0*i for i in range(N)])
  signal = np.asarray(signal)

  delayK = 5

  dsL = modDS (signal, delayL)
  dsK = modDS(dsL, delayK)

  acc1 = np.zeros(dsK.shape[0])
  mult = np.zeros(dsK.shape[0])
  for i in range(1, dsK.shape[0]):
    acc1[i] = acc1[i-1] + .125*dsK[i]/4

  for i in range(dsK.shape[0]):
    mult[i] = 8*dsK[i]

  rn= acc1 + mult

  sn = np.zeros(rn.shape[0])

  for i in range(1, sn.shape[0]):
      sn[i] = sn[i-1] + .125*rn[i]


  t = [i for i in range(100)]

  try:
   plt.plot(t, rn[:100])
   #plt.plot(t, dsK[:100])
   #plt.plot(t, sn[:100])
   #plt.plot(t, rn[:100])
   plt.show()
  except NameError:
      pass


  thres = 100
  max_ = 0
  for i in range(100):
     if rn[i] > thres:
         print rn[i]
         if rn[i] > max_:
             max_ = rn[i]
  print max_
