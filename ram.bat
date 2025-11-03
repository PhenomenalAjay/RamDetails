@echo off

echo Downloading and running the PowerShell script...
powershell -NoProfile -ExecutionPolicy Bypass -Command "& {iwr https://raw.githubusercontent.com/PhenomenalAjay/RamDetails/main/RamDetails.ps1 -OutFile \"$env:TEMP\RamDetails.ps1\"; & \"$env:TEMP\RamDetails.ps1\"}"

echo.
echo The batch file has finished executing the PowerShell script.
pause
