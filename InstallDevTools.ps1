cmd /c setx CNTK_ENABLE_ASGD false
Invoke-Expression .\Tools\devInstall\Windows\DevInstall.ps1
cmd /c $Env:VS2017INSTALLDIR\VC\Auxiliary\Build\vcvarsall.bat amd64 -vcvars_ver="14.11"