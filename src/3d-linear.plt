set terminal wxt
set style data lines

f(x, y, a1, a2, a3, a4) = a1 + a2*x + a3*y + a4*x*y

set xrange [-2.5:0.5]
set yrange [-1.5:1.5]
set zrange [-4:5]
set xyplane 0

set xlabel 'x'
set ylabel 'y'
set zlabel 'z'

#set pm3d
#set palette gray
unset colorbox

set xzeroaxis
set yzeroaxis

#splot f(x, y, 2, 1, -2, 0), \
#      f(x, y, 2, 1, -2, -2)
splot f(x, y, 2, 0, 0, 1)

