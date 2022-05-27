if(USE_SYSTEM_PYTHON)
    pkg_check_modules(PYTHON python REQUIRED)
    add_library(python SHARED IMPORTED GLOBAL)
elseif(USE_PRECOMPILED_WIN_PYTHON)
    ExternalProject_Add(python_src_get
        URL https://www.python.org/ftp/python/3.9.13/Python-3.9.13.tar.xz
        DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/python_src
        BUILD_IN_SOURCE ON
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND sh -c "mkdir -p ${PROJECT_BINARY_DIR}/include && cp -rp Include/* ${PROJECT_BINARY_DIR}/include/ && cp PC/pyconfig.h ${PROJECT_BINARY_DIR}/include/"
        URL_HASH SHA256=125b0c598f1e15d2aa65406e83f792df7d171cdf38c16803b149994316a3080f
    )
    set(PYTHON_INCLUDE_DIRS ${PROJECT_BINARY_DIR}/include)

    ExternalProject_Add(python_get
        URL https://www.python.org/ftp/python/3.9.13/python-3.9.13-embed-win32.zip
        DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/python
        BUILD_IN_SOURCE ON
        CONFIGURE_COMMAND ""
        BUILD_COMMAND "pwd"
        INSTALL_COMMAND sh -c "mkdir -p ${PROJECT_BINARY_DIR}/lib && cp * ${PROJECT_BINARY_DIR}/lib/"
        URL_HASH SHA256=f8ed5e019d7bc6dba1d7dfa5d59052b5241c37e8eaa5293133c898ac7acedb98
    )
    add_library(python STATIC IMPORTED GLOBAL)
    set_target_properties(python PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/libpython-0.dll)
    add_dependencies(python python_get python_src_get)
else()
    message( SEND_ERROR "Python static build not supported yet")
    #ExternalProject_Add(python
    #    URL https://github.com/python/python/archive/refs/tags/v1.42.0.tar.gz
    #    DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/cache/python
    #    CMAKE_ARGS ${COMPILE_OPT} -DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR} -DCMAKE_INSTALL_LIBDIR=${PROJECT_BINARY_DIR}/lib -DPYTHON_BUILD_TESTS=OFF
    #    URL_HASH SHA256=371e5419708f6aaeb8656671f89400b92a9bba6443369af1bb70bcd6e4b3c764
    #)
    #add_library(uv STATIC IMPORTED GLOBAL)
    #set_target_properties(uv PROPERTIES IMPORTED_LOCATION ${PROJECT_BINARY_DIR}/lib/python_a.a)
    #add_dependencies(uv python)
endif()
