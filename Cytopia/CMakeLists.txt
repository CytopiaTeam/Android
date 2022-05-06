# ensure cmake features we need
CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/source/cmake" "${CMAKE_SOURCE_DIR}/source/cmake/find-modules")
include(FeatureSummary)

project(build_wrapper)

include_directories(
        ${CMAKE_SOURCE_DIR}/include
        ${CMAKE_SOURCE_DIR}/source/external/header_only
)
find_library(ANDROID_LOG_LIBRARY log REQUIRED)
find_library(ANDROID_LIBRARY_LIBRARY android REQUIRED)


find_package(libnoise CONFIG REQUIRED)
add_library(LibNoise::LibNoise ALIAS libnoise::noise)


find_package(SDL2 CONFIG REQUIRED)

add_library(LIBPNG::LIBPNG INTERFACE IMPORTED GLOBAL)
add_library(ZLIB::ZLIB INTERFACE IMPORTED GLOBAL)
get_target_property(Z_IMPORTED_LOCATION SDL2::zlib IMPORTED_LOCATION)
get_filename_component(Z_IMPORTED_LOCATION ${Z_IMPORTED_LOCATION} DIRECTORY)
target_link_libraries(ZLIB::ZLIB INTERFACE ${Z_IMPORTED_LOCATION}/libz.so)

add_library(SDL::SDL ALIAS SDL2::SDL2)
add_library(SDL::SDL_image ALIAS SDL2::SDL2_image)
add_library(SDL::TTF ALIAS SDL2::SDL2_ttf)


find_package(openal CONFIG REQUIRED)


find_package(libogg CONFIG REQUIRED)
find_package(libvorbis CONFIG REQUIRED)
add_library(VorbisFile::VorbisFile INTERFACE IMPORTED GLOBAL)
target_link_libraries(VorbisFile::VorbisFile INTERFACE libvorbis::vorbis libogg::ogg)


# Joysticks were causing trouble on android.
add_definitions(-DSDL_JOYSTICK=0)


add_subdirectory(source)
feature_summary(WHAT ALL FILENAME ${CMAKE_BINARY_DIR}/feature_summary.log)