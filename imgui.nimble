# Package

version     = "1.91.1"
author      = "Leonardo Mariscal"
description = "Dear ImGui bindings for Nim"
license     = "MIT"
srcDir      = "src"
skipDirs    = @["tests"]

# Dependencies

requires "nim >= 1.0.0" # 1.0.0 promises that it will have backward compatibility

task cimgui, "Compiles cimgui":
  rmDir("src/imgui/private/cimgui/build")
  exec("cmake -S src/imgui/private/cimgui -B src/imgui/private/cimgui/build -DIMGUI_STATIC=no")
  exec("cmake --build src/imgui/private/cimgui/build")

before install:
  cimguiTask()

task gen, "Generate bindings from source":
  exec("nim c -r tools/generator.nim")

task test, "Create window with imgui demo":
  requires "nimgl@#1.0" # Please https://github.com/nim-lang/nimble/issues/482
  exec("nim c -r tests/test.nim") # requires cimgui.dll
  exec("nim cpp -r tests/test.nim")

task ci, "Create window with imgui null demo":
  requires "nimgl@#1.0" # Please https://github.com/nim-lang/nimble/issues/482
  exec("nim c -r tests/tnull.nim") # requires cimgui.dll
  exec("nim cpp -r tests/tnull.nim")
