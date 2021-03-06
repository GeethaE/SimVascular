# Hey emacs, this is a -*- makefile -*-

# Copyright (c) 2009-2011 Open Source Medical Software Corporation,
#                         University of California, San Diego.
# 
# All rights reserved. 
#
# Portions copyright (c) 1999-2007 Stanford University,
# Nathan Wilson, Ken Wang, Charles Taylor.
# 
# See SimVascular Acknowledgements file for additional
# contributors to the source code. 
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, merge, publish, 
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject
# to the following conditions:
# 
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

TOP=../../../BuildWithMake

include $(TOP)/include.mk

# --------------
# Compiler flags
# --------------

CXXFLAGS = $(GLOBAL_CXXFLAGS) $(LOCAL_INCDIR) $(TCLTK_INCDIR) $(VTK_INCDIRS) \
           $(ZLIB_INCDIR) $(PARASOLID_INCDIR) $(MESHSIM_INCDIR) $(TETGEN_INCDIR) \
           $(ITK_INCDIRS) $(OPENCASCADE_INCDIR) $(OPENCASCADE_DEFS) \
           $(PYTHON_INCDIR) $(SV_GDCM_INCDIR) $(QT_INCDIRS) -DSV_STATIC_LINK

HDRS	= 

CXXSRCS = main.cxx gdscInit.cxx cv_VTK_init.cxx

ifeq ($(MAKE_STATIC_BUILD),1)  

  COPIED_CXXSRCS += ../Common/Geometry/cv_geom_init.cxx \
                    ../PostProcessing/cv_post_init.cxx \
                    ../ImageProcessing/cv_image_init.cxx \
                    ../Common/Repository/cv_repos_init.cxx \
                    ../Model/SolidModel/cv_solid_init.cxx \
                    ../Legacy/LevelSet/cv_LsetCore_init.cxx \
                    ../Legacy/LevelSet/cv_LsetV_init.cxx \
                    ../Common/Utils/cv_get_tcl_interp_init.cxx \
                    ../Mesh/MeshObject/cv_mesh_init.cxx \
                    ../Model/PolyDataSolidModel/cv_polydatasolid_init.cxx \
                    ../Common/Utils/cv_math_init.cxx \

  ifeq ($(SV_USE_TETGEN_ADAPTOR),1)
	COPIED_CXXSRCS += ../Mesh/AdaptObject/cv_adapt_init.cxx
  else
    ifeq ($(SV_USE_MESHSIM_ADAPTOR),1)
	  COPIED_CXXSRCS += ../Mesh/AdaptObject/cv_adapt_init.cxx
    endif
  endif

  ifeq ($(SV_USE_MESHSIM),1)
    ifneq ($(SV_USE_MESHSIM_SHARED),1)
	COPIED_CXXSRCS += ../Mesh/MeshSimMeshObject/cv_meshsim_mesh_init.cxx
    endif
  endif
  ifeq ($(SV_USE_MESHSIM_ADAPTOR),1)
    ifneq ($(SV_USE_MESHSIM_SHARED),1)
	COPIED_CXXSRCS += ../Mesh/MeshSimAdapt/cv_meshsim_adapt_init.cxx
    endif
  endif
  ifeq ($(SV_USE_TETGEN),1)
	COPIED_CXXSRCS += ../Mesh/TetGenMeshObject/cv_tetgen_mesh_init.cxx
  endif
  ifeq ($(SV_USE_TETGEN_ADAPTOR),1)
	COPIED_CXXSRCS += ../Mesh/TetGenAdapt/cv_tetgen_adapt_init.cxx
  endif
  ifeq ($(SV_USE_MESHSIM_DISCRETE_MODEL),1)
    ifneq ($(SV_USE_MESHSIM_DISCRETE_MODEL_SHARED),1)
	COPIED_CXXSRCS += ../Model/MeshSimDiscreteSolidModel/cv_discrete_init.cxx
    endif
  endif
  ifeq ($(SV_USE_MESHSIM_SOLID_MODEL),1)
    ifneq ($(SV_USE_MESHSIM_SOLID_MODEL_SHARED),1)
	COPIED_CXXSRCS += ../Model/MeshSimSolidModel/cv_meshsimsolid_init.cxx
    endif
  endif
  ifeq ($(SV_USE_PARASOLID),1)
    ifneq ($(SV_USE_PARASOLID_SHARED),1)
	COPIED_CXXSRCS += ../../Licensed/ParasolidSolidModel/cv_parasolid_solid_init.cxx
    endif
  endif
  ifeq ($(SV_USE_OPENCASCADE),1)
    ifneq ($(SV_USE_OPENCASCADE_SHARED),1)
	COPIED_CXXSRCS += ../Model/OCCTSolidModel/cv_occt_init.cxx
    endif
  endif
  ifeq ($(SV_USE_ITK),1)
	COPIED_CXXSRCS += ../Segmentation/ITK/Util/cv_ITKUtils_init.cxx
	COPIED_CXXSRCS += ../Segmentation/ITK/cv_ITKLset2d_init.cxx
	COPIED_CXXSRCS += ../Segmentation/ITK/cv_ITKLset3d_init.cxx
  endif

  ifeq ($(SV_USE_SOLVERIO),1)
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_solverio$(LIBLINKEXT)
  endif

  ifeq ($(SV_USE_MESHSIM),1)
    ifeq ($(SV_USE_MESHSIM_SHARED),1)
