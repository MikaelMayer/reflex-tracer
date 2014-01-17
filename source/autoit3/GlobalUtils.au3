#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.2.10.0
	Author:         Mikaël Mayer
	Date:          10/08/2008

	Script Function:
	Util functions for Reflex Renderer

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include-once
#include "Parameters.au3"
#include "IniHandling.au3"
#include <GDIPlus.au3>
#include <Array.au3>
#include <Date.au3>
#include <Misc.au3>
#include <Math.au3>
#include <WindowsConstants.au3>

Global Const $VERSION_NUMER = "2.8.11 beta"
Global Const $COPYRIGHT_DATE = "2009"

Global $ERROR_DECODE_HANDLING = ""
Global Const $EmptySizedArray = emptySizedArray()
Global Const $LENGTH_SIZED_ARRAY_INDEX = 0

If @Compiled Then
	Opt('TrayIconHide', 1)
Else
	Opt('TrayIconDebug', 1)
EndIf

;Manipulating Array which can be empty
Func size(ByRef $SizedArray)
	Return $SizedArray[0]
EndFunc   ;==>size

Func emptyQueue()
	Return _ArrayCreate(0)
EndFunc   ;==>emptyQueue

Func emptySizedArray()
	Return _ArrayCreate(0)
EndFunc   ;==>emptySizedArray

;Removes the first element of the sized array
Func pop(ByRef $queue)
	$tmp = $queue[1]
	_ArrayDelete($queue, 1)
	$queue[0] -= 1
	Return $tmp
EndFunc   ;==>pop

Func push(ByRef $queue, $element)
	_ArrayAdd($queue, $element)
	$queue[0] += 1
EndFunc   ;==>push

Func insert(ByRef $queue, $element, $index)
	insertAfter($queue, $element, $index - 1)
EndFunc   ;==>insert

Func insertAfter(ByRef $queue, $element, $index)
	;Logging("inserting "&formulaItemToString($element)&" into a queue")
	If $index + 1 > size($queue) Then
		push($queue, $element)
	Else
		_ArrayInsert($queue, $index + 1, $element)
		$queue[0] += 1
	EndIf
EndFunc   ;==>insertAfter

;Inserts the obj = [a, b, c] in queue sorted on the first element
Func insertSortedObj(ByRef $queue, $obj, $increasing = True)
	; Linear insertion... not that bad.
	For $i = 1 To size($queue)
		$el = $queue[$i]
		If $el[0] > $obj[0] And $increasing Then
			insert($queue, $obj, $i)
			Return
		EndIf
		If $el[0] < $obj[0] And Not $increasing Then
			insert($queue, $obj, $i)
			Return
		EndIf
	Next
	push($queue, $obj)
EndFunc   ;==>insertSortedObj

Func deleteAt(ByRef $queue, $index)
	If $index > $queue[0] Or $index < 1 Then
		Return
	Else
		_ArrayDelete($queue, $index)
		$queue[0] -= 1
	EndIf
EndFunc   ;==>deleteAt

Func indexOf(ByRef $queue, $element)
	For $i = 1 To $queue[0]
		If $queue[$i] == $element Then Return $i
	Next
	Return 0
EndFunc   ;==>indexOf

Func deleteElement(ByRef $queue, $element)
	deleteAt($queue, indexOf($queue, $element))
EndFunc   ;==>deleteElement

Func isEmpty(ByRef $queue)
	Return $queue[0] == 0
EndFunc   ;==>isEmpty

Func isNotEmpty(ByRef $queue)
	Return $queue[0] <> 0
EndFunc   ;==>isNotEmpty

Func toBasicArray(ByRef $queue)
	_ArrayDelete($queue, 0)
EndFunc   ;==>toBasicArray

Func arrayDiff($t1, $t2)
	Local $result[UBound($t1)]
	For $i = 0 To UBound($t1) - 1
		$result[$i] = $t1[$i] - $t2[$i]
	Next
	Return $result
EndFunc   ;==>arrayDiff

