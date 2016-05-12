**need to read gattibono-collela2006** (cited by klein2009)

Problem/Intro
=============
We want to present two pieces of work: the cubicUpwindCPCFit advection scheme and the slanted cell mesh.  What problems do each of these pieces of work address?

cubicUpwindCPCFit
-----------------
- using a multidimensional scheme avoids splitting errors (present evidence that splitting errors cause problems in atmospheric models)
- the scheme is computationally cheap (compared to what?)
- accurate on arbitrary meshes: insensitive to choice of terrain representation
- why is an Eulerian scheme desirable?  because it straightfowardly conserves the dependent variable?  or is this 

slanted cell mesh
-----------------
- we hope to reduce pressure gradient errors while avoiding the small cell problem associated with the cut cell method (there are already several ways of doing this, what advantages can we offer?)
- compared to cut cell meshes, slanted cell meshes are more straightfoward to construct
- apart from the cut cell method, no other type of hybrid structured/unstructured mesh has been tried in an atmospheric model before


detailed intro
--------------

- Higher spatial resolutions resolve small-scale, steep slopes in terrain
- Such steep slopes increase numerical errors associated with advection and pressure gradient calculations when TF coordinates are used, due to cancellation errors in metric terms or, equivalently, large non-orthogonality of TF meshes in Cartesian coordinates
- A hydrostatic reference profile is often subtracted to mitigate these errors [klemp-wilhelmson1978, tomita-satoh2004], but this helps less with global domains [walko-avissar2008b, jebens2011]
- Cut cell meshes reduce numerical errors because such meshes are orthogonal everywhere except in the lowest layer of cells
- However, without special treatment, the cut cell method can create very small cells which constrain the timestep for explicit methods: almgren1997 says, "A standard finite-volume approach using conservative differencing requires division by the volume of each cell; this is unstable unless the time step is reduced proportionally to the volume."
- Various approaches to alleviate the problem including cell merging, thin walls and implicit techniques
- TODO: what are the pros and cons of these techniques?

What are the potential advantages of our slanted cell mesh technique?
- Mesh is straightforward to construct
- Cells are long in the direction of flow (kirkpatrick2003 section 2.3.4 has a nice sentence on this w.r.t. CFL criterion, adcroft1997 also mentions this on p. 2313)
- Cells aligned in columns (potentially good for Dynamo and maybe others)
- No special numerics required (unlike Jebens and Steppeler)

Limitations of scope
====================
- it is difficult to maintain high vertical resolution about the ground at any surface elevation [y&s2010] which can be computationally expensive [walko-avissar2008b]; we are not going to address this issue here
- some papers [find refs] say that it is too computationally expensive to use/difficult to parallelise arbitrarily structured meshes -- OpenFOAM seems to do a pretty good job, but we're not concerned with computational efficiency here

Aim
===
Demonstrate a new method of dealing with the 'small cell problem'
- new mesh generation method
- upwind-biased advection scheme

Mesh
====
Describe mesh generation method (or just cite Shaw & Weller 2016?)
- justify choice of 'snap' tolerance (how close does a point have to be for it to be snapped to the surface?)
  - it might be nice to justify this using some real orography, maybe even 3D orography (to demonstrate that our technique extends to 3D)

Advection scheme
================
- multidimensional
- upwind-biased stencil
- least squares polynomial fit
- typically more points than coefficients
- not monotonic
- not flux-corrected
- weights are precomputed
- figure showing stencil
- stability treatment
  - behaviour with reduced stencil sizes
  - incremental upwinding

- ASIDE: Hilary's talked about oscillations in the solution being damped by heavier weighting on constant and the linear term in x (but we're no longer using these heavy weights and it still seems to work fine)
  - https://en.wikipedia.org/wiki/Runge%27s_phenomenon
  - https://en.wikipedia.org/wiki/Multivariate_interpolation#Irregular_grid_.28scattered_data.29
  - how smooth are our polynomials?  how to measure this?  curvature?

Tests
=====
The small cell problem is about timestep constraints, so we need to demonstrate:
- that our mesh is better than a traditional cut cell mesh w.r.t. Courant numbers
- that our mesh is comparable to some TF mesh (e.g. BTF)
- that accuracy on our mesh is better than cut cell meshes, and comparable to TF (ideally!)
- that the upwind-biased advection scheme is better than other variants of the same scheme/other reasonable advection scheme(s)?

Pure advection tests -- similar setup to the thermal advection tests from Shaw & Weller 2016
- run at Co close to 1 and report timesteps
- l2 error norms, min/max values?
- compare with a more standard advection scheme? linear upwind (2nd order)?
- compare variants of the advection scheme?
- different resolutions/mountain heights? (we want steep slopes)
- same BTF velocity profile as usual?
- can we better explain why we get these stripey patterns of error through cut/slanted cells? (as seen in figure 8 of TF/cut cell comparison article)


Resting atmosphere test?
- one of the often-cited advantages of cut cells over TF meshes are more accurate pressure gradients.  Hence, it would be nice to show that we have smaller KE errors with the slantedCell mesh versus cutCell or TF meshes.

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
  - hirt1992?
  - quirk1994?
  - ye1999
  - yamazaki-satomura20[08/10/12]
  - yamazaki2016

Implicit/semi-Lagrangian methods:
  - jebens2011
  - leveque-shyue1996 (not atmospheric, cut cells used to resolve shock fronts)
  - murman2003 (for moving boundaries)
  - thomas2000
  - rosatti2005 (SISL method, fancy velocity reconstruction in cut cells)
  - bonaventura2000 (SISL method with partial-step cell volumes and thin-wall approximation for pressure equation)

Thin wall approximation:
  - steppeler2002
  - walko-avissar2008b (OLAM model, thin-wall style (?), found advection problems: oscillations in scalar and momentum fields near the surface, they increased upwind-bias in the lowest two model levels)

Redistribute conservation error:
  - pember1995

Flux redistribution

Rotated mesh methods:
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
  - boundary-fitted meshes
  - Chimera methods (takemura2015)
