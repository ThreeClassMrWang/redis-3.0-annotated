cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

message(STATUS "Enable unit test")

include_directories(${CMOCKA_INCLUDE_DIRS} ${PROJECT_SOURCE_DIR}/src/unit)
set(TEST_LINK_LIBRARIES_COMMON ${LINK_LIBRARIES_COMMON} ${CMOCKA_LIBRARIES})

set(REDIS_UNIT_TEST redis-unit-test)
set(REDIS_UNIT_TEST_SRCS redis_unit_test.c)
add_executable(${REDIS_UNIT_TEST} ${REDIS_UNIT_TEST_SRCS})
target_link_libraries(${REDIS_UNIT_TEST} ${TEST_LINK_LIBRARIES_COMMON})