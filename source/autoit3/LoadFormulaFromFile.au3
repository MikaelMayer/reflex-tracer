#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer

 Script Function:
   Imports a formula from a file

#ce ----------------------------------------------------------------------------
#include-once
#include "GlobalUtils.au3"
#include 'Translations.au3'
#include "JpegHandling.au3"
#include "PngHandling.au3"

Global $LOAD_FORMULA_EXISTS = False
Global $LOAD_FORMULA_CALLBACK=""

#CS
  Format of the Formula file:
 - Blank line separated items
 - How many do not start with @: If one, this is the formula, if two, the second is the formula
 - For those which start with the formula: some check boxes with "Load windows", "Load resolution" unchecked by default.
 - If only one line selected, then it's a formula.
 - Format : [VAR]=[VALUE](; ) etc.
 @Options: Winmin=-4-4i; Winmax=4+4i; Width=401; Height=401; PercentPreview=30
 - No case sensitive / no order. Don't care about the space after or before the semicolon.
 => Preview means also that "preview" is checked.

 Detect many formulas without blank lines in between. 3 or more is easy.
 Each formula will then be on its single item.
 If 2, the first is a comment over the second.
 Automatically breaks tree after a line beginning with @Options:

 Input / output example:
==== Input file=====
Whouahou
sin(z+x)/y
@Options: Winmin=-4-4i; Winmax=4+4i; Width=401; Height=401; PercentPreview=30
belle fonction
cos(z)
@Options:
g(z)
h(z)
j(z)
nbout
h(z)
@Options

==== Output tree=====
Whouahou
  sin(z+x)/y
  Winmin=-4-4i
  Winmax=4+4i
  ...
belle fonction
  cos(z)
g(z)
h(z)
j(z)
nbout
h(z)
  @Options

#CE

; formula_items contains (comment ,)formula, (single options)*
;    A Formula entry consists in {A1, A2, F}
; A1= Array: All treeViewItems controls that have been created for that particular entry
; A2= Array: If comment/window/resolution for this entry
; F = Formula, Comment, Window, Resolution.

Dim $ALL_FORMULAS
Dim $formula_entry_map = emptySizedArray()
Global Enum $BLANK_LINE = 401, $COMMENT_OR_FORMULA, $OPTIONS_LINE
Global Enum $FORMULA_ENTRY_TREEVIEWITEMS = 0, $FORMULA_ENTRY_IFOPTIONS, $FORMULA_ENTRY_OPTIONS, $FORMULA_ENTRY_SIZE
Global Enum $HAS_FORMULA, $HAS_COMMENT, $HAS_WINDOW, $HAS_RESOLUTION, $HAS_COLORNAN
Global Enum $FORMULA_ITEM_TYPE = 0, $FORMULA_ITEM_CONTENT0 = 1
Global Enum $FORMULA_ITEM_CONTENT0_KEY = 0, $FORMULA_ITEM_CONTENT0_VALUE = 1
Global $LOAD_FORMULA_PARENT_WINDOW = 0


; Line parsing : Gives a line of TYPE = "Formula"/"Comment", "BLANK" or "OPTION"
; Result: formula_item = {TYPE, Content...}
Func formulaItem($line)
  If $line == "" Then
    Return _ArrayCreate($BLANK_LINE)
  ElseIf StringCompare(StringLeft($line, StringLen($options_line_string)), $options_line_string)==0 Then
    $line = StringReplace($line, $options_line_string, "", 1)
    $parameters = StringSplit($line, ";")
    If size($parameters)==0 Then Return _ArrayCreate($BLANK_LINE)
    _ArrayDelete($parameters, 0)
    $result = _ArrayCreate($OPTIONS_LINE)
    For $key_value In $parameters
      $key_value = StringSplit($key_value, "=:")
      If size($key_value) <> 2 Then ContinueLoop
      $key = StringStripWS($key_value[1], 3)
      $value = StringStripWS($key_value[2], 3)
      _ArrayAdd($result, _ArrayCreate($key, $value))
    Next
    If UBound($result) == 1 Then Return _ArrayCreate($BLANK_LINE)
    Return $result
  Else
    Return _ArrayCreate($COMMENT_OR_FORMULA, $line)
  EndIf
  Return
