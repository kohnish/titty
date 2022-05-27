if(${USE_SYSTEM_DBUS})
    pkg_check_modules(DBUS dbus-1 REQUIRED)
    add_library(dbus SHARED IMPORTED GLOBAL)
    set_target_properties(dbus PROPERTIES IMPORTED_LOCATION ${pkgcfg_lib_DBUS_dbus-1})
else()
    message( SEND_ERROR "DBUS static build not supported yet")
    #ExternalProject_Add(dbus
    #    URL https://github.com/dbus/dbus/archive/refs/tags/v1.42.0.tar.gz
    #    DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/dbus
    #    CMAKE_ARGS ${COMPILE_OPT} -DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR} -DCMAKE_INSTALL_LIBDIR=${PROJECT_BINARY_DIR}/lib -DDBUS_BUILD_TESTS=OFF
    #    URL_HASH SHA256=371e5419708f6aaeb8656671f89400b92a9bba6443369af1bb70bcd6e4b3c764
    #)
    #add_library(uv STATIC IMPORTED GLOBAL)
    #set_target_properties(uv PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/dbus_a.a)
    #add_dependencies(uv dbus)
endif()
