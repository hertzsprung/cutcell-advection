set style data linespoints

set logscale x

set xlabel "$\\Delta x$ (\\si{\\meter})"
set ylabel "$\\mathrm{Co}_\\mathrm{max}$" offset 2

set xrange [100:10000]

plot "maxco-btf.dat" using 1:2 lw 1.5 ps 1.5 pt 4, \
     "maxco-cutCell.dat" using 1:2 lw 1.5 ps 1.5 pt 6, \
     "maxco-slantedCell.dat" using 1:2 lw 1.5 ps 1.5 pt 8, \