EndFunc

;Build a string representation of the formula_item
Func formulaItemToString($formula_item)
  If $formula_item[$FORMULA_ITEM_TYPE]==$BLANK_LINE Then
    Return ""
  ElseIf $formula_item[$FORMULA_ITEM_TYPE]==$OPTIONS_LINE Then
    $result = emptyQueue()
    For $i = 1 To UBound($formula_item)-1
      push($result, _ArrayToString($formula_item[$i], "="))
    Next
  if isEmpty($result) Then Return "Error : bad options"
    toBasicArray($result)
    Return _ArrayToString($result, ', ')
  ElseIf $formula_item[$FORMULA_ITEM_TYPE]==$COMMENT_OR_FORMULA Then
    Return $formula_item[$FORMULA_ITEM_CONTENT0];
  Else
    Return "Error : not a formula item"
	EndIf
EndFunc

Func addFormulaItem(ByRef $array, $line)
  $f = formulaItem($line)
  push($array, $f)
EndFunc

Func loadLinesIntoTreeControl($filepath, $tree_control)
  $file = FileOpen($filepath, 0)
  $ALL_FORMULAS = emptySizedArray()
  if @error == -1 Then
    Return -1
  EndIf
  While True
    $line = FileReadLine($file)
    if @error <> 0 Then
      ExitLoop
    EndIf
    addFormulaItem($ALL_FORMULAS, $line)
  WEnd
  If isEmpty($ALL_FORMULAS) Then Return -1
  toBasicArray($ALL_FORMULAS)
  CreateTreeControl($ALL_FORMULAS, $tree_control)
EndFunc

Func ResetTreeControl()
  For $i=1 To size($formula_entry_map)
    $formula_entry = $formula_entry_map[$i]
    Local $treeviewitems = $formula_entry[$FORMULA_ENTRY_TREEVIEWITEMS]
    For $treeviewitem In $treeviewitems
      GUICtrlDelete($treeviewitem)
    Next
  Next
EndFunc

Func CreateTreeControl(ByRef $ALL_FORMULAS, $tree_control)
  ResetTreeControl()
  $formula_entry_map = emptySizedArray()
  $queueLinesParsed = emptyQueue()
  $readyToBeFlushed = False

  For $line_parsed In $ALL_FORMULAS
	;Logging("Parser: "&FormulaItemToString($line_parsed))
    If $line_parsed[$FORMULA_ITEM_TYPE] == $BLANK_LINE Then
      flushFormulaGroup($queueLinesParsed, $formula_entry_map, $tree_control)
    ElseIf $line_parsed[$FORMULA_ITEM_TYPE] == $OPTIONS_LINE Then
      push($queueLinesParsed, $line_parsed)
      $readyToBeFlushed = True
    Else ;COMMMENT_OR_FORMULA
      If $readyToBeFlushed Then
   ;     Logging("and flush before")
        $readyToBeFlushed = False
        flushFormulaGroup($queueLinesParsed, $formula_entry_map, $tree_control)
      EndIf
      push($queueLinesParsed, $line_parsed)
    EndIf
;~       $tmp_tree_item = GUICtrlCreateTreeViewItem($line_parsed[$FORMULA_ITEM_CONTENT0], $tree_control)
;~       push($formula_entry_map, $tmp_tree_item)
  Next
  ;Logging("end flush")
  If isNotEmpty($queueLinesParsed) Then
    flushFormulaGroup($queueLinesParsed, $formula_entry_map, $tree_control)
  EndIf
EndFunc

Func LogFormulaItems(ByRef $queue)
  logging("Queue state:")
  For $i=1 To size($queue)
    $formula_item = $queue[$i]
    Logging("  "&FormulaItemToString($formula_item))
  Next
