set style data linespoints
set terminal svg size 1200,800 font "Times,28"
set output "maxdt.svg"

set logscale x
set logscale y

set xlabel "dx (m)"
set ylabel "dt (s)" offset 3

unset key

set xrange [100:10000]

set label at 250,7 rotate by 20 "Basic terrain following"
set label at 250,2 rotate by 20 "Slanted cells"
set label at 250,0.2 "Cut cells"

plot "maxdt-btf.dat" using 1:2 lw 1.5 ps 1.5 pt 4, \
     "maxdt-cutCell.dat" using 1:2 lw 1.5 ps 1.5 pt 6, \
     "maxdt-slantedCell.dat" using 1:2 lw 1.5 ps 1.5 pt 8
