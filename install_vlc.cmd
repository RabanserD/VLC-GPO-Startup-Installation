@ECHO OFF

::Querying installed version of VLC
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VideoLAN\VLC" /v "Version" | Find "2.2.6"
IF %ERRORLEVEL == 1 GOTO INSTALL
IF %ERRORLEVEL == 0 GOTO SKIP
GOTO end

::Kill VLC process and install new version
:INSTALL
::Set log file location.
SET lfvlc="%systemroot%\temp\GPO_Install_VLC_2.2.6.log"

::Writing header information to log file
ECHO ###%date% - %time% - VLC installation started > %lfvlc%
ECHO. >> %lfvlc%
ECHO Checking installed VLC version >> %lfvlc%
ECHO. >> %lfvlc%

ECHO ###Obsolete or no VLC version detected, proceeding with installation >> %lfvlc%
ECHO ###Installing VLC >> %lfvlc%

::Determining OS architecture
ECHO ###Determining OS architecture >> %lfvlc%
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "BuildLabEx" | find "x86"
IF %ERRORLEVEL == 1 GOTO INSTALL64
IF %ERRORLEVEL == 0 GOTO INSTALL86

:INSTALL86
ECHO ###x86 OS detected, proceeding with installation  >> %lfvlc%
\\domain.local\dfs\SoftwareDistribution\VLC\2.2.6\vlc-2.2.6-win32.exe /L=1033 /S
ECHO ###VLC installed, exiting  >> %lfvlc%
GOTO end

:INSTALL64
ECHO ###AMD64 OS detected, proceeding with installation  >> %lfvlc%
\\domain.local\dfs\SoftwareDistribution\VLC\2.2.6\vlc-2.2.6-win64.exe /L=1033 /S
ECHO ### VLC installed, exiting  >> %lfvlc%
GOTO end

::Skipping installation due to already installed version of vlc
:SKIP

ECHO ###Installation skipped...  >> %lfvlc%
GOTO end

:END