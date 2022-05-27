set(proj_name titty)
if(NOT BUILD_TEST)
    project(${proj_name} C)
else()
    project(${proj_name})
endif()

cmake_minimum_required(VERSION 3.14)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#option(USE_SYSTEM_GOOGLETEST "Use system gtest" ON)
#option(BUILD_FULL_STATIC "Fully static binary including libc for musl" OFF)
#option(BUILD_STATIC "Fully static binary" OFF)
#option(BUILD_TEST "Build test binary" OFF)


# Platform specific defaults
if(WIN32)
    if(NOT DEFINED USE_SYSTEM_HARFBUZZ)
        set(USE_SYSTEM_HARFBUZZ OFF)
    endif()

    if(NOT DEFINED USE_PRECOMPILED_WIN_HARFBUZZ)
        set(USE_PRECOMPILED_WIN_HARFBUZZ ON)
    endif()

    if(NOT DEFINED USE_PRECOMPILED_WIN_PYTHON)
        set(USE_PRECOMPILED_WIN_PYTHON ON)
    endif()
elseif(UNIX AND NOT APPLE)
    if(NOT DEFINED USE_SYSTEM_PYTHON)
        set(USE_SYSTEM_PYTHON ON)
    endif()

    if(NOT DEFINED USE_SYSTEM_HARFBUZZ)
        set(USE_SYSTEM_HARFBUZZ ON)
    endif()

    if(NOT DEFINED USE_SYSTEM_WAYLAND)
        set(USE_SYSTEM_WAYLAND ON)
    endif()

    if(NOT DEFINED USE_SYSTEM_DBUS)
        set(USE_SYSTEM_DBUS ON)
    endif()

    if(NOT DEFINED USE_SYSTEM_LCMS2)
        set(USE_SYSTEM_LCMS2 ON)
    endif()

    if(NOT DEFINED WAYLAND)
        set(WAYLAND ON)
    endif()
endif()


if("${CMAKE_BUILD_TYPE}" STREQUAL "")
    set(CMAKE_BUILD_TYPE "Release")
    message("[INFO] CMAKE_BUILD_TYPE not set, setting to Release")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Ofast -fomit-frame-pointer -flto")
endif()

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    message("[INFO] Debug Build")
    add_compile_options(-g3 -O0)
else()
    message("[INFO] CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
endif()


if(DEFINED SANITIZE)
    if(${SANITIZE} STREQUAL undefined)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=undefined")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=undefined")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=undefined")
    elseif(${SANITIZE} STREQUAL address)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=address")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address")
    elseif(${SANITIZE} STREQUAL leak)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=leak")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=leak")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=leak")
    elseif(${SANITIZE} STREQUAL thread)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=thread")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=thread")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=thread")
    endif()
endif()

#if(${BUILD_FULL_STATIC})
#    set(USE_SYSTEM_GOOGLETEST OFF)
#    set(USE_SYSTEM_LIBUV OFF)
#    set(BUILD_SHARED_LIBS OFF)
#    set(CMAKE_EXE_LINKER_FLAGS "-static")
#    set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
#elseif(${BUILD_STATIC})
#    set(USE_SYSTEM_GOOGLETEST OFF)
#    set(USE_SYSTEM_LIBUV OFF)
#endif()

include(ExternalProject)
include(FindPkgConfig)

add_subdirectory(ext)
add_subdirectory(kitty)
add_subdirectory(glfw)
#add_subdirectory(kittens)

add_custom_target(pip-install
                  COMMAND ../fix-proj.sh
                  DEPENDS kitty glfw
                  WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
                  )

add_custom_target(run
                  COMMAND python ./pip/local/lib/python*/site-packages/titty-*-py*.egg/titty/__main__.py
                  DEPENDS pip-install
                  WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
                  )

#set(src
#    launcher.c
#    )
#
#set(lib
#    kitty
#    glfw
#    wayland_protocols
#    #kittens
#    python3.10
#    )
#
#if(WIN32)
#    list(APPEND lib
#                gdi32
#                wsock32
#                ws2_32
#                gdi32
#                wsock32
#                ws2_32
#                rpcrt4
#                iphlpapi
#                userenv
#                psapi
#    )
#elseif(UNIX AND NOT APPLE)
#    list(APPEND lib
#        dl
#        pthread
#        )
#endif()
#
#set(inc
#    ${PROJECT_BINARY_DIR}/include
#    /usr/include/python3.10
#    /usr/include/harfbuzz
#    /usr/include/freetype2
#    )
#
#add_executable(${proj_name}
#    ${src}
#        )
#
#add_dependencies(${proj_name}
#    kitty
#    glfw
#    wayland_protocols
#    #kittens
#    )
#
#set(compile_opt
#    -Wall
#    -Wextra
#    -pedantic
#    -Werror
#    -Wcast-align
#    -Werror=vla
#    -DXT_VERSION=0.0.1
#    )
#
#target_compile_options(${proj_name} PRIVATE 
#    ${compile_opt}
#    )
#
#target_include_directories(${proj_name} SYSTEM PRIVATE
#    ${inc}
#    )
#
#target_link_libraries(${proj_name}
#    ${lib}
#    )
#
#install(TARGETS ${proj_name} RUNTIME DESTINATION ${PROJECT_SOURCE_DIR}/bin/)
#
#if(${BUILD_TEST})
#    set(test_executable_name test-${proj_name})
#    list(APPEND src
#        ${test_executable_name}.cxx 
#    )
#    list(REMOVE_ITEM src
#        ${proj_name}.c
#    )
#    list(APPEND lib
#        gtest
#        gtest_main
#    )
#    list(APPEND inc
#        ${CMAKE_CURRENT_BINARY_DIR}/src
#    )
#    if(NOT ${USE_SYSTEM_GOOGLETEST})
#        list(APPEND dep googletest)
#    endif()
#    add_executable(${test_executable_name}
#        ${src}
#    )
#    target_compile_options(${test_executable_name} PRIVATE 
#        ${compile_opt}
#    )
#    target_include_directories(${test_executable_name} SYSTEM PRIVATE
#        ${inc}
#    )
#    target_link_libraries(${test_executable_name}
#        ${lib}
#    )
#endif()
