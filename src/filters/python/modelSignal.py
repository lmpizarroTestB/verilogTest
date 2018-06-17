import biggles

import numpy as np

class PMT():
  def __init__(self, fs=100E6, tau=1E-6, Nsamples=15000):
    self.TS = 1/fs
    self.fs = fs
    self.tau = tau
    self.Nsamples =Nsamples

  def expSignal(self,amp=50):
    self.tsi = np.linspace(0,self.TS*self.Nsamples, self.Nsamples)
    self.signal = amp*np.exp(-self.tsi/self.tau)
    self.tsimicro = self.tsi*1E6

  def display(self):
    p = biggles.FramedPlot()
    p.add( biggles.Curve(self.tsimicro,self.signal, color="red") )
    p.show()


class preSignal:
  def __init__(self, PMT):
      self.detector = PMT
      self.tsimicro = self.detector.tsimicro
      self.TS = self.detector.TS


  def display(self):
    p = biggles.FramedPlot()
    p.add( biggles.Curve(self.detector.tsimicro,self.signal, color="red") )
    p.show()

  def genPre(self):

    self.signal=[]
    y1=0
    for i,e in enumerate(self.detector.signal):
        yy =e+ 0.9999*y1 
        self.signal.append(yy)
        y1=yy

    self.signal=np.asarray(self.signal)    


def integrator75(x):
    
    y=[]
    y1=0
    for e in x:
        yy =int(e+ int((y1 + int(y1/2.0))/2.0))
        y.append(yy)
        y1=yy

    return y


def delayS(s, t, TS, N=10):
    d=np.copy(s)
    size = d.shape[0] + N

    TT = np.linspace(0,TS*(size), (size))
    d=np.pad(d,(N,0),'constant')
    s=np.pad(s,(0,N),'constant')

    print TT.shape, d.shape, s.shape

    return TT, d,s

if __name__ == "__main__":


    pmt = PMT()
    pmt.expSignal(amp=5)
    pre = preSignal(pmt)
    pre.genPre()
    pmt.display()
    pre.display()


    t,x,s=delayS(pre.signal,pre.tsimicro, pre.TS, N=1000)


    p = biggles.FramedPlot()
    p.add( biggles.Curve(t,s, color="blue") )
    p.add( biggles.Curve(t,x, color="red") )
    p.show()

