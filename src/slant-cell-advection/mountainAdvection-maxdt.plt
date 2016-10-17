set term epslatex color size 4,3

set style data linespoints
set logscale

set xlabel "$\\Delta x$"
set ylabel "$\\Delta t$ when $\\max(\\mathrm{Co}) = 1$" offset 2

unset key

set label at 160,150 "Basic terrain following"
set label at 120,0.6 "Slanted cells"
set label at 900,1 "Cut cells"

plot "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-linearUpwind-collated/0/maxdt.txt" using 1:2 lw 2 ps 3, \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-cutCell-linearUpwind-collated/0/maxdt.txt" using 1:2 lw 2 ps 3, \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-linearUpwind-collated/0/maxdt.txt" using 1:2 lw 2 ps 3
