#configure_file(titty_env.h.in ${PROJECT_BINARY_DIR}/include/titty_env.h)

set(src
    charsets.c
    child.c
    child-monitor.c
    cleanup.c
    colors.c
    cursor.c
    data-types.c
    desktop.c
    disk-cache.c
    fast-file-copy.c
    fontconfig.c
    fonts.c
    freetype.c
    freetype_render_ui_text.c
    gl.c
    glfw.c
    glfw-wrapper.c
    gl-wrapper.c
    glyph-cache.c
    graphics.c
    history.c
    hyperlink.c
    key_encoding.c
    keys.c
    kittens.c
    line-buf.c
    line.c
    logging.c
    loop-utils.c
    monotonic.c
    mouse.c
    parser.c
    png-reader.c
    ringbuf.c
    screen.c
    shaders.c
    state.c
    unicode-data.c
    utmp.c
    wcswidth.c
    window_logo.c
    )


set(lib
    harfbuzz
    )

if(NOT USE_SYSTEM_PYTHON)
    list(APPEND lib
        python
        )
endif()

if(WIN32)
    list(APPEND lib
                gdi32
                wsock32
                ws2_32
                gdi32
                wsock32
                ws2_32
                rpcrt4
                iphlpapi
                userenv
                psapi
    )
elseif(UNIX AND NOT APPLE)
    list(APPEND lib
        dl
        pthread
        lcms2
        )
elseif(APPLE)
    list(APPEND src
        macos_process_info.c
        )
endif()


set(inc
    ${PROJECT_BINARY_DIR}/include
    ${HARFBUZZ_INCLUDE_DIRS}
    ${PYTHON_INCLUDE_DIRS}
    )

add_library(kitty SHARED
    ${src}
        )

set(compile_opt
    -Wall
    -Wextra
    -pedantic
    -Werror
    -Wcast-align
    -Werror=vla
    )

target_compile_options(kitty PRIVATE 
    ${compile_opt}
    )

target_include_directories(kitty SYSTEM PRIVATE
    ${inc}
    )

target_link_libraries(kitty
    ${lib}
    )

install(TARGETS kitty RUNTIME DESTINATION ${PROJECT_BINARY_DIR}/py_dlib/)

#if(${BUILD_TEST})
#    set(test_executable_name test-kitty)
#    list(APPEND src
#        ${test_executable_name}.cxx 
#    )
#    list(REMOVE_ITEM src
#        kitty.c
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
