cmake_minimum_required(VERSION 3.14)

project(youya VERSION 1.2.0)
cmake_policy(SET CMP0135 NEW)

include(CTest)                      # for BUILD_TESTING option
include(CMakePackageConfigHelpers)  # for write_basic_package_version_file

set(PROJECT_ROOT_DIR ${CMAKE_SOURCE_DIR})
set(MAJOR_VERSION 0)
set(MINOR_VERSION 0)
set(REVISION_VERSION 0)
set(BUILD_VERSION 0)

include(${PROJECT_ROOT_DIR}/cmake/version.cmake)
TAG_VERSION()

# deps
option(BUILD_DEPS "Use FetchContent download and build dependencies" ON)
option(BUILD_ABSL "Build and install ABSL" ON)
option(BUILD_PROTOBUF "Build and install Google Protocol Buffers" ON)
option(BUILD_GTEST "Build and install Google Test libraries" ON)

option(BUILD_TESTS "Build unit tests" ON)

if(BUILD_DEPS)
  include(FetchContent)
  set(FETCHCONTENT_QUIET OFF)
  set(extra_builds "")
  if (BUILD_ABSL)
    FetchContent_Declare(
      absl
      URL "https://github.com/abseil/abseil-cpp/archive/refs/tags/20230802.1.tar.gz"
      URL_HASH SHA256=987ce98f02eefbaf930d6e38ab16aa05737234d7afbab2d5c4ea7adbe50c28ed
    )
    list(APPEND extra_builds "absl")
  endif(BUILD_ABSL)
  if (BUILD_PROTOBUF)
    FetchContent_Declare(
        protobuf
        URL "https://github.com/protocolbuffers/protobuf/archive/refs/tags/v25.3.tar.gz"
        URL_HASH SHA256=d19643d265b978383352b3143f04c0641eea75a75235c111cc01a1350173180e
    )
    list(APPEND extra_builds "protobuf")
  endif(BUILD_PROTOBUF)
  if (BUILD_GTEST)
    FetchContent_Declare(
        googletest
        URL "https://github.com/google/googletest/archive/refs/tags/v1.14.0.tar.gz"
        URL_HASH SHA256=8ad598c73ad796e0d8280b082cebd82a630d73e73cd3c70057938a6501bba5d7
    )
  endif(BUILD_GTEST)
  if(BUILD_GTEST AND BUILD_TESTS AND CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    FetchContent_MakeAvailable(googletest)
  endif()
  set(protobuf_BUILD_TESTS OFF)
  set(ABSL_ENABLE_INSTALL ON)
  set(ABSL_PROPAGATE_CXX_STD ON)
  set(protobuf_BUILD_TESTS OFF)
  set(ABSL_ROOT_DIR ${CMAKE_BINARY_DIR}/_deps/absl-src)
  message("Using FetchContent to download and build dependencies")
  FetchContent_MakeAvailable(${extra_builds})
  if (BUILD_PROTOBUF)
    include("${protobuf_SOURCE_DIR}/cmake/protobuf-generate.cmake")
  endif(BUILD_PROTOBUF)
endif()

include_directories(src)
add_subdirectory(src)
add_subdirectory(test)