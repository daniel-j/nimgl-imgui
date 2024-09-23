switch("path", "$projectDir/../src")

import std/os, std/compilesettings
import "../src/imgui/helpers"

const backend = querySetting(SingleValueSetting.backend)

when backend != "cpp" or defined(cimguiDLL):
  echo "copying " & imgui_dll & " to " & projectDir()
  echo imgui_dll_path
  cpFile(imgui_dll_path / imgui_dll, projectDir() / imgui_dll)
