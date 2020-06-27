# Build and install hiredis

MESSAGE(" ")
MESSAGE("==== START BUILD HIREDIS ============================================")

set(HIREDIS_SOURCE_DIR ${PROJECT_SOURCE_DIR}/deps/hiredis)

execute_process(
        COMMAND make -j${DEPS_MAKE_THREADS}
        COMMAND make install PREFIX=${HIREDIS_ROOT}
        WORKING_DIRECTORY ${HIREDIS_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)

# Remove shared library
file(GLOB SHARED_LIBRARIES ${HIREDIS_ROOT}/lib/*.so ${HIREDIS_ROOT}/lib/*.so.*)
message(STATUS "Delete shared libraries: ${SHARED_LIBRARIES}")
file(REMOVE ${SHARED_LIBRARIES})

MESSAGE("==== END BUILD HIREDIS ==============================================")
MESSAGE(" ")
