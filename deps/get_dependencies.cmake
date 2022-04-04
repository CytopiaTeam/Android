cmake_minimum_required(VERSION 3.18)
include(FetchContent)

set(SRC_DIR "${CMAKE_SOURCE_DIR}/..")

FetchContent_Populate(
       Cytopia
       GIT_REPOSITORY https://github.com/CytopiaTeam/Cytopia.git
       SOURCE_DIR "${SRC_DIR}/Cytopia/source"
)

FetchContent_Populate(
        freetype
        GIT_REPOSITORY https://github.com/freetype/freetype.git
        SOURCE_DIR "${SRC_DIR}/SDL2/source/freetype"
)

FetchContent_Populate(
        SDL2
        GIT_REPOSITORY https://github.com/libsdl-org/SDL.git
        GIT_TAG main
        SOURCE_DIR "${SRC_DIR}/SDL2/source/sdl"
)
FetchContent_Populate(
        SDL_image
        GIT_REPOSITORY https://github.com/libsdl-org/SDL_image.git
        GIT_TAG main
        SOURCE_DIR "${SRC_DIR}/SDL2/source/sdl_image"
)
FetchContent_Populate(
        SDL2_ttf
        GIT_REPOSITORY https://github.com/libsdl-org/SDL_ttf.git
        GIT_TAG main
        SOURCE_DIR "${SRC_DIR}/SDL2/source/sdl_ttf"
)

FetchContent_Populate(
       libnoise
       GIT_REPOSITORY https://github.com/qknight/libnoise.git
       SOURCE_DIR "${SRC_DIR}/libnoise/source"
)
FetchContent_Populate(
       zlib
       URL https://www.zlib.net/zlib-1.2.12.tar.gz
       URL_MD5 5fc414a9726be31427b440b434d05f78
       SOURCE_DIR "${SRC_DIR}/zlib/source"
)
FetchContent_Populate(
       openal-soft
       URL https://github.com/kcat/openal-soft/archive/openal-soft-1.20.1.tar.gz
       URL_MD5 9431604d354437b12032c352203c2abb
       SOURCE_DIR "${SRC_DIR}/openal-soft/source"
)

FetchContent_Populate(
       libogg
       GIT_REPOSITORY https://github.com/xiph/ogg.git
       SOURCE_DIR "${SRC_DIR}/libogg/source"
)

FetchContent_Populate(
       libvorbis
       GIT_REPOSITORY https://github.com/xiph/vorbis.git
       SOURCE_DIR "${SRC_DIR}/libvorbis/source"
)

FetchContent_Populate(
       libpng
       URL https://nchc.dl.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.xz
       URL_MD5 015e8e15db1eecde5f2eb9eb5b6e59e9
       SOURCE_DIR "${SRC_DIR}/libpng/source"
)