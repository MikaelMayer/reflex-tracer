#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2009/09/21

 Script Function:
  Opens a Quick Save Box to save Formula and/or Reflex.

#ce ----------------------------------------------------------------------------
;testIncrementName()

#include-once
#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <ComboConstants.au3>
#include <GDIPlus.au3>
#include <GUIListBox.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>

#include "SaveBox.au3"
#include "translations.au3"
#include "WindowManager.au3"

Global $QUICKSAVE_BOX_EXISTS = False
Global $QUICKSAVE_BOX_CALLBACK="", $QUICKSAVE_BOX_PARENT_WINDOW = 0
Global $qs_width_value = -1, $qs_height_value = -1
Global $qs_background_value = False
Global $current_ratio = ""

Func QuickSaveBox__setParentWindow($win)
  $SAVE_BOX_PARENT_WINDOW = $win
EndFunc

#Region ### Form Variables
Global $qs_win=0, $qs_comment=0, $qs_resolution_list=0, $qs_width=0, $qs_height=0, $qs_label=0, $qs_ok=0, $qs_background=0
#EndRegion ### Form Variables

Func generateQuickSaveBox($parent, $ratio, $comment)
  If $QUICKSAVE_BOX_EXISTS Then
    If Not ($parent == 0) Then
      QuickSaveBox__MoveCenter(WinGetPos($parent))
    EndIf
    _QuickSaveBox__Activate()
    Return
  EndIf
  $QUICKSAVE_BOX_EXISTS = True

  #Region ### START Koda GUI section ### Form=C:\Documents and Settings\Mikaël\Mes documents\Reflex\LogicielOrdi\RenderReflex\ReflexRendererQuickSaveBox.kxf
  $qs_win = GUICreate($__quick_save__, 178, 173, 396, 188, BitOR($WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_BORDER,$WS_CLIPSIBLINGS))
  GUISetOnEvent($GUI_EVENT_CLOSE, "qs_winClose")
  GUISetOnEvent($GUI_EVENT_MINIMIZE, "qs_winMinimize")
  GUISetOnEvent($GUI_EVENT_MAXIMIZE, "qs_winMaximize")
  GUISetOnEvent($GUI_EVENT_RESTORE, "qs_winRestore")
  $qs_comment = GUICtrlCreateInput("Give a comment !", 8, 113, 161, 21)
  GUICtrlSetOnEvent(-1, "qs_commentChange")
  $qs_resolution_list = GUICtrlCreateList("", 8, 65, 97, 45, BitOR($WS_VSCROLL,$WS_BORDER))
  GUICtrlSetData(-1, "1280x800|16000x16000|16000x8000|1640x1024")
  GUICtrlSetOnEvent(-1, "qs_resolution_listClick")
  $qs_width = GUICtrlCreateInput("", 111, 65, 57, 21)
  GUICtrlSetOnEvent(-1, "qs_widthChange")
  $qs_height = GUICtrlCreateInput("", 111, 89, 57, 21)
  GUICtrlSetOnEvent(-1, "qs_heightChange")
  $qs_label = GUICtrlCreateLabel($__quick_save_that__, 8, 12, 164, 49)
  GUICtrlSetOnEvent(-1, "qs_labelClick")
  $qs_ok = GUICtrlCreateButton($__ok__, 8, 137, 81, 25, $BS_DEFPUSHBUTTON)
  GUICtrlSetOnEvent(-1, "qs_okClick")
  $qs_background = GUICtrlCreateCheckbox($__render_background__, 93, 141, 73, 17)
  GUICtrlSetOnEvent(-1, "qs_backgroundClick")
  GUICtrlSetTip(-1, $__render_background_hint__)
  #EndRegion ### END Koda GUI section ###

  GUICtrlSetData($qs_label, $Give_a_comment_for_this_reflex_&@CRLF& _
      StringFormat($To_change_the_saving_directory__go_to, _
      StringReplace($__tools__, "&", ""), _
      StringReplace($__menu_save__, "&", "")))
  Local $resolution_list = $resolutions_43
  If $ratio = "1:1" Then
    $resolution_list = $resolutions_11
  ElseIf $ratio = "2:1" Then
    $resolution_list = $resolutions_21
  ElseIf $ratio = "4:3" Then
    $resolution_list = $resolutions_43
  ElseIf $ratio = "8:5" Then
    $resolution_list = $resolutions_85
  ElseIf $ratio = "210:297" Then
    $resolution_list = $resolutions_A4
  Else
    $resolution_list = $resolutions_43
  EndIf
  GUICtrlSetData($qs_resolution_list, $resolution_list)

  If $current_ratio <> $ratio Or $qs_width_value == -1 Or $qs_height_value == -1 Then
    $current = StringSplit($resolution_list, "|")
    If $current[0] > 2 Then
      GUICtrlSetData($qs_resolution_list, $current[$current[0]-1])
      GUICtrlSetData($qs_resolution_list, $current[$current[0]-2])
      qs_resolution_listClick()
    EndIf
  Else
    GUICtrlSetData($qs_width, $qs_width_value)
    GUICtrlSetData($qs_height, $qs_height_value)
  EndIf
  check($qs_background, $qs_background_value)
  $current_ratio = $ratio

  $defaultComment = $comment
  $defaultComment = getFirstAvailableComment($defaultComment)
  GUICtrlSetData($qs_comment, $defaultComment)
  ;GUICtrlSetData($sq_resolution_list, "Custom")
  If $parent <> 0 Then
    QuickSaveBox__MoveCenter(WinGetPos($parent))
  EndIf

  GUISetState(@SW_SHOW, $qs_win)
  WinSetOnTop($qs_win, "", 1)
