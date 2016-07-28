questions
---------
- why is multidimensional better than dimensional splitting?
- what types of multidimensional advection schemes exist and what are their drawbacks?
- there are fancier dimensionally split schemes that likely perform better.  what do these papers say about multidimensional schemes and splitting errors?

list of multidimensional schemes for arbitrary meshes
-----------------------------------------------------
- lashley2002
- smolarkiewicz-szmelter2005

answers
-------

- leonard1993 has a great introduction about distortions introduced by dimensional splitting and presents comparisons between schemes as evidence
- lashley2002's multidimensional scheme requires recomputation when the wind field changes (TODO: double-check this is true for the 2D arbitrary mesh variant)
- bott2010 developed a dimensionally split scheme
- smolarkiewicz2006: MPDATA is multidimensional and suitable for arbitrary meshes
- 

TODO
----
- check leonard1993's multidimensional formulation, lashley2002 says it uses a 2D polynomial for interpolation, and is presumably a swept region scheme as lashley2002's is
- understand correct terminology: what is "volume of fluid method", "swept region" (lashley2002) /"swept area", "control volume algorithm" (leonard1993)
- ditto for "dimensional splitting", "time splitting" and "operator splitting"

asides
------

- volume of fluid method seems to be for advecting fluid interfaces, slightly different?  e.g. 