Func leftTopWithHeight_to_leftTopRightBottom($pos)
	$pos[2] = $pos[2] + $pos[0]
	$pos[3] = $pos[3] + $pos[1]
	Return $pos
EndFunc   ;==>leftTopWithHeight_to_leftTopRightBottom

Func leftTopRightBottom_to_leftTopWithHeight($pos)
	$pos[2] = $pos[2] - $pos[0]
	$pos[3] = $pos[3] - $pos[1]
	Return $pos
EndFunc   ;==>leftTopRightBottom_to_leftTopWithHeight


Func toString($element)
	Local $res = ""
	If IsArray($element) Then
		Local $first = True
		$res = "["
		For $el In $element
			If $first Then
				$res &= toString($el)
				$first = False
			Else
				$res &= ", " & toString($el)
			EndIf
		Next
		$res &= "]"
	ElseIf IsString($element) Then
		$res = """" & $element & """"
	Else
		$res = String($element)
	EndIf
	If Not IsArray($element) And StringLen($res) > 1000 Then
		$res = StringLeft($res, 1000) & "..."
	EndIf
	Return $res
EndFunc   ;==>toString

Func concatenate(ByRef $array, $array2)
	For $element In $array2
		_ArrayAdd($array, $element)
	Next
EndFunc   ;==>concatenate

Func makeFileName($str)
	$badchars = StringSplit('*?\/""|<>:', '')
	_ArrayDelete($badchars, 0)
	For $char In $badchars
		$str = StringReplace($str, $char, '')
	Next
	Return $str
EndFunc   ;==>makeFileName

