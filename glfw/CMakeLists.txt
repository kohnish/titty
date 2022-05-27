#configure_file(env.h.in ${PROJECT_BINARY_DIR}/include/env.h)

set(src
    backend_utils.c
    context.c
    dbus_glfw.c
    egl_context.c
    #glx_context.c
    ibus_glfw.c
    init.c
    input.c
    linux_desktop_settings.c
    linux_joystick.c
    linux_notify.c
    monitor.c
    monotonic.c
    #null_init.c
    #null_joystick.c
    #null_monitor.c
    #null_window.c
    osmesa_context.c
    posix_thread.c
    vulkan.c
    window.c
    wl_client_side_decorations.c
    wl_cursors.c
    wl_init.c
    wl_monitor.c
    wl_text_input.c
    wl_window.c
    #x11_init.c
    #x11_monitor.c
    #x11_window.c
    xkb_glfw.c
    )

set(lib "")

set(inc
    ${PROJECT_BINARY_DIR}/include
    )

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
    list(APPEND inc
        ${DBUS_INCLUDE_DIRS}
        )
    list(APPEND lib
        dl
        pthread
        dbus
        wayland_protocols
        xkbcommon-x11
        xkbcommon
        )
endif()

add_library(glfw SHARED
    ${src}
        )

set(compile_opt
    -Wall
    -Wextra
    -pedantic
    -Werror
    -Wcast-align
    -Werror=vla
    -D_GLFW_WAYLAND
    #-D_GLFW_BUILD_DLL
    )

target_compile_options(glfw PRIVATE 
    ${compile_opt}
    )

target_include_directories(glfw SYSTEM PRIVATE
    ${inc}
    )

target_link_libraries(glfw
    ${lib}
    )

install(TARGETS glfw RUNTIME DESTINATION ${PROJECT_SOURCE_DIR}/bin/)

if(${BUILD_TEST})
    set(test_executable_name test-glfw)
    list(APPEND src
        ${test_executable_name}.cxx 
    )
    list(REMOVE_ITEM src
        glfw.c
    )
    list(APPEND lib
        gtest
        gtest_main
    )
    list(APPEND inc
        ${CMAKE_CURRENT_BINARY_DIR}/src
    )
    if(NOT ${USE_SYSTEM_GOOGLETEST})
        list(APPEND dep googletest)
    endif()
    add_executable(${test_executable_name}
        ${src}
    )
    target_compile_options(${test_executable_name} PRIVATE 
        ${compile_opt}
    )
    target_include_directories(${test_executable_name} SYSTEM PRIVATE
        ${inc}
    )
    target_link_libraries(${test_executable_name}
        ${lib}
    )
endif()
