#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2008/07/02

 Script Function:
  Opens a Save Box to save Formula and/or Reflex.

#ce ----------------------------------------------------------------------------
;testIncrementName()

#include-once
#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <ComboConstants.au3>
#include <GDIPlus.au3>
#include "IniHandling.au3"
#include "translations.au3"
#include "WindowManager.au3"

Global $SAVE_BOX_EXISTS = False
Global $SAVE_BOX_CALLBACK="", $SAVE_BOX_PARENT_WINDOW = 0
Global $formula_group_controls, $reflex_group_controls, $saveboxParametersMap, $saveboxCheckBoxMap

Global $SaveBox__comment = ""

Func SaveBox__setParentWindow($win)
  $SAVE_BOX_PARENT_WINDOW = $win
EndFunc

Func LoadSavebox($saveboxParametersMap, $saveboxCheckBoxMap)
  for $singlemap in $saveboxParametersMap
    LoadSaveboxParameter($singlemap[0], $singlemap[1], $singlemap[2])
  Next
  for $singlemap in $saveboxCheckBoxMap
    LoadSaveboxCheckBox($singlemap[0], $singlemap[1], $singlemap[2])
  Next
EndFunc

Func SaveSavebox($saveboxParametersMap, $saveboxCheckBoxMap)
  For $singlemap in $saveboxParametersMap
    SaveSaveboxParameter($singlemap[0], $singlemap[1])
  Next
  For $singlemap in $saveboxCheckBoxMap
    SaveSaveboxCheckBox($singlemap[0], $singlemap[1])
  Next
EndFunc

#Region ### Form Variables
Global $sb_savebox=0, $sb_saving_parameters=0, $sb_save_fr=0, $sb_save_f=0, $sb_save_r=0, $sb_save_button=0, $sb_cancel_button=0, $sb_save_formula=0, $sb_formula_comment=0, $sb_save_comment=0, $sb_formula_filename=0, $sb_open_formula_file=0, $sb_LabelFormulaFileName=0, $sb_LabelFormulaComment=0, $sb_save_window=0, $sb_save_resolution=0, $sb_Label1=0, $sb_save_reflex=0, $sb_save_highres_reflex=0, $sb_save_last_reflex=0, $sb_save_lowres_reflex=0, $sb_LabelReflexFileName=0, $sb_reflex_extension=0, $sb_reflex_filename=0, $sb_new_reflex_filename=0, $sb_use_formula_comment=0, $sb_save_settings=0
#EndRegion ### Form Variables

