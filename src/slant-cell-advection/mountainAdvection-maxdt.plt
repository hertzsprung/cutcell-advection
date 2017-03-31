set term epslatex color size 3.5,2.5

set style data linespoints
set logscale x
set logscale y

set xlabel "$\\Delta x$ (\\si{\\meter})"
set ylabel "$\\Delta t_\\mathrm{max}$ (\\si{\\second})" offset 2

unset key

set xrange [100:10000]

set label at 180,6 rotate by 25 "Basic terrain following"
set label at 190,1.2 rotate by 25 "Slanted cells"
set label at 190,0.18 "Cut cells"

plot "../../src/mountainAdvection/maxdt-btf.dat" using 1:2 lw 1.5 ps 1.5 pt 4, \
     "../../src/mountainAdvection/maxdt-cutCell.dat" using 1:2 lw 1.5 ps 1.5 pt 6, \
     "../../src/mountainAdvection/maxdt-slantedCell.dat" using 1:2 lw 1.5 ps 1.5 pt 8
