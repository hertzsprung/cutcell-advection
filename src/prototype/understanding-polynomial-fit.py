#!/usr/bin/env python3
'''I want to understand why coefficients are the way they are:
- why should we expect large weights on the central cells?
- when is this expectation not met and why?
'''
from termcolor import colored
from polynomial import Nomial, x, y
import numpy as np
from numpy.linalg import pinv
from sympy import Lambda

np.set_printoptions(precision=4, linewidth=120, suppress=True)

default_polynomial = [ \
    Nomial(Lambda((x), 1.0), 0), \
    Nomial(Lambda((x), x), 1), \
    Nomial(Lambda((x), x**2), 2), \
    Nomial(Lambda((x), x**3), 3), \
]

epsilon=1e-3

def matrix(pts, polynomial):
    return np.array([[n(x) for n in polynomial] for x in pts], dtype=float)

def weight(B, weights):
    return np.array([w * row for w, row in zip(weights, B)])

def invert(pts, weights, polynomial=default_polynomial):
    B = weight(matrix(pts, polynomial), weights)
    print("Points", pts)
    print("Polynomial", polynomial)
    print("Weights", weights)
    print("Matrix\n", B)
    return pinv(B)

def print_diagnostics(pts, weights, polynomial=default_polynomial):
    coeffs = invert(pts, weights, polynomial)[0] * weights
    print("Stencil and coefficients\n", np.array(list(zip(pts, coeffs))))

    # it seems that coeffs only sum to 1 when the matrix is full rank
    upwind_sum = sum([c for c, pt in zip(coeffs, pts) if pt < 0])
    downwind_sum = sum([c for c, pt in zip(coeffs, pts) if pt >= 0])
    upwind_sum_largest = upwind_sum + epsilon > downwind_sum

    upwind_mag_sum = sum([abs(c) for c, pt in zip(coeffs, pts) if pt < 0])
    downwind_mag_sum = sum([abs(c) for c, pt in zip(coeffs, pts) if pt >= 0])
    upwind_mag_sum_largest = upwind_mag_sum + epsilon > downwind_mag_sum

    upwind_coeff_is_largest = len([c for c in coeffs[1:] if c > coeffs[0] + epsilon]) == 0
    lower_bounded = abs(coeffs[1]) < coeffs[0]
    upper_bounded = coeffs[0] <= 1 + coeffs[0]
    upwind_more_than_half = coeffs[0] >= 0.5

    print("Coefficients sum to", colored(sum(coeffs), 'green' if sum(coeffs) > 1-epsilon and sum(coeffs) < 1+epsilon else 'red'))
    print("|downwind| < upwind", colored(lower_bounded, 'green' if lower_bounded else 'red'))
    print("upwind <= 1 + downwind", colored(upper_bounded, 'green' if upper_bounded else 'red'))
    print("upwind >= 0.5", colored(upwind_more_than_half, 'green' if upwind_more_than_half else 'red'))
    print("Upwind coefficient is largest", colored(upwind_coeff_is_largest, 'green' if upwind_coeff_is_largest else 'red'))
    print("Upwind coefficients sum to", colored(upwind_sum, 'green' if upwind_sum_largest else 'red'))
    print("Downwind coefficients sum to", colored(downwind_sum, 'green' if upwind_sum_largest else 'red'))
    print("mag upwind coefficients sum to", colored(upwind_mag_sum, 'green' if upwind_mag_sum_largest else 'red'))
    print("mag downwind coefficients sum to", colored(downwind_mag_sum, 'green' if upwind_mag_sum_largest else 'red'))
    print()

pts = [-1, 0.5, -3, -5]
#pts = [-1, 0.5, -2]
weights = [1e3, 1e3, 1, 1]

print_diagnostics(pts, weights)
print_diagnostics(pts, weights, default_polynomial[:3])
print_diagnostics(pts, weights, default_polynomial[:2])
print_diagnostics(pts, weights, default_polynomial[:1])