Func generateSaveBox($coordinates = 0)
  If $SAVE_BOX_EXISTS Then
    If Not $coordinates == 0 Then
      SaveBox__Move($coordinates)
    EndIf
    _SaveBox__Activate()
    Return
  EndIf
  $SAVE_BOX_EXISTS = True

  #Region ### START Koda GUI section ### Form=C:\Documents and Settings\Mikaël\Mes documents\Reflex\LogicielOrdi\RenderReflex\ReflexRendererSaveBox.kxf
  $sb_savebox = GUICreate($__save_reflex_and_or_formula__, 283, 381, 252, 153)
  GUISetOnEvent($GUI_EVENT_CLOSE, "sb_saveboxClose")
  GUISetOnEvent($GUI_EVENT_MINIMIZE, "sb_saveboxMinimize")
  GUISetOnEvent($GUI_EVENT_MAXIMIZE, "sb_saveboxMaximize")
  GUISetOnEvent($GUI_EVENT_RESTORE, "sb_saveboxRestore")
  $sb_saving_parameters = GUICtrlCreateGroup($__saving_parameters__, 9, 5, 153, 86)
  $sb_save_fr = GUICtrlCreateRadio($__save_formula_reflex__, 20, 24, 136, 17)
  GUICtrlSetState($sb_save_fr, $GUI_CHECKED)
  GUICtrlSetOnEvent($sb_save_fr, "sb_save_typeClick")
  $sb_save_f = GUICtrlCreateRadio($__save_only_formula__, 20, 45, 136, 17)
  GUICtrlSetOnEvent($sb_save_f, "sb_save_typeClick")
  $sb_save_r = GUICtrlCreateRadio($__save_only_reflex__, 20, 67, 136, 17)
  GUICtrlSetOnEvent($sb_save_r, "sb_save_typeClick")
  GUICtrlCreateGroup("", -99, -99, 1, 1)
  $sb_save_button = GUICtrlCreateButton($__save_button__, 169, 13, 105, 25, 0)
  GUICtrlSetOnEvent($sb_save_button, "sb_save_buttonClick")
  GUICtrlSetTip($sb_save_button, $__hint_save_all_button__)
  $sb_cancel_button = GUICtrlCreateButton($__cancel_button__, 169, 64, 105, 25, 0)
  GUICtrlSetOnEvent($sb_cancel_button, "sb_cancel_buttonClick")
  $sb_save_formula = GUICtrlCreateGroup($__save_formula_group__, 9, 93, 265, 131)
  $sb_formula_comment = GUICtrlCreateInput($__my_nice_function__, 82, 111, 185, 21)
  GUICtrlSetOnEvent($sb_formula_comment, "sb_formula_commentChange")
  $sb_save_comment = GUICtrlCreateCheckbox($__save_comment__, 18, 154, 121, 17)
  GUICtrlSetState($sb_save_comment, $GUI_CHECKED)
  GUICtrlSetOnEvent($sb_save_comment, "sb_save_withClick")
  $sb_formula_filename = GUICtrlCreateInput("c:\Images\fileFormula.txt", 16, 195, 217, 21)
  GUICtrlSetOnEvent($sb_formula_filename, "sb_formula_filenameChange")
  $sb_open_formula_file = GUICtrlCreateButton("...", 239, 196, 28, 20, 0)
  GUICtrlSetOnEvent($sb_open_formula_file, "sb_open_formula_fileClick")
  $sb_LabelFormulaFileName = GUICtrlCreateLabel($__formula_file_name__, 17, 178, 129, 17)
  GUICtrlSetOnEvent($sb_LabelFormulaFileName, "sb_LabelFormulaFileNameClick")
  $sb_LabelFormulaComment = GUICtrlCreateLabel($__comment__, 16, 113, 64, 17, $SS_RIGHT)
  GUICtrlSetOnEvent($sb_LabelFormulaComment, "sb_LabelFormulaCommentClick")
  $sb_save_window = GUICtrlCreateCheckbox($__save_window__, 146, 135, 113, 17)
  GUICtrlSetState($sb_save_window, $GUI_CHECKED)
  GUICtrlSetOnEvent($sb_save_window, "sb_save_withClick")
  $sb_save_resolution = GUICtrlCreateCheckbox($__save_resolution__, 146, 154, 117, 17)
  GUICtrlSetState($sb_save_resolution, $GUI_CHECKED)
  GUICtrlSetOnEvent($sb_save_resolution, "sb_save_withClick")
  $sb_Label1 = GUICtrlCreateLabel($__save_with__, 20, 136, 92, 17)
  GUICtrlSetOnEvent($sb_Label1, "sb_Label1Click")
  GUICtrlCreateGroup("", -99, -99, 1, 1)
  $sb_save_reflex = GUICtrlCreateGroup($__save_reflex_group__, 9, 226, 265, 145)
  $sb_save_highres_reflex = GUICtrlCreateRadio($__high_resolution_reflex__, 19, 244, 193, 17)
  GUICtrlSetState($sb_save_highres_reflex, $GUI_CHECKED)
  GUICtrlSetOnEvent($sb_save_highres_reflex, "sb_save_reflex_typeClick")
  $sb_save_last_reflex = GUICtrlCreateRadio($__copy_last_reflex__, 19, 261, 193, 17)
  GUICtrlSetOnEvent($sb_save_last_reflex, "sb_save_reflex_typeClick")
  $sb_save_lowres_reflex = GUICtrlCreateRadio($__low_resolution_reflex__, 19, 279, 193, 17)
  GUICtrlSetOnEvent($sb_save_lowres_reflex, "sb_save_reflex_typeClick")
  $sb_LabelReflexFileName = GUICtrlCreateLabel($__reflex_file_name__, 22, 304, 120, 17)
  GUICtrlSetOnEvent($sb_LabelReflexFileName, "sb_LabelReflexFileNameClick")
  $sb_reflex_extension = GUICtrlCreateCombo("Jpeg (*.jpg)", 167, 298, 97, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
  GUICtrlSetData($sb_reflex_extension, "PNG (*.png)|Bitmap (*.bmp)")
  GUICtrlSetOnEvent($sb_reflex_extension, "sb_reflex_extensionChange")
  $sb_reflex_filename = GUICtrlCreateInput("c:\Images\My nice function.jpg", 19, 321, 217, 21)
  GUICtrlSetOnEvent($sb_reflex_filename, "sb_reflex_filenameChange")
  GUICtrlSetState($sb_reflex_filename, $GUI_DISABLE)
  $sb_new_reflex_filename = GUICtrlCreateButton("...", 238, 321, 28, 20, 0)
  GUICtrlSetOnEvent($sb_new_reflex_filename, "sb_new_reflex_filenameClick")
  $sb_use_formula_comment = GUICtrlCreateCheckbox($__use_formula_comment__, 19, 347, 249, 17)
  GUICtrlSetState($sb_use_formula_comment, $GUI_CHECKED)
  GUICtrlSetOnEvent($sb_use_formula_comment, "sb_use_formula_commentClick")
  GUICtrlSetTip($sb_use_formula_comment, $__hint_use_formula_comment__)
  GUICtrlCreateGroup("", -99, -99, 1, 1)
  $sb_save_settings = GUICtrlCreateButton($__just_save_settings__, 169, 39, 105, 25, 0)
  GUICtrlSetOnEvent($sb_save_settings, "sb_save_settingsClick")
  GUICtrlSetTip($sb_save_settings, $__hint_save_options_button__)
  #EndRegion ### END Koda GUI section ###

  ;#include "SaveBox_lang.au3"
  ;$sb_formula_comment, _
  ;$sb_LabelFormulaComment _
  $formula_group_controls = _ArrayCreate( _
    $sb_formula_filename, _
    $sb_open_formula_file, _
    $sb_LabelFormulaFileName _
  )
  $reflex_group_controls = _ArrayCreate( _
    $sb_save_highres_reflex, _
    $sb_save_last_reflex, _
	$sb_save_lowres_reflex, _
    $sb_LabelReflexFileName, _
    $sb_reflex_extension, _
    $sb_reflex_filename, _
    $sb_new_reflex_filename, _
    $sb_use_formula_comment _
  )

  $saveboxParametersMap = _ArrayCreate( _
   _ArrayCreate('formulaComment', $sb_formula_comment, 'My nice function'), _
   _ArrayCreate('formulaFile', $sb_formula_filename, '%MY_DOCUMENTS%\Reflex\formulas.txt'), _
   _ArrayCreate('Extension', $sb_reflex_extension, 'Jpeg (*.jpg)'), _
   _ArrayCreate('reflexFile', $sb_reflex_filename, '%MY_DOCUMENTS%\Reflex\My nice function.jpg') _
  )

  $saveboxCheckBoxMap = _ArrayCreate( _
   _ArrayCreate('saveBoth', $sb_save_fr, 'TRUE'), _
   _ArrayCreate('saveFormula', $sb_save_f, 'FALSE'), _
   _ArrayCreate('saveReflex', $sb_save_r, 'FALSE'), _
   _ArrayCreate('saveComment', $sb_save_comment, 'TRUE'), _
   _ArrayCreate('saveWindow', $sb_save_window, 'TRUE'), _
   _ArrayCreate('saveResolution', $sb_save_resolution, 'TRUE'), _
   _ArrayCreate('HRReflex', $sb_save_highres_reflex, 'TRUE'), _
   _ArrayCreate('CopyLast', $sb_save_last_reflex, 'FALSE'), _
   _ArrayCreate('LRReflex', $sb_save_lowres_reflex, 'FALSE'), _
   _ArrayCreate('useComment', $sb_use_formula_comment, 'TRUE') _
  )

  LoadSavebox($saveboxParametersMap, $saveboxCheckBoxMap)
  GUICtrlSetData($sb_formula_filename, UpdateMyDocuments(GUICtrlRead($sb_formula_filename)))
  GUICtrlSetData($sb_reflex_filename, UpdateMyDocuments(GUICtrlRead($sb_reflex_filename)))

  EnableDisableGroups($sb_save_fr, $sb_save_f, $sb_save_r, $formula_group_controls, $reflex_group_controls)
  $returnValue = -1
  maybeUpdateReflexFilename($sb_formula_comment, $sb_formula_filename, _
  $sb_use_formula_comment, $sb_reflex_filename, $sb_reflex_extension)

  If $SAVE_BOX_PARENT_WINDOW <> 0 And $coordinates == 0 Then
    $pos = WinGetPos($SAVE_BOX_PARENT_WINDOW)
    WinMove($sb_savebox, "", $pos[0]+$pos[2], $pos[1])
  EndIf
  If Not $coordinates == 0 Then
    SaveBox__Move($coordinates)
  EndIf

  ;TODO: Save the temp parameters somewhere before closing (?)
  WindowManager__registerWindow($sb_savebox, "SaveBox", "DeleteSaveBox")

  AnimateFromLeft($sb_savebox)
  GUISetState(@SW_SHOW, $sb_savebox)
EndFunc

Func SaveBox__Move($coordinates)
  WinMove($sb_savebox, "", $coordinates[0], $coordinates[1], $coordinates[2], $coordinates[3])
EndFunc

; Functions to save and load the EditFormula window
; TODO: finir!!
WindowManager__addLoadSaveFunctionForType("SaveBox", "SaveBox__LoadFromIni", "SaveBox__SaveKeyValue")
Func SaveBox__LoadFromIni($value)
  ;Value contains the coordinates of the save box
  $values = StringSplit($value, ";", 1)
  If $values[$LENGTH_SIZED_ARRAY_INDEX] = 0 Then
    Dim $p[4]
    $p[0] = pop($values)
    $p[1] = pop($values)
    $p[2] = pop($values)
    $p[3] = pop($values)
    SaveBox__createInstance($p)
  Else
    SaveBox__createInstance()
  EndIf
EndFunc
Func SaveBox__SaveKeyValue($win_handle)
  $pos = WinGetPos($win_handle, "")
  Return _ArrayToString($pos, ";")
EndFunc

Func _SaveBox__Activate()
  WinActivate($sb_savebox)
EndFunc

Func DeleteSaveBox($win_handle=$sb_savebox)
  logging("SaveBox.au3 : "&$win_handle)
  If $SAVE_BOX_EXISTS Then
    AnimateToLeft($win_handle)
    GUIDelete($win_handle)
    WindowManager__unregisterWindow($win_handle)
    $SAVE_BOX_EXISTS = False
  EndIf
EndFunc

Func sb_saveboxClose()
  DeleteSaveBox()
EndFunc

Func sb_saveboxMaximize()
EndFunc
Func sb_saveboxMinimize()
EndFunc
Func sb_saveboxRestore()
EndFunc

Func sb_cancel_buttonClick()
  sb_saveboxClose()
EndFunc

Func sb_formula_commentSet($new_comment)
  If $SAVE_BOX_EXISTS Then
    GUICtrlSetData($sb_formula_comment, $new_comment)
    sb_formula_commentChange()
  EndIf
EndFunc

Func SaveBox__updateComment($new_comment)
  $SaveBox__comment = $new_comment
  sb_formula_commentSet($new_comment)
  IniWriteSavebox('formulaComment', $new_comment)
EndFunc
Func sb_formula_commentChange()
  sb_save_withClick()
EndFunc

Func sb_formula_filenameChange()

EndFunc

Func sb_new_reflex_filenameClick()
  $f = FileSaveDialog($New_Reflex_file, '', $Bitmap_24_bits____bmp__Jpeg____jpg_ , 16, IniReadSavebox('reflexFile', ''))
  if @error <> 1 Then
    FileChangeDir(@ScriptDir)
    GUICtrlSetData($sb_reflex_filename, $f)
    GUICtrlSetState($sb_use_formula_comment, $GUI_UNCHECKED)
  EndIf
EndFunc

Func sb_open_formula_fileClick()
    $f = FileOpenDialog($Open_Formula_file, '', $Formula_file____txt__All______ , 8, IniReadSavebox('formulaFile', ''))
    if @error <> 1 Then
      FileChangeDir(@ScriptDir)
      GUICtrlSetData($sb_formula_filename, $f)
      maybeUpdateReflexFilename($sb_formula_comment, $sb_formula_filename, _
        $sb_use_formula_comment, $sb_reflex_filename, $sb_reflex_extension)
    EndIf
EndFunc

Func sb_reflex_extensionChange()
  sb_save_withClick()
EndFunc

Func sb_reflex_filenameChange()
  GUICtrlSetState($sb_use_formula_comment, $GUI_UNCHECKED)
EndFunc

Func sb_save_buttonClick()
  SaveSavebox($saveboxParametersMap, $saveboxCheckBoxMap)
  Call($SAVE_BOX_CALLBACK, 1)
EndFunc

Func sb_save_reflex_typeClick()

EndFunc

Func sb_save_settingsClick()
  SaveSavebox($saveboxParametersMap, $saveboxCheckBoxMap)
  ; TODO: export that:
  $rri_comment = GUICtrlRead($sb_formula_comment)
EndFunc

Func sb_save_typeClick()
  EnableDisableGroups($sb_save_fr, $sb_save_f, $sb_save_r, $formula_group_controls, $reflex_group_controls)
EndFunc

Func sb_save_withClick()
  maybeUpdateReflexFilename($sb_formula_comment, $sb_formula_filename, _
      $sb_use_formula_comment, $sb_reflex_filename, $sb_reflex_extension)
EndFunc

Func sb_use_formula_commentClick()
  sb_save_withClick()
EndFunc

Func SaveBox__setCallbackFunction($callback)
  $SAVE_BOX_CALLBACK = $callback
EndFunc

Func SaveBox__createInstance($coordinates = 0)
  generateSaveBox($coordinates)
EndFunc

Func AllGUIctrlSetState($gui_controls, $state)
  For $control in $gui_controls
    GUICtrlSetState($control, $state)
  Next
EndFunc

Func EnableDisableGroups($sb_save_fr, $sb_save_f, $sb_save_r, $formula_group_controls, $reflex_group_controls)
  $fr = BitAnd(GUICtrlRead($sb_save_fr),$GUI_CHECKED)
  $f = BitAnd(GUICtrlRead($sb_save_f),$GUI_CHECKED)
  $r = BitAnd(GUICtrlRead($sb_save_r),$GUI_CHECKED)
  If $fr Or $f Then
    AllGUIctrlSetState($formula_group_controls, $GUI_ENABLE)
  Else
    AllGUIctrlSetState($formula_group_controls, $GUI_DISABLE)
  EndIf
  If $fr Or $r Then
    AllGUIctrlSetState($reflex_group_controls, $GUI_ENABLE)
  Else
    AllGUIctrlSetState($reflex_group_controls, $GUI_DISABLE)
  EndIf
EndFunc

Func maybeUpdateReflexFilename($sb_formula_comment, $sb_formula_filename, _
                               $sb_use_formula_comment, $sb_reflex_filename, $sb_reflex_extension)
  If BitAnd(GUICtrlRead($sb_use_formula_comment),$GUI_CHECKED) Then
    $newname = reflexFileNameFromComment( _
      GUICtrlRead($sb_formula_comment), _
      GUICtrlRead($sb_formula_filename), _
      GUICtrlRead($sb_reflex_extension))

    GUICtrlSetData($sb_reflex_filename, $newname)
    ;todo
  EndIf
EndFunc

Func saveboxSave($width_local=Default, $height_local=Default, $render_background=False)
  $save_fr = isSavebox('saveBoth')
  $save_f  = isSavebox('saveFormula') or $save_fr
  $save_r  = isSavebox('saveReflex') or $save_fr
  $continue = True
  $comment_to_increment = False

  If $save_f Then
    $continue = saveFormula()
    If Not $continue Then Return
  EndIf
  If $save_r Then
    saveReflex($width_local, $height_local, $render_background)
  EndIf
EndFunc
;saveReflex() is defined in ReflexRender.au3

Func addLine(ByRef $string, $line_withouth_crlf)
  $string &= $line_withouth_crlf&@CRLF
EndFunc

Func saveFormulaString($formula, $comment, $save_comment, $save_resolution, $save_window)
  $formula_string = ""
  If $save_comment Then
    addLine($formula_string, $comment)
  EndIf
  addLine($formula_string, $formula)
  If $save_window Or $save_resolution  Then
    $result = _ArrayCreate(0)
    ;$options_line_string
    If $save_window Then
      $wmi = IniReadSession('winmin', '')
      $wma = IniReadSession('winmax', '')
      If $wmi <> "" and $wma <> "" Then
        push($result, 'winmin='&$wmi)
        push($result, 'winmax='&$wma)
      EndIf
    EndIf
    If $save_resolution Then
      $wx = IniReadSession('width', '')
      $wy = IniReadSession('height', '')
      If $wx <> "" and $wy <> "" Then
        push($result, 'width='&$wx)
        push($result, 'height='&$wy)
      EndIf
    EndIf
    push($result, 'colornan='&Eval("color_NaN_complex"))
    If $result[0] <> 0 Then
      toBasicArray($result)
      $optline = $options_line_string&" "&_ArrayToString($result, "; ")
      addLine($formula_string, $optline)
    EndIf
  EndIf
  Return $formula_string
EndFunc

Func getFirstAvailableComment($comment, $formula_file = Default)
  If $formula_file == Default Then $formula_file = UpdateMyDocuments(IniReadSavebox('formulafile', ''))
  If FileExists($formula_file) Then
    $content = FileRead($formula_file)
    While StringInStr($content, $comment) > 0
      $comment = incrementName($comment)
    WEnd
  EndIf
  Return $comment
EndFunc

Func saveFormula($formula=Default, $comment=Default, $formula_file=Default)
  If $formula == Default Then  $formula = IniRead($ini_file, 'Session', 'formula', '')
  If $comment == Default Then  $comment = IniReadSavebox('formulaComment', '')
  If $formula_file == Default Then $formula_file = UpdateMyDocuments(IniReadSavebox('formulafile', ''))
  $comment = getFirstAvailableComment($comment, $formula_file)

  Return saveFormulaIntoFile($formula_file, $formula, $comment, isSavebox('saveComment'), isSavebox('saveResolution'), isSavebox('saveWindow'))
EndFunc

Func saveFormulaIntoFile($filename, $formula, $comment, $b_saveComment, $b_saveResolution, $b_saveWindow)
  $fileExistedBefore = FileExists($filename)
  $f = FileOpen($filename, 9)
  If $f == -1 Then
    MsgBox(0, $Error_title, StringFormat($__s__is_not_a_valid_filename__s_Saving_canceled_, $filename, @CRLF))
    Return False
  EndIf
  If $fileExistedBefore Then
    FileWriteLine($f, '')
  EndIf
  $to_be_written_for_formula = saveFormulaString($formula, _
$comment, $b_saveComment, $b_saveResolution, $b_saveWindow)
  FileWrite($f, $to_be_written_for_formula)
  FileClose($f)
  Return True
EndFunc

; Something => Something 001, Something 001=> Something 002
; Something 999=>Something 1000, Something [n]=>Something [n+1]
Func incrementName($name)
  $last_number = ""
  $size_number = -1
  $name_length = StringLen($name)
  Do
    $size_number += 1
    $char = StringMid($name, $name_length - $size_number, 1)
    If StringIsDigit($char) Then
      $last_number = $char & $last_number
    Else
      ExitLoop
    EndIf
  Until False
  If $size_number == 0 Then
    $maybe_space = " "
    If StringIsSpace(StringRight($name, 1)) Then
      $maybe_space= ""
    EndIf
    Return $name&$maybe_space&"0002"
  Else
    $last_number = String(Int($last_number)+1)
    While StringLen($last_number) < $size_number
      $last_number = "0"&$last_number
    WEnd
    Return StringMid($name, 1, $name_length - $size_number)&$last_number
  EndIf
EndFunc

Func incrementFileName($name)
  $position_extension = StringInStr($name, ".")
  Return incrementName(StringLeft($name, $position_extension-1))&StringMid($name, $position_extension)
EndFunc

Func testIncrementName()
  assertEqual(incrementName("something"), "something 0002")
  assertEqual(incrementName("something "), "something 0002")
  assertEqual(incrementName("something 0002"), "something 0003")
  assertEqual(incrementName("something 62"), "something 63")
  assertEqual(incrementName("something42"), "something43")
  assertEqual(incrementName("something99"), "something100")
  assertEqual(incrementName("something 999"), "something 1000")
  assertEqual(incrementName("something 1928"), "something 1929")
  assertEqual(incrementFileName("something.bmpk"), "something 0002.bmpk")
  ;TestFinished
  Exit
EndFunc

Func sb_Label1Click()

EndFunc
Func sb_LabelFormulaCommentClick()

EndFunc
Func sb_LabelFormulaFileNameClick()

EndFunc
Func sb_LabelReflexFileNameClick()

EndFunc

#include "ReflexRenderer.au3"

;~ Func AssertEqual($a, $b)
;~   If $a <> $b Then
;~     MsgBox(0, "Assertion error", StringFormat("%s != %s and it's bad", $a, $b))
;~     Exit
;~   EndIf
;~ EndFunc
