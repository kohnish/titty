#if(${USE_SYSTEM_WAYLAND})
    pkg_get_variable(PROTOCOL_DIR wayland-protocols pkgdatadir)
    pkg_get_variable(SCANNER_PATH wayland-scanner wayland_scanner)
#else()
#    ExternalProject_Add(wayland_build
#        URL https://gitlab.freedesktop.org/wayland/wayland/-/archive/1.20.0/wayland-1.20.0.tar.bz2
#        DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/wayland
#        URL_HASH SHA256=473d1c4e26e19d4620078f402e0120d93d791e419cf8c7def4d92ce6b0941f64
#        BUILD_IN_SOURCE 1
#        CONFIGURE_COMMAND ""
#        BUILD_COMMAND meson build/ --prefix=${PROJECT_BINARY_DIR} -Dlibdir=lib -Ddefault_library=static
#        INSTALL_COMMAND ninja -C build/ install
#        )
#    add_library(wayland-client STATIC IMPORTED GLOBAL)
#    add_library(wayland-cursor STATIC IMPORTED GLOBAL)
#    add_library(wayland-egl STATIC IMPORTED GLOBAL)
#    add_library(wayland-server STATIC IMPORTED GLOBAL)
#    add_executable(wayland-scanner IMPORTED GLOBAL)
#    set_target_properties(wayland-client PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/libwayland-client.a)
#    set_target_properties(wayland-cursor PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/libwayland-cursor.a)
#    set_target_properties(wayland-egl PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/libwayland-egl.a)
#    set_target_properties(wayland-server PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/libwayland-server.a)
#    add_dependencies(wayland-client wayland-build)
#    add_dependencies(wayland-cursor wayland-build)
#    add_dependencies(wayland-egl wayland-build)
#    add_dependencies(wayland-server wayland-build)
#    add_dependencies(wayland-scanner wayland-build)
#
#    ExternalProject_Add(wayland_protocols_get
#        URL https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/1.25/wayland-protocols-1.25.tar.bz2
#        DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/wayland_protocols
#        URL_HASH SHA256=633c9bed0efb8e773c5780d4442051264d179c154b7d1896ca3b56b5d4da4718
#        BUILD_IN_SOURCE 1
#        CONFIGURE_COMMAND ""
#        BUILD_COMMAND ""
#        INSTALL_COMMAND ""
#        )
#    set(PROTOCOL_DIR ${CMAKE_CURRENT_BINARY_DIR}/wayland_protocols_get-prefix/src/wayland_protocols_get)
#    set(SCANNER_PATH ${PROJECT_BINARY_DIR}/bin/wayland-scanner)
#    set(wayland_protocols_deps "wayland_protocols_get")
#endif()

set(OUT_PATH ${PROJECT_BINARY_DIR}/wayland_protocols)
set(PROTOCOL_SOURCES
    ${OUT_PATH}/wayland-xdg-shell-client-protocol.c
    ${OUT_PATH}/wayland-xdg-decoration-unstable-v1-client-protocol.c
    ${OUT_PATH}/wayland-relative-pointer-unstable-v1-client-protocol.c
    ${OUT_PATH}/wayland-pointer-constraints-unstable-v1-client-protocol.c
    ${OUT_PATH}/wayland-idle-inhibit-unstable-v1-client-protocol.c
    ${OUT_PATH}/wayland-primary-selection-unstable-v1-client-protocol.c
    ${OUT_PATH}/wayland-text-input-unstable-v3-client-protocol.c
    )
add_custom_command(OUTPUT ${PROTOCOL_SOURCES}
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/gen_code.sh ${SCANNER_PATH} ${PROTOCOL_DIR} ${OUT_PATH} ${PROJECT_BINARY_DIR}/include
    DEPENDS ${wayland_protocols_deps}
    )
add_library(wayland_protocols STATIC ${PROTOCOL_SOURCES})
target_link_libraries(wayland_protocols wayland-client)
target_include_directories(wayland_protocols PUBLIC ${PROJECT_BINARY_DIR}/include)
set_property(TARGET wayland_protocols PROPERTY POSITION_INDEPENDENT_CODE ON)

