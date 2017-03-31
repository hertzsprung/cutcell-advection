set term epslatex color size 3.5,3.8

set style data linespoints
set logscale x

set lmargin 6
#set bmargin 1.5

unset key

set xrange [100:10000]

set multiplot layout 2,1 margins 0.15, 0.95, 0.12, 0.94 spacing 0,0.12

set title "Longest stable time-steps" offset 0,-0.5

set xtics out
set logscale y
set format x ""
set label at 110,500 "(a)"
set label at 180,7 rotate by 18 "Basic terrain following"
set label at 190,1.1 rotate by 15 "Slanted cells"
set label at 190,0.16 "Cut cells"

set ylabel "$\\Delta t_\\mathrm{max}$ (\\si{\\second})" offset 2

plot "../../src/mountainAdvection/maxdt-btf.dat" using 1:2 lw 1.5 ps 1.5 pt 4, \
     "../../src/mountainAdvection/maxdt-cutCell.dat" using 1:2 lw 1.5 ps 1.5 pt 6, \
     "../../src/mountainAdvection/maxdt-slantedCell.dat" using 1:2 lw 1.5 ps 1.5 pt 8

set title "Largest stable maximum Courant numbers"

unset label

set format x "$%h$"
unset logscale y
set label at 110,3.3 "(b)"
set label at 140,3 "Cut cells"
set label at 110,2.2 "Slanted cells"
set label at 110,1.15 "Basic terrain following"
set xlabel "$\\Delta x$ (\\si{\\meter})" offset 0,0.2
set ylabel "$\\max(\\mathrm{Co})$" offset 1.2

plot "../../src/mountainAdvection/maxco-btf.dat" using 1:2 lw 1.5 ps 1.5 pt 4, \
     "../../src/mountainAdvection/maxco-cutCell.dat" using 1:2 lw 1.5 ps 1.5 pt 6, \
     "../../src/mountainAdvection/maxco-slantedCell.dat" using 1:2 lw 1.5 ps 1.5 pt 8

unset multiplot
