cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    qt-json-editor
    VERSION 0.1.0
    DESCRIPTION "Generating editor from a json schema"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)
include(cmake/general.cmake)
include(cmake/link_qt.cmake)

# ---- Declare library ----

add_library(
    qt-json-editor_qt-json-editor
    source/qt-json-editor.cpp
)
add_library(qt-json-editor::qt-json-editor ALIAS qt-json-editor_qt-json-editor)

include(GenerateExportHeader)
generate_export_header(
    qt-json-editor_qt-json-editor
    BASE_NAME qt-json-editor
    EXPORT_FILE_NAME export/qt-json-editor/qt-json-editor_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(qt-json-editor_qt-json-editor PUBLIC QT_JSON_EDITOR_STATIC_DEFINE)
endif()

set_target_properties(
    qt-json-editor_qt-json-editor PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME qt-json-editor
    OUTPUT_NAME qt-json-editor
)

target_include_directories(
    qt-json-editor_qt-json-editor ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    qt-json-editor_qt-json-editor SYSTEM
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(qt-json-editor_qt-json-editor PUBLIC cxx_std_17)

find_package(fmt REQUIRED)
target_link_libraries(qt-json-editor_qt-json-editor PRIVATE fmt::fmt)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${qt-json-editor_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT qt-json-editor_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of qt-json-editor"
  )
endif()

include(cmake/dev-mode.cmake)
