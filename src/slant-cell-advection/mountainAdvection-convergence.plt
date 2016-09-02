set term epslatex color size 6,4

set style data linespoints
set logscale
set format x "$10^{%L}$"
set format y "$10^{%L}$"

set key outside top center

set xlabel "$\\Delta x$"

set xrange [1e2:1e4]
set yrange [1e-3:1]

set multiplot layout 1,2

### l2

set ylabel "$\\ell_2$ error"
plot "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-linearUpwind-collated/10000/l2errorT.txt" using 1:2 lc 1 dt 3 lw 2 title 'btf linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-cubicUpwind-collated/10000/l2errorT.txt" using 1:2 lc 1 title 'btf cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-linearUpwind-collated/10000/l2errorT.txt" using 1:2 lc 2 dt 3 lw 2 title 'slantedCell linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-cubicUpwind-collated/10000/l2errorT.txt" using 1:2 lc 2 title 'slantedCell cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-cutCell-linearUpwind-collated/10000/l2errorT.txt" using 1:2 lc 3 dt 3 lw 2 title 'cutCell linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-cutCell-cubicUpwind-collated/10000/l2errorT.txt" using 1:2 lc 3 title 'cutCell cubicUpwind', \
     x * 1e-4 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 * 1e-8 lc rgbcolor "black" dt 3 lw 3 title '2nd order'

### linf

set ylabel "$\\ell_\\infty$ error"
plot "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-linearUpwind-collated/10000/linferrorT.txt" using 1:2 lc 1 dt 3 lw 2 title 'btf linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-cubicUpwind-collated/10000/linferrorT.txt" using 1:2 lc 1 title 'btf cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-linearUpwind-collated/10000/linferrorT.txt" using 1:2 lc 2 dt 3 lw 2 title 'slantedCell linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-cubicUpwind-collated/10000/linferrorT.txt" using 1:2 lc 2 title 'slantedCell cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-cutCell-linearUpwind-collated/10000/linferrorT.txt" using 1:2 lc 3 dt 3 lw 2 title 'cutCell linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-cutCell-cubicUpwind-collated/10000/linferrorT.txt" using 1:2 lc 3 title 'cutCell cubicUpwind', \
     x * 1e-4 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 * 1e-8 lc rgbcolor "black" dt 3 lw 3 title '2nd order'
