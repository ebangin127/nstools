; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Naraeon SSD Tools"
!define PRODUCT_PUBLISHER "나래지기"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\SSDTools.exe"
!define PRODUCT_UNINST_OLD_KEY "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Naraeon SSD Tools"
!define PRODUCT_UNINST_OLD_KEY2 "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Naraeon SSD Tools (for LiteOn SSDs)"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor /solid lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"
!include "Version.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "ICON2.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE ".\license.txt"
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\SSDTools.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "English"
; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "Naraeon SSD Tools ${_VERSION_SHORTEN}"
OutFile "..\Setup\Setup.exe"

InstallDir "$PROGRAMFILES\Naraeon\"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section "MainSection" SEC01
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_OLD_KEY}"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_OLD_KEY2}"

  SetOverwrite on

  SetOutPath "$INSTDIR"
  File "..\Exe\SSDTools.exe"
  File "..\Exe\NSTDiagSvc_New.exe"

  SetOutPath "$INSTDIR\7z"
  File "..\Exe\7z\7z.exe"
  File "..\Exe\7z\7z.dll"

  SetOutPath "$INSTDIR\Image"
  File "..\Exe\Image\logo.png"
  File "..\Exe\Image\bg.png"

  CreateDirectory "$SMPROGRAMS\Naraeon SSD Tools"
  CreateShortCut "$SMPROGRAMS\Naraeon SSD Tools\Naraeon SSD Tools.lnk" "$INSTDIR\SSDTools.exe"
  CreateShortCut "$DESKTOP\Naraeon SSD Tools.lnk" "$INSTDIR\SSDTools.exe"

  CreateDirectory "$INSTDIR\Unetbootin"

  ExecWait '"$INSTDIR\NSTDiagSvc_New.exe" /uninstall /silent'
  ExecWait '"$INSTDIR\NSTDiagSvc_New.exe" /install /silent'
SectionEnd

Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\Naraeon SSD Tools\Uninstall.lnk" "$INSTDIR\uninst_ssdtools.exe"
SectionEnd

Section -Post
  Push $INSTDIR
  Call GetParent
  Pop $R0

  WriteUninstaller "$R0\SSDTools\uninst_ssdtools.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$R0\SSDTools.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$R0\SSDTools\uninst_ssdtools.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$R0\SSDTools\SSDTools.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name)은 완전히 제거되었습니다."
FunctionEnd

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "$(^Name)을 제거하시겠습니까?" IDYES +2
  Abort
FunctionEnd

Function GetParent
 
  Exch $R0
  Push $R1
  Push $R2
  Push $R3
 
  StrCpy $R1 0
  StrLen $R2 $R0
 
  loop:
    IntOp $R1 $R1 + 1
    IntCmp $R1 $R2 get 0 get
    StrCpy $R3 $R0 1 -$R1
    StrCmp $R3 "\" get
  Goto loop
 
  get:
    StrCpy $R0 $R0 -$R1
 
    Pop $R3
    Pop $R2
    Pop $R1
    Exch $R0
 
FunctionEnd

Section Uninstall
  ExecWait '"$INSTDIR\NSTDiagSvc_New.exe" /uninstall /silent'

  Delete "$SMPROGRAMS\Naraeon SSD Tools\Uninstall.lnk"
  Delete "$DESKTOP\Naraeon SSD Tools.lnk"
  Delete "$SMPROGRAMS\Naraeon SSD Tools\Naraeon SSD Tools.lnk"

  RMDir "$SMPROGRAMS\Naraeon SSD Tools"
  RMDir /r "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd