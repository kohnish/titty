if(${USE_SYSTEM_LCMS2})
    pkg_check_modules(LCMS2 lcms2 REQUIRED)
    add_library(lcms2 SHARED IMPORTED GLOBAL)
    set_target_properties(lcms2 PROPERTIES IMPORTED_LOCATION ${pkgcfg_lib_LCMS2_lcms2})
else()
    message( SEND_ERROR "LCMS2 static build not supported yet")
    #ExternalProject_Add(lcms2
    #    URL https://github.com/lcms2/lcms2/archive/refs/tags/v1.42.0.tar.gz
    #    DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/lcms2
    #    CMAKE_ARGS ${COMPILE_OPT} -DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR} -DCMAKE_INSTALL_LIBDIR=${PROJECT_BINARY_DIR}/lib -DLCMS2_BUILD_TESTS=OFF
    #    URL_HASH SHA256=371e5419708f6aaeb8656671f89400b92a9bba6443369af1bb70bcd6e4b3c764
    #)
    #add_library(uv STATIC IMPORTED GLOBAL)
    #set_target_properties(uv PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/lcms2_a.a)
    #add_dependencies(uv lcms2)
endif()
