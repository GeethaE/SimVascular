# Copyright (c) 2014-2015 The Regents of the University of California.
# All Rights Reserved.
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
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
# OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
set(proj OpenCASCADE)

set(${proj}_DEPENDENCIES VTK FREETYPE)

ExternalProject_Include_Dependencies(${proj}
  PROJECT_VAR proj
  DEPENDS_VAR ${proj}_DEPENDENCIES
  EP_ARGS_VAR ${proj}_EXTERNAL_PROJECT_ARGS
  USE_SYSTEM_VAR ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj}
  )

get_filename_component(TCL_LIBRARY_DIR ${TCL_LIBRARY} PATH)
get_filename_component(TK_LIBRARY_DIR ${TK_LIBRARY} PATH)

set(${proj}_BUILD_LIBRARY_TYPE "Static")
if(SV_USE_${proj}_SHARED)
  set(${proj}_BUILD_LIBRARY_TYPE "Shared")
endif()

if(NOT ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj})


  set(revision_tag "v${${proj}_VERSION}")
  set(location_args GIT_REPOSITORY "https://github.com/SimVascular/OpenCASCADE.git"
    GIT_TAG ${revision_tag})
  if(WIN32)
    set(${proj}_PFX_DIR ${SV_EXTERNALS_TOPLEVEL_DIR}/${SV_EXT_${proj}_PFX_DIR} 
      CACHE PATH "On windows, there is a bug with OpenCASCADE source code directory path length, you can change this path to avoid it")
    set(${proj}_SRC_DIR ${SV_EXTERNALS_TOPLEVEL_DIR}/${SV_EXT_${proj}_SRC_DIR} 
      CACHE PATH "On windows, there is a bug with OpenCASCADE source code directory path length, you can change this path to avoid it")
    set(${proj}_BLD_DIR ${SV_EXTERNALS_TOPLEVEL_DIR}/${SV_EXT_${proj}_BLD_DIR}  
      CACHE PATH "On windows, there is a bug with OpenCASCADE source code directory path length, you can change this path to avoid it")
    set(${proj}_BIN_DIR ${SV_EXTERNALS_TOPLEVEL_DIR}/${SV_EXT_${proj}_BIN_DIR}  
      CACHE PATH "On windows, there is a bug with OpenCASCADE source code directory path length, you can change this path to avoid it")
  else()
    set(${proj}_PFX_DIR ${SV_EXTERNALS_TOPLEVEL_DIR}/${SV_EXT_${proj}_PFX_DIR})
    set(${proj}_SRC_DIR ${SV_EXTERNALS_TOPLEVEL_DIR}/${SV_EXT_${proj}_SRC_DIR})
    set(${proj}_BLD_DIR ${SV_EXTERNALS_TOPLEVEL_DIR}/${SV_EXT_${proj}_BLD_DIR})
    set(${proj}_BIN_DIR ${SV_EXTERNALS_TOPLEVEL_DIR}/${SV_EXT_${proj}_BIN_DIR})
  endif()

  #if(APPLE)
  #  set(${proj}_BUILD_TYPE "Debug")
  #else()
    set(${proj}_BUILD_TYPE ${CMAKE_BUILD_TYPE})
  #endif()

  ExternalProject_Add(${proj}
   ${location_args}
   PREFIX ${${proj}_PFX_DIR}
   SOURCE_DIR ${${proj}_SRC_DIR}
   BINARY_DIR ${${proj}_BLD_DIR}
   UPDATE_COMMAND ""
   CMAKE_CACHE_ARGS
   -DCMAKE_CXX_COMPILER:STRING=${CMAKE_CXX_COMPILER}
   -DCMAKE_C_COMPILER:STRING=${CMAKE_C_COMPILER}
   -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
   -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
   -DCMAKE_THREAD_LIBS:STRING=-lpthread
   -DCMAKE_MACOSX_RPATH:INTERNAL=1
   -DBUILD_EXAMPLES:BOOL=OFF
   -DBUILD_SHARED_LIBS:BOOL=${SV_USE_${proj}_SHARED}
   -DBUILD_LIBRARY_TYPE:STRING=${${proj}_BUILD_LIBRARY_TYPE}
   -DBUILD_TESTING:BOOL=OFF
   -DBUILD_MODULE_Draw:BOOL=OFF
   -DCMAKE_BUILD_TYPE:STRING=${${proj}_BUILD_TYPE}
   -D3RDPARTY_TCL_INCLUDE_DIR:PATH=${TCL_INCLUDE_PATH}
   -D3RDPARTY_TCL_LIBRARY_DIR:PATH=${TCL_LIBRARY_DIR}
   -D3RDPARTY_TK_INCLUDE_DIR:PATH=${TK_INCLUDE_PATH}
   -D3RDPARTY_TK_LIBRARY_DIR:PATH=${TK_LIBRARY_DIR}
   -DUSE_VTK:BOOL=ON
   -DVTK_VERSION:STRING=${VTK_MAJOR_VERSION}.${VTK_MINOR_VERSION}
   -D3RDPARTY_VTK_DIR:PATH=${SV_VTK_DIR}
   -D3RDPARTY_FREETYPE_DIR:PATH=${SV_FREETYPE_DIR}
   -DCMAKE_INSTALL_PREFIX:STRING=${${proj}_BIN_DIR}
   DEPENDS
   ${${proj}_DEPENDENCIES}
   )
 set(${proj}_SOURCE_DIR ${${proj}_SRC_DIR})
 set(SV_${proj}_DIR ${${proj}_BIN_DIR})
 set(${proj}_DIR ${${proj}_BIN_DIR}/lib/cmake/opencascade)
 mark_as_superbuild(${proj}_DIR})

else()
  # Sanity checks
  if((DEFINED SV_OpenCASCADE_DIR AND NOT EXISTS SV_${OpenCASCADE_DIR})
     AND (DEFINED SV_OpenCASCADE_DIR AND NOT EXISTS SV_${OpenCASCADE_DIR}))
    message(FATAL_ERROR "SV_OpenCASCADE_DIR variable is defined but corresponds to non-existing directory")
  endif()
  ExternalProject_Add_Empty(${proj} DEPENDS ${${proj}_DEPENDENCIES})
endif()
if(SV_INSTALL_EXTERNALS)
  ExternalProject_Install_CMake(${proj})
endif()
mark_as_superbuild(${proj}_SOURCE_DIR:PATH)

mark_as_superbuild(
  VARS SV_${proj}_DIR:PATH
  LABELS "FIND_PACKAGE"
  )
