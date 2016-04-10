yamazaki-satomura2008
---------------------

- combine cells vertically (only)
- cells with area < dx\*dz/2 are combined, hence timesteps are at worst halved by this approach
- mention thin-wall approximation (bonaventura2000,steppeler2002) but don't way why their alternative might have advantages over this approximation
- finite volume, quasi-flux form
- comparison is made with a BTF model (satomura1989), and results are as good or better

yamazaki-satomura2010
---------------------

- model codenamed "sayaca-2D"
- combine cells vertically or horizontally, depending on slope angle and grid aspect ratio
- horizontal combination useful for very steep slopes
- suggests that there is some difference between cut cells and shaved cells, but that they are 'very similar'
- thin-wall approximation has issues: see lock2008 and walko-avissar2008
- talk about "internal inconsistency", but what is meant by this?
- they say that having cell centres at centroids is too hard/expensive -- not so with OpenFOAM
- talk about problems with OLAM, but I don't understand the description
- they use "category 5" variable staggering which thuburn-woolings2005 say has many computational modes, although these are not revealed in tests presented here
- difficult to use cut cells with high vertical resolution near the ground over a range of terrain elevations

yamazaki-satomura2012
---------------------



lock2008
--------

walko-avissar2008
-----------------

calhoun-leveque2000
-------------------

ye1999
------

