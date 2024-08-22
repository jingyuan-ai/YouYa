macro(get_git_hash _git_hash)
    find_package(Git QUIET)
    if(GIT_FOUND)
      execute_process(
        COMMAND ${GIT_EXECUTABLE} log -1 --pretty=format:%h
        OUTPUT_VARIABLE ${_git_hash}
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
        WORKING_DIRECTORY
          ${CMAKE_CURRENT_SOURCE_DIR}
        )
    endif()
endmacro()

macro(get_git_branch _git_branch)
    find_package(Git QUIET)
    if(GIT_FOUND)
      execute_process(
        COMMAND ${GIT_EXECUTABLE} symbolic-ref --short -q HEAD
        OUTPUT_VARIABLE ${_git_branch}
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
        WORKING_DIRECTORY
          ${CMAKE_CURRENT_SOURCE_DIR}
        )
    endif()
endmacro()

macro(TAG_VERSION)
    if(("${BUILD_VERSION}" STREQUAL "0"))
        set(SDK_VERSION ${MAJOR_VERSION}.${MINOR_VERSION}.${REVISION_VERSION})
    else()
        set(SDK_VERSION ${MAJOR_VERSION}.${MINOR_VERSION}.${REVISION_VERSION}.${BUILD_VERSION})
    endif()
    string(TIMESTAMP BUILD_TIME "%Y-%m-%d %H:%M:%S")
    message(STATUS "Build Sdk Version: v${SDK_VERSION}")
    message(STATUS "Build Time:${BUILD_TIME}")

    set(GIT_HASH "")
    set(GIT_BRANCH "")
    find_package(Git QUIET)
    if(GIT_FOUND)
        message(STATUS "Git Cmd: ${GIT_EXECUTABLE}")
        get_git_branch(GIT_BRANCH)
        get_git_hash(GIT_HASH)
    else()
        message(WARN "git not found.")
    endif()
    message(STATUS "Git branch is ${GIT_BRANCH}")
    message(STATUS "Git hash is ${GIT_HASH}")

    if(EXISTS "${PROJECT_ROOT_DIR}/src/config/config.h.in")
        configure_file(
            "${PROJECT_ROOT_DIR}/src/config/config.h.in"
            "${PROJECT_ROOT_DIR}/src/config/config.h"
        )
        message(STATUS "Generated config file ${PROJECT_ROOT_DIR}/src/config/config.h")
    else()
        message(STATUS "Tag version failed, check if ${PROJECT_ROOT_DIR}/src/config/config.h.in exists.")
    endif()
endmacro()