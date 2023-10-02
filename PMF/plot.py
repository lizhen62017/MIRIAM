from matplotlib import pyplot as plt, patches
import numpy as np
for i in range(121): 
  data = []
  with open('u%s/COLVAR' % i) as inf:
    next(inf)    
    for line in inf:
      parts = line.split() # split line into parts
      if len(parts) > 1:   # if at least 2 parts/columns
        data.append(float(parts[1]))   # print column 2
  #print(data)
  plt.hist(data,bins=np.arange(min(data), max(data) + 0.001, 0.001), histtype=u'step')
plt.savefig('hist.png')
