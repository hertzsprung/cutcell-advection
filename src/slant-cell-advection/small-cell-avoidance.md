specifically, I'm looking at other methods of alleviating the small cell problem, their merits and drawbacks

- combine cells
  - ye1999 combine vertically based on position of cell centre being above/below ground
  - yamazaki-satomura2008 (vertically), yamazaki-satomura2010 (verticall or horizontally) based on cell size
  - timestep constrained by smallest remaining cell which, for y&s, is half the size of an uncut cell
  - it is no longer possible to separate horizontal/vertical gradient calculations [walko-avissar2008]
  - velocity points may not have pressure points on both sides [kirkpatrick2003]
- thin-wall approximation
  - bonaventura uses vertical thin walls for modelling slanted terrain in the discretisation of the pressure equation, but I don't *think* this alleviates the small cell problem?
  - steppeler2002 use vertical and horizontal thin walls
- implicit/semi-implicit techniques
  - jebens2011
  - TODO: leveque-shyue1996
  - TODO: murman2003

yamazaki-satomura2008
---------------------

- combine cells vertically (only)
- cells with area < dx\*dz/2 are combined, hence timesteps are at worst halved by this approach
- mention thin-wall approximation [bonaventura2000, steppeler2002] but don't say why their alternative might have advantages over this approximation
- finite volume, quasi-flux form
- comparison is made with a BTF model (satomura1989), and results are as good or better

yamazaki-satomura2010
---------------------

- model codenamed "sayaca-2D"
- combine cells vertically or horizontally, depending on slope angle and grid aspect ratio
- horizontal combination useful for very steep slopes
- suggests that there is some difference between cut cells and shaved cells, but that they are 'very similar'
- thin-wall approximation has issues: see [lock2008, walko-avissar2008b]
- talk about "internal inconsistency", **but what is meant by this?**
- they say that having cell centres at centroids is too hard/expensive -- not so with OpenFOAM
- talk about problems with OLAM, but I don't understand the description
- they use "category 5" variable staggering which thuburn-woolings2005 say has many computational modes, although these are not revealed in tests presented here
- difficult to use cut cells with high vertical resolution near the ground over a range of terrain elevations [walko-avissar2008b]

yamazaki-satomura2012
---------------------

- local mesh refinement for high vertical resolution near the ground
- uses Building-Cube Method with sub-timestepping for small cells
- non-conforming mesh with hanging nodes

yamazaki2015 (preprint)
-----------------------

- extension of yamazaki-satomura2012 into 3D
- cell merging procedure need terrain to be well-resolved to avoid very small cells

kirkpatrick2003
---------------

- cell linking addresses issue where a velocity point does not have pressure values on both sides
- full Navier-Stokes (with viscosity)
- 2nd order centred differencing, but uses third-order QUICK for advection, with tweaks to handle the non-uniform grid spacing at boundaries
- criticise ye1999 for using a Wannier flow test which has no advection **TODO: check this**
- says it is difficult to extend cell merging techniques into 3D **but yamazaki2016 manages it**
- face area and centroids are adjusted

klein2009
---------

- **no additional CFL constraints**
- 2D fully-compressible flows
- flux stabilisation
- dimensional splitting -- **does it suffer from splitting errors I wonder?**
- first-order accurate near boundaries

gattibono-collela2006
---------------------

- do not really address the small cell problem
- they run with timesteps small enough for acoustic waves
- but say they could use timesteps for advective Courant number if they treated acoustics implicitly
- even then, they admit that their divergence operator will not be suitable for explicit schemes (p. 609)

leveque-shyue1996
-----------------

- have smaller "cut" cells to better resolve shock fronts

almgren1997
-----------

- volume-of-fluid approach
- advection treats boundary with shock tracking, several correction steps are necessary
- **no additional CFL constraints whatsoever!**
- says cell merging is only 1st order at boundary 
- says that losing 2nd order accuracy at boundary should not be a problem for atmospheric flows over orography -- **do we think this is (still) true?**
- lots of citations about other grid types


lock2008 (phd thesis)
---------------------

