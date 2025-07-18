:: Run this batch script to link the DataForAzeroth addon with all non-PTR versions of the game.
@echo off
SETLOCAL
pushd %~dp0

call :link_wowfolder "C:\Program Files\World of Warcraft"
call :link_wowfolder "C:\Program Files (x86)\World of Warcraft"
call :link_wowfolder "..\World of Warcraft"
call :link_wowfolder "..\Blizzard\World of Warcraft"
call :link_wowfolder "F:\World of Warcraft"
call :report_taskcomplete
EXIT /B 0

:link_wowfolder
if exist "%~1\" (
    call :link_expansion "%~1\_classic_"
    call :link_expansion "%~1\_classic_era_"
    call :link_expansion "%~1\_classic_beta_"
    call :link_expansion "%~1\_classic_ptr_"
    call :link_expansion "%~1\_classic_era_ptr_"
    call :link_expansion "%~1\_retail_"
    call :link_expansion "%~1\_beta_"
    call :link_expansion "%~1\_ptr_"
    call :link_expansion "%~1\_xptr_"
)
EXIT /B 0

:link_expansion
if exist "%~1\" (
    echo Linking Expansion "%~1\"
    if exist "%~1\Interface\AddOns\DataForAzeroth" (
        rmdir /s /q "%~1\Interface\AddOns\DataForAzeroth"
    )
    if NOT exist "%~1\Interface\AddOns\DataForAzeroth" (
        if NOT exist "%~1\Interface" (
            mkdir "%~1\Interface"
        )
        if NOT exist "%~1\Interface\AddOns" (
            mkdir "%~1\Interface\AddOns"
        )
        mklink /J "%~1\Interface\AddOns\DataForAzeroth" "%cd%"
    )
)
EXIT /B 0

:report_taskcomplete
echo Task Complete!
set /p DUMMY=Hit ENTER to close...
EXIT /B 0