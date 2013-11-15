#include-once
#include <GuiConstants.au3>
#include <GuiConstantsEx.au3>
#include <Include\DllCallBack.au3>
#include <string.au3>
#Include <Misc.au3>
#Include <GuiEdit.au3>
#include <Color.au3>
#include "Include\_RichEdit_912.au3"

HotKeySet("{TAB}", "_Tab")

Global $Main_GUI, $Width = 510, $Height = 650, $RichEdit
Global $hToolbar, $iMemo
Global $iItem 
Global Enum $idNew = 1000, $idOpen, $idSave, $idHelp

Global $hB_Bold, $hB_Italic, $hB_Underline, $hB_StrikeOut, $hB_FontColor, $hB_BkColor, $hB_AlignL, $hB_AlignC, $hB_AlignR, $hB_Bk, $hB_GetSel, $hB_Table
Global $hC_FontSize

$dlll = DllOpen("user32.dll")
;=================================================================================

$Main_GUI = GUICreate("Rich Edit (Exemple)", $Width, $Height, -1, -1)
$Label = GuiCtrlCreateLabel("Rich Edit (Exemple)", $Width/3, 40, 300, 30)
GUICtrlSetFont($Label, 16)
$ButtonSave = GuiCtrlCreateButton("Save", 300, $Height-70, 60, 25)
$ButtonSaveSel = GuiCtrlCreateButton("Save Sel.", 300, $Height-45, 60, 25)
$ButtonOpen = GuiCtrlCreateButton("Open", 420, $Height-70 , 60, 25)
$ButtonOpenSel = GuiCtrlCreateButton("Open Sel.", 420, $Height-45 , 60, 25)

$Label = GuiCtrlCreateLabel("", 30, $Height-60, 250, 18)
GUICtrlSetBkColor($Label, 0xFFFFFF)
$Input = GUICtrlCreateInput("", 30, $Height-120, 450, 30)

$RichEdit = _GuiCtrl_RichEdit_Create($Main_GUI, 30, 170, 450, 350)
_SetButtons()

;===================================================================================
Opt("ColorMode", 0)
_RichEdit_LimitText($RichEdit, 512000)
_GUICtrlEdit_SetMargins ($RichEdit, BitOR($EC_LEFTMARGIN, $EC_RIGHTMARGIN), 10, 10)
_RichEdit_SetFont($RichEdit, 0000, 0x000000, 0xFFFFFF, "Times New Roman", 12, 0)
;_RichEdit_BkColor($RichEdit, 0xc0c0c0)
_RichEdit_BkColor($RichEdit, 0xFFFFFF)

#cs
_RichEdit_SetNumbering($RichEdit, 2, 0x200)
_RichEdit_SetAlignment($RichEdit, 3)
;_RichEdit_SetFont($RichEdit, 1010, 0x0000FF, 0xc0c0c0, -1, 18)
_RichEdit_SetFont($RichEdit, 1010, 0x0000FF, 0xFFFFFF, -1, 18)
_GUICtrlEdit_AppendText($RichEdit, "Title" & @CRLF)

_RichEdit_SetAlignment($RichEdit, 2)
_RichEdit_SetFont($RichEdit, 0001, 0x45d3b4, 0xFFa300, -1, 14)
_GUICtrlEdit_AppendText($RichEdit, "Right aligned")
_RichEdit_SetFont($RichEdit, 0000, -1, -1, -1, 14)
_GUICtrlEdit_AppendText($RichEdit, @CRLF)

_RichEdit_SetAlignment($RichEdit, 4)
_RichEdit_SetFont($RichEdit, 0100, 0x00FF00, 0x339933, -1)
_GUICtrlEdit_AppendText($RichEdit, "Left aligned" & @CRLF)

_RichEdit_SetAlignment($RichEdit, 3)
_RichEdit_SetSpaceAfter($RichEdit, 1)
_RichEdit_SetFont($RichEdit, 1000, 0xCBA900, 0xc0c0c0)
_RichEdit_SetProtected($RichEdit)
_GUICtrlEdit_AppendText($RichEdit, "Centred" & @CRLF)
_RichEdit_SetNumbering($RichEdit, 0, 0)

