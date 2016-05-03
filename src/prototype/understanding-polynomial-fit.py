#!/usr/bin/env python3
'''I want to understand why coefficients are the way they are:
- why should we expect large weights on the central cells?
- when is this expectation not met and why?
'''
from polynomial import Nomial, PolynomialFit, x, y
import numpy as np
from numpy.linalg import pinv
from sympy import Lambda

np.set_printoptions(precision=4, linewidth=120, suppress=True)

default_polynomial = [ \
    Nomial(Lambda((x, y), 1.0), 0), \
    Nomial(Lambda((x, y), x), 1), \
    Nomial(Lambda((x, y), y), 1), \
    Nomial(Lambda((x, y), x**2), 2), \
    Nomial(Lambda((x, y), x*y), 2), \
    Nomial(Lambda((x, y), y**2), 2), \
]

def invert(pts, polynomial=default_polynomial):

    B = PolynomialFit().matrix(pts, polynomial)
    return pinv(B)

def print_diagnostics(pts, polynomial=default_polynomial):
    coeffs = invert(pts, polynomial)[0]
    print("Stencil and coefficients\n", np.array(list(zip(pts, coeffs))))

    # it seems that coeffs only sum to 1 when the matrix is full rank
    print("Coefficients sum to", sum(coeffs))
    print()


print("xxx\nxxx\nxxx")
print_diagnostics([ \
    (-1, 0), (1, 0), (-2, 0), \
    (-1, 1), (1, 1), (-2, 1), \
    (-1, -1), (1, -1), (-2, -1), \
])

##############################################################################

# the coeffs for this (rank-deficient) matrix only sum to 0.5!
print(" xx\n xx\n xx")

no_x_squared = [ \
    Nomial(Lambda((x, y), 1.0), 0), \
    Nomial(Lambda((x, y), x), 1), \
    Nomial(Lambda((x, y), y), 1), \
    Nomial(Lambda((x, y), x*y), 2), \
    Nomial(Lambda((x, y), y**2), 2), \
]

print_diagnostics([ \
    (1, 0), (-1, 0), \
    (1, 2), (-1, 2), \
    (1, -1), (-1, -1), \
])

print_diagnostics([ \
    (1, 0), (-1, 0), \
    (1, 2), (-1, 2), \
    (1, -1), (-1, -1), \
], no_x_squared)

##############################################################################

print("xxx\n xx\n xx")
print_diagnostics([ \
    (-1, 0), (1, 0), \
    (-1, 1), (1, 1), (-2, 1), \
    (-1, -1), (1, -1), \
])
