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
from collections import Counter
from functools import total_ordering

x, y = symbols("x y")

@total_ordering
class FullRank:
    def __init__(self, B, threshold=1e-3):
        u,s,v = la.svd(B)
        self.min_singular_value = min(s)
        self.threshold = threshold

    def __bool__(self):
        return bool(self.min_singular_value > self.threshold)

    def __repr__(self):
        return "min_singular={s:.4g}".format(s=self.min_singular_value)

    def __eq__(self, other):
        if not self._is_valid_operand(other):
            return NotImplemented
        return self.min_singular_value == other.min_singular_value

    def __lt__(self, other):
        if not self._is_valid_operand(other):
            return NotImplemented
        return self.min_singular_value < other.min_singular_value

    def _is_valid_operand(self, other):
        return hasattr(other, "min_singular_value")

class UnfittableException(Exception):
    def __init__(self, msg):
        self.msg = msg

    def __str__(self):
        return repr(self.msg)

class Nomial:
    def __init__(self, func):
        self.func = func

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

class FullRankPolynomial:
    def __init__(self, terms, full_rank):
        self.terms = terms
        self.full_rank = full_rank

    def __iter__(self):
        for term in self.terms:
            yield term

    def __repr__(self):
        return "({terms}, {full_rank})".format(terms=self.terms, full_rank=self.full_rank)

    def __len__(self):
        return len(self.terms)

class StableFit:
    def __init__(self, pts, terms, upwind_weight, downwind_weight, coeffs):
        self.pts = pts
        self.terms = terms
        self.upwind_weight = upwind_weight
        self.downwind_weight = downwind_weight
        self.coeffs = coeffs

    def __repr__(self):
        return "({coeffs}, up_weight={upwind_weight}, down_weight={downwind_weight}, {terms})".format(coeffs=self.coeffs, upwind_weight=self.upwind_weight, downwind_weight=self.downwind_weight, terms=self.terms)

class PolynomialFit:
    const = Nomial(Lambda((x, y), 1.0))
    X = Nomial(Lambda((x, y), x))
    Y = Nomial(Lambda((x, y), y))
    XY = Nomial(Lambda((x, y), x*y))
    XX = Nomial(Lambda((x, y), x**2))
    YY = Nomial(Lambda((x, y), y**2))
    XXX = Nomial(Lambda((x, y), x**3))
    XXY = Nomial(Lambda((x, y), x**2*y))
    XYY = Nomial(Lambda((x, y), x*y**2))

    default_polynomial= [ \
        const, \
        X, \
        Y, \
        XY, \
        XX, \
        YY, \
        XXY, \
        XYY, \
        XXX, \
    ]

    default_combinations = [ \
        [const, X], \
        [const, Y], \
        [const, X, Y], \
        [const, X, XX], \
        [const, Y, YY], \
        [const, X, Y, XY], \
        [const, X, Y, XX], \
        [const, X, Y, YY], \
        [const, X, XX, XXX], \
        [const, X, Y, XY, XX], \
        [const, X, Y, XY, YY], \
        [const, X, Y, XX, XXX], \
        [const, X, Y, XY, XX, XXX], \
        [const, X, Y, XY, XX, YY], \
        [const, X, Y, XY, XX, XXY], \
        [const, X, Y, XY, YY, XYY], \
        [const, X, Y, XY, XX, YY,  XXY], \
        [const, X, Y, XY, XX, YY,  XYY], \
        [const, X, Y, XY, XX, YY,  XXX], \
        [const, X, Y, XY, XX, XXY, XXX], \
        [const, X, Y, XY, XX, YY,  XXY, XYY], \
        [const, X, Y, XY, XX, YY,  XXY, XXX], \
        [const, X, Y, XY, XX, YY,  XYY, XXX], \
        [const, X, Y, XY, XX, YY,  XXY, XYY, XXX], \
    ]

    def __init__(self, nomials = default_polynomial, full_rank_tol=1e-9):
        self.nomials = nomials
        self.full_rank_tol = full_rank_tol

    def stable_fit(self, pts, upwind_weight=1000, default_downwind_weight=1000):
        stable_polynomial = None
        target_length = min(len(pts), len(self.default_combinations))

        while not stable_polynomial and target_length > 0:
            all_candidates = [p for p in self.default_combinations if len(p) == target_length]
            full_rank_candidates = self.retain_full_rank(pts, all_candidates)
            stabilisable_candidates = self.retain_positive_central_coefficients(pts, full_rank_candidates)
            stable_polynomials = self.retain_stable(pts, stabilisable_candidates)
            if len(stable_polynomials) > 0:
                stable_polynomial = stable_polynomials[-1]

            target_length -= 1
            
        if target_length == 0 and not stable_polynomial:
            raise UnfittableException("Cannot find stable polynomial")

        return stable_polynomial

    def retain_full_rank(self, pts, candidates):
        polynomial = []

        full_rank_candidates = []
        for candidate_polynomial in candidates:
            B = self.matrix(pts, candidate_polynomial)
            full_rank = FullRank(B, self.full_rank_tol)
            if full_rank:
                logging.debug("Candidate %s is full rank", candidate_polynomial)
                full_rank_candidates.append(FullRankPolynomial(candidate_polynomial, full_rank))
            else:
                logging.debug("%s is rank-deficient with min_singular_value=%s", candidate_polynomial, full_rank.min_singular_value)

        return full_rank_candidates

    def retain_positive_central_coefficients(self, pts, full_rank_candidates):
        candidates = []

        for candidate in full_rank_candidates:
            B = self.matrix(pts, candidate)
            Binv = la.pinv(B)
            coefficients = Binv[0]
            if self.central_are_positive(coefficients):
                logging.debug("Found stabilisable fit %s with unweighted coefficients %s", candidate, coefficients)
                candidates.append(candidate)
            else:
                logging.debug("Unstabilisable fit %s with unweighted coefficients %s", candidate, coefficients)

        return candidates

    def retain_stable(self, pts, stabilisable_candidates, upwind_weight=1000, default_downwind_weight=1000):
        candidates = []
    
        for candidate in stabilisable_candidates:
            stable = False
            downwind_weight = default_downwind_weight
            while not stable and downwind_weight > 0:
                B = self.matrix(pts, candidate)
                B[0] = B[0] * upwind_weight
                B[1] = B[1] * downwind_weight
                Binv = la.pinv(B)
                Binv[0][0] = Binv[0][0] * upwind_weight
                Binv[0][1] = Binv[0][1] * downwind_weight
                coeffs = Binv[0]
                if self.stable(coeffs):
                    candidates.append(StableFit(pts, candidate, upwind_weight, downwind_weight, coeffs))
                    stable = True
                downwind_weight -= 1

        candidates.sort(key=lambda x: (len(x.terms), x.terms.full_rank))
        logging.debug(np.array(candidates))

        return candidates

    def central_are_positive(self, coefficients):
        return coefficients[0] > 0 and coefficients[1] > -1e-14

    def stable(self, coefficients):
        upwind = coefficients[0]
        downwind = coefficients[1]
        
        return abs(downwind) < upwind and downwind <= 0.5

    def matrix(self, pts, polynomial):
        return np.array([[n(x, y) for n in polynomial] for (x, y) in pts], dtype=float)

