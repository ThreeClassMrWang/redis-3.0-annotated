cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pedantic -Wall -Wno-cpp -Wno-expansion-to-defined -Wno-comment")
add_link_options(-rdynamic)

set(INSTALL_BINARY_DIR bin)

# Make release
message(STATUS "Make release")
execute_process(
        COMMAND sh -c ${PROJECT_SOURCE_DIR}/src/mkreleasehdr.sh
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src
        COMMAND_ECHO STDOUT
)

# Malloc library
set(JEMALLOC jemalloc)
set(LIBC libc)

message(STATUS "Operation system is ${CMAKE_SYSTEM}")
if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    set(MALLOC ${JEMALLOC})
else()
    set(MALLOC ${LIBC})
endif ()

option(FORCE_USE_JEMALLOC "Force use jemalloc anyway" OFF)
if (${FORCE_USE_JEMALLOC})
    set(MALLOC ${JEMALLOC})
endif ()

if(${MALLOC} STREQUAL ${JEMALLOC})
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUSE_JEMALLOC")
endif()

# Link libraries
set(LINK_LIBRARIES_COMMON ${HIREDIS_LIBRARIES} ${JEMALLOC_LIBRARIES}
        ${LINENOISE_LIBRARIES} ${LUA_LIBRARIES} pthread dl m)

# Include directory
include_directories(${HIREDIS_INCLUDE_DIRS} ${JEMALLOC_INCLUDE_DIRS}
        ${LINENOISE_INCLUDE_DIRS} ${LUA_INCLUDE_DIRS} ${PROJECT_SOURCE_DIR}/src)

# Redis server
set(REDIS_SERVER redis-server)
set(REDIS_SERVER_SRCS config.c config.h fmacros.h version.h asciilogo.h
        adlist.c adlist.h ae.c ae.h anet.c anet.h dict.c dict.h redis.c redis.h
        sds.c sds.h zmalloc.c zmalloc.h lzf_c.c lzf_d.c lzf.h lzfP.h pqsort.c
        pqsort.h zipmap.c zipmap.h sha1.c sha1.h ziplist.c ziplist.h release.c
        release.h networking.c util.c util.h object.c db.c replication.c rdb.c
        rdb.h t_string.c t_list.c t_set.c t_zset.c t_hash.c aof.c pubsub.c
        multi.c debug.c sort.c intset.c intset.h syncio.c cluster.c cluster.h
        crc16.c endianconv.c endianconv.h slowlog.c slowlog.h scripting.c bio.c
        bio.h rio.c rio.h rand.c rand.h memtest.c crc64.c crc64.h bitops.c
        sentinel.c notify.c setproctitle.c blocked.c hyperloglog.c)
add_executable(${REDIS_SERVER} ${REDIS_SERVER_SRCS})
target_link_libraries(${REDIS_SERVER} ${LINK_LIBRARIES_COMMON})

# Redis client
set(REDIS_CLIENT redis-cli)
set(REDIS_CLIENT_SRCS redis.h fmacros.h version.h asciilogo.h anet.c anet.h
        sds.c sds.h adlist.c adlist.h redis-cli.c zmalloc.c zmalloc.h
        release.c release.h ae.c ae.h crc64.c crc64.h)
add_executable(${REDIS_CLIENT} ${REDIS_CLIENT_SRCS})
target_link_libraries(${REDIS_CLIENT} ${LINK_LIBRARIES_COMMON})
install(TARGETS ${REDIS_CLIENT} DESTINATION ${INSTALL_BINARY_DIR})

# Redis sentinel
set(REDIS_SENTINEL redis-sentinel)
install(TARGETS ${REDIS_CLIENT} RENAME ${REDIS_SENTINEL}
        DESTINATION ${INSTALL_BINARY_DIR})

# Redis benchmark
set(REDIS_BENCHMARK redis-benchmark)
set(REDIS_BENCHMARK_SRCS config.h redis.h fmacros.h version.h ae.c ae.h
        anet.c anet.h redis-benchmark.c sds.c sds.h adlist.c adlist.h
        zmalloc.c zmalloc.h)
add_executable(${REDIS_BENCHMARK} ${REDIS_BENCHMARK_SRCS})
target_link_libraries(${REDIS_BENCHMARK} ${LINK_LIBRARIES_COMMON})
install(TARGETS ${REDIS_BENCHMARK} DESTINATION ${INSTALL_BINARY_DIR})

# Redis check dump
set(REDIS_CHECK_DUMP redis-check-dump)
set(REDIS_CHECK_DUMP_SRCS redis-benchmark.c lzf_d.c lzf_c.c lzfP.h config.h
        ae.c ae.h crc64.c crc64.h fmacros.h config.h zmalloc.c zmalloc.h
        adlist.c adlist.h)
add_executable(${REDIS_CHECK_DUMP} ${REDIS_CHECK_DUMP_SRCS})
target_link_libraries(${REDIS_CHECK_DUMP} ${LINK_LIBRARIES_COMMON})
install(TARGETS ${REDIS_CHECK_DUMP} DESTINATION ${INSTALL_BINARY_DIR})

# Redis check aof
set(REDIS_CHECK_AOF redis-check-aof)
set(REDIS_CHECK_AOF_SRCS redis-check-aof.c fmacros.h config.h)
add_executable(${REDIS_CHECK_AOF} ${REDIS_CHECK_AOF_SRCS})
target_link_libraries(${REDIS_CHECK_AOF} ${LINK_LIBRARIES_COMMON})
install(TARGETS ${REDIS_CHECK_AOF} DESTINATION ${INSTALL_BINARY_DIR})
