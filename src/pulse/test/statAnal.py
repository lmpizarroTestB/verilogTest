import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

nameFile = "data.txt"
dir_='./'

fo = open (dir_ + nameFile, 'r')
fo.readline()
fo.readline()

d1=[]
d2=[]
for e in fo:
    d= e.split()
    d1.append(float(d[0]))
    d2.append(float(d[1]))

d1 = np.asarray(d1)
d2 = np.asarray(d2)

print d1.mean(), d2.mean()

des1 = stats.describe(d1)
des2 = stats.describe(d2)
print "N (min, max) Mean var skew kurt"
print des1
print des2

his2 = np.histogram(d2)

print his2[0], his2[1][1:]

plt.plot ( his2[1][1:], his2[0])
plt.show()
