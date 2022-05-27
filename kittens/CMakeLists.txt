#configure_file(titty_env.h.in ${PROJECT_BINARY_DIR}/include/titty_env.h)

set(src
    choose/main.c
    choose/output.c
    choose/score.c
    choose/unix_compat.c
    #choose/windows_compat.c
    diff/speedup.c
    transfer/rsync.c
    unicode_input/unicode_names.c
    )

set(lib
    #python
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
    list(APPEND lib
        dl
        pthread
        )
endif()

set(inc
    ${PROJECT_BINARY_DIR}/include
    ../kitty
    /usr/include/python3.10
    /usr/include/harfbuzz
    /usr/include/freetype2
    )

add_library(kittens SHARED
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

target_compile_options(kittens PRIVATE 
    ${compile_opt}
    )

target_include_directories(kittens SYSTEM PRIVATE
    ${inc}
    )

target_link_libraries(kittens
    ${lib}
    )

install(TARGETS kittens RUNTIME DESTINATION ${PROJECT_SOURCE_DIR}/bin/)

if(${BUILD_TEST})
    set(test_executable_name test-kittens)
    list(APPEND src
        ${test_executable_name}.cxx 
    )
    list(REMOVE_ITEM src
        kittens.c
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