EndFunc

;Takes a stack of FORMULA_OR_COMMENT*+OPTIONS_LINES* and expand options.
Func expandOptions(ByRef $queue)
	;Refractor code, in order to use it in the next function (load from reflex)
	;Expand options.
	$i = 1
	While $i <= size($queue)
      $item = $queue[$i]
      If $item[$FORMULA_ITEM_TYPE] == $OPTIONS_LINE Then
        $options_item = $queue[$i]
        ;Logging("  considering:"&FormulaItemToString($options_item))
        While UBound($options_item) >= 3
          ;logging("One expansion done")
          $last = _ArrayCreate($OPTIONS_LINE, _ArrayPop($options_item))
          ;Logging("  Queue length before:"&size($queue))
          ;Logging("  Moving ressource "& FormulaItemToString($last))
          ;LogFormulaItems($queue)
          insertAfter($queue, $last, $i)
          ;Logging("  options_item "& FormulaItemToString($options_item))
          ;Logging("  Queue length after:"&$size(queue))
          $queue[$i] = $options_item
          ;LogFormulaItems($queue)
        WEnd
      EndIf
      $i += 1
  WEnd
EndFunc

Func FormulaBeforeOptionsLines(ByRef $queue)
	$options_encountered = False
	For $i = 1 To size($queue)
    $item = $queue[$i]
    $option_bool = ($item[$FORMULA_ITEM_TYPE] == $OPTIONS_LINE)
		$options_encountered = $option_bool Or $options_encountered
    ; Logging("Formula_item[$FORMULA_ITEM_TYPE]="&$item[$FORMULA_ITEM_TYPE])
    If Not $option_bool and $options_encountered Then Return False
	Next
	Return True
EndFunc

Func assertFormulaBeforeOptionsLines(ByRef $queue)
	If not FormulaBeforeOptionsLines($queue) Then AssertEqual("Formula appears options", "Error 21948")
EndFunc

Func CountCertainType(ByRef $queue, $type)
	$counter = 0
	For $i = 1 To size($queue)
		$item = $queue[$i]
		If $item[$FORMULA_ITEM_TYPE] == $type Then $counter += 1
	Next
	Return $counter
EndFunc
Func CountOptionsLines($queue)
	Return CountCertainType($queue, $OPTIONS_LINE)
EndFunc
Func CountCommentOrFormula($queue)
	Return CountCertainType($queue, $COMMENT_OR_FORMULA)
EndFunc

;Takes a stack of FORMULA_OR_COMMENT*+OPTIONS_LINES*
Func flushFormulaGroup(ByRef $queue, ByRef $formula_entry_map, $tree_control)
  ;Logging("FlushFormulaGroup")
  If isEmpty($queue) Then Return
  assertFormulaBeforeOptionsLines($queue)

  $count_formula_or_comment = CountCommentOrFormula($queue)
  $count_options_lines = CountOptionsLines($queue)
  ;If only options, discard.
  If $count_formula_or_comment == 0 Then Return
  expandOptions($queue)

  If $count_formula_or_comment >= 3 Then
    ;Each line is a formula, and the options lines apply only on the last one
    For $i = 1 To $count_formula_or_comment -1
      ;Logging("102 size queue:"&size($queue))
      $tmp = _ArrayCreate(1, pop($queue))
      $formula_entry = createFormulaEntry($tmp, $tree_control)
      push($formula_entry_map, $formula_entry)
    Next
  EndIf
  ;Logging("107 & "&size($queue))
  $formula_entry = createFormulaEntry($queue, $tree_control)
  push($formula_entry_map, $formula_entry)
  While isNotEmpty($queue)
    pop($queue)
  WEnd
EndFunc

