# ensure cmake features we need
CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

include(../BuildHelper.cmake)

project(build_wrapper)

include_directories(${CMAKE_SOURCE_DIR}/include)

string(TOLOWER ${CMAKE_BUILD_TYPE} ANDROID_BUILD_DIR)

add_library(Ogg::ogg INTERFACE IMPORTED GLOBAL)
target_include_directories(Ogg::ogg INTERFACE "${CMAKE_SOURCE_DIR}/../libogg/source/include")
target_link_libraries(Ogg::ogg INTERFACE ${CMAKE_SOURCE_DIR}/../build/libogg/intermediates/cmake/${ANDROID_BUILD_DIR}/obj/${ANDROID_ABI}/libogg.so)

add_subdirectory(source)