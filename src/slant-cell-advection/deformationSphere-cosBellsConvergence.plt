set term epslatex color size 6,3

set style data linespoints
set logscale
set format x "$10^{%L}$"
set format y "$10^{%L}$"

set key rmargin
set rmargin 27

set xlabel "$\\Delta \\lambda$"

set xrange [10:9e-2]
set yrange [1e-2:1]

set ylabel "$\\ell_2$ error" offset 1.5

set label "CSLAM-CN5.5" at 1.5,0.033 center point pt 7 ps 2 offset character -3,-1.1
set label "FARSIGHT" at 0.1875,0.033 center point pt 5 ps 2 offset character 0.5,0.7
set label "ICON-FFSL" at 0.42,0.032 center point pt 9 ps 2.5 offset character -2,-1

plot "`echo $ATMOSTESTS_DIR`/build/deformationSphere-cosBells-nondiv-linearUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 1 dt 3 lw 2 title 'Icosahedra linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-cosBells-nondiv-cubicUpwind-hex-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 1 title 'Icosahedra cubicFit', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-cosBells-nondiv-linearUpwind-quad-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 2 dt 3 lw 2 title 'Cubed-sphere linearUpwind', \
     "`echo $ATMOSTESTS_DIR`/build/deformationSphere-cosBells-nondiv-cubicUpwind-quad-collated/1.0368e+06/l2errorT.txt" using 1:2 lc 2 title 'Cubed-sphere cubicFit', \
     x * 1e-1 lc rgbcolor "black" dt 1 lw 1 title '1st order', \
     x**2 * 3e-1 lc rgbcolor "black" dt 3 lw 3 title '2nd order', \
     0.033 lc rgbcolor "black" dt 1 lw 5 title "\`\`Minimal'' resolution"
