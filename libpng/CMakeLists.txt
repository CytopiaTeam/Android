# ensure cmake features we need
CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

include(../BuildHelper.cmake)

project(build_wrapper)

set(OUT_DIR "${CMAKE_SOURCE_DIR}/out/${ANDROID_ABI}-${CMAKE_BUILD_TYPE}/")

SET(RUNTIME_OUTPUT_DIRECTORY "${OUT_DIR}")
SET(LIBRARY_OUTPUT_DIRECTORY "${OUT_DIR}")
SET(ARCHIVE_OUTPUT_DIRECTORY "${OUT_DIR}")
SET(EXECUTABLE_OUTPUT_PATH ${OUT_DIR})
SET(LIBRARY_OUTPUT_PATH ${OUT_DIR})

macro(create_fake_lib path)
    if (NOT EXISTS ${path})
        file(TOUCH ${path})
    endif ()
endmacro()

create_fake_lib("${CMAKE_BINARY_DIR}/source/libpng16d.so")
create_fake_lib("${CMAKE_BINARY_DIR}/source/libpng16.so")

add_subdirectory(source)