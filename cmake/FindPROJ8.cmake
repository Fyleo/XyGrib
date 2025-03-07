# - Find PROJ8
# Find the PROJ8 includes and library
#
#  PROJ8_INCLUDE_DIR - Where to find PROJ8 includes
#  PROJ8_LIBRARIES   - List of libraries when using PROJ8
#  PROJ8_FOUND       - True if PROJ8 was found

IF(PROJ8_INCLUDE_DIR)
  SET(PROJ8_FIND_QUIETLY TRUE)
ENDIF(PROJ8_INCLUDE_DIR)

FIND_PATH(PROJ8_INCLUDE_DIR "proj.h"
  PATHS
  $ENV{EXTERNLIBS}/include
  $ENV{EXTERNLIBS}/PROJ8/include
  ~/Library/Frameworks/include
  /Library/Frameworks/include
  /usr/local/include
  /usr/include
  /sw/include # Fink
  /opt/local/include # DarwinPorts
  /opt/csw/include # Blastwave
  /opt/include
  DOC "PROJ8 - Headers"
)

SET(PROJ8_NAMES PROJ8 proj proj_8_0)
SET(PROJ8_DBG_NAMES PROJ8D projD proj_8_0_1)

FIND_LIBRARY(PROJ8_LIBRARY NAMES ${PROJ8_NAMES}
  PATHS
  $ENV{EXTERNLIBS}
  $ENV{EXTERNLIBS}/PROJ8
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw
  /opt/local
  /opt/csw
  /opt
  PATH_SUFFIXES lib lib64
  DOC "PROJ8 - Library"
)

INCLUDE(FindPackageHandleStandardArgs)

IF(MSVC)
  # VisualStudio needs a debug version
  FIND_LIBRARY(PROJ8_LIBRARY_DEBUG NAMES ${PROJ8_DBG_NAMES}
    PATHS
    $ENV{EXTERNLIBS}/PROJ8/lib
    DOC "PROJ8 - Library (Debug)"
  )
  
  IF(PROJ8_LIBRARY_DEBUG AND PROJ8_LIBRARY)
    SET(PROJ8_LIBRARIES optimized ${PROJ8_LIBRARY} debug ${PROJ8_LIBRARY_DEBUG})
  ENDIF(PROJ8_LIBRARY_DEBUG AND PROJ8_LIBRARY)

  FIND_PACKAGE_HANDLE_STANDARD_ARGS(PROJ8 DEFAULT_MSG PROJ8_LIBRARY PROJ8_LIBRARY_DEBUG PROJ8_INCLUDE_DIR)

  MARK_AS_ADVANCED(PROJ8_LIBRARY PROJ8_LIBRARY_DEBUG PROJ8_INCLUDE_DIR)
  
ELSE(MSVC)
  # rest of the world
  SET(PROJ8_LIBRARIES ${PROJ8_LIBRARY})

  FIND_PACKAGE_HANDLE_STANDARD_ARGS(PROJ8 DEFAULT_MSG PROJ8_LIBRARY PROJ8_INCLUDE_DIR)
  
  MARK_AS_ADVANCED(PROJ8_LIBRARY PROJ8_INCLUDE_DIR)
  
ENDIF(MSVC)

IF(PROJ8_FOUND)
  SET(PROJ8_INCLUDE_DIRS ${PROJ8_INCLUDE_DIR})
ENDIF(PROJ8_FOUND)
