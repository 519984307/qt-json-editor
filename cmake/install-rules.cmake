if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/qt-json-editor CACHE PATH "")
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package qt-json-editor)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT qt-json-editor_Development
)

install(
    TARGETS qt-json-editor_qt-json-editor
    EXPORT qt-json-editorTargets
    RUNTIME #
    COMPONENT qt-json-editor_Runtime
    LIBRARY #
    COMPONENT qt-json-editor_Runtime
    NAMELINK_COMPONENT qt-json-editor_Development
    ARCHIVE #
    COMPONENT qt-json-editor_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    qt-json-editor_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(qt-json-editor_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${qt-json-editor_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT qt-json-editor_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${qt-json-editor_INSTALL_CMAKEDIR}"
    COMPONENT qt-json-editor_Development
)

install(
    EXPORT qt-json-editorTargets
    NAMESPACE qt-json-editor::
    DESTINATION "${qt-json-editor_INSTALL_CMAKEDIR}"
    COMPONENT qt-json-editor_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
