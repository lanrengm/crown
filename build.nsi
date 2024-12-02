; Chinese need GBK
; ʹ������ʱ����Ҫ�� GBK �����ʽ�༭���ļ�

!include "MUI.nsh"

!define AppName "Crown"
!define AppShortName "crown"
!define AppVersion "1.0.0"
!define InstallerVersion "1.0.0.0"
!define AppPublisher "lanren_007@163.com"
!define AppCopyRight "lanren_007 ��Ȩ����"
!define AppWebsite "https://gitee.com/lanren_007"
!define AppDesc "���� Chrome ��������е��������û�� Chrome �Ͳ������С�"

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
; !define MUI_FINISHPAGE_RUN_TEXT "Run Init" ; �����������������
; !define MUI_FINISHPAGE_RUN "install.vbs" ; ���г���
!insertmacro MUI_PAGE_FINISH ; ��������

!insertmacro MUI_UNPAGE_WELCOME
; ȷ��ж��·��
!insertmacro MUI_UNPAGE_CONFIRM
; ж��ҳ�棬ѡ��ж�����
; !insertmacro MUI_UNPAGE_COMPONENTS
; ж�ؽ��棬��ʾж�ص��ļ�
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

  ; ���� JS ����Ļ�������
  FileOpen $1 "$INSTDIR\env.js" w
  FileWrite $1 "var WorkDir = String.raw`$INSTDIR\${AppShortName}\``;"
  FileClose $1

  ; ������ݷ�ʽ
  CreateShortCut \
    "$INSTDIR\${AppName}.lnk" \
    "C:\Program Files\Google\Chrome\Application\chrome.exe" \
    ' --allow-file-access-from-files --app="file:///$INSTDIR\index.html"' \
    "$INSTDIR\assets\fav.ico" 0 \
    SW_SHOWNORMAL \
    CONTROL|SHIFT|E \
    "${AppDesc}"
  ; �����ݷ�ʽ
  CreateShortCut "$DESKTOP\${AppName}.lnk" "$INSTDIR\${AppName}.lnk"
  ; ��ʼ�˵���ݷ�ʽ
  SetShellVarContext current ; ��ǰ�û���
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
