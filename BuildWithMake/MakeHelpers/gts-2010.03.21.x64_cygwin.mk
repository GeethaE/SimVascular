ifeq ($(CLUSTER), x64_cygwin)
    GTS_TOPLEVEL = $(OPEN_SOFTWARE_BINARIES_TOPLEVEL)/gts-2010.03.21
    GTS_INCDIR = -I$(GTS_TOPLEVEL)/include
    GTS_LIBDIR = $(GTS_TOPLEVEL)/lib
    GTS_LIBS   = /LIBPATH:$(GTS_LIBDIR) libgts.lib
endif
