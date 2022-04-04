# ensure cmake features we need
CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/source/cmake" "${CMAKE_SOURCE_DIR}/source/cmake/find-modules")

project(build_wrapper)

include_directories(
        ${CMAKE_SOURCE_DIR}/include
        ${CMAKE_SOURCE_DIR}/source/external/header_only
)

## Set some helper variables.
#string(TOLOWER "${CMAKE_SYSTEM_NAME}" targetSystem)
#set(projectDir "${CMAKE_CURRENT_LIST_DIR}")
#set(sourceDir "${projectDir}/source")
#set(targetName "SimpleExample")
#set(binDir "${projectDir}/bin")
#
## Define executable output dir.
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${binDir}/${targetSystem}")
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${binDir}/${targetSystem}")
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL "${binDir}/${targetSystem}")
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${binDir}/${targetSystem}_debug")

#find_library(OpenGLES2_LIBRARY GLESv2 REQUIRED)
#find_library(OpenGLES3_LIBRARY GLESv3 REQUIRED)
find_library(ANDROID_LOG_LIBRARY log REQUIRED)
find_library(ANDROID_LIBRARY_LIBRARY android REQUIRED)
find_library(zlib z)

string(TOLOWER ${CMAKE_BUILD_TYPE} ANDROID_BUILD_DIR)

function(add_android_lib interface_name libname filename include_dir)
    add_library(${interface_name} INTERFACE IMPORTED GLOBAL)

    target_include_directories(${interface_name} INTERFACE ${include_dir})
    target_link_libraries(
            ${interface_name} INTERFACE
            ${CMAKE_SOURCE_DIR}/../build/${libname}/intermediates/cmake/${ANDROID_BUILD_DIR}/obj/${ANDROID_ABI}/${filename}
    )
endfunction()

# SDL2
# build/SDL2/intermediates/cmake/debug/obj/x86/libSDL2.so
add_android_lib(SDL::SDL SDL2 libSDL2.so "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl/include")
add_android_lib(SDL::SDL_image SDL2 libSDL2_image.so "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl_image")
add_android_lib(SDL::TTF SDL2 libSDL2_ttf.so "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl_ttf")
add_android_lib(ZLIB::ZLIB SDL2 libz.so "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl_image/external/zlib-1.2.12")

# libnoise
# build/libnoise/intermediates/cmake/release/obj/x86/libnoise.so
add_android_lib(LibNoise::LibNoise libnoise libnoise.so "${CMAKE_SOURCE_DIR}/../libnoise/source/src/noise")
# zlib
# build/zlib/intermediates/cmake/release/obj/x86/libz.so


# libpng
# build/libpng/intermediates/cmake/debug/obj/x86/libpng.so
# build/libpng/intermediates/cmake/debug/obj/arm64-v8a/libpng16d.so
set(LIBPNG_DISTRIBUTION_DIR ${CMAKE_SOURCE_DIR}/../build/libpng/intermediates/cmake/)
if (CMAKE_BUILD_TYPE EQUAL "DEBUG")
    set(LIBPNG_LOCATION ${LIBPNG_DISTRIBUTION_DIR}/${ANDROID_BUILD_DIR}/obj/${ANDROID_ABI}/libpng16.so)
else ()
    set(LIBPNG_LOCATION ${LIBPNG_DISTRIBUTION_DIR}/${ANDROID_BUILD_DIR}/obj/${ANDROID_ABI}/libpng16d.so)
endif ()
add_library(LIBPNG::LIBPNG INTERFACE IMPORTED GLOBAL)
target_include_directories(LIBPNG::LIBPNG INTERFACE "${CMAKE_SOURCE_DIR}/../SDL2/source/sdl_image/external/libpng-1.6.37")
target_link_libraries(LIBPNG::LIBPNG INTERFACE ${LIBPNG_LOCATION})

# openal
#add_android_lib(OPENAL openal-soft libopenal.so "${CMAKE_SOURCE_DIR}/../openal-soft/source/include")

# ogg
#add_android_lib(LIBOGG libogg libogg.so "${CMAKE_SOURCE_DIR}/../source/sdl/include")

# vorbis
# ./build/libvorbis/intermediates/cmake/debug/obj/x86/libvorbis.so
#add_android_lib(LIBVORBIS libvorbis libvorbis.so "${CMAKE_SOURCE_DIR}/../source/sdl/include")
#add_android_lib(LIBVORBISFILE libvorbis libvorbisfile.so "${CMAKE_SOURCE_DIR}/../source/sdl/include")

# Joysticks were causing trouble on android.
add_definitions(-DSDL_JOYSTICK=0)

add_subdirectory(source)