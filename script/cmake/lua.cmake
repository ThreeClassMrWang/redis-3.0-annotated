# Build and install lua

MESSAGE(" ")
MESSAGE("==== START BUILD LUA ============================================")

set(LUA_SOURCE_DIR ${PROJECT_SOURCE_DIR}/deps/lua)
if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL SunOS)
    set(LUA_CFLAGS -D__C99FEATURES__=1)
endif()
set(LUA_CFLAGS ${LUA_CFLAGS} -O2 -Wall -DLUA_ANSI)

file(WRITE ${LUA_SOURCE_DIR}/pre_build.sh "cat Makefile | sed 's#^INSTALL_TOP=.*$#INSTALL_TOP=\ ${LUA_ROOT}#g' | sed 's#^PLAT=.*$#PLAT=\ linux#g' > Makefile.linux")

execute_process(
        COMMAND sh ${LUA_SOURCE_DIR}/pre_build.sh
        WORKING_DIRECTORY ${LUA_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)

execute_process(
        COMMAND make -j${DEPS_MAKE_THREADS} -f Makefile.linux all "CFLAGS=${LUA_CFLAGS}"
        WORKING_DIRECTORY ${LUA_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)

execute_process(
        COMMAND make -f Makefile.linux install
        WORKING_DIRECTORY ${LUA_SOURCE_DIR}
        COMMAND_ECHO STDOUT
)

MESSAGE("==== END BUILD LUA ==============================================")
MESSAGE(" ")
