set style data linespoints

set logscale x
set logscale y

set xlabel "$\\Delta x$ (\\si{\\meter})"
set ylabel "$\\Delta t_\\mathrm{max}$" offset 2

set key bottom right

set xrange [100:10000]

plot "maxdt-btf.dat" using 1:2 lw 1.5 ps 1.5 pt 4, \
     "maxdt-cutCell.dat" using 1:2 lw 1.5 ps 1.5 pt 6, \
     "maxdt-slantedCell.dat" using 1:2 lw 1.5 ps 1.5 pt 8, \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-btf-6000-linearUpwind-collated/0/maxdt.txt" using 1:2 lw 1.5 ps 1.5 pt 4 lc 1 dt 2 title "btf-old", \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-cutCell-6000-linearUpwind-collated/0/maxdt.txt" using 1:2 lw 1.5 ps 1.5 pt 6 lc 2 dt 2 title "cutCell-old", \
     "`echo $ATMOSTESTS_DIR`/build/mountainAdvection-slantedCell-6000-linearUpwind-collated/0/maxdt.txt" using 1:2 lw 1.5 ps 1.5 pt 8 lc 3 dt 2 title "slantedCell-old"
