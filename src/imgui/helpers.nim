import std/os, std/strutils

proc currentSourceDir(): string {.compileTime.} =
  result = currentSourcePath().replace("\\", "/")
  result = result[0 ..< result.rfind("/")]

when not defined(cpp) or defined(cimguiDLL):
  const imgui_dll_path* = currentSourceDir() / ".." / "imgui/private/cimgui/build"
  when defined(windows):
    const imgui_dll* = "cimgui.dll"
  elif defined(macosx):
    const imgui_dll* = "cimgui.dylib"
  else:
    const imgui_dll* = "cimgui.so"