Func createFormulaEntry(ByRef $formula_items, $tree_control)
  ;The last non-option is the formula
  Dim $tree_view_items_controls = emptySizedArray()
  Dim $first = True, $firsthead
  Dim $isComment = 0, $isWindow = 0, $isResolution = 0, $isColornan = 0
  Dim $window_min = "", $window_max = "", $resolution_width = "", $resolution_height = "", $reflex_colornan = ""
  Dim $formula = "", $comment = "", $window = "; ", $resolution = " x "

  For $i = 1 To size($formula_items)
    $formula_item = $formula_items[$i]
    If $formula_item[$FORMULA_ITEM_TYPE] <> $OPTIONS_LINE Then
      $formula = $formula_item[$FORMULA_ITEM_CONTENT0]
    EndIf
    $size = size($tree_view_items_controls)
    Dim $tmp
    If $first Then ; Is not an option
      AssertEqual($COMMENT_OR_FORMULA, $formula_item[$FORMULA_ITEM_TYPE])
      $comment = $formula_item[$FORMULA_ITEM_TYPE]
      $first = False
      $tmp = GUICtrlCreateTreeViewItem($formula_item[$FORMULA_ITEM_CONTENT0], $tree_control)
      GUICtrlSetColor(-1, 0x000000)
      GUICtrlSetOnEvent(-1, "lf_ControlClick")
      $firsthead = $tmp
    Else
      ;TODO: finir ici
      ;Options: Extract if window, resolution, comment.
      $tmp = GUICtrlCreateTreeViewItem(FormulaItemToString($formula_item), $firsthead)
             GUICtrlSetOnEvent(-1, "lf_ControlClick")
      If $formula_item[$FORMULA_ITEM_TYPE] == $OPTIONS_LINE Then
        $tab = $formula_item[$FORMULA_ITEM_CONTENT0]
        If StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "winmin")==0 Then
          $isWindow = BitOR($isWindow, 1)
          $window_min = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
          GUICtrlSetColor(-1, 0x00C000)
        ElseIf StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "winmax")==0 Then
          $isWindow = BitOR($isWindow, 2)
          $window_max = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
          GUICtrlSetColor(-1, 0x00C000)
        ElseIf StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "height")==0 Then
          $isResolution = BitOR($isResolution, 1)
          $resolution_height = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
          GUICtrlSetColor(-1, 0x00A0A0)
        ElseIf StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "width")==0 Then
          $isResolution = BitOR($isResolution, 2)
          $resolution_width = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
          GUICtrlSetColor(-1, 0x00A0A0)
        ElseIf StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "colornan")==0 Then
          $isColornan = BitOR($isColornan, 1)
          $reflex_colornan = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
        EndIf
      Else
        $formula = $formula_item[$FORMULA_ITEM_CONTENT0]
        $isComment = True
        GUICtrlSetColor($firsthead, 0x0000C0)
      EndIf
    EndIf
    push($tree_view_items_controls, $tmp)
  Next
  toBasicArray($tree_view_items_controls)
  $window = StringFormat("%s, %s", $window_min, $window_max)
  $resolution = StringFormat("%s x %s", $resolution_width, $resolution_height)
  Dim $formula_entry[$FORMULA_ENTRY_SIZE]
  $formula_entry[$FORMULA_ENTRY_TREEVIEWITEMS] = $tree_view_items_controls
  $formula_entry[$FORMULA_ENTRY_IFOPTIONS]     = _ArrayCreate(True, $isComment, $isWindow==3, $isResolution==3, $isColornan)
  $formula_entry[$FORMULA_ENTRY_OPTIONS]       = _ArrayCreate($formula, $comment, $window, $resolution, $reflex_colornan)
  Return $formula_entry
EndFunc

Func lookForFormulaFile()
  $fullpath = UpdateMyDocuments(IniReadSavebox('formulaFile', ''))
  $fullpath = FileOpenDialog($Formula_File, '', $Formula_file____txt__All______, 1+2, $fullpath)
  FileChangeDir(@ScriptDir)
  return $fullpath
EndFunc

