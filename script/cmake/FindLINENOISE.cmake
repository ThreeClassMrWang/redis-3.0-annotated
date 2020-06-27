# Try to find linenoise
# Once done, this will define
#
# LINENOISE_FOUND        - system has linenoise
# LINENOISE_INCLUDE_DIRS - linenoise include directories
# LINENOISE_LIBRARIES    - libraries need to use linenoise

find_path(
        LINENOISE_INCLUDE_DIR
        NAMES linenoise
        HINTS ${LINENOISE_ROOT}/include)

find_library(
        LINENOISE_LIBRARY
        NAMES linenoise
        HINTS ${LINENOISE_ROOT}/lib)

set(LINENOISE_INCLUDE_DIRS ${LINENOISE_INCLUDE_DIR})
set(LINENOISE_LIBRARIES ${LINENOISE_LIBRARY})

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(
        LINENOISE DEFAULT_MSG LINENOISE_LIBRARY LINENOISE_INCLUDE_DIR)

mark_as_advanced(LINENOISE_LIBRARY LINENOISE_INCLUDE_DIR)
