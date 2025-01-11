@echo off
echo Add to start menu (y/n)?
set /p sm=
echo Add to desktop (y/n)?
set /p dsk=
if %sm% == n goto chkdsk
cd "%AppData%\Microsoft\Windows\Start Menu\Programs"
mkdir frostsoftware
del "%AppData%\Microsoft\Windows\Start Menu\Programs\frostsoftware\Hydropoxy.url"
echo [InternetShortcut] >> "%AppData%\Microsoft\Windows\Start Menu\Programs\frostsoftware\Hydropoxy.url"
echo URL=%~dp0Hydropoxy.exe >> "%AppData%\Microsoft\Windows\Start Menu\Programs\frostsoftware\Hydropoxy.url"
echo IconFile=%~dp0\asset\hydropoxydrop.ico >> "%AppData%\Microsoft\Windows\Start Menu\Programs\frostsoftware\Hydropoxy.url"
echo IconIndex=0 >> "%AppData%\Microsoft\Windows\Start Menu\Programs\frostsoftware\Hydropoxy.url"
cd %~dp0
echo Installed Start Menu
:chkdsk
if %dsk% == n goto end
del "%userprofile%\desktop\Hydropoxy.url"
echo [InternetShortcut] >> "%userprofile%\desktop\Hydropoxy.url"
echo URL=%~dp0Hydropoxy.exe >> "%userprofile%\desktop\Hydropoxy.url"
echo IconFile=%~dp0\asset\hydropoxydrop.ico >> "%userprofile%\desktop\Hydropoxy.url"
echo IconIndex=0 >> "%userprofile%\desktop\Hydropoxy.url"
echo Installed Desktop
:end
pause
exit