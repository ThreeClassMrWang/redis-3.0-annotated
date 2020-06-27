
# Try to find cmocka
# Once done, this will define
#
# CMOCKA_FOUND        - system has cmocka
# CMOCKA_INCLUDE_DIRS - cmocka include directories
# CMOCKA_LIBRARIES    - libraries need to use cmocka

find_path(
        CMOCKA_INCLUDE_DIR
        NAMES cmocka.h
        HINTS ${CMOCKA_ROOT}
        PATH_SUFFIXES include)

find_library(
        CMOCKA_LIBRARY
        NAMES cmocka
        HINTS ${CMOCKA_ROOT}
        PATH_SUFFIXES lib)

set(CMOCKA_INCLUDE_DIRS ${CMOCKA_INCLUDE_DIR})
set(CMOCKA_LIBRARIES ${CMOCKA_LIBRARY})

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(
        CMOCKA DEFAULT_MSG CMOCKA_LIBRARY CMOCKA_INCLUDE_DIR)

mark_as_advanced(CMOCKA_LIBRARY CMOCKA_INCLUDE_DIR)
