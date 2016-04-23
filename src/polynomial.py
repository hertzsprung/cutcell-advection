#!/usr/bin/env python3
from numpy.linalg import pinv
import scipy.linalg
import numpy.linalg as la
from numpy import multiply
from numpy import dot
from numpy import diag
from math import exp
import numpy as np
import sys
import operator
from sympy import *
import logging

x, y = symbols("x y")

class UnfittableException(Exception):
    def __init__(self, msg):
        self.msg = msg

    def __str__(self):
        return repr(self.msg)

class Nomial:
    def __init__(self, func, degree):
        self.func = func
        self.degree = degree

    def __call__(self, *pargs, **kargs):
        return self.func(*pargs, **kargs)

    def __str__(self):
        return str(self.func.expr)

    def __repr__(self):
        return self.__str__()

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def __ne__(self, other):
        return not self.__eq__(other)

class PolynomialFit:
    default_polynomial= [ \
        Nomial(Lambda((x, y), 1.0), 0), \
        Nomial(Lambda((x, y), x), 1), \
        Nomial(Lambda((x, y), y), 1), \
        Nomial(Lambda((x, y), x**2), 2), \
        Nomial(Lambda((x, y), x*y), 2), \
        Nomial(Lambda((x, y), y**2), 2), \
        Nomial(Lambda((x, y), x**3), 3), \
        Nomial(Lambda((x, y), x**2*y), 3), \
        Nomial(Lambda((x, y), x*y**2), 3), \
    ]

    def __init__(self, nomials = default_polynomial, full_rank_tol=None):
        self.nomials = nomials
        self.full_rank_tol = full_rank_tol

    def subset_that_fits(self, pts):
        polynomial = []
        target_length = max(len(self.nomials), len(pts))

        for nomial in self.nomials:
            candidate_polynomial = list(polynomial)
            candidate_polynomial.append(nomial)

            logging.debug("Candidate %s", candidate_polynomial)

            B = self.matrix(pts, candidate_polynomial)
            if self.full_rank(B):
                polynomial = candidate_polynomial
            else:
                logging.debug("Discarding %s because the matrix would become rank-deficient", nomial)

            if B.shape[1] == target_length:
                logging.debug("Best polynomial is %s", polynomial)
                return polynomial

        logging.debug("Best polynomial is %s", polynomial)
        return polynomial

    def full_rank(self, B):
        u,s,v = la.svd(B)
        return la.matrix_rank(B, self.full_rank_tol) == B.shape[1]

    def matrix(self, pts, polynomial):
        return np.array([[n(x, y) for n in polynomial] for (x, y) in pts], dtype=float)

