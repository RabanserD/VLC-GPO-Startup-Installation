# VLC-GPO-Startup-Installation
Lightweight Installation/Update script to deploy VLC Media Player interactively or by a startup script (e.g. using a GPO)

Adjust the following to meed your desired destination Version of VLC:

    L4. REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\VideoLAN\VLC" /v "Version" | Find "2.2.6"
    L12. SET lfvlc="%systemroot%\temp\GPO_Install_VLC_2.2.6.log"
    L30. \\domain.local\dfs\SoftwareDistribution\VLC\2.2.6\vlc-2.2.6-win32.exe /L=1033 /S >> %lfvlc%
    L37. \\domain.local\dfs\SoftwareDistribution\VLC\2.2.6\vlc-2.2.6-win64.exe /L=1033 /S >>  %lfvlc%
    L44. ECHO ###VLC 2.2.6 is already installed, skipping installation
