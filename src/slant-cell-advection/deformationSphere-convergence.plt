set term epslatex color size 6,4

set style data linespoints
set logscale
set format x "$10^{%L}$"
set format y "$10^{%L}$"

set key outside top center

set xlabel "$\\Delta \\lambda$"

set xrange [0.1:10] reverse
set yrange [1e-2:1]

set multiplot layout 1,2

### l2

set ylabel "$\\ell_2$ error"
plot "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 title 'hex linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 title 'hex cubicUpwind', \
     x / 3e5 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 / 2.5e9 lc rgbcolor "black" dt 3 lw 3 title '2nd order', \
     x**4 / 1e16 lc rgbcolor "black" dt 3 lw 1 title '4th order'

### linf

set ylabel "$\\ell_\\infty$ error"
plot "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-hex-collated/1.0368e+06/linferrorT.txt" using 1:2 title 'hex linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-hex-collated/1.0368e+06/linferrorT.txt" using 1:2 title 'hex cubicUpwind', \
     x / 5e4 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 / 3e8 lc rgbcolor "black" dt 3 lw 3 title '2nd order', \
     x**4 / 1e15 lc rgbcolor "black" dt 3 lw 1 title '4th order'
