set style data linespoints
set terminal svg size 1200,800 font "Times,28"
set output "maxco.svg"

set logscale x

set xlabel "dx (m)"
set ylabel "Courant number" offset 2

set xrange [100:10000]

unset key

set label at 136,2.8 "Cut cells"
set label at 110,2 "Slanted cells"
set label at 110,1.15 "Basic terrain following"

plot "maxco-btf.dat" using 1:2 lw 1.5 ps 1.5 pt 4, \
     "maxco-cutCell.dat" using 1:2 lw 1.5 ps 1.5 pt 6, \
     "maxco-slantedCell.dat" using 1:2 lw 1.5 ps 1.5 pt 8
