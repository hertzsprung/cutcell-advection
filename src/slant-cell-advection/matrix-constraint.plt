set term epslatex color size 5,4

alpha1(x1,x2,x3)=(x2*x3**2 - x2**2*x3)/det(x1,x2,x3)
alpha2(x1,x2,x3)=(x1**2*x3 - x1*x3**2)/det(x1,x2,x3)
alpha3(x1,x2,x3)=(x1*x2**2 - x1**2*x2)/det(x1,x2,x3)

constraint(x1,x2,x3)=(abs(alpha1(x1,x2,x3)) < abs(alpha2(x1,x2,x3)) && abs(alpha1(x1,x2,x3)) < abs(alpha3(x1,x2,x3)) ? 1 : 1/0)
det(x1,x2,x3)=x2*x3**2 + x3*x1**2 + x1*x2**2 - x3*x2**2 - x2*x1**2 - x1*x3**2

set xlabel "$x_u$"
set ylabel "$x_d$"

set xrange [-1:0]
set yrange [0:1]

set cbrange [-3:3]
set pm3d map
set isosample 300,300
set sample 300

set multiplot layout 2,2

unset colorbox
set title "$x_{uu}=-2$"
splot [-1:0] [0:1] constraint(-2,x,y) notitle

set title "$x_{uu}=-1.75$"
splot [-1:0] [0:1] constraint(-1.75,x,y) notitle

set title "$x_{uu}=-1.5$"
splot [-1:0] [0:1] constraint(-1.5,x,y) notitle

set title "$x_{uu}=-1$"
splot [-1:0] [0:1] constraint(-1,x,y) notitle
