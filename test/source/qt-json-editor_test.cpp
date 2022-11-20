#include <string>

#include "qt-json-editor/qt-json-editor.hpp"

#include <gtest/gtest.h>

TEST(CodeGenTest, SampleExpectNoError)
{
  auto const exported = exported_class {};
  EXPECT_EQ(std::string("qt-json-editor"), exported.name());
}
