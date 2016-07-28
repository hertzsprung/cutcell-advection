#!/bin/bash
set -e
make -C $ATMOSTESTS_DIR build/horizontalAdvection-{cubic,linear}Upwind-{noOrography,btf}-{31x5,91x15,151x25,301x50,601x100,1201x200,2401x400}/10000/l{2,inf}errorT.txt

cat /dev/null > convergence-horizontalAdvection.dat

function testSet {
cat \
  $ATMOSTESTS_DIR/build/horizontalAdvection-linearUpwind-btf-$1/10000/l2errorT.txt \
  $ATMOSTESTS_DIR/build/horizontalAdvection-linearUpwind-btf-$1/10000/linferrorT.txt \
  $ATMOSTESTS_DIR/build/horizontalAdvection-linearUpwind-noOrography-$1/10000/l2errorT.txt \
  $ATMOSTESTS_DIR/build/horizontalAdvection-linearUpwind-noOrography-$1/10000/linferrorT.txt \
  $ATMOSTESTS_DIR/build/horizontalAdvection-cubicUpwind-btf-$1/10000/l2errorT.txt \
  $ATMOSTESTS_DIR/build/horizontalAdvection-cubicUpwind-btf-$1/10000/linferrorT.txt \
  $ATMOSTESTS_DIR/build/horizontalAdvection-cubicUpwind-noOrography-$1/10000/l2errorT.txt \
  $ATMOSTESTS_DIR/build/horizontalAdvection-cubicUpwind-noOrography-$1/10000/linferrorT.txt \
| tr "\n" " " >> convergence-horizontalAdvection.dat
}

printf "31x5 10000 " >> convergence-horizontalAdvection.dat
testSet 31x5

printf "\n91x15 3333 " >> convergence-horizontalAdvection.dat
testSet 91x15

printf "\n151x25 2000 " >> convergence-horizontalAdvection.dat
testSet 151x25

printf "\n301x50 1000 " >> convergence-horizontalAdvection.dat
testSet 301x50

printf "\n601x100 500 " >> convergence-horizontalAdvection.dat
testSet 601x100

printf "\n1201x200 250 " >> convergence-horizontalAdvection.dat
testSet 1201x200

printf "\n2401x400 125 " >> convergence-horizontalAdvection.dat
testSet 2401x400
