if(USE_SYSTEM_HARFBUZZ)
    pkg_check_modules(HARFBUZZ harfbuzz REQUIRED)
    add_library(harfbuzz SHARED IMPORTED GLOBAL)
    set_target_properties(harfbuzz PROPERTIES IMPORTED_LOCATION ${pkgcfg_lib_HARFBUZZ_harfbuzz})
elseif(USE_PRECOMPILED_WIN_HARFBUZZ)
    ExternalProject_Add(harfbuzz_get
        URL https://github.com/harfbuzz/harfbuzz/releases/download/4.3.0/harfbuzz-win32-4.3.0.zip
        DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/harfbuzz
        BUILD_IN_SOURCE ON
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND sh -c "mkdir -p ${PROJECT_BINARY_DIR}/lib && cp * ${PROJECT_BINARY_DIR}/lib/"
        URL_HASH SHA256=68dc3e28ed8ec9a7683ad773371e3b990798e25bad26c5eb8edf43f5a247d2cc
    )
    add_library(harfbuzz STATIC IMPORTED GLOBAL)
    set_target_properties(harfbuzz PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/libharfbuzz-0.dll)
    add_dependencies(harfbuzz harfbuzz_get)
else()
    message( SEND_ERROR "Harfbuzz static build not supported yet")
    #ExternalProject_Add(harfbuzz
    #    URL https://github.com/harfbuzz/harfbuzz/archive/refs/tags/v1.42.0.tar.gz
    #    DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/harfbuzz
    #    CMAKE_ARGS ${COMPILE_OPT} -DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR} -DCMAKE_INSTALL_LIBDIR=${PROJECT_BINARY_DIR}/lib -DHARFBUZZ_BUILD_TESTS=OFF
    #    URL_HASH SHA256=371e5419708f6aaeb8656671f89400b92a9bba6443369af1bb70bcd6e4b3c764
    #)
    #add_library(uv STATIC IMPORTED GLOBAL)
    #set_target_properties(uv PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/harfbuzz_a.a)
    #add_dependencies(uv harfbuzz)
endif()
