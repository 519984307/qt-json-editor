#include <string>

#include "qt-json-editor/qt-json-editor.hpp"

#include <fmt/core.h>

exported_class::exported_class()
    : m_name {fmt::format("{}", "qt-json-editor")}
{
}

auto exported_class::name() const -> const char*
{
  return m_name.c_str();
}
