Problem
=======
Cut cell grids result give rise to small cell problem
Various approaches to alleviate the problem
- Jebens semi-implicit
- Steppeler thin walls
- Yamazaki&Satomura cell merging

What are the potential advantages of our technique?
- Cells aligned in columns (good for Dynamo and maybe others)
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

Advection scheme
================
Describe advection scheme

Tests
=====
Pure advection tests -- same as Shaw&Weller2015?
- compare with a more standard advection scheme? linear upwind?
- compare variants of the advection scheme?
- order-of-accuracy tests?

I don't think we should call these grids "cut cell grids" because they are not like grids created by cell shaving.  How about "slanting cell grid"?
