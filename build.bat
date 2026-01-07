@echo off
setlocal

echo === ImGui docking static library build ===

rem Go to script directory
cd /d "%~dp0"

rem Ensure lib folder exists
if not exist lib (
    echo Creating lib folder...
    mkdir lib
)

rem Clean and recreate build folder
if exist build (
    echo Cleaning old build folder...
    rmdir /s /q build
)
mkdir build
cd build

echo === Compiling ImGui core ===
cl /c ^
  ..\imgui.cpp ^
  ..\imgui_draw.cpp ^
  ..\imgui_tables.cpp ^
  ..\imgui_widgets.cpp ^
  ..\imgui_demo.cpp ^  
  /I..\ ^
  /EHsc /MD /O2

echo === Compiling ImGui backends ===
cl /c ^
  ..\backends\imgui_impl_sdl3.cpp ^
  ..\backends\imgui_impl_dx12.cpp ^
  /I..\ ^
  /I..\backends ^
  /EHsc /MD /O2

echo === Creating static library imgui.lib ===
lib /OUT:imgui.lib *.obj

echo === Copying imgui.lib to ..\lib ===
copy /Y imgui.lib ..\lib\ >nul

echo === Done. Output: C:\Libraries\imgui-docking\lib\imgui.lib ===

endlocal