Func lookForReflexFile()
  $fullpath = UpdateMyDocuments(IniReadSavebox('formulaFile', ''))
  $fullpath = FileOpenDialog($Jpeg_Reflex_File, '', $Jpeg_Reflex_File____jpg__All______, 1+2, $fullpath)
  FileChangeDir(@ScriptDir)
  return $fullpath
EndFunc

Func formula_chooserClose()
	DeleteLoadFormulaBox()
EndFunc
Func formula_chooserMinimize()
EndFunc
Func formula_chooserMaximize()
EndFunc
Func formula_chooserRestore()
EndFunc
Func lf_labelClick()
EndFunc

#Region ### Form Variables
Global $formula_chooser=0, $lf_Label1=0, $lf_ok=0, $lf_other_file=0, $lf_import_window=0, $lf_import_resolution=0, $lf_formula_tree=0, $lf_import_comment=0
#EndRegion ### Form Variables

Func GenerateLoadFormulaBox($fullpath)
  If $LOAD_FORMULA_EXISTS Then
    Return
  EndIf
  $LOAD_FORMULA_EXISTS = True
  #Region ### START Koda GUI section ### Form=C:\Documents and Settings\Mikaël\Mes documents\Reflex\LogicielOrdi\RenderReflex\ReflexRendererFormulaList.kxf
  $formula_chooser = GUICreate($__formula_chooser__, 257, 346, 303, 219, BitOR($WS_MAXIMIZEBOX,$WS_MINIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_SYSMENU,$WS_CAPTION,$WS_OVERLAPPEDWINDOW,$WS_TILEDWINDOW,$WS_POPUP,$WS_POPUPWINDOW,$WS_GROUP,$WS_TABSTOP,$WS_BORDER,$WS_CLIPSIBLINGS))
  GUISetOnEvent($GUI_EVENT_CLOSE, "formula_chooserClose")
  GUISetOnEvent($GUI_EVENT_MINIMIZE, "formula_chooserMinimize")
  GUISetOnEvent($GUI_EVENT_MAXIMIZE, "formula_chooserMaximize")
  GUISetOnEvent($GUI_EVENT_RESTORE, "formula_chooserRestore")
  $lf_Label1 = GUICtrlCreateLabel($__choose_a_formula__, 8, 12, 108, 17)
  GUICtrlSetResizing(-1, $GUI_DOCKTOP)
  GUICtrlSetOnEvent(-1, "lf_labelClick")
  $lf_ok = GUICtrlCreateButton($__set_button__, 192, 8, 57, 25, 0)
  GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
  GUICtrlSetOnEvent(-1, "lf_OkClick")
  $lf_other_file = GUICtrlCreateButton($__other_file__, 120, 8, 65, 25, 0)
  GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
  GUICtrlSetOnEvent(-1, "lf_ControlClick")
  $lf_import_window = GUICtrlCreateCheckbox($__import_window__, 4, 32, 122, 17)
  GUICtrlSetState(-1, $GUI_CHECKED)
  GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKHEIGHT)
  GUICtrlSetOnEvent(-1, "lf_ControlClick")
  $lf_import_resolution = GUICtrlCreateCheckbox($__import_resolution__, 4, 48, 122, 17)
  GUICtrlSetState(-1, $GUI_CHECKED)
  GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKHEIGHT)
  GUICtrlSetOnEvent(-1, "lf_ControlClick")
  $lf_formula_tree = GUICtrlCreateTreeView(8, 72, 241, 265)
  GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKRIGHT+$GUI_DOCKTOP+$GUI_DOCKBOTTOM)
  GUICtrlSetOnEvent(-1, "lf_ControlClick")
  GUICtrlSetTip(-1, $__formula_chooser_hint__)
  $lf_import_comment = GUICtrlCreateCheckbox($__import_comment__, 130, 40, 122, 17)
  GUICtrlSetState(-1, $GUI_CHECKED)
  GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKHEIGHT)
  GUICtrlSetOnEvent(-1, "lf_ControlClick")
  #EndRegion ### END Koda GUI section ###
  If loadLinesIntoTreeControl($fullpath, $lf_formula_tree) == -1 Then
    ;It's an error... but should not happen
  EndIf
  $pos = WinGetPos($LOAD_FORMULA_PARENT_WINDOW)
  WinMove($formula_chooser, "", $pos[0]+$pos[2], $pos[1])
