; Chinese need GBK
; 使用中文时，需要以 GBK 编码格式编辑本文件

!include "MUI.nsh"

!define AppName "Crown"
!define AppShortName "crown"
!define AppVersion "1.0.0"
!define InstallerVersion "1.0.0.0"
!define AppPublisher "lanren_007@163.com"
!define AppCopyRight "lanren_007 版权所有"
!define AppWebsite "https://gitee.com/lanren_007"
!define AppDesc "依赖 Chrome 浏览器运行的桌面程序，没有 Chrome 就不能运行。"

; installer
!define MUI_ABORTWARNING
!define MUI_ICON "assets\fav.ico"
!define MUI_UNICON "assets\fav.ico"
Name "${AppShortName}-setup-${AppVersion}"
InstallDir "$PROGRAMFILES\${AppShortName}"
OutFile "dist\${AppShortName}-setup-${InstallerVersion}.exe"

VIAddVersionKey "ProductName" "${AppName} Installer"
VIAddVersionKey "ProductVersion" "${APPVersion}"
VIAddVersionKey "Comments" "The application running on chrome."
VIAddVersionKey "CompanyName" "${AppPublisher}"
VIAddVersionKey "LegalCopyright" "${AppCopyRight}"
VIAddVersionKey "FileVersion" "${InstallerVersion}"
VIAddVersionKey "FileDescription" "${AppName} installer."
VIProductVersion "${InstallerVersion}"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.GBK.txt"
; !insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
ShowInstDetails show
!insertmacro MUI_PAGE_INSTFILES
; !define MUI_FINISHPAGE_RUN_TEXT "Run Init" ; 结束界面的运行文字
; !define MUI_FINISHPAGE_RUN "install.vbs" ; 运行程序
!insertmacro MUI_PAGE_FINISH ; 结束界面

!insertmacro MUI_UNPAGE_WELCOME
; 确认卸载路径
!insertmacro MUI_UNPAGE_CONFIRM
; 卸载页面，选择卸载组件
; !insertmacro MUI_UNPAGE_COMPONENTS
; 卸载界面，显示卸载的文件
ShowUninstDetails show
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Section "core" section_index_output
  SetOutPath "$INSTDIR"
  SetOverwrite ifdiff

  File /r "assets"
  File /r "lib"
  File /r "src"

  File "index.html"
  ; File "install.vbs"
  WriteUninstaller "uninstall.exe"

  ; 创建 JS 程序的环境变量
  FileOpen $1 "$INSTDIR\env.js" w
  FileWrite $1 "var WorkDir = String.raw`$INSTDIR\${AppShortName}\``;"
  FileClose $1

  ; 创建快捷方式
  CreateShortCut \
    "$INSTDIR\${AppName}.lnk" \
    "C:\Program Files\Google\Chrome\Application\chrome.exe" \
    ' --allow-file-access-from-files --app="file:///$INSTDIR\index.html"' \
    "$INSTDIR\assets\fav.ico" 0 \
    SW_SHOWNORMAL \
    CONTROL|SHIFT|E \
    "${AppDesc}"
  ; 桌面快捷方式
  CreateShortCut "$DESKTOP\${AppName}.lnk" "$INSTDIR\${AppName}.lnk"
  ; 开始菜单快捷方式
  SetShellVarContext current ; 当前用户下
  CreateDirectory "$SMPROGRAMS\${AppName}"
  CreateShortCut "$SMPROGRAMS\${AppName}\uninstall.lnk" "$INSTDIR\uninstall.exe"
  CreateShortCut "$SMPROGRAMS\${AppName}\${AppName}.lnk" "$INSTDIR\${AppName}.lnk"
SectionEnd

Section -Uninstall
  ; RMDir /r "$INSTDIR\assets"
  ; RMDir /r "$INSTDIR\lib"
  ; RMDir /r "$INSTDIR\src"

  ; Delete "$INSTDIR\index.html"
  ; Delete "$INSTDIR\install.vbs"
  ; Delete "$INSTDIR\uninstall.exe"
  ; Delete "$INSTDIR\${AppName}.lnk"

  RMDir /r "$INSTDIR"

  Delete "$DESKTOP\${AppName}.lnk"
  SetShellVarContext current
  ; Delete "$SMPROGRAMS\${AppName}\${AppName}.lnk"
  ; Delete "$SMPROGRAMS\${AppName}\uninstall.lnk"
  RMDir /r "$SMPROGRAMS\${AppName}"
SectionEnd
