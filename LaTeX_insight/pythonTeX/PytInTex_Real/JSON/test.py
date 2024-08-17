def main(x):
    y = 2*x
    z = 2*y
    g = 2*z
    return g

from matplotlib import pyplot as plt
import numpy as np

x = np.linspace(0, 2*np.pi, num = 80)
y = np.sin(x)
plt.plot(x, y)

# plt.show()
plt.savefig("Tran.pdf")