_RichEdit_SetNumbering($RichEdit, 3, 0, 1)
_RichEdit_SetAlignment($RichEdit, 1)
_RichEdit_SetSpaceAfter($RichEdit, 0)
_RichEdit_SetFont($RichEdit, -1, -1, 0xc0c0c0, -1, 12)
_GUICtrlEdit_AppendText($RichEdit, "Another paragraph" & @CRLF)

_RichEdit_SetLineSpacing($RichEdit, 0)
_RichEdit_SetFont($RichEdit, -1, -1, 0xc0c0c0, -1, 12)
_RichEdit_AddText($RichEdit, "*** ")
_RichEditAppendLink($RichEdit, "I'm a link")
_RichEdit_AddText($RichEdit, " *** " & @CRLF)
_RichEdit_SetNumbering($RichEdit, 0, 0)

_RichEdit_SetAlignment($RichEdit, 3)
_RichEdit_AddText($RichEdit, @CRLF & @CRLF & "Table: " & @CRLF & @CRLF)

#ce

_RichEdit_SetEventMask($RichEdit, BitOr($ENM_LINK, $ENM_PROTECTED, $ENM_MOUSEEVENTS, $ENM_KEYEVENTS, $ENM_SELCHANGE))	;-------------------------------------To recieve EN_LINK and $EN_PROTECTED Notifications
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUISetState()

While 1
   $msg = GUIGetMsg()
   Select
		Case $msg = -3 
            _DllCallBack_Free($pEditStreamCallback)
			DllClose($dlll)
			Exit
		Case $msg = $ButtonSave	
			$sGetRtf = ""
			$File = FileSaveDialog("Guardar como:", @ScriptDir, "rtf (*.myrt;*.rtf)")
			_Save($RichEdit, $File)
			;ConsoleWrite("End" & @LF & @LF)
			;ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
		Case $msg = $ButtonSaveSel	
			$File = FileSaveDialog("Guardar selección como:", @ScriptDir, "rtf (*.myrt;*.rtf)")
			_Save($RichEdit, $File, 1)
			;ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)	
		Case $msg = $ButtonOpen
			$File = FileOpenDialog("Insertar archivo:", @ScriptDir, "rtf (*.myrt;*.rtf)")
			_Open($RichEdit, $File)
			;ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
			ConsoleWrite("Line count: "  & _RichEdit_GetLineCount($RichEdit))
		Case $msg = $ButtonOpenSel
			$File = FileOpenDialog("Insertar archivo en la selección:", @ScriptDir, "rtf (*.myrt;*.rtf)")
			_Open($RichEdit, $File, 1)
			;ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)	
		Case $msg = $hB_Table
			Dim $InVert = 1, $InHor = 1, $OutLine = 40, $Columns = 4, $Width = 60, $rows = 10, $RowHeight = 400
			Dim $ColorLine = 0x00c300, $ColorCell = 0xb7eed6, $ColorTopLeft = 0x676767, $ColorHead = 0x87ccff, $ColorLeft = 0xb7d6ff
			Dim $HeadLine = 25, $TopLeft = 0, $TopLeftBk = 0
			Dim $AlignTable = "c"
			_RichEdit_InsertTable($RichEdit)
		Case $msg = $hB_Bold
			_RichEdit_ToggleBold($RichEdit)
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)	
		Case $msg = $hB_Italic
			_RichEdit_ToggleItalic($RichEdit)
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
		Case $msg = $hB_Underline
			_RichEdit_ToggleUnderline($RichEdit)
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)	
		Case $msg = $hB_StrikeOut
			_RichEdit_ToggleStrikeOut($RichEdit)
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
		Case $msg = $hB_FontColor
			_RichEdit_SetFontColor($RichEdit, _ChooseColor(1, 0x0000FF))	
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)	
		Case $msg = $hB_BkColor
			_RichEdit_SetBkColor($RichEdit, _ChooseColor(1, 0x0000FF))	
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
		Case $msg =	$hB_AlignL
			_RichEdit_SetAlignment($RichEdit, 1)
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
		Case $msg =	$hB_AlignC
			_RichEdit_SetAlignment($RichEdit, 3)
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
		Case $msg =	$hB_AlignR
			_RichEdit_SetAlignment($RichEdit, 2)
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
		Case $msg =	$hB_Bk
			_RichEdit_BkColor($RichEdit, _ChooseColor(1, 0x0000FF))
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
		Case $msg =	$hB_GetSel
			$Sel = _RichEdit_GetSelection($RichEdit)
			ConsoleWrite("actual sel.: " & @LF & $Sel[0] & " --- " & $Sel[1] & @LF)
		Case $msg = $hC_FontSize
			_RichEdit_SetFontSize($RichEdit, GUiCtrlRead($hC_FontSize))
			ControlFocus ( "Rich Edit (Exemple)", "", $RichEdit)
	EndSelect		
	;
	Sleep(10)
