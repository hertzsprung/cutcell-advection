set term epslatex color size 4,3

alpha(kdx) = -0.06*cos(3*kdx) + 0.37*cos(2*kdx) - 0.94*cos(kdx) + 1.25
beta(kdx) = 0.06*sin(3*kdx) - 0.37*sin(2*kdx) + 0.94*sin(kdx)

f(kdx, Co) = sqrt(1 + Co**2 * (alpha(kdx)**2 + beta(kdx)**2) - 2*Co*alpha(kdx))
PI=3.14

set xlabel "$k \\Delta x$"
set ylabel "$|A|$"
set xrange [0:2*PI]
set yrange [0:1.2]

set key outside above

plot f(x, 1) title "$\\mathrm{Co} = 1$", \
     f(x, 0.75) title "$\\mathrm{Co} = 0.75$", \
     f(x, 0.5) title "$\\mathrm{Co} = 0.5$", \
     f(x, 0.05) title "$\\mathrm{Co} = 0.05$"
