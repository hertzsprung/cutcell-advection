from polynomial import Nomial, PolynomialFit, x, y
import numpy.linalg as la
import itertools
from termcolor import colored

def central_are_largest(coefficients):
    smallest_central_coefficient = min(coefficients[:2])
    large_peripheral_coefficients = [c for c in coefficients[2:] if c > smallest_central_coefficient]
    return len(large_peripheral_coefficients) == 0

def stable(coefficients):
    upwind = coefficients[0]
    downwind = coefficients[1]
    return abs(downwind) < upwind and upwind <= 1 + downwind and upwind >= 0.5 and central_are_largest(coefficients)

def test_six_points_with_diagonal():
    pts = [(-1, 0.0330314), (0.907926, -2.64e-14), (-1.13441, 3.05716), (-0.87524, -2.99221), (0.907926, 3.02642), (0.907926, -3.02642)]

    polynomialFit = PolynomialFit(full_rank_tol=1e-3)
    candidateTerms = polynomialFit.subset_that_fits(pts)

    for termCount in reversed(range(1,len(candidateTerms)+1)):
        combinations = itertools.combinations(candidateTerms, termCount)
        stabilisable = None
        for c in combinations:
            print("***", c)
            B = polynomialFit.matrix(pts, c)
            #B[0] = B[0] * 5
            #B[1] = B[1] * 5
            Binv = la.pinv(B)
            #Binv[0][0] = Binv[0][0] * 5
            #Binv[0][1] = Binv[0][1] * 5
            coeffs = Binv[0]
            if central_are_largest(coeffs):
                stabilisable = c
        if stabilisable:
            break

    downwind_weight = 5
    while downwind_weight > 2:
        downwind_weight -= 1
        B = polynomialFit.matrix(pts, stabilisable)
        B[0] = B[0] * 5
        B[1] = B[1] * downwind_weight
        Binv = la.pinv(B)
        Binv[0][0] = Binv[0][0] * 5
        Binv[0][1] = Binv[0][1] * downwind_weight
        coeffs = Binv[0]
        if stable(coeffs):
            print(colored(stabilisable, 'green'))
            print("downwind weight", downwind_weight)
            print(colored(coeffs, 'green'))
            break

