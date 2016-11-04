set term epslatex color colortext size 4.5,3

set xrange [0:10]
set yrange [0:0.2]

set style data linespoints

set xlabel "Peak mountain height $h_0$ (\\si{\\kilo\\meter})"
set ylabel "$\\ell_2$ error" offset 2

set label "\\textit{BTF linearUpwind}" at 6.2,0.077 textcolor rgb "dark-violet"
set label "BTF cubicUpwind" at 6.2,0.045 textcolor rgb "dark-violet"
set label "\\textit{Cut cells linearUpwind}" at 5.75,0.14 textcolor rgb "#009e73"
set label "Cut cells cubicUpwind" at 6,0.061 textcolor rgb "#009e73"
set label "\\textit{Slanted cells linearUpwind}" at 5.2,0.185 textcolor rgb "#1a8acb"
set label "Slanted cells cubicUpwind" at 5.6,0.095 textcolor rgb "#1a8acb"

unset key

plot "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-collated-linearUpwind-1000/10000/l2errorT.txt" using ($1/1000):($2) lc 1 lw 2 dt 2 ps 1.5 pt 4, \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-collated-cubicUpwind-1000/10000/l2errorT.txt" using ($1/1000):($2) lc 1 lw 2 dt 1 ps 1.5 pt 5, \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-cutCell-collated-linearUpwind-1000/10000/l2errorT.txt" using ($1/1000):($2) lc 2 lw 2 dt 2 ps 1.5 pt 8, \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-cutCell-collated-cubicUpwind-1000/10000/l2errorT.txt" using ($1/1000):($2) lc 2 lw 2 dt 1 ps 1.5 pt 9, \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-collated-linearUpwind-1000/10000/l2errorT.txt" using ($1/1000):($2) lc 3 lw 2 dt 2 ps 1.5 pt 6, \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-collated-cubicUpwind-1000/10000/l2errorT.txt" using ($1/1000):($2) lc 3 lw 2 dt 1 ps 1.5 pt 7
