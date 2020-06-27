cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

project(redis-3.0-annotated-cmake VERSION 3.0)

#######################################################
# Config
set(DEPS_MAKE_THREADS 4)

#######################################################
# Common config

set(BUILD_SCRIPTS ${PROJECT_SOURCE_DIR}/script)
set(BUILD_CMAKE_SCRIPTS_ROOT ${BUILD_SCRIPTS}/cmake)
set(LIB_ROOT ${PROJECT_SOURCE_DIR}/lib)
file(MAKE_DIRECTORY ${LIB_ROOT})

list(APPEND CMAKE_MODULE_PATH "${BUILD_CMAKE_SCRIPTS_ROOT}")
message(STATUS "CMAKE_MODULE_PATH = ${CMAKE_MODULE_PATH}")

######################################################
# Build dependencies

# Hiredis
set(HIREDIS_ROOT ${LIB_ROOT}/hiredis)
file(MAKE_DIRECTORY ${HIREDIS_ROOT})

find_package(HIREDIS)
if (NOT HIREDIS_FOUND)
    include(${BUILD_CMAKE_SCRIPTS_ROOT}/hiredis.cmake)
    find_package(HIREDIS)
endif ()

message(STATUS "HIREDIS_INCLUDE_DIRS = ${HIREDIS_INCLUDE_DIRS}")
message(STATUS "HIREDIS_LIBRARIES = ${HIREDIS_LIBRARIES}")

# Jemalloc
set(JEMALLOC_ROOT ${LIB_ROOT}/jemalloc)
file(MAKE_DIRECTORY ${JEMALLOC_ROOT})

find_package(JEMALLOC)
if (NOT JEMALLOC_FOUND)
    include(${BUILD_CMAKE_SCRIPTS_ROOT}/jemalloc.cmake)
    find_package(JEMALLOC)
endif ()

message(STATUS "JEMALLOC_INCLUDE_DIRS = ${JEMALLOC_INCLUDE_DIRS}")
message(STATUS "JEMALLOC_LIBRARIES = ${JEMALLOC_LIBRARIES}")

# Linenoise
set(LINENOISE_ROOT ${LIB_ROOT}/linenoise)
file(MAKE_DIRECTORY ${LINENOISE_ROOT})

find_package(LINENOISE)
if (NOT LINENOISE_FOUND)
    include(${BUILD_CMAKE_SCRIPTS_ROOT}/linenoise.cmake)
    find_package(LINENOISE)
endif ()

message(STATUS "LINENOISE_INCLUDE_DIRS = ${LINENOISE_INCLUDE_DIRS}")
message(STATUS "LINENOISE_LIBRARIES = ${LINENOISE_LIBRARIES}")

# Lua
set(LUA_ROOT ${LIB_ROOT}/lua)
file(MAKE_DIRECTORY ${LUA_ROOT})

find_package(LUA)
if (NOT LUA_FOUND)
    include(${BUILD_CMAKE_SCRIPTS_ROOT}/lua.cmake)
    find_package(LUA)
endif ()

message(STATUS "LUA_INCLUDE_DIRS= ${LUA_INCLUDE_DIRS}")
message(STATUS "LUA_LIBRARIES = ${LUA_LIBRARIES}")

###############################################################################
# Add redis subdirectory
add_subdirectory(src)
