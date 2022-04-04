# ensure cmake features we need
CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/source/cmake" "${CMAKE_SOURCE_DIR}/source/cmake/find-modules")

project(build_wrapper)

include_directories(
        ${CMAKE_SOURCE_DIR}/include
        ${CMAKE_SOURCE_DIR}/source/external/header_only
)
find_library(ANDROID_LOG_LIBRARY log REQUIRED)
find_library(ANDROID_LIBRARY_LIBRARY android REQUIRED)

if (${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    set(ANDROID_BUILD_DIR "debug")
else ()
    set(ANDROID_BUILD_DIR "release")
endif ()

function(add_android_lib interface_name libname filename include_dir)
    add_library(${interface_name} INTERFACE IMPORTED GLOBAL)

    target_include_directories(${interface_name} INTERFACE ${include_dir})
    target_link_libraries(
            ${interface_name} INTERFACE
            ${CMAKE_SOURCE_DIR}/../build/${libname}/intermediates/cmake/${ANDROID_BUILD_DIR}/obj/${ANDROID_ABI}/${filename}
    )
endfunction()

if (${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    set(LIBPNG_NAME "libpng16d.so")
else ()
    set(LIBPNG_NAME "libpng16.so")
endif ()

# SDL2
# build/SDL2/intermediates/cmake/debug/obj/x86/libSDL2.so
add_android_lib(SDL::SDL SDL2 libSDL2.so "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl/include")
add_android_lib(SDL::SDL_image SDL2 libSDL2_image.so "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl_image")
add_android_lib(SDL::TTF SDL2 libSDL2_ttf.so "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl_ttf")
add_android_lib(ZLIB::ZLIB SDL2 libz.so "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl_image/external/zlib-1.2.12")
add_android_lib(LIBPNG::LIBPNG SDL2 ${LIBPNG_NAME} "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl_image/external/libpng-1.6.37")

# libnoise
# build/libnoise/intermediates/cmake/release/obj/x86/libnoise.so
add_android_lib(LibNoise::LibNoise libnoise libnoise.so "${CMAKE_SOURCE_DIR}/../libnoise/source/src/noise")

# openal
add_android_lib(OpenAL::OpenAL openal-soft libopenal.so "${CMAKE_SOURCE_DIR}/../openal-soft/source/include")

# ogg
add_android_lib(LIBOGG::LIBOGG libogg libogg.so "${CMAKE_SOURCE_DIR}/../libogg/source/include")

# vorbis
# ./build/libvorbis/intermediates/cmake/debug/obj/x86/libvorbis.so
add_android_lib(VorbisFile::VorbisFile libvorbis libvorbis.so "${CMAKE_SOURCE_DIR}/../libvorbis/source/include")
target_link_libraries(VorbisFile::VorbisFile INTERFACE ${CMAKE_SOURCE_DIR}/../build/libvorbis/intermediates/cmake/${ANDROID_BUILD_DIR}/obj/${ANDROID_ABI}/libvorbisfile.so)
target_link_libraries(VorbisFile::VorbisFile INTERFACE LIBOGG::LIBOGG)

# Joysticks were causing trouble on android.
add_definitions(-DSDL_JOYSTICK=0)

add_subdirectory(source)