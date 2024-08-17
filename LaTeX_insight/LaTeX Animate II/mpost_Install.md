# Animation

## MetaPost 安装

一般在windows上是默认安装了metepost的相关东西的，但是在Linux上则不然，你很有可能在第一次运行如下命令

```tex
mpost example.mp
```

时报错:

```tex
Sorry, I can't find the 'mpost' preload file; will try 'plain'.
I can't find the 'plain' preload file!
```

解决方法也很简单，使用你的包管理器（Ubuntu和Arch可以直接安装）安装如下的包即可:

> texlive-metapost

```shell
sudo apt-get install texlive
# 或
sudo pacman -S texlive-metapost
```

然后就可以愉快的玩耍了。

## LaTeXworkshop log

``` la
[10:03:52.877][Builder] Does the executable exist? $PATH: /home/zpd/.vscode-server/bin/2ccd690cbff1569e4a83d7c43d45101f817401dc/bin/remote-cli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Program Files/WindowsApps/Microsoft.PowerShell_7.3.6.0_x64__8wekyb3d8bbwe:/mnt/c/Program Files (x86)/VMware/VMware Workstation/bin/:/mnt/c/texlive/Relateed-Applications/ImageMagick-7.1.0-Q16:/mnt/c/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Program Files/Microsoft/jdk-11.0.12.7-hotspot/bin:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files/Microsoft SQL Server/Client SDK/ODBC/170/Tools/Binn/:/mnt/c/Program Files/Microsoft SQL Server/150/Tools/Binn/:/mnt/c/Program Files/Wolfram Research/WolframScript/:/mnt/c/Program Files/MATLAB/R2022a/runtime/win64:/mnt/c/Program Files/MATLAB/R2022a/bin:/mnt/c/Program Files/Microsoft SQL Server/Client SDK/ODBC/110/Tools/Binn/:/mnt/c/Program Files (x86)/Microsoft SQL Server/120/Tools/Binn/:/mnt/c/Program Files/Microsoft SQL Server/120/Tools/Binn/:/mnt/c/Program Files/Microsoft SQL Server/120/DTS/Binn/:/mnt/c/Program Files (x86)/Windows Kits/8.1/Windows Performance Toolkit/:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/Program Files/Git/cmd:/mnt/c/Users/PC/AppData/Local/SumatraPDF:/mnt/c/Program Files/WindowsApps/5E8FC25E.XODODOCS_6.0.0.0_x64__3v3sf0k6w2rec/Xodo.exe:/mnt/c/Program Files/Go/bin:/mnt/c/Strawberry/c/bin:/mnt/c/Strawberry/perl/site/bin:/mnt/c/Strawberry/perl/bin:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/Users/PC/AppData/Local/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe:/mnt/c/Program Files/WindowsApps/Microsoft.PowerShell_7.3.4.0_x64__8wekyb3d8bbwe:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/Program Files/PowerShell/7/:/mnt/c/Program Files/Microsoft VS Code/bin:/mnt/c/Program Files/Gurobi/win64/bin:/mnt/c/Program Files/LINGO18/:/mnt/c/Program Files/LxRunOffline-v3.5.0-mingw:/mnt/c/Program Files (x86)/PDFtk Server/bin/:/mnt/c/Program Files (x86)/Lua/5.1:/mnt/c/Program Files (x86)/Lua/5.1/clibs:/mnt/c/Users/PC/AppData/Roaming/npm:/mnt/c/Program Files/nodejs/:/mnt/c/ProgramData/chocolatey/bin:/mnt/c/texlive/2021/bin/win32:/mnt/c/Program Files/Quarto/bin:/mnt/c/scoop/apps/gcc/current/bin:/mnt/c/scoop/apps/llvm/current/bin:/mnt/c/scoop/apps/ghostscript/current/lib:/mnt/c/scoop/apps/mpv/current:/mnt/c/scoop/apps/mingw/current/bin:/mnt/c/scoop/shims:/mnt/c/Program Files/Stack/bin:/mnt/c/Users/PC/AppData/Local/Programs/oh-my-posh/bin:/mnt/c/ghcup/bin:/mnt/c/Users/PC/AppData/Local/Programs/Python/Python38:/mnt/c/Users/PC/AppData/Local/Programs/Python/Envs/ManimCE/Scripts:/mnt/c/Users/PC/AppData/Local/Programs/Python/Envs/ManimGL/Scripts:/mnt/c/Python311:/mnt/c/Program Files/Qing:/mnt/c/Program Files/Lua_5.4.6:/mnt/c/Program Files/Lua_5.4.6/LuaDist_0.9.8/bin:/mnt/c/Program Files/Inkscape/bin:/mnt/c/Users/PC/AppData/Local/Microsoft/WindowsApps:/mnt/c/Program Files/komorebi/bin:/mnt/c/BIN:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl, $Path: undefined, $SHELL: /usr/bin/zsh

```

