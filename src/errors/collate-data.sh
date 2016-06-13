#!/bin/bash
set -e
make -C $ATMOSTESTS_DIR build/thermalAdvection-{btf,slantedCell}-{linear,cubic}Upwind-{24x10,48x20,96x40,192x80,384x160}/4000/l{2,inf}errorT.txt

cat /dev/null > convergence.dat

function testSet {
cat \
  $ATMOSTESTS_DIR/build/thermalAdvection-btf-linearUpwind-$1/4000/l2errorT.txt \
  $ATMOSTESTS_DIR/build/thermalAdvection-btf-linearUpwind-$1/4000/linferrorT.txt \
  $ATMOSTESTS_DIR/build/thermalAdvection-slantedCell-linearUpwind-$1/4000/l2errorT.txt \
  $ATMOSTESTS_DIR/build/thermalAdvection-slantedCell-linearUpwind-$1/4000/linferrorT.txt \
  $ATMOSTESTS_DIR/build/thermalAdvection-btf-cubicUpwind-$1/4000/l2errorT.txt \
  $ATMOSTESTS_DIR/build/thermalAdvection-btf-cubicUpwind-$1/4000/linferrorT.txt \
  $ATMOSTESTS_DIR/build/thermalAdvection-slantedCell-cubicUpwind-$1/4000/l2errorT.txt \
  $ATMOSTESTS_DIR/build/thermalAdvection-slantedCell-cubicUpwind-$1/4000/linferrorT.txt \
| tr "\n" " " >> convergence.dat
}

printf "24x10x2.5 833.33 " >> convergence.dat
testSet 24x10

printf "\n48x20x2.5 416.66 " >> convergence.dat
testSet 48x20

printf "\n96x40x2.5 208.33 " >> convergence.dat
testSet 96x40

printf "\n192x80x2.5 104.16 " >> convergence.dat
testSet 192x80

printf "\n384x160x1.5 52.08 " >> convergence.dat
testSet 384x160