WEnd

;============================================================================================================

Func _RichEdit_InsertTable($hWnd)
	Local $SingleCell = Round($Width*100/$Columns, 0), $CellIn, $RowIn, $CellInBottom, $CellInTop, $cll
	Local $ColorTable = "{\colortbl ;\red0\green0\blue0;\red255\green255\blue255;"
	Local $FontTable = "{\rtf1\ansi\ansicpg1252\deff0\deflang1034{\fonttbl{\f0\froman\fprq2\fcharset0 Times New Roman;}{\f1\fnil\fcharset0 Times New Roman;}}"
	
	$ColorTable &= "\red" & _ColorGetRed($ColorCell) & "\green" & _ColorGetGreen($ColorCell) & "\blue" & _ColorGetBlue($ColorCell) & ";" 
	$ColorTable &= "\red" & _ColorGetRed($ColorLine) & "\green" & _ColorGetGreen($ColorLine) & "\blue" & _ColorGetBlue($ColorLine) & ";"
	$ColorTable &= "\red" & _ColorGetRed($ColorHead) & "\green" & _ColorGetGreen($ColorHead) & "\blue" & _ColorGetBlue($ColorHead) & ";"
	$ColorTable &= "\red" & _ColorGetRed($ColorLeft) & "\green" & _ColorGetGreen($ColorLeft) & "\blue" & _ColorGetBlue($ColorLeft) & ";"
	$ColorTable &= "}"
	
	If $TopLeftBk Then $TopLeftBk = "\clcbpat3"
	
	If Not $TopLeft Then
		$HeadLine2 = $OutLine
	Else
		$HeadLine2 = $HeadLine	
	EndIf
		
	For $x = 1 To $Columns - 1
		$cll &= "\cell"
	Next	
	
	For $x = 2 To $Columns - 1
		$CellInTop &= "\clvertalc" & "\clcbpat5" & "\clbrdrl\brdrw" & $InVert & "\brdrs\brdrcf4\clbrdrt\brdrw" & $OutLine & "\brdrs\brdrcf4\clbrdrb\brdrw" & $HeadLine & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*$x
		$CellIn &= "\clvertalc" & "\clcbpat3" & "\clbrdrl\brdrw" & $InVert & "\brdrs\brdrcf4\clbrdrt\brdrw" & $InHor & "\brdrs\brdrcf4\clbrdrb\brdrw" & $InHor & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*$x
		$CellInBottom &= "\clvertalc" & "\clcbpat3" & "\clbrdrl\brdrw" & $InVert & "\brdrs\brdrcf4\clbrdrt\brdrw" & $InHor & "\brdrs\brdrcf4\clbrdrb\brdrw" & $OutLine & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*$x
	Next
	
	For $x = 2 To $rows - 1
		$RowIn &= 	"\trrh" & $RowHeight & _
					"\clvertalc" & "\clcbpat3" & "\clbrdrl\brdrw" & $OutLine & "\brdrs\brdrcf4\clbrdrt\brdrw" & $InHor & "\brdrs\brdrcf4\clbrdrr\brdrw" & $HeadLine & "\brdrs\brdrcf4\clbrdrb\brdrw" & $InHor & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*1 & _
					$CellIn & _
					"\clvertalc" & "\clcbpat3" & "\clbrdrl\brdrw" & $InVert & "\brdrs\brdrcf4\clbrdrt\brdrw" & $InHor & "\brdrs\brdrcf4\clbrdrr\brdrw" & $OutLine & "\brdrs\brdrcf4\clbrdrb\brdrw" & $InHor & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*$Columns & _
					"\pard\intbl" & "\ql" & $cll & _
					"\row\trowd\trq" & $AlignTable
	Next	
	
	Local $Table =  $FontTable & $ColorTable & _	;color table
					"\viewkind4\uc1" & _
					"\trowd\trq" & $AlignTable & _
					"\trrh" & $RowHeight & _	;row formating; trowd = default, trrh+Num = row hight
					"\clvertalc" & $TopLeftBk & "\clbrdrl\brdrw" & $TopLeft & "\brdrs\brdrcf4\clbrdrt\brdrw" & $TopLeft & "\brdrs\brdrcf4\clbrdrr\brdrw" & $HeadLine2 & "\brdrs\brdrcf4\clbrdrb\brdrw" & $HeadLine2 & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*1 & _ 
					$CellInTop & _
					"\clvertalc" & "\clcbpat5" & "\clbrdrl\brdrw" & $InVert & "\brdrs\brdrcf4\clbrdrt\brdrw" & $OutLine & "\brdrs\brdrcf4\clbrdrr\brdrw" & $OutLine & "\brdrs\brdrcf4\clbrdrb\brdrw" & $HeadLine & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*$Columns & _ 
					"\pard\intbl" & "\qc" & $cll & _ ;text in row (here: next 3 cells)
					"\row\trowd\trq" & $AlignTable  & _	;end of a row
					$RowIn & _	;a loop for more rows
					"\trrh" & $RowHeight & _
					"\clvertalc" & "\clcbpat3" & "\clbrdrl\brdrw" & $OutLine & "\brdrs\brdrcf4\clbrdrt\brdrw" & $InHor & "\brdrs\brdrcf4\clbrdrr\brdrw" & $HeadLine & "\brdrs\brdrcf4\clbrdrb\brdrw" & $OutLine & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*1 & _
					$CellInBottom & _
					"\clvertalc" & "\clcbpat3" & "\clbrdrl\brdrw" & $InVert & "\brdrs\brdrcf4\clbrdrt\brdrw" & $InHor & "\brdrs\brdrcf4\clbrdrr\brdrw" & $OutLine & "\brdrs\brdrcf4\clbrdrb\brdrw" & $OutLine & "\brdrs\brdrcf4" & " \cellx" & $SingleCell*$Columns & _
					"\intbl" & "\ql" & $cll & "\row" & _
					"}"
	_RichEdit_PasteRichText($hWnd, $Table, 1)