Func reflexFileNameFromComment($formula_comment, $formula_filename, $reflex_extension)
	$comment = makeFileName($formula_comment)
	$pos = StringInStr($formula_filename, '\', 0, -1)
	While True
		If $pos == 0 Then ExitLoop
		$basefilename = StringMid($formula_filename, 1, $pos)
		$pos1 = StringInStr($reflex_extension, '.')
		If $pos1 == 0 Then ExitLoop
		$extension = StringMid($reflex_extension, $pos1, 4)
		Return $basefilename & $comment & $extension
	WEnd
	Return IniReadSaveBox('reflexFile', '')
EndFunc   ;==>reflexFileNameFromComment

Func FileBaseName($longFileName)
	Return StringRegExpReplace($longFileName, ".*\\", "")
EndFunc   ;==>FileBaseName

Func FileFolder($longFileName)
	Return StringLeft($longFileName, StringLen($longFileName) - StringLen(FileBaseName($longFileName)))
EndFunc   ;==>FileFolder

Func FileReplaceContent($file_name, $file_name_after, $to_search, $to_replace)
	$fi = FileOpen($file_name, 0)
	$fo = FileOpen($file_name_after & "_tmp", 2)
	While True
		$l = FileReadLine($fi)
		If @error <> 0 Then ExitLoop
		FileWriteLine($fo, StringReplace($l, $to_search, $to_replace))
	WEnd
	FileClose($fi)
	FileClose($fo)
	FileMove($file_name_after & "_tmp", $file_name_after, 1)
EndFunc   ;==>FileReplaceContent

Func ImageConvert($previous_image, $after_image)
	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($previous_image)
	_GDIPlus_ImageSaveToFile($hImage, $after_image)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
EndFunc   ;==>ImageConvert

Func Logging($str, $line = @ScriptLineNumber)
	If Not @Compiled Then
		ConsoleWrite("Line:" & $line & ": " & _NowCalc() & " : " & $str & @CRLF)
	EndIf
EndFunc   ;==>Logging

Func isChecked($ctrl)
	$state = GUICtrlRead($ctrl)
	Return BitAND($state, $GUI_CHECKED)
EndFunc   ;==>isChecked

Func check($ctrl, $checked)
  GUICtrlSetState($ctrl, _Iif($checked, $GUI_CHECKED, $GUI_UNCHECKED))
EndFunc   ;==>isChecked

Func SetFocus($hCtrl)
	GUICtrlSetState($hCtrl, $GUI_FOCUS)
EndFunc   ;==>SetFocus

Func ErrorDecodeAdd($string)
	logging("Adding '" & $string & "' to error string")
	$ERROR_DECODE_HANDLING &= @CRLF & $string
EndFunc   ;==>ErrorDecodeAdd

Func ErrorDecodeDisplay()
	ConsoleWriteError($ERROR_DECODE_HANDLING & @CRLF)
	logging("Error: " & $ERROR_DECODE_HANDLING)
	Return False
EndFunc   ;==>ErrorDecodeDisplay

; Flag and complex management

Func createFlag($flag, $value)
	If $value <> "" Or Not IsString($value) Then
		If StringLeft($value, 1) == "-" Then
			Return StringFormat(' --%s " %s"', $flag, $value)
		Else
			Return StringFormat(' --%s "%s"', $flag, $value)
		EndIf
	Else
		Return StringFormat(' --%s', $flag)
	EndIf
EndFunc   ;==>createFlag

Func addFlag(ByRef $flags, $new_flag, $new_value = "")
	$flags = $flags & createFlag($new_flag, $new_value)
EndFunc   ;==>addFlag

Func isFormulaLine($line)
	Return StringCompare(StringLeft($line, 8), "formula:") == 0
EndFunc   ;==>isFormulaLine

Func extractFormulaLine($line)
	Return StringMid($line, 9)
EndFunc   ;==>extractFormulaLine

Func simplifyParenthesis($complex_number)
	While StringLeft($complex_number, 1) == '(' And StringRight($complex_number, 1) == ')'
		$complex_number = StringMid($complex_number, 2, StringLen($complex_number) - 2)
	WEnd
	Return $complex_number
EndFunc   ;==>simplifyParenthesis

;$RenderReflexExe should be declared outside in global (like in Parameters.au3)
Global $RenderReflexExe
Func runReflexWithArguments($args)
	$cmd = StringFormat("%s %s", $RenderReflexExe, $args)
	logging("Running " & $cmd)
	Local $pid = Run($cmd, '', @SW_HIDE, 2 + 4)
	Return $pid
EndFunc   ;==>runReflexWithArguments

Func complex_calculate($expr)
	;logging("Calculating "&$expr)
	Dim $flags = ""
	addFlag($flags, "simplify")
	addFlag($flags, "formula", $expr)
	;$flags = $formula_flag&$seed_flag
	$p = runReflexWithArguments($flags)
	$found = False
	$result = 0
	$text = ""
	While True ; Read everything
		$text = $text & StdoutRead($p)
		If @error Then ExitLoop
	WEnd
	$lines = StringSplit($text, @CRLF, 1)
	For $i = 1 To $lines[0]
		$current_line = $lines[$i]
		;Logging("Line to compare: "&$current_line)
		If isFormulaLine($current_line) Then
			;Logging("Formula!")
			$result = extractFormulaLine($current_line)
			$found = True
			ExitLoop
		EndIf
	Next
	ProcessClose($p)
	;logging("rr output={"&$text&"}")
	If Not $found Then
		logging(StringFormat("%s has not been simplified, retrying.", $expr))
		Return complex_calculate($expr)
	EndIf
	$result = simplifyParenthesis($result)
	Return $result
EndFunc   ;==>complex_calculate

; Returns the number of processors of this machine
Func getNumberOfProcessors()
	$test = 0
	While RegRead("HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\" & $test, "~MHz") <> ""
		$test += 1
	WEnd
	Return $test
EndFunc   ;==>getNumberOfProcessors


;=============== String management ===============

;Returns a boolean indicating if the string starts with a certain prefix (case insensitive)
Func StringStartsWith($str, $start)
	Return StringCompare(StringLeft($str, StringLen($start)), $start) == 0
EndFunc   ;==>StringStartsWith

;Returns a boolean indicating if the string ends with a certain postfix (case insensitive)
Func StringEndsWith($str, $end)
	Return StringCompare(StringRight($str, StringLen($end)), $end) == 0
EndFunc   ;==>StringEndsWith

;Return a boolean indicating if the $str contains some characters present in $char_str
Func StringContains($str, $char_str)
	For $i = 1 To StringLen($str)
		If StringInStr($char_str, StringMid($str, $i, 1)) Then Return True
	Next
	Return False
EndFunc   ;==>StringContains

Func replaceVariableString($string, $varname, $varvalue)
	$varname = StringReplace(StringStripWS($varname, 3), "$", "\$")
	If StringContains($varvalue, "+*-/()") Then $varvalue = "(" & $varvalue & ")"
	$string = StringRegExpReplace($string, $varname & "([^[:alnum:]]|\z)", $varvalue & "\1")
	Return $string
EndFunc   ;==>replaceVariableString

Func StringSizeMin($str, $length, $add_char = " ")
	While StringLen($str) < $length
		$str = $str & $add_char
	WEnd
	Return $str
EndFunc   ;==>StringSizeMin

Func UpdateMyDocuments($str)
	Return StringReplace($str, "%MY_DOCUMENTS%", @MyDocumentsDir)
EndFunc   ;==>UpdateMyDocuments

; Remove comments from a string Comments are introduced by semicolon.
; Beware, if other introductors, should be compatible by StringRegExpReplace, so escaped if necessary.
Func removeComments($string, $introductor = ";")
	$comments_replaced = $string
	Do
		$string = $comments_replaced
		$comments_replaced = StringRegExpReplace($string, "(\r?\n|\A)" & $introductor & "(?m).*(?:\r?\n|\z)", "\1")
	Until $comments_replaced == $string
	Return $comments_replaced
EndFunc   ;==>removeComments

Func _FileSaveDialog($sTitle, $sInitDir, $sFilter = 'All (*.*)', $iOpt = 0, $sDefFile = '', $iDefFilter = 1, $hWnd = 0)
	Local $iFileLen = 65536 ; Max chars in returned string

	; API flags prepare
	Local $iFlag = BitOR(BitShift(BitAND($iOpt, 2), -10), BitShift(BitAND($iOpt, 16), 3))

	; Filter string to array convertion
	If Not StringInStr($sFilter, '|') Then $sFilter &= '|*.*'
	$sFilter = StringRegExpReplace($sFilter, '|+', '|')

	Local $asFLines = StringSplit($sFilter, '|')
	Local $i, $suFilter = ''

	For $i = 1 To $asFLines[0] Step 2
		If $i < $asFLines[0] Then _
				$suFilter &= 'byte[' & StringLen($asFLines[$i]) + 1 & '];char[' & StringLen($asFLines[$i + 1]) + 1 & '];'
	Next

	; Create API structures
	Local $uOFN = DllStructCreate('dword;int;int;ptr;ptr;dword;dword;ptr;dword' & _
			';ptr;int;ptr;ptr;dword;short;short;ptr;ptr;ptr;ptr;ptr;dword;dword')
	Local $usTitle = DllStructCreate('char[' & StringLen($sTitle) + 1 & ']')
	Local $usInitDir = DllStructCreate('char[' & StringLen($sInitDir) + 1 & ']')
	Local $usFilter = DllStructCreate($suFilter & 'byte')
	Local $usFile = DllStructCreate('char[' & $iFileLen & ']')
	Local $usExtn = DllStructCreate('char[1]')

	For $i = 1 To $asFLines[0]
		DllStructSetData($usFilter, $i, $asFLines[$i])
	Next

	; Set Data of API structures
	DllStructSetData($usTitle, 1, $sTitle)
	DllStructSetData($usInitDir, 1, $sInitDir)
	DllStructSetData($usFile, 1, $sDefFile)
	DllStructSetData($usExtn, 1, "")
	DllStructSetData($uOFN, 1, DllStructGetSize($uOFN))
	DllStructSetData($uOFN, 2, $hWnd)
	DllStructSetData($uOFN, 4, DllStructGetPtr($usFilter))
	DllStructSetData($uOFN, 7, $iDefFilter)
	DllStructSetData($uOFN, 8, DllStructGetPtr($usFile))
	DllStructSetData($uOFN, 9, $iFileLen)
	DllStructSetData($uOFN, 12, DllStructGetPtr($usInitDir))
	DllStructSetData($uOFN, 13, DllStructGetPtr($usTitle))
	DllStructSetData($uOFN, 14, $iFlag)
	DllStructSetData($uOFN, 17, DllStructGetPtr($usExtn))
	DllStructSetData($uOFN, 23, BitShift(BitAND($iOpt, 32), 5))

	;Set Timer to check FileName Input for file extension
	Local $hCallBack = DllCallbackRegister("_Check_FSD_Input", "none", "hwnd;int;int;dword")
	Local $ahTimer = DllCall("user32.dll", "int", "SetTimer", "hwnd", 0, _
			"int", TimerInit(), "int", 100, "ptr", DllCallbackGetPtr($hCallBack))

	; Call API function
	Local $aRet = DllCall('comdlg32.dll', 'int', 'GetSaveFileName', 'ptr', DllStructGetPtr($uOFN))

	;Free CallBack and kill the timer
	DllCallbackFree($hCallBack)
	DllCall("user32.dll", "int", "KillTimer", "hwnd", 0, "int", $ahTimer)

	If Not IsArray($aRet) Or Not $aRet[0] Then Return SetError(1, 0, "")

	;Return Results
	Local $sRet = StringStripWS(DllStructGetData($usFile, 1), 3)
	Return SetExtended(DllStructGetData($uOFN, 7), $sRet) ;@extended is the 1-based index of selected filter
EndFunc   ;==>_FileSaveDialog

Func _Check_FSD_Input($hWndGUI, $MsgID, $WParam, $LParam)
	Local $sSaveAs_hWnd = _WinGetHandleEx(@AutoItPID, "#32770", "", "FolderView")

	If ControlGetFocus($sSaveAs_hWnd) = "Edit1" Then Return

	Local $sEdit_Data = ControlGetText($sSaveAs_hWnd, "", "Edit1")
	Local $sFilter_Ext = ControlCommand($sSaveAs_hWnd, "", "ComboBox3", "GetCurrentSelection")
	$sFilter_Ext = StringRegExpReplace($sFilter_Ext, ".*\(\*(.*?)\)$", "\1")

	If $sFilter_Ext = ".*" Then
		$sFilter_Ext = ""
	ElseIf Not StringInStr($sFilter_Ext, ".") Then
		Return
	EndIf

	Local $sEdit_Ext = StringRegExpReplace($sEdit_Data, "^.*\.", ".")

	If $sEdit_Ext <> $sFilter_Ext And ($sEdit_Ext <> $sEdit_Data Or $sFilter_Ext <> "") Then
		$sEdit_Data = StringRegExpReplace($sEdit_Data, "\.[^.]*$", "")
		ControlSetText($sSaveAs_hWnd, "", "Edit1", $sEdit_Data & $sFilter_Ext)
	EndIf
EndFunc   ;==>_Check_FSD_Input

Func _WinGetHandleEx($iPID, $sClassNN = "", $sPartTitle = "", $sText = "", $iVisibleOnly = 1)
	If IsString($iPID) Then $iPID = ProcessExists($iPID)

	Local $aWList = WinList("[CLASS:" & $sClassNN & ";REGEXPTITLE:(?i).*" & $sPartTitle & ".*]", $sText)
	If @error Then Return SetError(1, 0, "")

	For $i = 1 To $aWList[0][0]
		If WinGetProcess($aWList[$i][1]) = $iPID And (Not $iVisibleOnly Or _
				($iVisibleOnly And BitAND(WinGetState($aWList[$i][1]), 2))) Then Return $aWList[$i][1]
	Next

	Return SetError(2, 0, "")
EndFunc   ;==>_WinGetHandleEx

; Animation and windows

Func AnimateFadeIn($win)
	WinSetTrans($win, "", 0)
	GUISetState(@SW_SHOW, $win)
	Local $delay = 500
	Local $init = TimerInit()
	Do
		$d = TimerDiff($init)
		WinSetTrans($win, "", _Max($d * 255 / $delay, 255))
	Until $d > $delay
	WinSetTrans($win, "", 255)
EndFunc   ;==>AnimateFadeIn

Func AnimateFadeOut($win)
	For $i = 255 To 0 Step 5
		WinSetTrans($win, "", $i)
	Next
EndFunc   ;==>AnimateFadeOut

Func AnimateFromTopLeft($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 200, "long", 0x00040005);diag slide-in from Top-left
	GUISetState(@SW_SHOW, $win)
EndFunc   ;==>AnimateFromTopLeft

Func AnimateToTopRight($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 200, "long", 0x00050009);diag slide-out to Top-Right
EndFunc   ;==>AnimateToTopRight

Func AnimateToBottomRight($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 200, "long", 0x00050005);diag slide-out to Bottom-right
EndFunc   ;==>AnimateToBottomRight

Func AnimateFromTop($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 100, "long", 0x00040004);diag slide-in from Top
	GUISetState(@SW_SHOW, $win)
EndFunc   ;==>AnimateFromTop

Func AnimateToTop($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 100, "long", 0x00050008);slide-out to Top
EndFunc   ;==>AnimateToTop

Func AnimateFromLeft($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 100, "long", 0x00040001);slide in from left
EndFunc   ;==>AnimateFromLeft

Func AnimateToLeft($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 100, "long", 0x00050002);slide out to left
EndFunc   ;==>AnimateToLeft


;Moves a LTRB (left/top/right/bottom) rectangle $pos_child_ltrb given that a rectangle moved from $pos_before_ltrb to $pos_after_ltrb
Func move_ltrb(ByRef $pos_child_ltrb, ByRef $pos_before_ltrb, ByRef $pos_after_ltrb)

	Local $x_dep = 0, $y_dep = 0

	;If the window can be hit if the window moves left or right
	;logging(toString($pos_child_ltrb)&","&toString($pos_before_ltrb)&","&toString($pos_after_ltrb))
	If Not ($pos_child_ltrb[3] <= $pos_before_ltrb[1] Or $pos_child_ltrb[1] >= $pos_before_ltrb[3]) Then
		If $pos_child_ltrb[2] <= $pos_before_ltrb[0] Then $x_dep = $pos_after_ltrb[0] - $pos_before_ltrb[0]
		If $pos_child_ltrb[0] >= $pos_before_ltrb[2] Then $x_dep = $pos_after_ltrb[2] - $pos_before_ltrb[2]
	Else
		$x_dep = ($pos_after_ltrb[0] - $pos_before_ltrb[0] + $pos_after_ltrb[2] - $pos_before_ltrb[2]) / 2
	EndIf
	;If the window can be hit if the window moves top or bottom
	If Not ($pos_child_ltrb[2] <= $pos_before_ltrb[0] Or $pos_child_ltrb[0] >= $pos_before_ltrb[2]) Then
		If $pos_child_ltrb[3] <= $pos_before_ltrb[1] Then $y_dep = $pos_after_ltrb[1] - $pos_before_ltrb[1]
		If $pos_child_ltrb[1] >= $pos_before_ltrb[3] Then $y_dep = $pos_after_ltrb[3] - $pos_before_ltrb[3]
	Else
		$y_dep = ($pos_after_ltrb[1] - $pos_before_ltrb[1] + $pos_after_ltrb[3] - $pos_before_ltrb[3]) / 2
	EndIf
	$pos_child_ltrb[0] += $x_dep
	$pos_child_ltrb[2] += $x_dep
	$pos_child_ltrb[1] += $y_dep
	$pos_child_ltrb[3] += $y_dep
EndFunc   ;==>move_ltrb

; =============== Timeout control =================;

Global Const $global_timer = TimerInit()
Global $global_timeout_functions = emptySizedArray()

; Timeout class declaration
; Timeout:Timer,FunctionName
Global Enum $N_Timeout_Timer, $N_Timeout_FunctionName, $N_Timeout_size

Func setTimeout_Timer(ByRef $obj, $value)
	$obj[$N_Timeout_Timer] = $value
EndFunc   ;==>setTimeout_Timer
Func getTimeout_Timer($obj)
	Return $obj[$N_Timeout_Timer]
EndFunc   ;==>getTimeout_Timer

Func setTimeout_FunctionName(ByRef $obj, $value)
	$obj[$N_Timeout_FunctionName] = $value
EndFunc   ;==>setTimeout_FunctionName
Func getTimeout_FunctionName($obj)
	Return $obj[$N_Timeout_FunctionName]
EndFunc   ;==>getTimeout_FunctionName

; Timeout constructor
Func newTimeout($Timer, $FunctionName)
	Local $result[$N_Timeout_size]
	$result[$N_Timeout_Timer] = $Timer
	$result[$N_Timeout_FunctionName] = $FunctionName
	Return $result
EndFunc   ;==>newTimeout

Func setTimeout($function_name, $timeout)
	$now = TimerDiff($global_timer)
	insertSortedObj($global_timeout_functions, newTimeout($now + $timeout, $function_name))
EndFunc   ;==>setTimeout

Func setTimeout_external($command, $timeout)
	Local $arguments = ' timeout ' & $timeout & ' "' & $command & '"'
	If @Compiled Then
		Run(@ScriptFullPath & $arguments)
	Else
		Run('"' & @AutoItExe & '" "' & @ScriptFullPath & '"' & $arguments)
		logging('"' & @AutoItExe & '" "' & @ScriptFullPath & '"' & $arguments)
	EndIf
EndFunc   ;==>setTimeout_external

Func cancelAllTimeouts($function_name)
	For $i = size($global_timeout_functions) To 1 Step -1
		If StringCompare(getTimeout_FunctionName($global_timeout_functions[$i]), $function_name) == 0 Then
			deleteAt($global_timeout_functions, $i)
		EndIf
	Next
EndFunc   ;==>cancelAllTimeouts

Func cancelAllTimeoutsStartingWith($function_name)
	For $i = size($global_timeout_functions) To 1 Step -1
		If StringStartsWith(getTimeout_FunctionName($global_timeout_functions[$i]), $function_name) Then
			deleteAt($global_timeout_functions, $i)
		EndIf
	Next
EndFunc   ;==>cancelAllTimeoutsStartingWith

Func parseTimeOutFunctions()
	If size($global_timeout_functions) > 0 Then
		;Logging(TimerDiff($global_timer)&" should get bigger than "&getTimeout_Timer($global_timeout_functions[1]))
		If TimerDiff($global_timer) > getTimeout_Timer($global_timeout_functions[1]) Then
			Local $function = getTimeout_FunctionName($global_timeout_functions[1])
			deleteAt($global_timeout_functions, 1)
			Call($function)
			If @error = 0xDEAD And @extended = 0xBEEF Then
				logging("Error: Function '" & $function & " does not exist")
			EndIf
		EndIf
	EndIf
EndFunc   ;==>parseTimeOutFunctions

Func clear_tooltip_after_ms($ms)
	setTimeout("clear_tooltip", $ms)
EndFunc   ;==>clear_tooltip_after_ms

Func clear_tooltip()
	ToolTip("")
EndFunc   ;==>clear_tooltip

; ==================== Testing ====================;

Func AssertEqual($a, $b, $e = "")
	If $a <> $b Then
		If $e <> "" Then $e = " : " & $e
		MsgBox(0, "Assertion error", StringFormat("%s != %s" & $e, $a, $b))
		Exit
	EndIf
EndFunc   ;==>AssertEqual

