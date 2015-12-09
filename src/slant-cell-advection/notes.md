Problem/Intro
=============
Cut cell grids result give rise to small cell problem
Various approaches to alleviate the problem including cell merging, thin walls and implicit techniques
What are the pros and cons of these techniques?

What are the potential advantages of our technique?
- Grid is straightfoward to construct
- Cells aligned in columns (potentially good for Dynamo and maybe others)
- No special numerics required (unlike Jebens and Steppeler)
- Advection scheme is less sensitive to thin cells (than what?)

Aim
===
Demonstrate a new method of dealing with the 'small cell problem'
- new grid generation method
- upwind-biased advection scheme

Grids
=====
Describe grid generation method
- move vertices below the surface up to the surface
- remove cells that zero volume
- remove zero area faces (where quads have been squashed into triangles)

Advection scheme
================
- multidimensional
- upwind-biased stencil
- least squares polynomial fit
- more points than coefficients (why?)
- not monotonic
- not flux-corrected
- weights are precomputed
- figure showing stencil, identifying two "exact" points either side of the face
- behaviour with reduced stencil sizes
- boundary treatment

Tests
=====
The small cell problem is about timestep constraints, so we need to demonstrate:
- that our grid is better than a traditional cut cell grid? (but presumably we don't want to generate 2D cut cell grids for OpenFOAM?)
- that our grid is comparable to some TF grid?
- that the upwind-biased advection scheme is better than other variants of the same scheme/other reasonable advection scheme(s)

Pure advection tests -- same as Shaw&Weller2015?
- push the timestep and see where accuracy drops off/results become unstable
- what is the maximum 2D Courant number?
- could we calculate 1D Courant numbers in the direction of flow?
- l2 error norms, min/max values?
- compare with a more standard advection scheme? linear upwind?
- compare variants of the advection scheme?
- different resolutions/mountain heights?
- same BTF velocity profile as usual?
- can we better explain why we get these stripey patterns of error through cut cells (as seen in figure 8 of TF/cut cell comparison article)
- order-of-accuracy tests? (just because we're documenting an advection scheme)

Other least squares fit publications
====================================
- lashley2002
- cueto2006
- cueto2007
- miura2007
- weller2009
- skamarock-menchaca2011
- skamarock-gassmann2011

Other cut cell publications
===========================
Cell merging:
  - clarke1986?
  - quirk1994?
  - yamazaki-satomura20[08/10/12]
  - yamazaki2015

Implicit methods:
  - jebens2011
  - leveque-shyue1996
  - murman2003
  - rosatti2005 (SISL method, fancy velocity reconstruction in cut cells)
  - thomas2000

Thin wall approximation:
  - steppeler2002
  - walko-avissar2008 (OLAM model, thin-wall style (?), found advection problems: oscillations in scalar and momentum fields near the surface, they increased upwind-bias in the lowest two model levels)

Redistribute conservation error:
  - pember1995

Rotated grid methods:
  - helzel2005

Dimensional splitting:
  - klein2009 (and well-balancing from botta2004)

Other papers that talk about cut cells:
  - lock2012 (don't address small cell problem)
  - good2014 (use model from lock2012)
  - jaehn2015 (ASAM model, linear-implicit Rosenbrock timestepping method for handling cut cells, similar to Jebens)
  - ingram2003: review of cut cell developments

Other techniques similar to cut cells:
  - bonaventura2000: partial step/piecewise slope, height coords
  - mesinger2012: slantwise transport, similar to bonaventura2000, but pressure coords
  - immersed boundary (gattibono-collela2006, helzel2005, simon2012)
  - boundary-fitted grids
  - Chimera methods (takemura2015)
