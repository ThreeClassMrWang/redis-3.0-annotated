# Build and install linenoise

MESSAGE(" ")
MESSAGE("==== START BUILD LINENOISE ==========================================")

set(LINENOISE_SOURCE_DIR ${PROJECT_SOURCE_DIR}/deps/linenoise)

execute_process(
        COMMAND make -j${DEPS_MAKE_THREADS}
        WORKING_DIRECTORY ${LINENOISE_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)
execute_process(
        COMMAND ar -r liblinenoise.a linenoise.o
        WORKING_DIRECTORY ${LINENOISE_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)

set(LINENOISE_SOURCE_HEADER ${LINENOISE_SOURCE_DIR}/linenoise.h)
set(LINENOISE_BINARY_LIBRARY ${LINENOISE_SOURCE_DIR}/liblinenoise.a)

file(MAKE_DIRECTORY ${LINENOISE_ROOT}/include)
file(MAKE_DIRECTORY ${LINENOISE_ROOT}/lib)
file(COPY ${LINENOISE_SOURCE_HEADER} DESTINATION ${LINENOISE_ROOT}/include/linenoise)
file(COPY ${LINENOISE_BINARY_LIBRARY} DESTINATION ${LINENOISE_ROOT}/lib)

MESSAGE("==== END BUILD LINENOISE ============================================")
MESSAGE(" ")

