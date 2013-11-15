#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2009/11/13
 Script Function:
  The Rendering window to generate the script and render a formula along a variable

Wish list:
- Check the two checks box at the end.
- Asynchronous dialog (callback)
- include translations
- Store the last folder where a video has been rendered
V Use the comment and/or proposes one.
- Assistant of video exportation
#ce ----------------------------------------------------------------------------
#include-once

#include <WinAPI.au3>
#include <Date.au3>
#include "Parameters.au3"
#include "GlobalUtils.au3"
#include "IniHandling.au3"
#include "translations.au3"
#include "RenderVideoIniConfig.au3"
#include "AssistantGenerator.au3"

Global $width_highres, $height_highres
Func RenderingBox__create($formula, $varname, $varmin, $varmax)
  Local $default_comment = IniReadSavebox('formulaComment', 'MyNiceVideo')
  $default_comment = StringStripWS(StringRegExpReplace($default_comment, "([^0-9])[0-9]*\z", "\1"), 1+2)

  Local $ini_file = FileOpenDialog("Store video generator", "", "Video config files (*.ini)|All (*.*)", Default, $default_comment&".ini")
  FileChangeDir(@ScriptDir)
  If $ini_file == "" Then Return

  Local $output_type = "png"
  Local $comment = $default_comment&"####"
  Local $start_frame = "0"
  Local $last_frame = "100"
  Local $num_frames = "101"
  Local $rendered_frames = "0-100"
  Local $incl_last_frame = "True"
  Local $width = $width_highres
  Local $height = $height_highres
  Local $winmin = getWinMin()
  Local $winmax = getWinMax()
  Local $colornan = $color_NaN_complex

  If FileExists($ini_file) Then
    ; Imports the parameters from it.
    $formula = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_FORMULA, $formula)
    $varname = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_VARNAME, $varname)
    $varmin = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_STARTVALUE, $varmin)
    $varmax = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_ENDVALUE, $varmax)
    $comment = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_OUTPUT_MODEL, $comment)
    $output_type = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_OUTPUT_TYPE, $output_type)

    $start_frame = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_STARTFRAME, $start_frame)
    $last_frame = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_LASTFRAME, $last_frame)
    $num_frames = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_NUMFRAMES, $num_frames)

    $rendered_frames = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_RENDEREDFRAMES, $rendered_frames)
    $tmp = IniRead($ini_file, $INI_VIDEO, $INI_VIDEO_INCLASTFRAME, $incl_last_frame)
    If $tmp == "1" Or StringCompare($tmp, "True") == 0 Then
      $incl_last_frame = True
    ElseIf $tmp == "0" Or StringCompare($tmp, "False") == 0 Then
      $incl_last_frame = False
    EndIf

    $width = IniRead($ini_file, $INI_IMAGE, $INI_IMAGE_WIDTH, $width_highres)
    $height = IniRead($ini_file, $INI_IMAGE, $INI_IMAGE_HEIGHT, $height_highres)
    $winmin = IniRead($ini_file, $INI_IMAGE, $INI_IMAGE_WINMIN, $winmin)
    $winmax = IniRead($ini_file, $INI_IMAGE, $INI_IMAGE_WINMAX,  $winmax)
    $colornan = IniRead($ini_file, $INI_IMAGE, $INI_IMAGE_COLORNAN, $color_NaN_complex)
  EndIf
  Dim $options = emptySizedArray()
  push($options, _ArrayCreate($AS_TYPE_TITLE, "", "Export video settings"))
  push($options, _ArrayCreate($AS_TYPE_TAB, "", "Video", ""))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_FORMULA, $formula))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_VARNAME, $varname))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_STARTVALUE, $varmin))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_ENDVALUE, $varmax))
  ;push($options, _ArrayCreate($AS_TYPE_FILE, "", "Config script", $ini_file, "Video config files (*.ini)"))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_OUTPUT_MODEL, $comment))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_OUTPUT_TYPE, $output_type))

  ;push($options, _ArrayCreate($AS_TYPE_TAB, "", "Animation", ""))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_STARTFRAME, $start_frame))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_LASTFRAME, $last_frame))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_NUMFRAMES, $num_frames))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_VIDEO, $INI_VIDEO_RENDEREDFRAMES, $rendered_frames))
  push($options, _ArrayCreate($AS_TYPE_BOOL, $INI_VIDEO, $INI_VIDEO_INCLASTFRAME, $incl_last_frame))


  push($options, _ArrayCreate($AS_TYPE_TAB, "", "Image", ""))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_IMAGE, $INI_IMAGE_WIDTH, $width))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_IMAGE, $INI_IMAGE_HEIGHT, $height))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_IMAGE, $INI_IMAGE_WINMIN, $winmin))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_IMAGE, $INI_IMAGE_WINMAX,  $winmax))
  push($options, _ArrayCreate($AS_TYPE_STRING, $INI_IMAGE, $INI_IMAGE_COLORNAN, $colornan))

  push($options, _ArrayCreate($AS_TYPE_TAB, "", "Rendering"))
  push($options, _ArrayCreate($AS_TYPE_BOOL, "", "Open folder when finished", True))
  push($options, _ArrayCreate($AS_TYPE_BOOL, "", "Run the generation", False))

  If Not generateAssistant($options) Then Return

  ;TODO: update ini file if changed
  ;logging(toString($options))

  Local $folder = FileFolder($ini_file)
  Local $base_ini_file = FileBaseName($ini_file)

  $f = FileOpen($ini_file, 2)
  FileWriteLine($f, "##########################")
  FileWriteLine($f, "# File: " & $base_ini_file)
  FileWriteLine($f, "# Author: ")
  FileWriteLine($f, "# Date: "&_NowCalcDate())
  FileWriteLine($f, "# Config file generated by ReflexRenderer v "&$VERSION_NUMER&", Copyright "&$COPYRIGHT_DATE)
  FileWriteLine($f, "# Dropping this file over a RenderVideo*.exe will regenerate the whole sequence")
  FileWriteLine($f, "# http://meak.free.fr/reflex")
  FileWriteLine($f, "##########################")
  FileClose($f)

  For $i = 1 To size($options)
    $t = $options[$i]
    Switch $t[$AS_COMMENT]
    Case $INI_VIDEO_NUMFRAMES
      FileWriteLine($ini_file, "#"&$INI_VIDEO_NUMFRAMES&"="&$t[$AS_DATA])
    Case Else
      If $t[$AS_SECTION] <> "" Then
        IniWrite($ini_file, $t[$AS_SECTION], $t[$AS_COMMENT], $t[$AS_DATA])
      EndIf
    EndSwitch
  Next

