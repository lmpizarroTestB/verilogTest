import numpy as np
import twoCompl as twc

import biggles

class PMT ():

  '''
  PHOTOMULTIPLIER TUBES
  principles & applications

  Re-edited September 2002 by S-O Flyckt* and Carole Marmonier**,
  Photonis, Brive, France

  '''
  def __init__(self, gain=4, nDynodes=10):
     self.dynodeGain = np.ones(nDynodes)*gain
     # current amplification
     self.totalGain = np.multiply.reduce(self.dynodeGain)

     print self.totalGain 



class GenPulse:

    def __init__(self, FS= 100E6):
      self.IMAX = 0.005
      self.LAMBDA = 0.01  

      self.FS = FS 
      self.VADC = 5.0
      self.NBITS = 14


    def setPmtComps(self, RES=1000, CAP=1E-9):
        self.RES = RES
        self.CAP = CAP 

    def calcConstants(self):
        self.TAO = self.CAP * self.RES
        self.NOiSE = self.LAMBDA / 100.0  #percent noise
        self.RADC = np.power(2, self.NBITS)  # ADC resolution

        self.TS = 1.0 / self.FS # sampling period
        self.K2 = self.CAP / self.TS
        self.K1 = self.TS * self.RES /(self.TAO  + self.TS)

    def initLists(self, RINIT=1028):
        self.RINIT = RINIT
        self.RPULSE = 4096 * 2 - self.RINIT
        self.expPulse = []
        self.gaussianPulse = []
        self.pulseOut = []
        self.pulseOut.append(0)
        for i in range(self.RINIT):
            self.expPulse.append((.5 - np.random.random())*self.NOiSE)
            self.gaussianPulse.append(0)

    def calcPulseExp(self):
        for i in range(self.RPULSE):
            self.expPulse.append(self.IMAX*np.exp(-i*self.LAMBDA) + (.5-
                np.random.random())*self.NOiSE)

        self.expPulse.append(0)

    def differential(self):
        t = 0
        for i,e in enumerate(self.pulseOut):
            self.pulseOut[i] = e - t
            t = e

    def integra(self, a1 = 0.03125 / 512.0  , a2 = 0.00391 / 1024.0 , amp = 0.5):
        suma = 0
        m1 = 0
        m2 = 0
        for i,e in enumerate(self.pulseOut):
            suma = int(suma + amp * e  -  a1 * m1   +  a2 * m2)
            self.pulseOut[i] =  suma 
            m2 = m1
            m1 = suma

    def amplifier(self, a = .5):
        for i,e in enumerate(self.pulseOut):
            self.pulseOut[i] =  a * e 

    def calcPulseTri(self, WIDE = 500):
        N1=int(.2*WIDE)
        N2=WIDE-N1

        for i in range(N1):
            noise = (.5 - np.random.random())*self.NOiSE
            self.expPulse.append(self.IMAX * i / N1 + noise)
        for i in range(N2):
            noise = (.5 - np.random.random())*self.NOiSE
            self.expPulse.append(noise + self.IMAX - i * self.IMAX / N2)
        for i in range(self.RPULSE - N1 - N2):
            noise = (.5 - np.random.random())*self.NOiSE
            self.expPulse.append(noise)

    def calcPmtOut(self):
        for i in range(self.RINIT + self.RPULSE - 1):
            self.pulseOut.append((self.expPulse[i+1] + self.K2 * self.pulseOut[i])*self.K1)

    def calcADCOut(self, noise):
        for i,e in enumerate(self.pulseOut):
            self.pulseOut[i] = int(self.pulseOut[i] * self.RADC / self.VADC +
                    np.random.randint(-noise,noise))
        time=[]
        [time.append(i) for i in range(len(self.pulseOut))]
        return time, self.pulseOut



    def calcPulse(self):
        for i in range(self.RPULSE):
            self.expPulse.append(self.IMAX*np.exp(-i*self.LAMBDA) + (.5-
                np.random.random())*self.NOiSE)
            T = (i-2000)
            if ( T < 0):
                self.gaussianPulse.append(self.IMAX*np.exp(-T**2/200000))
            else:
                self.gaussianPulse.append(0)

        self.expPulse.append(0)

        for i in range(self.RINIT + self.RPULSE - 1):
            self.pulseOut.append((self.expPulse[i+1] + self.K2 * self.pulseOut[i])*self.K1)


        for i,e in enumerate(self.pulseOut):
            self.pulseOut[i] = int(self.pulseOut[i] * self.RADC / self.VADC +
                    np.random.randint(-30,30))

def main():
    pulse = GenPulse()
    pulse.setPmtComps()
    pulse.calcConstants()
    pulse.initLists()
    #pulse.calcPulseExp()
    pulse.calcPulseTri()
    pulse.calcPmtOut()
    time, out = pulse.calcADCOut(3)
    #pulse.differential()

    import copy
    tmp = copy.copy(pulse.pulseOut)

    #pulse.integra()
    pulse.amplifier(1.0/256.0)
    pulse.integra()
    tw = twc.TwoCompl(16)
    #twl = tw.toFile(pulse.pulseOut, "vector.tv")

    plt = biggles.FramedPlot()

    plt.add(biggles.Curve( time,pulse.expPulse, color="black"))

    plt.show()

if __name__ == "__main__":
  #main()
  pmt = PMT()
