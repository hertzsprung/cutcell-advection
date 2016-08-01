set terminal pngcairo size 640,480
set output "timesteps.png"

set style data linespoints
set logscale

set xlabel "$\\Delta x$"
set ylabel "$\\Delta t$"

unset key

set label at 200,100 "Basic terrain following"
set label at 300,10 "Slanted cells"
set label at 300,0.8 "Cut cells"

plot 'slantedCell.dat.csv' using 1:6 lw 2 ps 3, \
     'slantedCell.dat.csv' using 1:7 lw 2 ps 3, \
     'slantedCell.dat.csv' using 1:8 lw 2 ps 3
