set term epslatex color size 6,3.2

set style data linespoints
set logscale
set format x "$10^{%L}$"
set format y "$10^{%L}$"

set key tmargin

set xlabel "$\\Delta \\lambda$" offset 0,0.5

set xrange [10:0.2]
set yrange [3e-3:1]

set multiplot layout 1,2

### l2

set ylabel "$\\ell_2$ error" offset 1.5
plot "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 1 dt 3 lw 2 title 'Hexagonal-icosahedral, linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 1 title 'Hexagonal-icosahedral, cubicFit', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-quad-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 2 dt 3 lw 2 title 'Cubed-sphere, linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-quad-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 2 title 'Cubed-sphere, cubicFit', \
     x * 1e-1 lc rgbcolor "black" dt 1 lw 1 notitle, \
     x**2 * 1e-1 lc rgbcolor "black" dt 3 lw 3 notitle

### linf

set tmargin 5.2
set ylabel "$\\ell_\\infty$ error" offset 1.5
plot "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-hex-collated/1.0368e+06/linferrorT.txt" using 1:2 lc 1 dt 3 lw 2 notitle, \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-hex-collated/1.0368e+06/linferrorT.txt" using 1:2 lc 1 notitle, \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-linearUpwind-quad-collated/1.0368e+06/linferrorT.txt" using 1:2 lc 2 dt 3 lw 2 notitle, \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-gaussians-nondiv-cubicUpwind-quad-collated/1.0368e+06/linferrorT.txt" using 1:2 lc 2 notitle, \
     x * 1e-1 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 * 1e-1 lc rgbcolor "black" dt 3 lw 3 title '2nd order'
