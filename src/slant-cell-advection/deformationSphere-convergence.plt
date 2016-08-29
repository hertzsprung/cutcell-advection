set term epslatex color size 6,4

set style data linespoints
set logscale
set format x "$10^{%L}$"
set format y "$10^{%L}$"

set key outside top center

set xlabel "$\\Delta \\lambda$"

set xrange [10:0.25]
set yrange [1e-2:1]

set multiplot layout 1,2

### l2

set ylabel "$\\ell_2$ error"
plot "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 1 dt 2 title 'hex linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 1 title 'hex cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-tri-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 2 dt 2 title 'tri linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-tri-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 2 title 'tri cubicUpwind', \
     x * 1e-1 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 * 1e-1 lc rgbcolor "black" dt 3 lw 3 title '2nd order'

### linf

set ylabel "$\\ell_\\infty$ error"
plot "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-hex-collated/1.0368e+06/linferrorT.txt" using 1:2 lc 1 dt 2 title 'hex linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-hex-collated/1.0368e+06/linferrorT.txt" using 1:2 lc 1 title 'hex cubicUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-tri-collated/1.0368e+06/linferrorT.txt" using 1:2 lc 2 dt 2 title 'tri linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-tri-collated/1.0368e+06/linferrorT.txt" using 1:2 lc 2 title 'tri cubicUpwind', \
     x * 1e-1 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 * 1e-1 lc rgbcolor "black" dt 3 lw 3 title '2nd order'
