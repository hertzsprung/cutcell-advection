set term epslatex color size 6,4
set termoption dashed

set multiplot layout 3,2

set style data lines

set xrange [-75:75]
set yrange [0:15]
set xtics 25 format ""
#set xtics 25 format "%h"
#set xlabel "$x$ (\\si{\\kilo\\meter})"
set ytics 5 offset 0.5

a = 25e3
hm = 6e3
lambda = 8e3

schaerCos(x) = abs(x) < a ? hm*cos(pi*x/(2*a))**2 * cos(pi*x/lambda)**2 : 0

set parametric
set trange [-25:25]

set ylabel "$z$ (\\si{\\kilo\\meter})" offset 2

set title "linearUpwind on BTF mesh" offset 0,-0.9
plot t, schaerCos(t*1000)/1000 notitle lt 1 lc 0, \
"`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-linearUpwind-1000/10000/T_diff.contour.positive" using ($1/1000):($2/1000) notitle lt 1 lc 0, \
"`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-linearUpwind-1000/10000/T_diff.contour.negative" using ($1/1000):($2/1000) notitle dt 3 lc rgbcolor '#ff0000'

set title "cubicFit on BTF mesh" offset 0,-0.9
plot t, schaerCos(t*1000)/1000 notitle lt 1 lc 0, \
"`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-cubicUpwind-1000/10000/T_diff.contour.positive" using ($1/1000):($2/1000) notitle lt 1 lc 0, \
"`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-cubicUpwind-1000/10000/T_diff.contour.negative" using ($1/1000):($2/1000) notitle dt 3 lc rgbcolor '#ff0000'

set title "linearUpwind on slanted cell mesh" offset 0,-0.9
plot t, schaerCos(t*1000)/1000 notitle lt 1 lc 0, \
"`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-linearUpwind-1000/10000/T_diff.contour.positive" using ($1/1000):($2/1000) notitle lt 1 lc 0, \
"`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-linearUpwind-1000/10000/T_diff.contour.negative" using ($1/1000):($2/1000) notitle dt 3 lc rgbcolor '#ff0000'

set title "cubicFit on slanted cell mesh" offset 0,-0.9
plot t, schaerCos(t*1000)/1000 notitle lt 1 lc 0, \
"`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-cubicUpwind-1000/10000/T_diff.contour.positive" using ($1/1000):($2/1000) notitle lt 1 lc 0, \
"`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-cubicUpwind-1000/10000/T_diff.contour.negative" using ($1/1000):($2/1000) notitle dt 3 lc rgbcolor '#ff0000'

unset multiplot
