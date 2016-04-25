from polynomial import Nomial, PolynomialFit, x, y
import numpy.linalg as la
from termcolor import colored

def test_six_points_with_diagonal():
    pts = [(-1, 0.0330314), (0.907926, -2.64e-14), (-1.13441, 3.05716), (-0.87524, -2.99221), (0.907926, 3.02642), (0.907926, -3.02642)]

    fit = PolynomialFit(full_rank_tol=1e-3)
    print(fit.find_stable_fit(pts))