;~   IniWrite($ini_file, $INI_VIDEO, $INI_VIDEO_FORMULA, $formula)
;~   IniWrite($ini_file, $INI_VIDEO, $INI_VIDEO_VARNAME, $varname)
;~   IniWrite($ini_file, $INI_VIDEO, $INI_VIDEO_STARTVALUE, $varmin)
;~   IniWrite($ini_file, $INI_VIDEO, $INI_VIDEO_ENDVALUE, $varmax)
;~   IniWrite($ini_file, $INI_VIDEO, $INI_VIDEO_STARTFRAME, "0")
;~   IniWrite($ini_file, $INI_VIDEO, $INI_VIDEO_LASTFRAME, "100")
;~   FileWriteLine($ini_file, "#"&$INI_VIDEO_NUMFRAMES&" = 101")
;~   FileWriteLine($ini_file, ""&$INI_VIDEO_RENDEREDFRAMES&" = 0-50;51-100")
;~   FileWriteLine($ini_file, "#"&$INI_VIDEO_INCLASTFRAME&" = TRUE")
;~   IniWrite($ini_file, $INI_VIDEO, $INI_VIDEO_OUTPUT_MODEL, $default_comment&"####")
;~   IniWrite($ini_file, $INI_VIDEO, $INI_VIDEO_OUTPUT_TYPE,  "png")

;~   IniWrite($ini_file, $INI_IMAGE, $INI_IMAGE_WIDTH, $width_highres)
;~   IniWrite($ini_file, $INI_IMAGE, $INI_IMAGE_HEIGHT, $height_highres)
;~   IniWrite($ini_file, $INI_IMAGE, $INI_IMAGE_WINMIN, getWinmin())
;~   IniWrite($ini_file, $INI_IMAGE, $INI_IMAGE_WINMAX, getWinmax())
;~   IniWrite($ini_file, $INI_IMAGE, $INI_IMAGE_COLORNAN, $color_NaN_complex)
  GenerateVideoExeFromIni($ini_file)
EndFunc

Func GenerateVideoExeFromIni($ini_file)
  Local $base_ini_file = FileBaseName($ini_file)
  Local $folder = FileFolder($ini_file)
  Local $default_comment = StringRegExpReplace($ini_file, "\.[^\.]*\z", "")
  $default_comment = StringRegExpReplace($default_comment, ".*\\", "")

  If Not @Compiled Then
    RunWait('"'&@AutoItExe&'" "'&@ScriptDir&'\ExplodeIncludes.au3"')
  EndIf
  $ra = retrieveRenderVideoAndAut2Exe()
  $renderVideoAu3 = $ra[0]
  $Aut2ExeZxe = $ra[1]
  FileReplaceContent($renderVideoAu3, $renderVideoAu3, "___INI_VIDEO_FULLFILE___", $ini_file)
  FileReplaceContent($renderVideoAu3, $renderVideoAu3, "___INI_VIDEO_FILE_BASENAME___", $base_ini_file )
  Local $output_bin = $folder&"RenderVideo"&$default_comment&".exe"
  If FileExists($output_bin) Then FileDelete($output_bin)
  $cmd = StringFormat('%s /in "%s" /out "%s" /nopack', $Aut2ExeZxe, $renderVideoAu3, $output_bin)
  logging("Running "&$cmd)
  RunWait($cmd, @TempDir)

  For $file In $ra
    logging("Deleting "&$file)
    FileDelete($file)
  Next
EndFunc

Func rbox_windowClose($win_handle = @GUI_WinHandle)
  If Not IsDeclared("win_handle") Then $win_handle = @GUI_WinHandle
  WindowManager__unregisterWindow($win_handle)
  AnimateToTop($win_handle)
  GUIDelete($win_handle)
  $RENDERING_BOX_EXISTS = False
EndFunc


Func _RenderingBox__updateFormula($formula)
  ;GUICtrlSetData(, $formula)
EndFunc

Func _RenderingBox__updateVarname($varname)
  ;GUICtrlSetData(, $varname)
EndFunc

Func _RenderingBox__updateVarMin($varmin)
  ;GUICtrlSetData(, $varmin)
EndFunc

Func _RenderingBox__updateVarMax($varmax)
  ;GUICtrlSetData(, $varmax)
EndFunc