EndFunc

Func DeleteLoadFormulaBox()
  If $LOAD_FORMULA_EXISTS Then
    AnimateToLeft($formula_chooser)
    GUIDelete($formula_chooser)
    $LOAD_FORMULA_EXISTS = False
  EndIf
EndFunc

Func loadFormulaFromReflex()
  $fullpath = lookForReflexFile()
  LoadFormulaFromFile__LoadImgContainingReflex($fullpath)
EndFunc

Func LoadFormulaFromFile__setCallbackFunction($callbackfunction)
  $LOAD_FORMULA_CALLBACK = $callbackfunction
EndFunc
Func LoadFormulaFromFile__setParentWindow($main_window_handle)
  $LOAD_FORMULA_PARENT_WINDOW = $main_window_handle
EndFunc


Func LoadFormulaFromFile__LoadImgContainingReflex($fullpath)
  If $fullpath =='' Then Return
  $isJpeg = StringEndsWith($fullpath, '.jpeg') Or StringEndsWith($fullpath, '.jpg')
  $isPng =  StringEndsWith($fullpath, '.png')
  Dim $text_tags_found
  If $isJpeg Then
    $text_tags_found = XpExifTags($fullpath)
  ElseIf $isPng Then
    $text_tags_found = PngReflexTags($fullpath)
  Else
    MsgBox(0, $Error_title, StringFormat($no_algorithm_to_import_data_from_this_kind_of_file__s, $fullpath))
    Return
  EndIf
  If $ERROR_DECODE_HANDLING <> "" Then
    MsgBox(0, $Error_title, StringFormat($error_while_importing_from__s, $fullpath)&@CRLF&$ERROR_DECODE_HANDLING)
    Return
  EndIf
  Dim $comment = ""
  ;logging("tags:"&toString($text_tags_found))
  For $i = 1 To $text_tags_found[0]
    $current_tag = $text_tags_found[$i]
    If StringCompare($current_tag[0], "comment")==0 Then
      $comment = $current_tag[1]
      ExitLoop
    EndIf
  Next
  If $comment == "" Then
    MsgBox(0, $Error_title, $No_comments_found_in_this_image)
    Return
  EndIf
  ;logging("Comment trouvé: "&$comment)
  $file = StringSplit($comment, @CRLF, 1)
  _ArrayDelete($file, 0) ;Supprime le compteur
  ;logging("File splité")
  $queue = emptyQueue()
  if @error == -1 Then
    logging("Error while creating queue")
    Return -1
  EndIf
  ;logging("queue créée")
  For $line in $file
	;logging("Adding line to queue: "&$line)
    If $line <> "" Then
      addFormulaItem($queue, $line)
    EndIf
  Next
  If isEmpty($queue) Then
    MsgBox(0, $Error_title, $Bad_formatting_in_xp_comment)
    Return
  EndIf
  If not FormulaBeforeOptionsLines($queue) Then
    MsgBox(0, $Error_title, $Bad_formatting_in_xp_comment)
    Return
  EndIf
  $count_formula_or_comment = CountCommentOrFormula($queue)
  $count_options_lines = CountOptionsLines($queue)
  ;If only options, discard.
  If $count_formula_or_comment == 0 or $count_formula_or_comment >= 3 Then
      MsgBox(0, $Error_title, $Bad_formatting_in_xp_comment)
      Return
  EndIf
  expandOptions($queue)

  $result = getEverythingAvailableFromFormula($queue)
  ;logging("Retour avec n options: "&size($queue))
  ;logging("calling back load formula callback : "&$LOAD_FORMULA_CALLBACK)
  Call($LOAD_FORMULA_CALLBACK, $result)
EndFunc