EndFunc	

Func _RichEdit_StringGetPos($hWnd, $sText)
	$SearchIn = _RichEdit_GetText($hWnd)
	$Pos = StringInStr($SearchIn, $sText)-1
	ConsoleWrite($sText & " (at pos) " & $Pos)
EndFunc	

Func _RichEdit_PasteRichText($hWnd, $sRTFText, $iSelec = 0)	; Set rich text from a var 
	If $iSelec Then $iSelec = $SFF_SELECTION
	$sSetRtf = $sRTFText
	$fSet = True
	_SendMessage($hWnd, $EM_STREAMIN, BitOr($SF_RTF, $iSelec), DllStructGetPtr($EDITSTREAM))
	_RichEdit_AddText ($hWnd, "")
EndFunc 

Func _Save($hWnd, $hSaveFileName, $iSelec = 0)
	$fSet = False
	If $iSelec Then $iSelec = $SFF_SELECTION
	$RtfFile = FileOpen($hSaveFileName, 2)
	_SendMessage($hWnd, $EM_STREAMOUT, BitOr($SF_RTF, $iSelec), DllStructGetPtr($EDITSTREAM))
	FileWrite($RtfFile, $sGetRtf)
	FileClose($RtfFile)
EndFunc	

Func _Open($hWnd, $hSaveFileName, $iSelec = 0)
	If $iSelec Then $iSelec = $SFF_SELECTION
	$fSet = True
	$RtfFile = FileOpen($hSaveFileName, 0)
	$sSetRtf = FileRead($RtfFile)
	FileClose($RtfFile)
	$Chars = _SendMessage($hWnd, $EM_STREAMIN, BitOr($SF_RTF, $iSelec), DllStructGetPtr($EDITSTREAM))
	ConsoleWrite("Chars to read: " & $Chars & @LF)
