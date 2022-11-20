cmake_minimum_required(VERSION 3.14)

project(qt-json-editorTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(qt-json-editor REQUIRED)
  enable_testing()
endif()

find_package(GTest CONFIG REQUIRED)

set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# ---- Tests ----

add_executable(qt-json-editor_test source/qt-json-editor_test.cpp)
target_link_libraries(
    qt-json-editor_test PRIVATE
    qt-json-editor::qt-json-editor
    GTest::gmock GTest::gtest GTest::gmock_main GTest::gtest_main
)

target_compile_features(qt-json-editor_test PRIVATE cxx_std_17)


# ---- End-of-file commands ----

add_folders(Test)
