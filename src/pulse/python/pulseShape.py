'''
integrador:

y(n) = x(n) + y(n-1) + ci*y(n-2)
ci: coef integ = 0.01

y(n) = (x(n) + y(n-1) + ci2*y(n-2))/ci3

ci2 = 2 - ci3

derivador:

y(n) = (x(n) -x(n-1) - (1-cd) * y(n-1)) / (1+cd)

y(n) = x(n) - x(n-1) - cd * y(n-1))

cd = 0.8

cross zero:

y(n) = 3 * (x(n) - x(n-1)) - (x(n) + y(n-1) + ci2*y(n-2))/ci3


pass bass:

b1=-0.1 b2= 0 b3=1 b4=-0.02

y(n) = x(n) + b1 * x(n-1) + b2 * x(n-2) + b3 * y(n-1) + b4 * y(n-2) 

'''

import numpy as np
from scipy import signal
'''
y(n) = a0 * x(n) + a1 * x(n-1) + a2 * x(n-2) - b1 * y(n-1) - b2 * y(n-2)
'''

'''
http://scipy-cookbook.readthedocs.io/items/ButterworthBandpass.html

'''
class Butter():

  def __init__(self, lowcut=1E5, highcut=20E6, fs=100E6, order=1):
    self.lowcut = lowcut
    self.highcut = highcut
    self.fs = fs
    self.order = order
    self.nyq = 0.5 * fs

  def bandpass(self):
    
    low = self.lowcut / self.nyq
    high = self.highcut / self.nyq
    bband, aband = signal.butter(self.order, [low, high], btype='band')
    return bband, aband


  def bandpass_filter(self,data):
    bband, aband = self.bandpass()
    y = signal.lfilter(bband, aband, data)
    return y

  def lowpass(self):
    low = self.lowcut / self.nyq
    blow, alow = signal.butter(self.order, low, btype='lowpass')
    return blow, alow

  def highpass(self):
    high = self.lowcut / self.nyq
    blow, alow = signal.butter(self.order, high, btype='highpass')
    return blow, alow




def PBO2(rel=0.01):
  K = np.tan( np.pi * rel )
  K2 = K **2
  DEN = 1 + np.sqrt(2) * K + K**2
  a0=K2 / DEN
  a1=2*a0
  a2=a1
  b1=2*(K2-1) / DEN
  b2 = (DEN - 2 * np.sqrt(2) * K) / DEN
  b, a = signal.butter(2, rel, 'lowpass', analog=False)

  return {"a0" : a0, "a1" : a1, "a2":a2, 'b0':1, 'b1':b1, 'b2':b2}

def PBO2_S(rel=0.05):
  b, a = signal.butter(2, rel, 'lowpass', analog=False)
  return {"a0" : b[0], "a1" : b[1], "a2":b[2], 'b0':a[0], 'b1':a[1], 'b2':a[2]}

def PBO1_S(rel=0.01):
  b, a = signal.butter(1, rel, 'lowpass', analog=False)
  return {"a0" : b[0], "a1" : b[1], "a2":0.0, 'b0':a[0], 'b1':a[1], 'b2':0.0}

def HPO1_S(rel=0.01):
  b, a = signal.butter(1, rel, 'highpass', analog=False)
  return {"a0" : b[0], "a1" : b[1], "a2":0.0, 'b0':a[0], 'b1':a[1], 'b2':0.0}


def HPO2_S(rel=0.01):
  b, a = signal.butter(2, rel, 'highpass', analog=False)
  return {"a0" : b[0], "a1" : b[1], "a2":b[2], 'b0':a[0], 'b1':a[1], 'b2':a[2]}

def BPO2_S(low=0.01, high=0.1):
  b, a = signal.butter(2, [low,high], 'band', analog=False)
  return {"a0" : b[0], "a1" : b[1], "a2":b[2], 'b0':a[0], 'b1':a[1], 'b2':a[2]}



def HPO2 (rel=0.1):
  K = np.tan( np.pi * rel )
  coef = PBO2(rel)
  coef['b0'] = 1 
  coef['a0'] = coef['a0'] / (K**2)
  coef['a1'] = -1 * coef['a1'] / (K**2)
  coef['a2'] = coef['a2'] / (K**2)
  b, a = signal.butter(2, rel, 'highpass', analog=False)
  return coef

'''
integrador:

y(n) = x(n) + y(n-1) + ci*y(n-2)
ci: coef integ = 0.01
'''
def integrador(ci=0.05):
    return {"a0" : 1.0, "a1" : 0, "a2":0, 'b0':2,'b1':-1.0, 'b2':ci}

'''
derivador:

y(n) = (x(n) -x(n-1) - (1-cd) * y(n-1)) / (1+cd)
'''
def derivador1(cd=0.2):
    return {"a0" : 1.0, "a1" : -1, "a2":0, 'b0':1+cd,'b1':-(1.0-cd), 'b2':0}

'''
derivador:
y(n) = x(n) - x(n-1) + cd * y(n-1))
cd = .8
'''
def derivador(cd=0.8):
    return {"a0" : 1.0, "a1" : -1, "a2":0, 'b0':1,'b1':-cd, 'b2':0}

'''
pass bass:

b1=-0.1 b2= 0 b3=1 b4=-0.02

y(n) = x(n) + b1 * x(n-1) + b2 * x(n-2) + b3 * y(n-1) + b4 * y(n-2) 
y(n) = x(n) + b1 * x(n-1) + b2 * x(n-2) + b1 * y(n-1) + b2 * y(n-2) 

'''

def pass_bass():
    return {"a0" : 1.0, "a1" : -0.1, "a2":0, 'b0':1,'b1':-1, 'b2':0.02}

def response (coef, x):
  response = []
  a0=coef['a0']
  a1=coef['a1']
  a2=coef['a2']

  b2=coef['b2']
  b1=coef['b1']
  b0=coef['b0']

  x1=0.0
  x2=0.0
  y1=0.0
  y2=0.0
  x0=1.0

  for e in x:
      x0 = (e)
      y0= ((a0 * x0 + a1 * x1 + a2 * x2 - b1 * y1 - b2 * y2) / b0)
      response.append(y0)
      x2=x1
      x1=x0
      y2=y1
      y1=y0
  return response

def signalGen(Nzeros=40,N=300, tipo='imp', exp_=.5):

    x=[0]*N
    t = [i for i in range(N+Nzeros)]
    x[0] = 1
    if tipo == 'step':
      x=[1]*N
      x[0] = 1
    else: 
      if tipo == 'exp':
        for i,e in enumerate(x):
            x[i] = np.exp(-i*exp_)
    [x.insert(0,0) for i in range(Nzeros)]
    return t,x

import biggles
def main ():
  coefI = integrador()
  coefD = derivador1()
  coefHP = HPO2_S(rel=0.01)
  coefPB = PBO1_S()
  print coefHP
  print coefPB
  t,x = signalGen(tipo='step')
  r = response(coefHP, x)
  rr = response(coefPB, x)

  #r = response(coefI, rr)
  #rr = response(coefI, r)

  plt = biggles.FramedPlot()

  plt.add(biggles.Curve( t,x, color="black"))
  plt.add(biggles.Curve( t,rr, color="red"))
  plt.add(biggles.Curve( t,r, color="blue"))
  plt.show()

def testBP():

  but = Butter()
  t,x = signalGen(tipo='step')
  y = but.bandpass_filter(x)
  plt = biggles.FramedPlot()

  plt.add(biggles.Curve( t,y, color="black"))
  plt.add(biggles.Curve( t,x, color="black"))
  plt.show()

if __name__ == "__main__":
        #main()
        testBP()
