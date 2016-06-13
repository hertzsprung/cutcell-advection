#!/bin/bash
set -e
make -C $ATMOSTESTS_DIR build/horizontalAdvection-{cubic,linear}Upwind-{noOrography,btf}-{151x25,301x50}/10000/l{2,inf}errorT.txt

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

printf "151x25 2000 " >> convergence-horizontalAdvection.dat
testSet 151x25

printf "\n301x50 1000 " >> convergence-horizontalAdvection.dat
testSet 301x50
