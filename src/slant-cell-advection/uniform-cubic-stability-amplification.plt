set term epslatex color size 4,2.5

alpha(kdx) = 0.06*cos(3*kdx) - 0.25*cos(2*kdx) + 0.94*cos(kdx) + 1.25
beta(kdx) = -0.06*sin(3*kdx) + 0.25*sin(2*kdx) - 0.32*sin(kdx)

f(kdx, Co) = 1 + Co**2 * (alpha(kdx)**2 + beta(kdx)**2) - 2*Co*alpha(kdx)
PI=3.14

set xlabel "$k \\Delta x$"
set ylabel "$|A|^2$"
set xrange [0:2*PI]
set yrange [0:1.2]

unset key

plot f(x, 1.5) title "$\\mathrm{Co} = 1.5$" at end, \
     f(x, 1) title "$\\mathrm{Co} = 1$" at end, \
     f(x, 0.5) title "$\\mathrm{Co} = 0.5$" at end, \
