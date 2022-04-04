@echo off
setlocal
cd deps
cmake -P get_dependencies.cmake
endlocal