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
import itertools

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

class StabilisedFit:
    def __init__(self, pts, terms, upwind_weight, downwind_weight, coeffs):
        self.pts = pts
        self.terms = terms
        self.upwind_weight = upwind_weight
        self.downwind_weight = downwind_weight
        self.coeffs = coeffs

    def __repr__(self):
        return "StabilisedFit({coeffs}, upwind_weight={upwind_weight}, downwind_weight={downwind_weight}, terms={terms})".format(coeffs=self.coeffs, upwind_weight=self.upwind_weight, downwind_weight=self.downwind_weight, terms=self.terms)

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

    def best_candidate(self, pts):
        terms = self.subset_that_fits(pts)
        stabilisable = self.find_stabilisable(pts, terms)

        if not stabilisable:
            raise UnfittableException("Cannot find combination of candidate terms which are stabilisable")

        return list(stabilisable)

    def find_stabilisable(self, pts, terms):
        for termCount in reversed(range(1,len(terms)+1)):
            combinations = itertools.combinations(terms, termCount)
            for c in combinations:
                B = self.matrix(pts, c)
                Binv = la.pinv(B)
                coeffs = Binv[0]
                if self.central_are_largest(coeffs):
                    logging.debug("Found stabilisable fit %s with unweighted coefficients %s", c, coeffs)
                    return c

        return None


    def stable_fit(self, pts, upwind_weight=5, downwind_weight=5):
        terms = self.best_candidate(pts)

        while downwind_weight > 2:
            downwind_weight -= 1
            B = self.matrix(pts, terms)
            B[0] = B[0] * upwind_weight
            B[1] = B[1] * downwind_weight
            Binv = la.pinv(B)
            Binv[0][0] = Binv[0][0] * upwind_weight
            Binv[0][1] = Binv[0][1] * downwind_weight
            coeffs = Binv[0]
            if self.stable(coeffs):
                return StabilisedFit(pts, terms, upwind_weight, downwind_weight, coeffs)

        raise UnfittableException("Cannot stabilise %s".format(terms))

    def stable(self, coefficients):
        upwind = coefficients[0]
        downwind = coefficients[1]
        return abs(downwind) < upwind and upwind <= 1 + downwind and upwind >= 0.5 and self.central_are_largest(coefficients)

    def central_are_largest(self, coefficients):
        smallest_central_coefficient = min(coefficients[:2])
        large_peripheral_coefficients = [c for c in coefficients[2:] if c > smallest_central_coefficient]
        return len(large_peripheral_coefficients) == 0

    def full_rank(self, B):
        u,s,v = la.svd(B)
        return la.matrix_rank(B, self.full_rank_tol) == B.shape[1]

    def matrix(self, pts, polynomial):
        return np.array([[n(x, y) for n in polynomial] for (x, y) in pts], dtype=float)

