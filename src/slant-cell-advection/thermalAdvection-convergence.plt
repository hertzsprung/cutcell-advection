set term epslatex color size 6,4

set style data linespoints
set logscale
set format x "$10^{%L}$"
set format y "$10^{%L}$"

set key outside top center

set xlabel "$\\Delta x$"

set yrange [1e-8:1e-1]

set multiplot layout 1,2

### l2

set ylabel "$\\ell_2$ error"
plot "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-btf-linearUpwind-collated/18000/l2errorT.txt" using 1:2 title 'BTF linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-btf-cubicUpwind-collated/18000/l2errorT.txt" using 1:2 title 'BTF cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-slantedCell-linearUpwind-collated/18000/l2errorT.txt" using 1:2 title 'Slanted cell linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-slantedCell-cubicUpwind-collated/18000/l2errorT.txt" using 1:2 title 'Slanted cell cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-cutCell-linearUpwind-collated/18000/l2errorT.txt" using 1:2 title 'Cut cell linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-cutCell-cubicUpwind-collated/18000/l2errorT.txt" using 1:2 title 'Cut cell cubicUpwind', \
     x / 3e5 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 / 2.5e9 lc rgbcolor "black" dt 3 lw 3 title '2nd order', \
     x**4 / 1e16 lc rgbcolor "black" dt 3 lw 1 title '4th order'

### linf

set ylabel "$\\ell_\\infty$ error"
plot "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-btf-linearUpwind-collated/18000/linferrorT.txt" using 1:2 title 'BTF linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-btf-cubicUpwind-collated/18000/linferrorT.txt" using 1:2 title 'BTF cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-slantedCell-linearUpwind-collated/18000/linferrorT.txt" using 1:2 title 'Slanted cell linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-slantedCell-cubicUpwind-collated/18000/linferrorT.txt" using 1:2 title 'Slanted cell cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-cutCell-linearUpwind-collated/18000/linferrorT.txt" using 1:2 title 'Cut cell linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/steepThermalAdvection-cutCell-cubicUpwind-collated/18000/linferrorT.txt" using 1:2 title 'Cut cell cubicUpwind', \
     x / 5e4 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 / 3e8 lc rgbcolor "black" dt 3 lw 3 title '2nd order', \
     x**4 / 1e15 lc rgbcolor "black" dt 3 lw 1 title '4th order'
