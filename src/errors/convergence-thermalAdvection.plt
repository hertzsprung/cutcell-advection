set terminal pdf size 6in,4in
set output 'convergence-thermalAdvection.pdf'
set logscale xy

set xlabel "dx (m)"

set style data linespoints

set key outside top center

set format y "10^{%L}"

set multiplot layout 1,2

set xrange [30:1000]
set yrange [1e-9:1e-1]

set title "l2"

plot 'convergence-thermalAdvection.dat' using 2:3 lt 1 dt 1 pt 1 title 'btf linUp', \
     'convergence-thermalAdvection.dat' using 2:5 lt 1 dt 2 pt 2 title 'slant linUp', \
     'convergence-thermalAdvection.dat' using 2:7 lt 2 dt 1 pt 3 title 'btf cubUp', \
     'convergence-thermalAdvection.dat' using 2:9 lt 2 dt 2 pt 4 title 'slant cubUp', \
     x / 2.5e6 lt -1 dt 1 lw 1 title '1st order', \
     x**2 / 2.5e9 lt -1 dt 3 lw 3 title '2nd order', \
     x**3 / 5e12 lt -1 dt 4 lw 1 title '3rd order', \
     x**4 / 3e15 lt -1 dt 3 lw 1 title '4th order'

set title "linf"

plot 'convergence-thermalAdvection.dat' using 2:4 lt 1 dt 1 pt 1 title 'btf linUp', \
     'convergence-thermalAdvection.dat' using 2:6 lt 1 dt 2 pt 2 title 'slant linUp', \
     'convergence-thermalAdvection.dat' using 2:8 lt 2 dt 1 pt 3 title 'btf cubUp', \
     'convergence-thermalAdvection.dat' using 2:10 lt 2 dt 2 pt 4 title 'slant cubUp', \
     x / 4e5 lt -1 dt 1 lw 1 title '1nd order', \
     x**2 / 5e8 lt -1 dt 3 lw 3 title '2nd order', \
     x**3 / 2e12 lt -1 dt 4 lw 1 title '3rd order'
