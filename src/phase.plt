u = 1
dt = 0.4
dx = 1
c=u*dt/dx

set samples 1000

ctcs(k) = asin(c*sin(k*dx))
btcs(k) = atan(c*sin(k*dx))
linUp(k) = c*(1.5*sin(k*dx) - 0.25*sin(2*k*dx))
cubUp(k) = c*(0.0625*sin(3*k*dx) - 0.375 * sin(2*k*dx) + 1.5625 * sin(k*dx))
k(x) = (x*dx/(2*pi))**-1

set xrange [2:32]
set xlabel "wavelength / dx"
set ylabel "phase speed ratio"

plot btcs(k(x))/(k(x)*dt*u) lw 1.5 title "BTCS", \
     ctcs(k(x))/(k(x)*dt*u) lw 1.5 title "CTCS", \
     linUp(k(x))/(k(x)*dt*u) lw 1.5 title "linearUpwind", \
     cubUp(k(x))/(k(x)*dt*u) lw 1.5 title "cubUp", \
     1 lt -1 dt 2 notitle