EndFunc	

Func _RichEdit_SetFont($hWnd, $Set = -1, $FontColor = -1, $BkColor = -1, $sFontName = -1, $iFontSize = -1, $Selec = 1)	; 1: Bold, 2: Italic, 3: Underline, 4: StrikeOut 
	If $Set <> -1 Then
		$Set = String($Set)
		While StringLen($Set) < 4
			$Set = "0" & $Set
		WEnd
		$SplitSet = StringSplit($Set, "")
		_RichEdit_SetBold ($hWnd, Number($SplitSet[1]), $Selec)
		_RichEdit_SetItalic ($hWnd, Number($SplitSet[2]), $Selec)
		_RichEdit_SetUnderline ($hWnd, Number($SplitSet[3]), $Selec)
		_RichEdit_SetStrikeOut ($hWnd, Number($SplitSet[4]), $Selec)
	EndIf	
	If $FontColor <> -1 Then _RichEdit_SetFontColor ($hWnd, $FontColor, $Selec)
	If $BkColor <> -1 Then _RichEdit_SetBkColor ($hWnd, $BkColor, $Selec)
	If $sFontName <> -1 Then _RichEdit_SetFontName ($hWnd, $sFontName, $Selec)
	If $iFontSize <> -1 Then _RichEdit_SetFontSize ($hWnd, $iFontSize, $Selec)
EndFunc	

Func _RichEditAppendLink($hWnd, $sText, $iNewLine = 1)
	Local $StartPos = StringLen(_RichEdit_GetText($hWnd)), $EndPos = $StartPos + StringLen($sText)
	_GUICtrlEdit_AppendText($hWnd, $sText)
	If $iNewLine Then _GUICtrlEdit_AppendText($hWnd, @CRLF)
	_RichEdit_SetSel($hWnd, $StartPos, $EndPos, 1)
	_RichEdit_SetLink($hWnd)
	_RichEdit_SetSel($hWnd, StringLen(_RichEdit_GetText($hWnd)), StringLen(_RichEdit_GetText($hWnd)), 1)
	_RichEdit_SetNumbering($hWnd, 0, 0)
	_RichEdit_SetSel($hWnd, $EndPos, $EndPos, 1)
EndFunc	;==> _RichEditAppendLink

Func _Tab()
    _RichEdit_AddText($RichEdit, @Tab)
EndFunc

Func _SetButtons()
	$hB_Bold = GUICtrlCreateButton("b", 30, 70, 20, 20)
	$hB_Italic = GUICtrlCreateButton("i", 50, 70, 20, 20)
	$hB_Underline = GUICtrlCreateButton("u", 70, 70, 20, 20)
	$hB_StrikeOut = GUICtrlCreateButton("s", 90, 70, 20, 20)
	$hB_FontColor = GUICtrlCreateButton("fc", 120, 70, 30, 20)
	$hB_BkColor = GUICtrlCreateButton("fbc", 150, 70, 30, 20)
	$hB_AlignL = GUICtrlCreateButton("align l", 190, 70, 45, 20)
	$hB_AlignC = GUICtrlCreateButton("align c", 235, 70, 45, 20)
	$hB_AlignR = GUICtrlCreateButton("align r", 280, 70, 45, 20)
	$hB_Bk = GUICtrlCreateButton("bgc", 335, 70, 30, 20)
	$hB_GetSel = GUICtrlCreateButton("get sel.", 375, 70, 40, 20)
	$hC_FontSize = GUICtrlCreateCombo(14, 30, 100, 65, 20)
	$hB_Table = GuiCtrlCreateButton("Insert table", 357, 100, 60, 20)
	
	$Values = 6
	
	For $x = 7 To 64
		$Values &= "|" & $x
	Next	
	
	GUICtrlSetData($hC_FontSize, $Values, 14)
EndFunc	

;=====================================================================================================================