EndFunc

Func qs_backgroundClick()
  $qs_background_value = IsChecked($qs_background)
EndFunc

Func QuickSaveBox__MoveCenter($c)
  Local $p = WinGetPos($qs_win)
  WinMove($qs_win, "", $c[0]+$c[2]/2-$p[0]/2, $c[1]+$c[3]/2-$p[1]/2)
EndFunc
Func _QuickSaveBox__Activate()
  WinActivate($qs_win)
EndFunc

Func qs_updateWidth($value = Default)
  If $value <> Default And $value > 0 Then
    GUICtrlSetData($qs_width, $value)
  EndIf
  $qs_width_value = GUICtrlRead($qs_width)
EndFunc
Func qs_updateHeight($value = Default)
  If $value <> Default And $value > 0 Then
    GUICtrlSetData($qs_height, $value)
  EndIf
  $qs_height_value = GUICtrlRead($qs_height)
EndFunc

Func qs_resolution_listClick()
  Local $selected = GUICtrlRead($qs_resolution_list)
  Local $dims = StringSplit($selected, "x")
  If $dims[0] <> 2 Then Return
  qs_updateWidth($dims[1])
  qs_updateHeight($dims[2])
  GUICtrlSetState ($qs_comment, $GUI_FOCUS)
EndFunc
Func qs_widthChange()
  If Int(GUICtrlRead($qs_width)) <= 0 Then
    GUICtrlSetData($qs_width, $qs_width_value)
  Else
    GUICtrlSetData($qs_resolution_list, "Custom")
    qs_updateWidth()
  EndIf
EndFunc
Func qs_heightChange()
  If Int(GUICtrlRead($qs_height)) <= 0 Then
    GUICtrlSetData($qs_height, $qs_height_value)
  Else
    GUICtrlSetData($qs_resolution_list, "Custom")
    qs_updateHeight()
  EndIf
EndFunc
Func qs_labelClick()
EndFunc
Func qs_commentChange()
EndFunc
Func qs_okClick()
  $result = GUICtrlRead($qs_comment)
  If $result == "" Then Return

  SaveBox__updateComment($result)
  $rri_comment = $result
  SaveSession()
  If isSavebox('useComment') Then
    $rfn = reflexFileNameFromComment( _
        IniReadSavebox('formulaComment',$result), _
        IniReadSavebox('formulaFile',''), _
        IniReadSavebox('Extension','') )
    ;logging("formulaComment = "&IniReadSavebox('formulaComment',$result))
    ;logging("$rfn = "&$rfn)
    if $rfn == '' Then
      MsgBox(0, '', $Error_while_quick_saving_in_file)
      Return
    EndIf
    IniWriteSavebox('reflexFile', $rfn)
  EndIf
  Local $width_local = GUICtrlRead($qs_width)
  Local $height_local = GUICtrlRead($qs_height)
  qs_winClose()
  saveboxSave($width_local, $height_local, $qs_background_value)
EndFunc

Func qs_winClose()
  GUIDelete($qs_win)
  $QUICKSAVE_BOX_EXISTS = False
EndFunc
Func qs_winMinimize()
EndFunc
Func qs_winMaximize()
EndFunc
Func qs_winRestore()
EndFunc
