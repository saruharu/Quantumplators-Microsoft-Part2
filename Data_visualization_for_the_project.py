#!/usr/bin/env python
# coding: utf-8

# In[12]:


import matplotlib.pyplot as plt
import pandas as pd

# Generate data on commute times.
size, scale = 1000, 10
commutes = pd.Series(np.random.gamma(scale, size=size) ** 1.5)

commutes.plot.hist(grid=True, bins=4, rwidth=0.9,
                   color='#607c8e')
plt.title('Probability for 1,000 randomly generated trials')
plt.xlabel('Counts')
plt.ylabel('Probability')
plt.grid(axis='y', alpha=0.75)


# In[20]:


from matplotlib import pyplot as plt
import numpy as np
# Creating a random dataset
a = np.random.gamma(scale, size=1000) ** 1.5
  
# Creating the histogram
fig, ax = plt.subplots(figsize =(10, 7))
ax.hist(a, bins = [0,25,50,75,100])
  
# Show plot
plt.show()


# In[ ]:




