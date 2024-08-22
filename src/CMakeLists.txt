file(GLOB_RECURSE srcs "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
set(target_name "youya")
add_library(${target_name} SHARED ${srcs})
target_link_libraries(${target_name})

install(TARGETS ${target_name} EXPORT youya)