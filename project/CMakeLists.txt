cmake_minimum_required(VERSION 2.8)
project(my)

# Set C++ standard and compilation flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ldl")

# Define actual library paths
set(RUNTIME_PATH /usr/local)
set(SOMEIP_PATH /usr/local)
set(VSOMEIP_PATH /usr/local)

# Debug info: print path variables
message(STATUS "RUNTIME_PATH: ${RUNTIME_PATH}")
message(STATUS "SOMEIP_PATH: ${SOMEIP_PATH}")
message(STATUS "VSOMEIP_PATH: ${VSOMEIP_PATH}")

# Check if paths exist
if(NOT EXISTS "${RUNTIME_PATH}/include/CommonAPI-3.2")
    message(FATAL_ERROR "CommonAPI runtime include directory not found: ${RUNTIME_PATH}/include/CommonAPI-3.2")
endif()

# Add include directories
include_directories(
    src-gen
    src
    ${RUNTIME_PATH}/include/CommonAPI-3.2  # Path to CommonAPI headers
    ${SOMEIP_PATH}/include/CommonAPI-3.2/SomeIP  # SOMEIP headers (assuming they're here)
    ${VSOMEIP_PATH}/include  # vsomeip headers path
)

# Add library search paths
link_directories(
    ${RUNTIME_PATH}/lib  # CommonAPI libraries directory
    ${SOMEIP_PATH}/lib  # SOMEIP libraries directory
    ${VSOMEIP_PATH}/lib  # vsomeip libraries directory
)

# Add executables
add_executable(HelloWorldClient
    src/HelloWorldClient.cpp
    src-gen/v1/commonapi/HelloWorldSomeIPProxy.cpp
    src-gen/v1/commonapi/HelloWorldSomeIPDeployment.cpp
)

target_link_libraries(HelloWorldClient CommonAPI CommonAPI-SomeIP vsomeip3)

add_executable(HelloWorldService
    src/HelloWorldService.cpp
    src/HelloWorldStubImpl.cpp    
    src-gen/v1/commonapi/HelloWorldSomeIPStubAdapter.cpp
    #src-gen/v1/commonapi/HelloWorldStubDefault.cpp
    src-gen/v1/commonapi/HelloWorldSomeIPDeployment.cpp
)

target_link_libraries(HelloWorldService CommonAPI CommonAPI-SomeIP vsomeip3)

# Debug info: print include directories and linked libraries
get_property(dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
message(STATUS "Include directories: ${dirs}")