Func getEverythingAvailableFromFormula($formula_items)
  Dim $first = True
  Dim $isComment = 0, $isWindow = 0, $isResolution = 0, $isColornan = 0
  Dim $window_min = "", $window_max = "", $resolution_width = "", $resolution_height = "", $reflex_colornan = ""
  Dim $formula = "", $comment = "", $window = "; ", $resolution = " x "

  For $i = 1 To size($formula_items)
    $formula_item = $formula_items[$i]
    If $formula_item[$FORMULA_ITEM_TYPE] <> $OPTIONS_LINE Then
      $formula = $formula_item[$FORMULA_ITEM_CONTENT0]
    EndIf
    If $first Then ; Is not an option
      AssertEqual($COMMENT_OR_FORMULA, $formula_item[$FORMULA_ITEM_TYPE])
      $comment = $formula_item[$FORMULA_ITEM_CONTENT0]
      $first = False
    Else
      ;Options: Extract if window, resolution, comment.
      If $formula_item[$FORMULA_ITEM_TYPE] == $OPTIONS_LINE Then
        $tab = $formula_item[$FORMULA_ITEM_CONTENT0]
        If StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "winmin")==0 Then
          $isWindow = BitOR($isWindow, 1)
          $window_min = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
        ElseIf StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "winmax")==0 Then
          $isWindow = BitOR($isWindow, 2)
          $window_max = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
        ElseIf StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "height")==0 Then
          $isResolution = BitOR($isResolution, 1)
          $resolution_height = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
        ElseIf StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "width")==0 Then
          $isResolution = BitOR($isResolution, 2)
          $resolution_width = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
        ElseIf StringCompare($tab[$FORMULA_ITEM_CONTENT0_KEY], "colornan")==0 Then
          $isColornan = BitOR($isColornan, 1)
          $reflex_colornan = $tab[$FORMULA_ITEM_CONTENT0_VALUE]
        EndIf
      Else
        $formula = $formula_item[$FORMULA_ITEM_CONTENT0]
        $isComment = True
      EndIf
    EndIf
  Next
  $window = StringFormat("%s, %s", $window_min, $window_max)
  $resolution = StringFormat("%s x %s", $resolution_width, $resolution_height)
  Local $formula_entry[$FORMULA_ENTRY_SIZE]
  $formula_entry[$FORMULA_ENTRY_IFOPTIONS] = _ArrayCreate(True,     $isComment, $isWindow==3, $isResolution==3, $isColornan)
  $formula_entry[$FORMULA_ENTRY_OPTIONS]   = _ArrayCreate($formula, $comment,   $window,      $resolution,      $reflex_colornan)
  $has_array = $formula_entry[$FORMULA_ENTRY_IFOPTIONS]
  $res_array = $formula_entry[$FORMULA_ENTRY_OPTIONS]
  $return_value = emptySizedArray()
  if $has_array[$HAS_FORMULA]    Then push($return_value, _ArrayCreate("formula",    $res_array[$HAS_FORMULA]))
  if $has_array[$HAS_COMMENT]    Then push($return_value, _ArrayCreate("comment",    $res_array[$HAS_COMMENT]))
  if $has_array[$HAS_WINDOW]     Then push($return_value, _ArrayCreate("window",     $res_array[$HAS_WINDOW]))
  if $has_array[$HAS_RESOLUTION] Then push($return_value, _ArrayCreate("resolution", $res_array[$HAS_RESOLUTION]))
  if $has_array[$HAS_COLORNAN]   Then push($return_value, _ArrayCreate("colornan",   $res_array[$HAS_COLORNAN]))
  Return $return_value
EndFunc

