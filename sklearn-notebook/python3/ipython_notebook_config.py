c = get_config()
# ... Any other configurables you want to set
c.IPKernelApp.matplotlib = 'inline'
#http://stackoverflow.com/questions/21176731/automatically-run-matplotlib-inline-in-ipython-notebook

import warnings
warnings.simplefilter(action = "ignore", category = DeprecationWarning)

import pandas as pd
#pd.describe_option('display')
pd.set_option('display.max_columns', 100)


import matplotlib as mpl
mpl.rcParams['figure.figsize']=(8.0,6.0)    #(6.0,4.0)
mpl.rcParams['font.size']=8                #10 
mpl.rcParams['savefig.dpi']=100             #72 
mpl.rcParams['figure.subplot.bottom']=.1    #.125