- follows steppeler2002 in her treatment of small cells
- uses CTCS schemes

walko-avissar2008 (OLAM)
------------------------

- OLAM uses a prismatic mesh with cut cells
- high vertical resolution near ground is expensive with cut cells
- cut cells require special treatment: cell volume (Psi) and face areas (sigma) are set to represent the portion of the cell above ground
- sigma/Psi ratio imposes additional timestep constraints
- hirt1992, steppeler2002, bonaventura2000 address this constraint by increasing cell volume without changing face area
- use example of horizontal thermal advection through long, thin cells to show why this technique can be bad
- the authors intend to use flux balancing following calhoun-leveque2000, although **"we resorted to slightly raising topography to submerge the smallest control volumes and to reducing the time step where necessary to avoid instability"** (it seems that they chose to use a different flux corrected transport, see [walko-avissar2011]
- **weak oscillations in advection schemes removed by increasing upwind bias in the lowest two levels**
- cell centres are not moved: they can be below ground
  - allows horizontal/vertical gradients to be calculated separately
- for scalar transport, flux form is straightforward and ensures conservation
- less straightforward for momentum transport on a C grid, detailed explanation provided on pp. 4054--4055
- **on p. 4053 they say they don't want to use calhoun-leveque2000 because that would prevent calculating horizontal/vertical pressure gradients separately.  but then on p. 4055 they say they'd like to use calhoun-leveque2000's flux balancing method.  so, are these two separate techniques?**


calhoun-leveque2000
-------------------

- explicit schemes, **no additional CFL constraints whatsoever**
- cell centres are moved
- advection-diffusion equation
- **talks about capacity functions, but appears to be the same/similar to the thin wall approximationof steppeler2002?**
- **and again, talks about "slightly enlarging the cell's capacity" -- same as thin wall approximation**
- **sounds plausible because yamazaki-satomura2010 say it suffers from the same internal inconsistency**
- includes the same diagram as walko-avissar2008b of horizontal flow next to the lower boundary


ye1999
------

- viscous, incompressible flows
- horizontally/vertically combine cells where cell centres lie below ground, taken from [udaykumar1997, udaykumar1999]
- centred spatial scheme, FVM, use compact polynomial interpolation to preserve 2nd order at boundaries -- **very similar to what we do in cubicUpwindCPCFit**
- boundary values are computed by decomposing dphi/dn into d/dx and d/dy components and using more polynomial fits, resulting in a weighted sum of surrounding known phi values
- 2nd order globally and locally, improvement over leveque-li1994
- use explicit Adams-Bashforth timestepping for advection, implicit C--N for diffusion
- **do they discuss any timestep constraints? -- I don't see any**

steppeler2002
-------------

- use thin-wall approximation with both vertical **and horizontal** walls, unlike [bonaventura2000] -- this seems to be necessary, for example, to represent no-flow beneath the ground
- this leaves cell volumes unaltered
- **nothing is said about potential problems with the thin-wall approach**
- transport, except for mass, is in advective form

hirt1992
--------

inter-library loan requested

bonaventura2000
---------------

- uses semi-Lagrangian advection to avoid timestep constraint
- partial-step orography with slants accounted for in pressure equation discretisation using vertical thin walls
- **I don't think this approximation alone will alleviate the small cell problem because the cell volume can be arbitrarily small with the partial step approach**
- they identify a "bottom cell" in each column, beneath which there is no air
- **authors say it has nothing in common with Mesinger's step-mountain coord** -- but Mesinger has a height-based coordinate and he also has slant-wise transport [mesinger2012] so I'd say this statement is no longer true

adcroft1997
-----------

- adjust topography to avoid very small cells

thomas2000
----------

- semi-implicit discretization

berger-leveque1990
------------------

- fluxes must be defined using more than just neighbouring cells -- **this sounds like what walko-avissar2008b describe w.r.t. [calhoun-leveque2000]**

jebens2011
----------

- implicit advection and diffusion in cut cells, explicit elsewhere
- third-order advection scheme
- **but first-order upwinding in the implicit advection I think?  this paper is too mathematical for me**
