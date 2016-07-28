why is linearUpwind doing better than cubicUpwindCPCFit on slantedCell meshes?

let's look at 192x80 mesh and compare error fields
is there something happening when running in parallel? --> nope, same result

linearUpwind:
dx = surface vector from cell to face
sfCorr = dx . grad(phi) where grad(phi) is assumed linear between the two cells sharing the face

this is a correction on upwind, so `phi_f = (1 + sfCorr) * phi_u`

how does this work? 

dx=0.5
grad(phi)=(3-1)/1=2
dx*grad(phi)=1
1+1=2=correct!

1     3
   |
