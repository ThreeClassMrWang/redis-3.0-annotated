# Build and install cmocka

MESSAGE(" ")
MESSAGE("==== START BUILD CMOCKA ============================================")

set(CMOCKA_SOURCE_DIR ${PROJECT_SOURCE_DIR}/deps/cmocka)

set(CMOCKA_BUILD_DIR ${CMOCKA_SOURCE_DIR}/build-cmake)
file(MAKE_DIRECTORY ${CMOCKA_BUILD_DIR})

execute_process(
        COMMAND cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${CMOCKA_ROOT} ..
        WORKING_DIRECTORY ${CMOCKA_BUILD_DIR}
        COMMAND_ECHO STDOUT
)

execute_process(
        COMMAND make -j${DEPS_MAKE_THREADS}
        WORKING_DIRECTORY ${CMOCKA_BUILD_DIR}
        COMMAND_ECHO STDOUT
)

execute_process(
        COMMAND make install
        WORKING_DIRECTORY ${CMOCKA_BUILD_DIR}
        COMMAND_ECHO STDOUT
)
MESSAGE("==== END BUILD CMOCKA ==============================================")
MESSAGE(" ")
