@echo off

set ahk2exe_path=C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe
set szexe_path=C:\Program Files\7-Zip\7z.exe

set input_name=main.ahk
set output_name=ahk_active_screenshot

:: kill the task, if any
echo Killing script tasks
taskkill /IM %output_name%.exe /T /F

:: delete old file
echo Deleting old files
if EXIST %output_name%.exe del /F %output_name%.exe
if EXIST %output_name%.zip del /F %output_name%.zip

:: build and zip
echo Building .exe file
"%ahk2exe_path%" /in %input_name% /out %output_name%.exe

echo Zipping .exe file
"%szexe_path%" a -tzip -mx9 %output_name%.zip %output_name%.exe

echo Done
pause
