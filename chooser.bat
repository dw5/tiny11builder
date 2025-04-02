@echo off
setlocal EnableDelayedExpansion

:: Set the directory to search for .ps1 files (current dir)
set "script_dir=%cd%"
set /a index=0

echo Listing .ps1 scripts in: %script_dir%
echo.

:: Loop through all .ps1 files
for %%f in ("%script_dir%\*.ps1") do (
    set /a index+=1
    set "script[!index!]=%%f"
    echo !index!: %%~nxf
)

:: Check if any scripts were found
if %index%==0 (
    echo No .ps1 scripts found in this directory.
    goto :eof
)

:: Prompt user to choose
echo.
set /p choice=Enter the number of the script to run: 
echo.

:: Validate choice
if not defined script[%choice%] (
    echo Invalid selection.
    goto :eof
)

:: Run the selected script
set "selected_script=!script[%choice%]!"
echo Running: "!selected_script!"
powershell.exe -ExecutionPolicy Bypass -File "!selected_script!"

endlocal
pause