#	LFLAGS += $(SVLIBFLAG)_simvascular_meshsim_mesh$(LIBLINKEXT)
    else
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_meshsim_mesh$(LIBLINKEXT)
    endif
  endif
  ifeq ($(SV_USE_MESHSIM_ADAPTOR),1)
    ifeq ($(SV_USE_MESHSIM_SHARED),1)
#	LFLAGS += $(SVLIBFLAG)_simvascular_meshsim_adaptor$(LIBLINKEXT)
    else
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_meshsim_adaptor$(LIBLINKEXT)
        LFLAGS += $(SVLIBFLAG)_lib_simvascular_adaptor$(LIBLINKEXT)
    endif
  endif
  ifeq ($(SV_USE_TETGEN),1)
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_tetgen_mesh$(LIBLINKEXT)
  endif
  ifeq ($(SV_USE_TETGEN_ADAPTOR),1)
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_tet_adaptor$(LIBLINKEXT)
        LFLAGS += $(SVLIBFLAG)_lib_simvascular_adaptor$(LIBLINKEXT)
  endif
  ifeq ($(SV_USE_MESHSIM_DISCRETE_MODEL),1)
    ifeq ($(SV_USE_MESHSIM_DISCRETE_MODEL_SHARED),1)
#	LFLAGS += $(SVLIBFLAG)_simvascular_meshsim_discrete$(LIBLINKEXT)
    else
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_meshsim_discrete$(LIBLINKEXT)
    endif
  endif
  ifeq ($(SV_USE_MESHSIM_SOLID_MODEL),1)
    ifeq ($(SV_USE_MESHSIM_SOLID_MODEL_SHARED),1)
#	LFLAGS += $(SVLIBFLAG)_simvascular_meshsim_solid$(LIBLINKEXT)
    else
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_meshsim_solid$(LIBLINKEXT)
    endif
  endif
  ifeq ($(SV_USE_PARASOLID),1)
    ifeq ($(SV_USE_PARASOLID_SHARED),1)
#	LFLAGS += $(SVLIBFLAG)_simvascular_parasolid$(LIBLINKEXT)
    else
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_parasolid$(LIBLINKEXT)
    endif
  endif
  ifeq ($(SV_USE_OPENCASCADE),1)
    ifeq ($(SV_USE_OPENCASCADE_SHARED),1)
#	LFLAGS += $(SVLIBFLAG)_simvascular_opencascade$(LIBLINKEXT)
    else
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_opencascade$(LIBLINKEXT)
    endif
  endif

  ifeq ($(SV_USE_VMTK),1)
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_vmtk$(LIBLINKEXT)
  endif

  ifeq ($(SV_USE_ITK),1)
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_itkutils$(LIBLINKEXT) \
                            $(SVLIBFLAG)_lib_simvascular_cvitk$(LIBLINKEXT)
  endif

  ifeq ($(SV_USE_SOLVERIO),1)
	LFLAGS += $(SVLIBFLAG)_lib_simvascular_solverio$(LIBLINKEXT)
  endif

