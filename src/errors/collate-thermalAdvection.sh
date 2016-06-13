#!/bin/bash
set -e
make -C $ATMOSTESTS_DIR build/thermalAdvection-{slantedCell,btf}-{cubic,linear}Upwind-{24x10,32x15,48x20,72x30,96x40,144x60,192x80,288x120,384x160}/4000/l{2,inf}errorT.txt

cat /dev/null > convergence-thermalAdvection.dat

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
| tr "\n" " " >> convergence-thermalAdvection.dat
}

printf "24x10 833.33 " >> convergence-thermalAdvection.dat
testSet 24x10

printf "\n32x15 625 " >> convergence-thermalAdvection.dat
testSet 32x15

printf "\n48x20 416.66 " >> convergence-thermalAdvection.dat
testSet 48x20

printf "\n72x30 312.5 " >> convergence-thermalAdvection.dat
testSet 72x30

printf "\n96x40 208.33 " >> convergence-thermalAdvection.dat
testSet 96x40

printf "\n144x60 156.25 " >> convergence-thermalAdvection.dat
testSet 144x60

printf "\n192x80 104.16 " >> convergence-thermalAdvection.dat
testSet 192x80

printf "\n288x120 78.12 " >> convergence-thermalAdvection.dat
testSet 288x120

printf "\n384x160 52.08 " >> convergence-thermalAdvection.dat
testSet 384x160
