#!/usr/bin/env python3

"""this gives the surprising result of 0.5, 0.5, 0, 0
which differs from the result from Eigen (~0.8, ~0.3, ~-0.3, 0)"""
import numpy as np
import numpy.linalg as la

B = [ \
    [1, -0.5, -0.5**2, -0.5**3], \
    [1, 0.5, 0.5**2, 0.5**3], \
    [1, -1.5, -1.5**2, -1.5**3], \
    [1, -2.5, -2.5**2, -2.5**3] \
]

Binv = la.pinv(B)
print(Binv)
print(np.allclose(B, np.dot(B, np.dot(Binv, B))))
print(np.allclose(Binv, np.dot(Binv, np.dot(B, Binv))))
