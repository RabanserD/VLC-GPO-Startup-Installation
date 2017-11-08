@ECHO OFF

::Parameter Region
::Parameterize those 4 variables for your specific needs
::Set your desired destination version of VLC
SET vlcversion=2.2.6

::Set your installation source path. E.g. results in (64Bit) -> \\domain.local\dfs\software\VLC\2.2.6\vlc-2.2.6-win64.exe
SET vlcsource=\\domain.local\dfs\software\VLC\%vlcversion%\

::Set your desired log path. E.g. results in -> C:\Windows\temp\
SET vlclogpath=%systemroot%\temp\

::Set your desired log file name scheme. E.g. results in -> GPO_Install_VLC_YourPCName_2.2.6.log
SET vlclogfilename=GPO_Install_VLC_%computername%_%vlcversion%.log


::Logic/Code Region
::Querying installed VLC version
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VideoLAN\VLC" /v "Version" | Find "%vlcversion%"
IF %ERRORLEVEL == 1 GOTO INSTALL
IF %ERRORLEVEL == 0 GOTO SKIP
GOTO END

::Gathering/Seting prerequisites for installation
:INSTALL
::Set log file location.
SET lfvlc="%vlclogpath%%vlclogfilename%"

::Writing base information to log file
ECHO ###%date% - %time% - VLC installation started on %hostname% > %lfvlc%
ECHO. >> %lfvlc%
ECHO ###Checking installed VLC version >> %lfvlc%
ECHO ###Obsolete or no VLC version detected, proceeding with installation >> %lfvlc%
ECHO. >> %lfvlc%

::KIll VLC.exe if running
TASKKILL /F /IM vlc.exe /T >> %lfvlc%

::Determining OS architecture
ECHO ###Determining OS architecture >> %lfvlc%
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "BuildLabEx" | find "x86"
IF %ERRORLEVEL == 1 GOTO INSTALL64
IF %ERRORLEVEL == 0 GOTO INSTALL86
GOTO END

:INSTALL86
ECHO ###x86 OS detected, proceeding with installation >> %lfvlc%
%vlcsource%vlc-%vlcversion%-win32.exe /L=1033 /S >> %lfvlc%
ECHO. >> %lfvlc%
ECHO ###%date% - %time% - Installation finished >> %lfvlc%
GOTO END

:INSTALL64
ECHO ###AMD64 OS detected, proceeding with installation >> %lfvlc%
%vlcsource%vlc-%vlcversion%-win64.exe /L=1033 /S >> %lfvlc%
ECHO. >> %lfvlc%
ECHO ###%date% - %time% - Installation finished >> %lfvlc%
GOTO END

::Skipping installation due to already installed version of vlc
:SKIP
ECHO ###VLC %vlcversion% is already installed, skipping installation
GOTO END

:END
::Find this script on GitHub -> https://github.com/RabanserD/VLC-GPO-Startup-Installation - Copyright (c) 2017 Daniel Rabanser
