; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "YUView"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "IENT"
!define PRODUCT_WEB_SITE "http://www.ient.rwth-aachen.de"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\YUView.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"
; x64 header
!include "x64.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\YUView.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "YUView-1-0-LATEST-MinGW-x64.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "Hauptgruppe" SEC01
${If} ${RunningX64}
   DetailPrint "Installer running on 64-bit host"
   ; disable registry redirection (enable access to 64-bit portion of registry)
   SetRegView 64
${EndIf}
  SetOutPath "$INSTDIR\bearer"
  SetOverwrite ifnewer
  File "release\bearer\qgenericbearer.dll"
  File "release\bearer\qnativewifibearer.dll"
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ;File "release\D3Dcompiler_47.dll"
  SetOutPath "$INSTDIR\iconengines"
  SetOverwrite ifnewer
  File "release\iconengines\qsvgicon.dll"
  SetOutPath "$INSTDIR\imageformats"
  SetOverwrite ifnewer
  File "release\imageformats\qdds.dll"
  File "release\imageformats\qgif.dll"
  File "release\imageformats\qicns.dll"
  File "release\imageformats\qico.dll"
  ;File "release\imageformats\qjp2.dll"
  File "release\imageformats\qjpeg.dll"
  ;File "release\imageformats\qmng.dll"
  File "release\imageformats\qsvg.dll"
  File "release\imageformats\qtga.dll"
  File "release\imageformats\qtiff.dll"
  File "release\imageformats\qwbmp.dll"
  File "release\imageformats\qwebp.dll"
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ;File "release\libEGL.dll"
  File "release\libgcc_s_seh-1.dll"
  ;File "release\libGLESV2.dll"
  File "release\libstdc++-6.dll"
  File "release\libwinpthread-1.dll"
  ;File "release\opengl32sw.dll"
  File "release\libgomp-1.dll"
  File "release\libde265-internals.dll"
  SetOutPath "$INSTDIR\platforms"
  SetOverwrite ifnewer
  File "release\platforms\qwindows.dll"
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "release\Qt5Core.dll"
  File "release\Qt5Gui.dll"
  File "release\Qt5Network.dll"
  File "release\Qt5Svg.dll"
  File "release\Qt5Widgets.dll"
  File "release\Qt5Xml.dll"
  SetOutPath "$INSTDIR\translations"
  SetOverwrite ifnewer
  File "release\translations\qt_ca.qm"
  File "release\translations\qt_cs.qm"
  File "release\translations\qt_de.qm"
  File "release\translations\qt_fi.qm"
  File "release\translations\qt_hu.qm"
  File "release\translations\qt_it.qm"
  File "release\translations\qt_ja.qm"
  File "release\translations\qt_ko.qm"
  File "release\translations\qt_lv.qm"
  File "release\translations\qt_ru.qm"
  File "release\translations\qt_sk.qm"
  File "release\translations\qt_uk.qm"
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "release\YUView.exe"
  CreateDirectory "$SMPROGRAMS\YUView"
  CreateShortCut "$SMPROGRAMS\YUView\YUView.lnk" "$INSTDIR\YUView.exe"
  CreateShortCut "$DESKTOP\YUView.lnk" "$INSTDIR\YUView.exe"
SectionEnd

Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\YUView\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\YUView.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\YUView.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

Function on.Init
${If} ${RunningX64}
StrCpy $INSTDIR "$PROGRAMFILES64\${PRODUCT_NAME}"
${Else}
StrCpy $INSTDIR "$PROGRAMFILES\${PRODUCT_NAME}"
${EndIf}
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) wurde erfolgreich deinstalliert."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "M�chten Sie $(^Name) und alle seinen Komponenten deinstallieren?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\YUView.exe"
  Delete "$INSTDIR\translations\qt_uk.qm"
  Delete "$INSTDIR\translations\qt_sk.qm"
  Delete "$INSTDIR\translations\qt_ru.qm"
  Delete "$INSTDIR\translations\qt_lv.qm"
  Delete "$INSTDIR\translations\qt_ko.qm"
  Delete "$INSTDIR\translations\qt_ja.qm"
  Delete "$INSTDIR\translations\qt_it.qm"
  Delete "$INSTDIR\translations\qt_hu.qm"
  Delete "$INSTDIR\translations\qt_fi.qm"
  Delete "$INSTDIR\translations\qt_de.qm"
  Delete "$INSTDIR\translations\qt_cs.qm"
  Delete "$INSTDIR\translations\qt_ca.qm"
  Delete "$INSTDIR\Qt5Xml.dll"
  Delete "$INSTDIR\Qt5Widgets.dll"
  Delete "$INSTDIR\Qt5Svg.dll"
  Delete "$INSTDIR\Qt5Network.dll"
  Delete "$INSTDIR\Qt5Gui.dll"
  Delete "$INSTDIR\Qt5Core.dll"
  Delete "$INSTDIR\platforms\qwindows.dll"
  ;Delete "$INSTDIR\opengl32sw.dll"
  Delete "$INSTDIR\libwinpthread-1.dll"
  Delete "$INSTDIR\libstdc++-6.dll"
  ;Delete "$INSTDIR\libGLESV2.dll"
  Delete "$INSTDIR\libgcc_s_seh-1.dll"
  ;Delete "$INSTDIR\libEGL.dll"
  Delete "$INSTDIR\libgomp-1.dll"
  Delete "$INSTDIR\libde265-internals.dll"
  Delete "$INSTDIR\imageformats\qwebp.dll"
  Delete "$INSTDIR\imageformats\qwbmp.dll"
  Delete "$INSTDIR\imageformats\qtiff.dll"
  Delete "$INSTDIR\imageformats\qtga.dll"
  Delete "$INSTDIR\imageformats\qsvg.dll"
  ;Delete "$INSTDIR\imageformats\qmng.dll"
  Delete "$INSTDIR\imageformats\qjpeg.dll"
  ;Delete "$INSTDIR\imageformats\qjp2.dll"
  Delete "$INSTDIR\imageformats\qico.dll"
  Delete "$INSTDIR\imageformats\qicns.dll"
  Delete "$INSTDIR\imageformats\qgif.dll"
  Delete "$INSTDIR\imageformats\qdds.dll"
  Delete "$INSTDIR\iconengines\qsvgicon.dll"
  ;Delete "$INSTDIR\D3Dcompiler_47.dll"
  Delete "$INSTDIR\bearer\qnativewifibearer.dll"
  Delete "$INSTDIR\bearer\qgenericbearer.dll"

  Delete "$SMPROGRAMS\YUView\Uninstall.lnk"
  Delete "$DESKTOP\YUView.lnk"
  Delete "$SMPROGRAMS\YUView\YUView.lnk"

  RMDir "$SMPROGRAMS\YUView"
  RMDir "$INSTDIR\platforms"
  RMDir "$INSTDIR\imageformats"
  RMDir "$INSTDIR\iconengines"
  RMDir "$INSTDIR\bearer"
  RMDir "$INSTDIR\translations"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  Exec 'cmd /C reg delete "HKEY_CURRENT_USER\SOFTWARE\Institut f�r Nachrichtentechnik, RWTH Aachen University" /f'
  SetAutoClose true
SectionEnd