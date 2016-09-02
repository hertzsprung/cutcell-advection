MAKEFLAGS += --no-builtin-rules                                                                 
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
.PHONY: all dist clean clean-dist

all::

dist:: all

clean:: clean-dist
	rm -rf build

clean-dist::

include $(MAKE_COMMON)/executables/Makefile
include $(MAKE_COMMON)/templates/Makefile-FileSystem
include $(MAKE_COMMON)/templates/Makefile-Gnuplot
include $(MAKE_COMMON)/templates/Makefile-LaTeX
include make/Makefile-Stabilisation
include make/Makefile-DeformationSphere-Convergence
include make/Makefile-MountainAdvection-Convergence
include make/Makefile-Slant-Cell-Advection
include make/Makefile-Supplementary
