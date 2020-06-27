# - Try to find jemalloc headers and libraries.
#
# Usage of this module as follows:
#
#     find_package(JeMalloc)
#
# Variables used by this module, they can change the default behaviour and need
# to be set before calling find_package:
#
#  JEMALLOC_ROOT_DIR Set this variable to the root installation of
#                    jemalloc if the module has problems finding
#                    the proper installation path.
#
# Variables defined by this module:
#
#  JEMALLOC_FOUND             System has jemalloc libs/headers
#  JEMALLOC_LIBRARIES         The jemalloc library/libraries
#  JEMALLOC_INCLUDE_DIRS       The location of jemalloc headers

find_path(JEMALLOC_ROOT_DIR
        NAMES include/jemalloc/jemalloc.h
        HINTS ${JEMALLOC_ROOT})

find_library(JEMALLOC_LIBRARIES
        NAMES jemalloc
        HINTS ${JEMALLOC_ROOT}/lib
        )

find_path(JEMALLOC_INCLUDE_DIRS
        NAMES jemalloc/jemalloc.h
        HINTS ${JEMALLOC_ROOT}/include
        )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(JEMALLOC DEFAULT_MSG
        JEMALLOC_LIBRARIES
        JEMALLOC_INCLUDE_DIRS
        )

mark_as_advanced(
        JEMALLOC_ROOT_DIR
        JEMALLOC_LIBRARIES
        JEMALLOC_INCLUDE_DIRS
)
