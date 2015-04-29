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

# - Find Tetgen Libraries
#
# === Variables ===
#
#  TETGEN_LIBRARIES, library search path
#  TETGEN_INCLUDE_DIR, include search path
#  TETGEN_{component}_LIBRARY, the library to link against
#  TETGEN_FOUND, If false, do not try to use this library.

set(proj TETGEN)
include(FindPackageHandleStandardArgs)
include(GetPrerequisites)

#-----------------------------------------------------------------------------
# Set what we need to find
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Libraries
set(${proj}_LIBNAMES tet)

# Add requestion components
set(${proj}_LIBNAMES ${${proj}_LIBNAMES} ${${proj}_FIND_COMPONENTS})

#-----------------------------------------------------------------------------
# Header
set(${proj}_HEADER "tetgen.h")

#-----------------------------------------------------------------------------
# Find Libraries
#-----------------------------------------------------------------------------
# Set paths to search for parasolid
set(${proj}_PATH "${SimVascular_SV_EXTERN_OpenLibs_BIN_DIR}/tetgen-1.5.0/")
set(${proj}_PATH2 "${SimVascular_SV_EXTERN_OpenLibs_BIN_DIR}/tetgen-1.4.3/")
if(LINUX)
	set(lib_sub_path "")
elseif(APPLE)
	set(lib_sub_path "")
elseif(WIN32 AND IS64)
	set(lib_sub_path "")
elseif(WIN32 AND NOT IS64)
	set(lib_sub_path "")
endif()

set(${proj}_POSSIBLE_LIB_PATHS ${${proj}_LIB_DIR} ${${proj}_EXTRA_PATHS} ${${proj}_INCLUDE_DIR}
	"${${proj}_PATH}/${lib_sub_path}" "${${proj}_PATH2}/${lib_sub_path}")

# add some more possible paths
set(${proj}_POSSIBLE_LIB_PATHS ${${proj}_POSSIBLE_LIB_PATHS}
	)
if(WIN32) #add some windows specific dirs/ registry stuff here
set(${proj}_POSSIBLE_LIB_PATHS ${${proj}_POSSIBLE_LIB_PATHS}
	)
endif()

set(${proj}_LIBRARIES_WORK "")
foreach(lib ${${proj}_LIBNAMES})
	#find library
	find_library(${proj}_${lib}_LIBRARY
		NAMES
		${lib}
		PATHS
		${${proj}_POSSIBLE_LIB_PATHS})
	mark_as_advanced(${proj}_${lib}_LIBRARY)
	set(${proj}_LIB_FULLNAMES ${${proj}_LIB_FULLNAMES} ${proj}_${lib}_LIBRARY)
	if(${proj}_${lib}_LIBRARY)
		set(${proj}_LIBRARIES_WORK ${${proj}_LIBRARIES_WORK} "${${proj}_${lib}_LIBRARY}")
	endif()
endforeach()

#message("${proj}_LIBRARIES_WORK: ${${proj}_LIBRARIES_WORK}")

list(LENGTH ${proj}_LIBRARIES_WORK ${proj}_NUMLIBS)
list(LENGTH ${proj}_LIBNAMES ${proj}_NUMLIBS_EXPECTED)
#message("${${proj}_NUMLIBS} ${${proj}_NUMLIBS_EXPECTED}")
if (NOT ${proj}_NUMLIBS EQUAL ${proj}_NUMLIBS_EXPECTED)
	set(${proj}_LIBRARIES_WORK "${proj}_LIBRARIES-NOTFOUND")
endif()

set(${proj}_LIBRARIES  ${${proj}_LIBRARIES_WORK} CACHE STRING 
	"${proj} libraries to link against" FORCE)

#-----------------------------------------------------------------------------
# Find Include Directory
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Setup search paths for header
if(LINUX)
	set(inc_sub_path "")
elseif(APPLE)
	set(inc_sub_path "")
elseif(WIN32 AND IS64)
	set(inc_sub_path "")
elseif(WIN32 AND NOT IS64)
	set(inc_sub_path "")
endif()		

set(${proj}_POSSIBLE_INCLUDE_PATHS ${${proj}_LIB_DIR} ${${proj}_EXTRA_PATHS}
	"${${proj}_PATH}/${inc_sub_path}"
	"${${proj}_PATH2}/${inc_sub_path}"
	)	

#-----------------------------------------------------------------------------
# Add windows Specific Search Paths
if(WIN32)
	set(${proj}_POSSIBLE_INCLUDE_PATHS ${${proj}_POSSIBLE_INCLUDE_PATHS} 
		)
endif()

#-----------------------------------------------------------------------------
# Search for header
FIND_PATH(${proj}_INCLUDE_DIR
	NAMES ${${proj}_HEADER}
	PATHS ${${proj}_POSSIBLE_INCLUDE_PATHS}
	NO_DEFAULT_PATH
	)

FIND_PATH(${proj}_INCLUDE_DIR
	NAMES ${${proj}_HEADER}
	PATHS ${${proj}_POSSIBLE_INCLUDE_PATHS}
	)


#-----------------------------------------------------------------------------
# Handle Standard Args
find_package_handle_standard_args(${proj} DEFAULT_MSG 
	${proj}_LIB_DIR
	${proj}_LIBRARIES
	${${proj}_LIBRARIES_NAMES}
	${proj}_INCLUDE_DIR)
set(${proj}_LIBRARY ${${proj}_LIBRARIES})


STRING(REGEX REPLACE
	"^.*tetgen-([0-9]\\.*[0-9]\\.*[0-9]).*$" "\\1" ${proj}_VERSION_WORK "${${proj}_tet_LIBRARY}")

string(REGEX MATCH ^[0-9]\\.*[0-9]\\.*[0-9]$ ${proj}_VERSION_DETECTED ${${proj}_VERSION_WORK})


if("${${proj}_VERSION_DETECTED}" STREQUAL "")
	message(STATUS "${proj} version could not be detected from filename")
	message(STATUS "${proj}_VERSION must be set manually")
	set(${proj}_VERSION_DETECTED "${proj}_VERSION-NOTFOUND")
endif()

#message("${proj}_VERSION_WORK ${${proj}_VERSION_WORK}") 
#message(STATUS "${proj}_VERSION_DETECTED: ${${proj}_VERSION_DETECTED}")
#message("${proj}_VERSION ${${proj}_VERSION}") 

if(NOT ${proj}_VERSION)
	set(${proj}_VERSION ${${proj}_VERSION_DETECTED} CACHE STRING 
		"${proj} Verison" FORCE)
else()
	message(STATUS "${proj}_VERSION already set: ${${proj}_VERSION}")
endif()
#message("${proj}_VERSION ${${proj}_VERSION}") 

unset(${proj}_VERSION_DETECTED)
