from polynomial import Nomial, PolynomialFit, x, y
import numpy.linalg as la
from sympy import Lambda, symbols
import numpy as np

np.set_printoptions(precision=4, linewidth=120, suppress=True)

def stable_fit(pts):
    return PolynomialFit(full_rank_tol=1e-3).stable_fit(pts)

def test_six_points_with_diagonal():
    pts = [(-1, 0.0330314), (0.907926, -2.64e-14), (-1.13441, 3.05716), (-0.87524, -2.99221), (0.907926, 3.02642), (0.907926, -3.02642)]

    expected = [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), x*y), 2), \
        Nomial(Lambda((x, y), y**2), 2) \
    ]
    assert stable_fit(pts).terms == expected

def test_nine_points_with_diagonal():
    pts = [ \
        (-1, 1.36424e-16), \
        (1, 5.80712e-14), \
        (1, 3.33333), \
        (1, -3.33333), \
        (-1, 3.33333), \
        (-1, -3.33333), \
        (-3.12554, 3.35946), \
        (-3.02091, 0.0282014), \
        (-2.91995, -3.30361) \
    ]

    expected = [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), x**2), 2), \
        Nomial(Lambda((x, y), x*y), 2), \
        Nomial(Lambda((x, y), y**2), 2), \
        Nomial(Lambda((x, y), x**2*y), 3), \
        Nomial(Lambda((x, y), x*y**2), 3) \
    ]

    assert stable_fit(pts).terms == expected
    
