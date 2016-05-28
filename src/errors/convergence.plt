set terminal pdf size 6in,4in
set output 'convergence.pdf'
set logscale xy

set xlabel "dx (m)"

set style data linespoints

set key outside top center

set format y "10^{%L}"

set multiplot layout 1,2

set yrange [1e-7:1e-1]

set title "l2"

#plot 'newCubUpCPC.dat' using 3:6 lt 1 dt 2 pt 2 title 'slanted cubUpCPC' at beginning, \
#'btf.dat' using 3:4 lt 1 pt 1 title 'btf cubUpCPC' at beginning, \

plot 'newCubUpCPC.dat' using 3:6 lt 1 dt 2 pt 2 title 'slanted cubUpCPC' at beginning, \
     'convergence.dat' using 3:10 lt 2 dt 2 pt 4 title 'slanted up', \
     'convergence.dat' using 3:14 lt 3 dt 2 pt 6 title 'slanted linUp', \
     'newCubUpCPC.dat' using 3:4 lt 1 pt 1 title 'btf cubUpCPC', \
     'btf.dat' using 3:6 lt 3 pt 5 title 'btf linUp', \
     'btf.dat' using 3:8 lt 2 pt 3 title 'btf up', \
     x / 1e5 lt -1 dt 1 title '1nd order', \
     x / 1e6 lt -1 dt 1 notitle, \
     x**2 / 1e10 lt -1 dt 3 title '2nd order', \
     x**3 / 1e13 lt -1 dt 4 title '3rd order'

set title "linf"

#plot 'btf.dat' using 3:7 lt 1 dt 2 pt 2 title 'slanted cubUpCPC' at beginning, \
# 'btf.dat' using 3:5 lt 1 pt 1 title 'btf cubUpCPC' at beginning, \

plot 'newCubUpCPC.dat' using 3:7 lt 1 dt 2 pt 2 title 'slanted cubUpCPC' at beginning, \
     'convergence.dat' using 3:11 lt 2 dt 2 pt 4 title 'slanted up' at beginning, \
     'convergence.dat' using 3:15 lt 3 dt 2 pt 6 title 'slanted linUp', \
     'newCubUpCPC.dat' using 3:5 lt 1 pt 1 title 'btf cubUpCPC', \
     'btf.dat' using 3:9 lt 3 pt 5 title 'btf linUp', \
     'btf.dat' using 3:7 lt 2 pt 3 title 'btf up', \
     x / 1e5 lt -1 dt 1 title '1nd order', \
     x**2 / 5e8 lt -1 dt 3 title '2nd order'
