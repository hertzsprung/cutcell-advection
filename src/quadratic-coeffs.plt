alpha1(x1,x2,x3)=(x2*x3**2 - x2**2*x3)/det(x1,x2,x3)
alpha2(x1,x2,x3)=(x1**2*x3 - x1*x3**2)/det(x1,x2,x3)
alpha3(x1,x2,x3)=(x1*x2**2 - x1**2*x2)/det(x1,x2,x3)

constraint(x1,x2,x3)=(abs(alpha1(x1,x2,x3)) < abs(alpha2(x1,x2,x3)) && abs(alpha1(x1,x2,x3)) < abs(alpha3(x1,x2,x3)) ? 1 : 1/0)
det(x1,x2,x3)=x2*x3**2 + x3*x1**2 + x1*x2**2 - x3*x2**2 - x2*x1**2 - x1*x3**2

set xlabel "x2"
set ylabel "x3"

set xrange [-1:0]
set yrange [0:1]

set cbrange [-3:3]
set pm3d map
set isosample 300,300
set sample 300

set multiplot layout 2,2

x1=-1

set title "alpha1"
splot [-1:0] [0:1] alpha1(x1,x,y)

set title "alpha2"
splot [-1:0] [0:1] alpha2(x1,x,y)

set title "alpha3"
splot [-1:0] [0:1] alpha3(x1,x,y)

unset colorbox
set title "abs(alpha1) < abs(alpha2) && abs(alpha1) < abs(alpha3)"
splot [-1:0] [0:1] constraint(x1,x,y)