endif

ifeq ($(SV_USE_QT_GUI),1)
  LFLAGS += $(SVLIBFLAG)_lib_simvascular_qtcode$(LIBLINKEXT)
endif

# need to explicitly add in globals for executable
ifeq ($(SV_USE_GLOBALS_SHARED),1)
  LFLAGS += $(SVLIBFLAG)_simvascular_globals$(LIBLINKEXT)
else
  LFLAGS += $(SVLIBFLAG)_lib_simvascular_globals$(LIBLINKEXT)
endif

SRCS	= $(CXXSRCS) $(foreach name,$(COPIED_CXXSRCS),$(lastword $(subst /, ,$(name))))

DEPS	= $(SRCS:.cxx=.d)

OBJS    = $(addprefix $(BUILD_DIR)/,$(SRCS:.cxx=.$(OBJECTEXT)))

TARGET_EXE_FULL = $(TOP)/Bin/simvascular-$(CXX_COMPILER_VERSION)-$(FORTRAN_COMPILER_VERSION).exe
TARGET_EXE = $(TOP)/Bin/simvascular.exe

dynamic: pre directories $(TARGET_EXE_FULL)

static: pre directories $(TARGET_EXE_FULL)

directories:
	-mkdir -p $(BUILD_DIR)

$(TARGET_EXE_FULL): $(OBJS)
	for fn in $(TARGET_EXE); do /bin/rm -f $$fn; done
	for fn in $(basename $(TARGET_EXE)).pdb; do /bin/rm -f $$fn; done
	for fn in $(TARGET_EXE_FULL); do /bin/rm -f $$fn; done
	for fn in $(basename $(TARGET_EXE_FULL)).pdb; do /bin/rm -f $$fn; done
	$(LINK_EXE)$(TARGET_EXE_FULL) $(LFLAGS) $(OBJS) \
        $(LFLAGS) \
        $(VMTK_LIBS) $(VTK_LIBS) $(ITK_LIBS) $(PARASOLID_LIBS) $(MESHSIM_LIBS) $(TETGEN_LIBS) $(ITK_LIBS) \
        $(ZLIB_LIBS) $(MPICH_LIBS) $(OPENCASCADE_LIBS) $(TCLTK_LIBS) $(CXX_LIBS) \
        $(PYTHON_LIB) $(SV_GDCM_LIBS) $(QT_LIBS) $(SV_FREETYPE_LIBS)
	for fn in $(TOP)/Bin/$(TARGET_EXE)*; do /bin/rm -f $$fn; done
ifeq ($(CLUSTER),x64_cygwin)
ifneq ($(MAKE_STATIC_BUILD),1)
        # can no longer rebase parasolid dlls
        # we need to check and see if we should be still rebasing 
        # the tcltk and vtk dlls
	editbin /REBASE:BASEFILE $(TARGET_EXE) ../../../BuildWithMake/Lib/$(CLUSTER)/$(CXX_COMPILER_VERSION)-$(FORTRAN_COMPILER_VERSION)*.$(SOEXT) \
          $(TCLTK_DLLS) $(VTK_DLLS)
endif
endif
	if [ -e $(notdir $(TARGET_EXE_FULL)).pdb ];then mv $(basename $(TARGET_EXE_FULL)).pdb $(TOP)/Bin;fi
	ln -s $(notdir $(TARGET_EXE_FULL)) $(TARGET_EXE)

pre:
	$(foreach name,$(COPIED_CXXSRCS),$(shell cp -f $(name) .))

ifndef NO_DEPEND
-include $(DEPS)
endif

clean:
	for fn in $(BUILD_DIR); do /bin/rm -f -r $$fn;done
	for fn in *~; do /bin/rm -f $$fn;done
	for fn in $(TOP)/Bin/$(TARGET_EXE)*; do /bin/rm -f $$fn; done
	for fn in $(notdir $(COPIED_CXXSRCS)); do /bin/rm -f $$fn;done

veryclean: clean
	if [ -e obj ];then /bin/rm -f -r obj;fi


