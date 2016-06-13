set terminal pdf size 6in,4in
set output 'convergence-horizontalAdvection.pdf'
set logscale xy

set xlabel "dx (m)"

set style data linespoints

set key outside top center

set format y "10^{%L}"

set multiplot layout 1,2

set yrange [1e-7:1e-1]

set title "l2"

plot 'convergence-horizontalAdvection.dat' using 2:3 lt 1 dt 1 pt 1 title 'btf linUp', \
     'convergence-horizontalAdvection.dat' using 2:5 lt 1 dt 2 pt 2 title 'noOrog linUp', \
     'convergence-horizontalAdvection.dat' using 2:7 lt 2 dt 1 pt 3 title 'btf cubUp', \
     'convergence-horizontalAdvection.dat' using 2:9 lt 2 dt 2 pt 4 title 'noOrog cubUp', \
     x / 1e6 lt -1 dt 1 notitle, \
     x**2 / 1e10 lt -1 dt 3 title '2nd order', \
     x**3 / 1e13 lt -1 dt 4 title '3rd order'

set title "linf"

plot 'convergence-horizontalAdvection.dat' using 2:4 lt 1 dt 1 pt 1 title 'btf linUp', \
     'convergence-horizontalAdvection.dat' using 2:6 lt 1 dt 2 pt 2 title 'noOrog linUp', \
     'convergence-horizontalAdvection.dat' using 2:8 lt 2 dt 1 pt 3 title 'btf cubUp', \
     'convergence-horizontalAdvection.dat' using 2:10 lt 2 dt 2 pt 4 title 'noOrog cubUp', \
     x / 1e5 lt -1 dt 1 title '1nd order', \
     x**2 / 5e8 lt -1 dt 3 title '2nd order'
