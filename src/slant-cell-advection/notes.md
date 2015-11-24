Problem/Intro
=============
Cut cell grids result give rise to small cell problem
Various approaches to alleviate the problem
- Jebens semi-implicit
- Steppeler thin walls
- Yamazaki&Satomura cell merging
What are the pros and cons of these techniques?

What are the potential advantages of our technique?
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
Describe advection scheme

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
- compare with a more standard advection scheme? linear upwind?
- compare variants of the advection scheme?
- different resolutions/mountain heights?
- same BTF velocity profile as usual?
- can we better explain why we get these stripey patterns of error through cut cells (as seen in figure 8 of TF/cut cell comparison article)
- order-of-accuracy tests? (just because we're documenting an advection scheme)

I don't think we should call these grids "cut cell grids" because they are not like grids created by cell shaving.  How about "slanting cell grid"?
