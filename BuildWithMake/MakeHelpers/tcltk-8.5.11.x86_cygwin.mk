ifeq ($(CLUSTER), x86_cygwin)
    BUILDFLAGS     += -D__NON_STD_TCL_INSTALL
    TCL_BASE       = $(OPEN_SOFTWARE_BINARIES_TOPLEVEL)/tcltk-8.5.11
    TK_BASE        = $(OPEN_SOFTWARE_BINARIES_TOPLEVEL)/tcltk-8.5.11
    TCLTK_INCDIR   = -I$(TCL_BASE)/include -I$(TK_BASE)/include
    TCLTK_LIBDIR   = /LIBPATH:$(TCL_BASE)/lib /LIBPATH:$(TK_BASE)/lib
    TCLTK_DLLS     = $(TCL_BASE)/bin/tcl85t.$(SOEXT) $(TCL_BASE)/bin/tk85t.$(SOEXT)   
    TCLTK_LIBS     = $(TCLTK_LIBDIR) tcl85t.lib tk85t.lib \
                     user32.lib advapi32.lib gdi32.lib comdlg32.lib imm32.lib comctl32.lib shell32.lib
    TKCXIMAGE_BASE = $(OPEN_SOFTWARE_BINARIES_TOPLEVEL)/tkcximage-0.98.9/tcltk-8.5.11
    TKCXIMAGE_DLL  = $(TKCXIMAGE_BASE)/bin/Tkcximage.$(SOEXT)
    TCLTK_SO_PATH  = $(TCL_BASE)/bin
    TCL_LIBRARY    = $(TCL_BASE)/lib/tcl8.5
    TK_LIBRARY     = $(TCL_BASE)/lib/tk8.5
    TCLSH          = $(TCL_BASE)/bin/tclsh85t.exe
endif