Func _EditStreamCallback($pdwCookie, $pbBuff, $cb, $pcb)
	Local $szRTF = DllStructCreate("char[" & $cb & "]", $pbBuff)
	If $fSet Then
		Local $_pcb = DllStructCreate("long", $pcb)
		Local $sPart = StringLeft($sSetRtf, $cb-1)
		$sSetRtf = StringTrimLeft($sSetRtf, $cb-1)
		DllStructSetData($szRTF, 1, $sPart)	; $TextPart
		DllStructSetData($_pcb, 1, $cb-1)	; StringLen($TextPart)
	Else
		$sGetRtf &= DllStructGetData($szRTF, 1)
	EndIf
	Return 0
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    ConsoleWrite($iMsg&" "&Random(10)&@CRLF)
	Local $hWndFrom, $idFrom, $iCode
	Local $tNMHDR, $tENLINK, $tENPROTECTED, $MousePos[2], $OldMousePos[2]
	$hWndRichEdit = $RichEdit
    If Not IsHWnd($RichEdit) Then $hWndRichEdit = GUICtrlGetHandle($RichEdit)

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")

    Switch $hWndFrom
        Case $RichEdit, $hWndRichEdit
            Switch $iCode
                Case $EN_LINK												
					Local $tENLINK = DllStructCreate($tagENLINK, $ilParam)
					Local $iMessage = DllStructGetData($tENLINK, 4)
					Local $cpMin = DllStructGetData($tENLINK, 7)
					Local $cpMax = DllStructGetData($tENLINK, 8)
					$Sel = _RichEdit_GetSelection($RichEdit)
					Local $LinkText = StringLeft(StringTrimLeft(_RichEdit_GetText($hwndFrom), $cpMin), $cpMax - $cpMin)
					Select
						Case BitAND($iMessage, $WM_LBUTTONDBLCLK) = $WM_LBUTTONDBLCLK
						    GuiCtrlSetData($Label, "Double-Clik on: " & $LinkText & @CRLF)	
						Case BitAND($iMessage, $WM_RBUTTONDOWN) = $WM_RBUTTONDOWN
						    GuiCtrlSetData($Label, "R-Clik on: " & $LinkText & @CRLF)
						Case BitAND($iMessage, $WM_LBUTTONDOWN) = $WM_LBUTTONDOWN
						    GuiCtrlSetData($Label, "L-Clik on: " & $LinkText & @CRLF)
					EndSelect
					_RichEdit_SetSel($hWndFrom, $Sel[0], $Sel[0])
				Case $EN_PROTECTED
					MsgBox(64, "", "Texto protegido")
					Send("^z")
				Case $EN_SELCHANGE
					Local $tSELCHANGE = DllStructCreate($tagSELCHANGE, $ilParam)
					Local $cpMin = DllStructGetData($tSELCHANGE, 4)
					Local $cpMax = DllStructGetData($tSELCHANGE, 5)
					ConsoleWrite("Sel change:" & @LF & $cpMin & " --- " & $cpMax & @LF)
				#cs
				Case $EN_MSGFILTER
					Local $tEN_MSGFILTER = DllStructCreate($tagEN_MSGFILTER, $ilParam)
					Local $iMessage = DllStructGetData($tEN_MSGFILTER, 4)
					$OldSel = _RichEdit_GetSelection($RichEdit)
					Select
						Case $iMessage = 513 
							ConsoleWrite("Left Click" & @CRLF)
						Case $iMessage = 514 
							ConsoleWrite("Left Up" & @CRLF)
						Case $iMessage = 515 
							ConsoleWrite("Left Double" & @CRLF)
						Case $iMessage = 516 
							ConsoleWrite("Right Click" & @CRLF)
						Case $iMessage = 517 
							ConsoleWrite("Right Up" & @CRLF)
						Case $iMessage = 519 
							ConsoleWrite("Wheel Click" & @CRLF)
						Case $iMessage = 520 
							ConsoleWrite("Wheel Up" & @CRLF)
						Case $iMessage = 522
							ConsoleWrite("Wheel Scroll" & @CRLF)	
						Case $iMessage = 256 
							;ConsoleWrite("Key Down" & @CRLF)
						Case $iMessage = 258 
							;ConsoleWrite("Key Still Down" & @CRLF)	
						Case $iMessage = 257 
							;ConsoleWrite("Key Up" & @CRLF)	
						;Case $iMessage = 512 or $iMessage = 33 
							;Return
						;Case Else
							;ConsoleWrite($iMessage & @CRLF)
					EndSelect
				#ce	
			EndSwitch
		Case Else
	EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
