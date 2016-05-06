set term epslatex color size 6,3

alpha(kdx) = -0.06*cos(3*kdx) + 0.37*cos(2*kdx) - 0.94*cos(kdx) + 0.63
beta(kdx) = 0.06*sin(3*kdx) - 0.37*sin(2*kdx) + 1.56*sin(kdx)

f(kdx, Co) = 1 + Co**2 * (alpha(kdx)**2 + beta(kdx)**2) - 2*Co*alpha(kdx)
PI=3.14

set xlabel "$k \\Delta x$"
set ylabel "$|A|^2$"
set xrange [0:2*PI]
set yrange [0:1.2]

set key outside above

set multiplot

set object 1 rectangle from 0,0.99 to 0.5,1.01 front fillstyle empty

plot f(x, 1.5) title "$\\mathrm{Co} = 1.5$" lw 2, \
     f(x, 1) title "$\\mathrm{Co} = 1$" lw 2, \
     f(x, 0.5) title "$\\mathrm{Co} = 0.5$" lw 2, \
     f(x, 0.2) title "$\\mathrm{Co} = 0.2$" lw 2, \
     f(x, 0.1) title "$\\mathrm{Co} = 0.1$" lw 2, \
     f(x, 0.05) title "$\\mathrm{Co} = 0.05$" lw 2


set size 0.35,0.4
set origin 0.1,0.17

unset key
unset xlabel
unset ylabel

unset object 1

set xrange [0:0.5]
set yrange [0.99:1.01]

set xtics 0.25
set ytics 0.01

plot f(x, 1.5) title "$\\mathrm{Co} = 1.5$" lw 2, \
     f(x, 1) title "$\\mathrm{Co} = 1$" lw 2, \
     f(x, 0.5) title "$\\mathrm{Co} = 0.5$" lw 2, \
     f(x, 0.2) title "$\\mathrm{Co} = 0.2$" lw 2, \
     f(x, 0.1) title "$\\mathrm{Co} = 0.1$" lw 2, \
     f(x, 0.05) title "$\\mathrm{Co} = 0.05$" lw 2