Func loadFormula($fp = '')
  ;$LOAD_FORMULA_CALLBACK = $callback
  $lfe_save = $LOAD_FORMULA_EXISTS
  If Not $LOAD_FORMULA_EXISTS Then
    If $fp <> '' Then
      $fullpath = $fp
    Else
      $fullpath = lookForFormulaFile()
    EndIf
    If @error == 1 Or $fullpath =='' Then
			Return
		EndIf
		GenerateLoadFormulaBox($fullpath)
	Else
		GUISwitch($formula_chooser)
		WinActivate($formula_chooser)
  EndIf

  If Not $lfe_save Then
    AnimateFromLeft($formula_chooser)
  EndIf
  GUISetState(@SW_SHOW)
EndFunc

Func lf_OkClick()
  $return_value = emptySizedArray()
  $selected = GUICtrlRead($lf_formula_tree)
  For $i=1 To size($formula_entry_map)
    $formula_entry = $formula_entry_map[$i]
    $treeitems = $formula_entry[$FORMULA_ENTRY_TREEVIEWITEMS]
    $has_array = $formula_entry[$FORMULA_ENTRY_IFOPTIONS]
    $res_array = $formula_entry[$FORMULA_ENTRY_OPTIONS]
    $found = False
    For $treeitem in $treeitems
      If $selected == $treeitem Then
        $found = True
        ExitLoop 1
      EndIf
    Next
    If $found Then
      if $has_array[$HAS_FORMULA]                                         Then push($return_value, _ArrayCreate("formula",    $res_array[$HAS_FORMULA]))
      if $has_array[$HAS_COMMENT]    and isChecked($lf_import_comment)    Then push($return_value, _ArrayCreate("comment",    $res_array[$HAS_COMMENT]))
      if $has_array[$HAS_WINDOW]     and isChecked($lf_import_window)     Then push($return_value, _ArrayCreate("window",     $res_array[$HAS_WINDOW]))
      if $has_array[$HAS_RESOLUTION] and isChecked($lf_import_resolution) Then push($return_value, _ArrayCreate("resolution", $res_array[$HAS_RESOLUTION]))
      if $has_array[$HAS_COLORNAN]                                        Then push($return_value, _ArrayCreate("colornan",   $res_array[$HAS_COLORNAN]))
      ExitLoop
    EndIf
  Next
  Call($LOAD_FORMULA_CALLBACK, $return_value)
EndFunc

Func enableControl($ctrl, $bool)
  GUICtrlSetState($ctrl, _Iif($bool, $GUI_ENABLE, $GUI_DISABLE))
EndFunc

Func lf_ControlClick()
  $nMsg = @GUI_CtrlId
  Switch $nMsg
  Case $lf_other_file
    $fullpath = lookForFormulaFile()
    if @error == -1 Or $fullpath =='' Then
      Return
    EndIf
    if loadLinesIntoTreeControl($fullpath, $lf_formula_tree) == -1 Then
      Return
    EndIf
  Case 0
  Case -11
  Case Else
    ;logging("Update interfaces "&Random(1, 10))
    $selected = GUICtrlRead($lf_formula_tree)
    If $selected <> $nMsg Then ContinueCase
    $found = False
    For $i=1 To size($formula_entry_map)
      $formula_entry = $formula_entry_map[$i]
      $treeitems = $formula_entry[$FORMULA_ENTRY_TREEVIEWITEMS]
      $has_array = $formula_entry[$FORMULA_ENTRY_IFOPTIONS]
      For $treeitem in $treeitems
        If $selected == $treeitem Then
          $found = True
          ExitLoop 1
        EndIf
      Next
      If $found Then
        enableControl($lf_import_comment,    $has_array[$HAS_COMMENT])
        enableControl($lf_import_window,     $has_array[$HAS_WINDOW])
        enableControl($lf_import_resolution, $has_array[$HAS_RESOLUTION])
        lf_OkClick()
        ExitLoop
      EndIf
    Next
    ;If $nMsg>0 Then Logging("Tree code : "&$nMsg)
  ;Case Else
    ;If $nMsg>0 Then Logging("Non tree code : "&$nMsg)
  ;  If Not WinActive($formula_chooser) Then WinActivate($formula_chooser)
  EndSwitch
  ;Opt('GUIOnEventMode', 1)
EndFunc
