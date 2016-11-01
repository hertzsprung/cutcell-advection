Justify our choices:
- finite volume method
- arbitrary meshes
- multidimensional?
  - moot?  if the mesh is arbitrary then I fail to see how dimension splitting could work
  - nevertheless, multidimensional schemes avoid splitting errors
- Eulerian
  - when so many NWP models use [flux form] semi-Lagragian

What advection schemes are we competing with?
- ones that are cheap to compute
- ones that have good treatment at the boundary
- second-order

What order are transport schemes that are in operational use?

citations
=========


why are multidimensional advection schemes desirable?
-----------------------------------------------------
Find examples of dimensional splitting errors

- leonard1993
- chen2016 and refs therein?
- thuburn1996?
- thuburn1997?



what advection schemes are there for arbitrary meshes?
------------------------------------------------------
Particularly for atmospheric models, or other CFD

- lashley2002
- olliviergooch-vanaltena2002?
- cueto2006?
- cueto2007?
- moraes2013?

what advections schemes are there for non-quad/non-uniform meshes?
------------------------------------------------------------------

- miura2007
- skamarock-menchaca2010
- gassmann2013?

what advection schemes have used least squares polynomial fits?
---------------------------------------------------------------

- lashley2002
- cueto2006?
- cueto2007?
- mavriplis2003?
- ye1999?

who else is doing stuff with non-quad/non-uniform meshes?
---------------------------------------------------------
How do they do advection?

- gassmann2013
- thuburn2014
- walko-avissar2011
- smolarkiewicz-szmelter2011
- szmelter2015
- pain2005?
- MPAS?

lashley2002
-----------

- multidimensional advection scheme for unstructured grids
- conservation and shape preservation (monotonicity) are desired
- conservation is easy in FV, shape preservation can be achieved with a flux limiter
- nonoscillatory Lax--Wendroff schemes include: (smolarkiewicz2006)
  - FCT apply antidiffusive fluxes to correct a first-order, shape-preserving scheme
  - TVD is similar to, but not the same as, shape preservation
  - ENO are weaker than shape preservation: they ensure spurious oscillations reduce with increasing resolution
- dimensional splitting can distort tracer when flow is misaligned with the mesh (thuburn1996)
- the scheme is centred, or slightly upwind-biased, depending on the even/oddness of the polynomial (p. 15)
- chapter 2: lots of recomputation needed when the flow varies in time -- eep!
- chapter 3: polynomial fitting for arbitrary meshes, uses SVD
- polynomial integral within a cell must equal the cell's volume average -- swept regions

