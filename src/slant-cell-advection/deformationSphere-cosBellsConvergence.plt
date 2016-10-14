set term epslatex color size 3,4

set style data linespoints
set logscale
set format x "$10^{%L}$"
set format y "$10^{%L}$"

set key tmargin

set xlabel "$\\Delta \\lambda$"

set xrange [10:0.4]
set yrange [1e-2:1]

set ylabel "$\\ell_2$ error"
plot "`echo $ATMOSTESTS_DIR`/build/deformationSphere-cosBells-nondiv-linearUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 1 dt 3 lw 2 title 'hex linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-cosBells-nondiv-cubicUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 1 title 'hex cubicFit', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-cosBells-nondiv-linearUpwind-quad-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 2 dt 3 lw 2 title 'quad linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-cosBells-nondiv-cubicUpwind-quad-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 2 title 'quad cubicFit', \
     x * 1e-1 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 * 1e-1 lc rgbcolor "black" dt 3 lw 3 title '2nd order', \
     0.033 lc rgbcolor "black" dt 1 lw 5 title "\`\`Minimal'' resolution"
