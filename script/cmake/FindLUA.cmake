# Try to find lua
# Once done, this will define
#
# LUA_FOUND        - system has lua
# LUA_INCLUDE_DIRS - lua include directories
# LUA_LIBRARIES    - libraries need to use lua

find_path(
        LUA_INCLUDE_DIR
        NAMES lua.h
        HINTS ${LUA_ROOT}
        PATH_SUFFIXES include)

find_library(
        LUA_LIBRARY
        NAMES lua
        HINTS ${LUA_ROOT}
        PATH_SUFFIXES lib)

set(LUA_INCLUDE_DIRS ${LUA_INCLUDE_DIR})
set(LUA_LIBRARIES ${LUA_LIBRARY})

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(
        LUA DEFAULT_MSG LUA_LIBRARY LUA_INCLUDE_DIR)

mark_as_advanced(LUA_LIBRARY LUA_INCLUDE_DIR)
