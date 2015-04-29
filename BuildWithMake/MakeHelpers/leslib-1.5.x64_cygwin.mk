ifeq ($(CLUSTER), x64_cygwin)
    LESLIB_DEFS   = -DACUSIM_NT -DACUSIM_WIN -DACUSIM_WIN64
    LESLIB_INCDIR = -I $(LESLIB_TOP)
    LESLIB_TOP    = $(LICENSED_SOFTWARE_TOPLEVEL)/leslib-1.5/win/x64
    LESLIB_LIBS   = /LIBPATH:$(LESLIB_TOP) libles.lib
    LESLIB_LIBS  += Advapi32.lib Ws2_32.lib
endif
