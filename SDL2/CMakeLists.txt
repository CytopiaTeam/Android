# ensure cmake features we need
CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

project(build_wrapper)

include(../BuildHelper.cmake)

add_subdirectory(source/sdl)
add_subdirectory(source/sdl_image)
add_subdirectory(source/sdl_ttf)


#add_custom_target(
#        copy_libs ALL
#        DEPENDS png
#        COMMAND ${CMAKE_COMMAND} -E copy "${file}" "${dest}"
#)