from polynomial import Nomial, PolynomialFit, x, y
import numpy as np
from sympy import Lambda, symbols
import logging

logging.basicConfig(level=logging.DEBUG)
np.set_printoptions(precision=4, linewidth=120, suppress=True)

def fit(pts):
    return PolynomialFit(full_rank_tol=1e-3).subset_that_fits(pts)

def test_too_close_for_x_squared():
    pts = [(0, 0), (1, 0), (0, 3), (0, 5) , (1.000001, 0)]
    expected = [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), y**2), 2) \
    ]
    assert fit(pts) == expected

def test_two_points_in_x():
    pts = [(0, 0), (1, 0.0001)]
    expected = [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
    ]
    assert fit(pts) == expected

def test_two_points_in_y():
    pts = [(0, 0), (0.00001, 3)]
    expected = [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), y), 1), \
    ]
    assert fit(pts) == expected

def test_twelve_points_in_two_rows():
    pts = [(0, 0), (1, 0), (2, 0), (3, 0), \
            (0, 1), (1, 1), (2, 1), (3, 1), \
            (0, 1), (1, 1), (2, 1), (3, 1)]
    expected= [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), x**2), 2), \
        Nomial(Lambda((x, y), x*y), 2), \
        Nomial(Lambda((x, y), x**3), 3), \
        Nomial(Lambda((x, y), x**2*y), 3), \
    ]
    assert fit(pts) == expected

def test_twelve_points_large_aspect_ratio():
    pts = [(0, 0), (1e6, 0), (2e6, 0), (3e6, 0), \
                (0, 1), (1e6, 1), (2e6, 1), (3e6, 1), \
                (0, 1), (1e6, 2), (2e6, 2), (3e6, 2)]
    assert fit(pts) == PolynomialFit.default_polynomial


def test_twelve_points_in_two_close_rows():
    pts = [(0, 0), (1, 0), (2, 0), (3, 0), \
            (0, 1), (1, 1), (2, 1), (3, 1), \
            (0, 1.00001), (1, 1.00001), (2, 1.00001), (3, 1.00001)]
    expected= [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), x**2), 2), \
        Nomial(Lambda((x, y), x*y), 2), \
        Nomial(Lambda((x, y), x**3), 3), \
        Nomial(Lambda((x, y), x**2*y), 3), \
    ]
    assert fit(pts) == expected

def test_nine_points():
    pts = [(0, 0), (1, 0), (2, 0), \
            (0, 1), (1, 1), (2, 1), \
            (0, 2), (1, 2), (2, 2)]
    expected= [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), x**2), 2), \
        Nomial(Lambda((x, y), x*y), 2), \
        Nomial(Lambda((x, y), y**2), 2), \
        Nomial(Lambda((x, y), x**2*y), 3), \
        Nomial(Lambda((x, y), x*y**2), 3), \
    ]
    assert fit(pts) == expected

def test_nine_points2():
    pts = [(0, 0), (4, 1), (8, 3), \
            (0, 2), (4, 3), (8, 5), \
            (0, 4), (4, 5), (8, 7)]
    expected= [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), x**2), 2), \
        Nomial(Lambda((x, y), x*y), 2), \
        Nomial(Lambda((x, y), y**2), 2), \
        Nomial(Lambda((x, y), x**2*y), 3), \
        Nomial(Lambda((x, y), x*y**2), 3), \
    ]
    assert fit(pts) == expected

def test_four_points():
    pts = [(0, 0), (1, 0), \
            (0, 1), (1, 1)]
    expected= [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), x*y), 2), \
    ]
    assert fit(pts) == expected

def test_three_points_in_diagonal_line():
    pts = [(1, 3), (3, 5), (7, 9)]
    expected = [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), x**2), 2), \
    ]
    assert fit(pts) == expected
