# ensure cmake features we need
CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

project(build_wrapper)

include(../BuildHelper.cmake)

include_directories(${CMAKE_SOURCE_DIR}/include)

find_package(libogg REQUIRED CONFIG)
add_library(Ogg::ogg ALIAS libogg::ogg)

add_subdirectory(source)