# Build and install jemalloc

MESSAGE(" ")
MESSAGE("==== START BUILD JEMALLOC ===========================================")

set(JEMALLOC_SOURCE_DIR ${PROJECT_SOURCE_DIR}/deps/jemalloc)
set(JEMALLOC_CFLAGS "-std=gnu99 -Wall -pipe -g3 -O3 -funroll-loops")

execute_process(
        COMMAND ./configure --with-jemalloc-prefix=je_ --enable-cc-silence -prefix=${JEMALLOC_ROOT} CFLAGS=${JEMALLOC_CFLAGS}
        WORKING_DIRECTORY ${JEMALLOC_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)

execute_process(
        COMMAND make -j${DEPS_MAKE_THREADS} CFLAGS=${JEMALLOC_CFLAGS} lib/libjemalloc.a
        WORKING_DIRECTORY ${JEMALLOC_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)
execute_process(
        COMMAND make install
        WORKING_DIRECTORY ${JEMALLOC_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)

# Remove shared library
file(GLOB SHARED_LIBRARIES ${JEMALLOC_ROOT}/lib/*.so ${JEMALLOC_ROOT}/lib/*.so.*)
message(STATUS "Delete shared libraries: ${SHARED_LIBRARIES}")
file(REMOVE ${SHARED_LIBRARIES})

MESSAGE("==== END BUILD JEMALLOC =============================================")
MESSAGE(" ")
