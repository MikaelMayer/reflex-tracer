#include-once
Opt("MustDeclareVars", 1)

Global Const $EM_STREAMIN = 0x400+73
Global Const $EM_STREAMOUT = 0x400+74
Global Const $SF_RTF = 2
Global $fSet
Global $sRTFClassName, $pEditStreamCallback, $dll, $sGetRtf, $sSetRtf 

Global $EDITSTREAM = DllStructCreate("DWORD pdwCookie;DWORD dwError;PTR pfnCallback")
$pEditStreamCallback = _DllCallBack("_EditStreamCallback", "ptr;ptr;long;ptr")
DllStructSetData($EDITSTREAM, "pfnCallback", $pEditStreamCallback)

If FileExists(@SystemDir & "\Msftedit.dll") Then
    $dll = DllOpen("MSFTEDIT.DLL")
    $sRTFClassName = "RichEdit50W"
	;$dll = DllOpen("RICHED20.DLL")
    ;$sRTFClassName = "RichEdit20A"
Else
    ;MSFTEDIT.DLL
	$dll = DllOpen("RICHED20.DLL")
    $sRTFClassName = "RichEdit20A"
EndIf
  
;events mask
Global Const $ENM_CHANGE = 0x1
Global Const $ENM_CORRECTTEXT = 0x400000
Global Const $ENM_DRAGDROPDONE = 0x10
Global Const $ENM_DROPFILES = 0x100000
Global Const $ENM_IMECHANGE = 0x800000
Global Const $ENM_KEYEVENTS = 0x10000
Global Const $ENM_LINK = 0x4000000
Global Const $ENM_MOUSEEVENTS = 0x20000
Global Const $ENM_OBJECTPOSITIONS = 0x2000000
Global Const $ENM_PROTECTED = 0x200000
Global Const $ENM_REQUESTRESIZE = 0x40000
Global Const $ENM_SCROLL = 0x4
Global Const $ENM_SCROLLEVENTS = 0x8
Global Const $ENM_SELCHANGE = 0x80000
Global Const $ENM_UPDATE = 0x2
Global Const $EM_AUTOURLDETECT = $WM_USER + 91
Global Const $EM_FINDTEXT = $WM_USER + 56

;Global Const $EM_GETLINE = 0xC4
;global Const $EM_GETSEL = 0xB0
Global Const $EM_EXLIMITTEXT = $WM_USER+53
Global Const $EM_GETSELTEXT = $WM_USER + 62
Global Const $EM_GETTEXTEX = $WM_USER + 94
Global Const $EM_GETTEXTLENGTHEX = $WM_USER + 95
Global Const $EM_GETTEXTMODE = $WM_USER + 90
Global Const $EM_GETTEXTRANGE = $WM_USER + 75
Global Const $EM_GETSCROLLPOS = $WM_USER + 221
Global Const $EM_HIDESELECTION = ($WM_USER + 63)
;Global Const $EM_SETPASSWORDCHAR = 0xCC
Global Const $EM_SETFONTSIZE = $WM_USER + 223
Global Const $EM_SETBKGNDCOLOR = ($WM_USER + 67)
Global Const $EM_GETCHARFORMAT = 1082
Global Const $EM_SETCHARFORMAT = 1092
global Const $EM_FINDWORDBREAK = $WM_USER + 76
Global Const $EM_REQUESTRESIZE = ($WM_USER + 65)
Global Const $EM_EXGETSEL = $WM_USER+52
Global Const $EM_SETPARAFORMAT = $WM_USER+71
Global Const $EM_GETPARAFORMAT = $WM_USER+61

Global Const $EN_LINK = 0x70b
Global Const $EN_MSGFILTER = 0x700
Global Const $EN_PROTECTED = 0x704
Global Const $EN_SELCHANGE = 0x702

Global Const $SCF_DEFAULT = 0x0
Global Const $SCF_SELECTION = 0x01
Global Const $SCF_WORD = 0x0002

Global Const $SFF_SELECTION = 0x8000

;constants for the CHARFORMAT2
Global Const $CFM_BOLD = 0x00000001
Global Const $CFM_ITALIC = 0x00000002
Global Const $CFM_UNDERLINE = 0x00000004
Global Const $CFM_STRIKEOUT = 0x00000008
Global Const $CFM_PROTECTED = 0x00000010
Global Const $CFM_DISABLED = 0x2000
Global Const $CFM_LINK = 0x00000020 ;/ * Exchange hyperlink extension * /
Global Const $CFM_SIZE = 0x80000000
Global Const $CFM_COLOR = 0x40000000
Global Const $CFM_FACE = 0x20000000
Global Const $CFM_OFFSET = 0x10000000
Global Const $CFM_RichEdit_SET = 0x08000000
Global Const $CFM_WEIGHT = 0x00400000
Global Const $CFM_BACKCOLOR = 0x04000000
Global Const $CFM_SPACING = 0x200000
Global Const $CFM_UNDERLINETYPE = 0x800000
Global Const $CFM_STYLE = 0x80000
Global Const $CFM_REVISED = 0x4000

; CHARFORMAT effects */
Global Const $CFE_BOLD = 0x0001
Global Const $CFE_ITALIC = 0x0002
Global Const $CFE_UNDERLINE = 0x0004
Global Const $CFE_STRIKEOUT = 0x0008
Global Const $CFE_PROTECTED = 0x0010
Global Const $CFE_DISABLED = $CFM_DISABLED
Global Const $CFE_LINK = 0x0020
Global Const $CFE_AUTOCOLOR = 0x40000000
Global Const $CFE_REVISED = $CFM_REVISED

Global Const $EM_SETEVENTMASK = $WM_USER + 69
;
Global Const $CFU_UNDERLINEDOUBLE = 3
Global Const $CFU_UNDERLINEWORD = 2

Global Const $PFA_LEFT = 0x1
Global Const $PFA_RIGHT = 0x2
Global Const $PFA_CENTER = 0x3
Global Const $PFA_JUSTIFY = 4

Global Const $PFE_TABLE = 0x4000

Global Const $PFM_NUMBERING = 0x20
Global Const $PFM_ALIGNMENT = 0x8
Global Const $PFM_SPACEBEFORE = 0x40
Global Const $PFM_NUMBERINGSTYLE = 0x2000
Global Const $PFM_NUMBERINGSTART = 0x8000
Global Const $PFM_BORDER = 0x800
Global Const $PFM_RIGHTINDENT = 0x2
Global Const $PFM_STARTINDENT = 0x1
Global Const $PFM_OFFSET = 0x4
Global Const $PFM_LINESPACING = 0x100
Global Const $PFM_SPACEAFTER = 0x80
Global Const $PFM_NUMBERINGTAB = 0x4000
Global Const $PFM_TABLE = 0x40000000

Global Const $PFN_BULLET = 0x1

global Const $WB_CLASSIFY = 3
global Const $WB_ISDELIMITER = 2
global Const $WB_LEFT = 0
global Const $WB_LEFTBREAK = 6
global Const $WB_MOVEWORDLEFT = 4
global Const $WB_MOVEWORDNEXT = 5
global Const $WB_MOVEWORDPREV = 4
global Const $WB_MOVEWORDRIGHT = 5
global Const $WB_NEXTBREAK = 7
global Const $WB_PREVBREAK = 6
global Const $WB_RIGHT = 1
global Const $WB_RIGHTBREAK = 7

Global Const $WM_LBUTTONDOWN = 0x201
Global Const $WM_RBUTTONDOWN = 0x204
Global Const $WM_LBUTTONDBLCLK = 0x203
;Global Const $WM_MOUSEMOVE = 0x200

Global Const $GT_DEFAULT = 0
Global Const $GT_SELECTION = 2

Global Const $tagCHARFORMAT2 = "uint;int;dword;long;long;dword;byte;byte;char[32];short;short;long;long;long;short;short;byte;byte;byte;byte"
;																			        10    11    12     13  14   15    16    17   18   19   20
;			"cbSize, dwMask, dwEffects, yHeight, yOffset, crTextColor, bCharSet, bPitchAndFamily, szFaceName, wWeight, sSpacing, crBackColor, " & _
;           "lcid, dwReserved, sStyle, wKerning, bUnderlineType, bAnimation, bRevAuthor, bReserved1" (84)

Global Const $tagPARAFORMAT = "uint;uint;short;short;int;int;int;short;short;int[32]"
;~ UINT cbSize;
;~ DWORD dwMask;
;~ WORD wNumbering;
;~ WORD wReserved;
;~ LONG dxStartIndent;
;~ LONG dxRightIndent;
;~ LONG dxOffset;
;~ WORD wAlignment;
;~ SHORT cTabCount;
;~ LONG rgxTabs[MAX_TAB_STOPS];

;Global Const $tagPARAFORMAT2 = "uint;uint;short;short;int;int;int;short;short;int[32];long;short;ushort;ulong;ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort"
Global Const $tagPARAFORMAT2 = "uint;uint;short;short;int;int;int;short;short;int[32];int;int;int;ushort;byte;byte;short;short;short;short;short;short;short;short"
;								 1	  2	   3	  4	   5   6   7	8	  9		10	  11  12  13	14	  15   16	17	  18	19	  20	21    22     23    24  
;~ UINT cbSize;
;~ DWORD dwMask;
;~ WORD  wNumbering;
;~ WORD  wEffects;
;~ LONG  dxStartIndent;
;~ LONG  dxRightIndent;
;~ LONG  dxOffset;
;~ WORD  wAlignment;
;~ SHORT cTabCount;
;~ LONG  rgxTabs[MAX_TAB_STOPS];
;~ LONG  dySpaceBefore;
;~ LONG  dySpaceAfter;
;~ LONG  dyLineSpacing;
;~ SHORT sStyle;
;~ BYTE  bLineSpacingRule;
;~ BYTE  bOutlineLevel;
;~ WORD  wShadingWeight;
;~ WORD  wShadingStyle;
;~ WORD  wNumberingStart;
;~ WORD  wNumberingStyle;
;~ WORD  wNumberingTab;
;~ WORD  wBorderSpace;
;~ WORD  wBorderWidth;
;~ WORD  wBorders;

Global $tagTEXTEX = "dword;dword;uint;char;int"
;					"cbSize, flags, codepage, lpDefaultChar, lpUsedDefChar"
Global $tagCHARRANGE = "long;long"
;						"cpMin, cpMax"
Global $tagFINDTEXT = "ptr;str"
;					"CHARRANGE, lpstrText"		
;Global $tagLOGFONT = "long;long;long;long;long;byte;byte;byte;byte;byte;byte;byte;byte;char[32]"
;					"lfHeight, lfWidth, lfEscapement, lfOrientation, lfWeight, lfItalic, lfUnderline, lfStrikeOut, lfCharset, " &_ 
;					"lfOutPrecision, lfClipPrecision, lfQuality, lfPitchAndFamily, lfFaceName" & _



Global $tagENLINK = $tagNMHDR & ";uint msg;int wParam;int lParam;" & $tagCHARRANGE

Global $tagEN_MSGFILTER = $tagNMHDR & ";uint msg;int wParam;int lParam;"

Global $tagENPROTECTED = $tagNMHDR & ";uint msg;int wParam;int lParam;" & $tagCHARRANGE

Global $tagSELCHANGE = $tagNMHDR & ";" & $tagCHARRANGE & ";long seltyp;"

Global $tcharformat = DllStructCreate($tagCHARFORMAT2)
DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
Global $tparaformat = DllStructCreate($tagPARAFORMAT2)
DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))



#cs===================================================================================================
 (*) ==> Functions that are not needed, because there are the same /similar functions in
 3.2.10 (GuiEdit.au3)!!!
 
 _GuiCtrl_RichEdit_Create
 _RichEdit_AddText(*)
 _RichEdit_BkColor 
 _RichEdit_GetFontName
 _RichEdit_GetFontSize
 _RichEdit_GetLineCount
 _RichEdit_GetBold
 _RichEdit_GetItalic 
 _RichEdit_GetUnderline
 _RichEdit_GetStrikeOut
 _RichEdit_GetFontColor
 _RichEdit_GetBkColor
 _RichEdit_GetFormat
 _RichEdit_GetSelection(*)         
 _RichEdit_GetText(*)
 _RichEdit_GetSelText
 _RichEdit_IncreaseFontSize
 _RichEdit_LimitText(*)
 _RichEdit_SetAlignment
 _RichEdit_SetFontName
 _RichEdit_SetFontSize
 _RichEdit_SetBold
 _RichEdit_SetItalic
 _RichEdit_SetLineSpacing
 _RichEdit_SetLink
 _RichEdit_SetOffSet
 _RichEdit_SetProtected
 _RichEdit_SetUnderline
 _RichEdit_SetStrikeOut
 _RichEdit_SetFontColor
 _RichEdit_SetBkColor
 _RichEdit_SetEventMask
 _RichEdit_SetNumbering
 _RichEdit_SetReadOnly(*)
 _RichEdit_SetSel(*)
 _RichEdit_ToggleBold
 _RichEdit_ToggleItalic
 _RichEdit_ToggleUnderline
 _RichEdit_ToggleStrikeOut
 _RichEdit_Undo(*)
#ce===================================================================================================

;=====================================================================================================
; _GuiCtrl_RichEdit_Create
; _GuiCtrl_RichEdit_CreateInput
;=====================================================================================================

Func _GuiCtrl_RichEdit_Create($hWnd, $x, $y, $width, $height, $dwStyle = -1, $dwExStyle = -1)
	If $dwStyle = -1 Then $dwStyle = BitOR($WS_CHILD, $ES_WANTRETURN, $ES_NOHIDESEL, $WS_VSCROLL, $WS_TABSTOP, $WS_VISIBLE, $ES_MULTILINE)
	If $dwExStyle = -1 Then $dwExStyle = $WS_EX_CLIENTEDGE
	Return _WinAPI_CreateWindowEx($dwExStyle, $sRTFClassName, "", $dwStyle, $x, $y, $width, $height, $hWnd)
EndFunc

Func _GuiCtrl_RichEdit_CreateInput($hWnd, $x, $y, $width, $height, $dwStyle = -1, $dwExStyle = -1)
	If $dwStyle = -1 Then $dwStyle = BitOR($WS_CHILD, $ES_WANTRETURN, $ES_NOHIDESEL, $WS_VISIBLE)
	If $dwExStyle = -1 Then $dwExStyle = $WS_EX_CLIENTEDGE
	Return _WinAPI_CreateWindowEx($dwExStyle, $sRTFClassName, "", $dwStyle, $x, $y, $width, $height, $hWnd)
EndFunc



; ====================================================================================================
; Description ..: Appends some text to the control
; Parameters ...: $hWnd         - Handle to the control
;                 $iText        - Text to append
;				  $i_udone		- if True, can be undone		
; Return values : none
; Author .......: grham
; Notes ........: appended to a selection; if no selection, at the caret 
; ====================================================================================================
Func _RichEdit_AddText($hWnd, $iText, $i_undone = True)
    Local $Buffer = DllStructCreate("char[" & StringLen($iText)+1 & "]")
	DllStructSetData($Buffer, 1, $iText)
	_SendMessage($hWnd, $EM_REPLACESEL, $i_undone, DllStructGetPtr($Buffer))
	$Buffer = 0
EndFunc   ;==>_RichEdit_AddText

; ====================================================================================================
; Description ..: Sets a background color of a richedit control
; Parameters ...: $hWnd         - Handle to the control
;                 $iColor       - Color to set
; Return values : none
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_BkColor($hWnd, $iColor)
	_SendMessage($hWnd, $EM_SETBKGNDCOLOR, 0, $iColor)
EndFunc	;==> _RichEdit_BkColor

; ====================================================================================================
; Description ..: _RichEdit_GetFontName
; Parameters ...: $hWnd         - Handle to the control
; Return values : Font name
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetFontName($hWnd)
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	_SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
	Return DllStructGetData($tcharformat, 9)
EndFunc	;==>_RichEdit_GetFontName

; ====================================================================================================
; Description ..: _RichEdit_GetFontSize
; Parameters ...: $hWnd         - Handle to the control
; Return values : Font size
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetFontSize($hWnd)
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	_SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
	Return DllStructGetData($tcharformat, 4)/20
EndFunc	;==>_RichEdit_GetFontSize

; ====================================================================================================
; Description ..: Get the Line Count for the Control
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns the line count if successful
; Author .......: Yoan Roblet (Arcker)
; Notes ........:
; ====================================================================================================
Func _RichEdit_GetLineCount($hWnd)
    Return _SendMessage($hWnd, $EM_GETLINECOUNT, 0, 0)
EndFunc   ;==>_RichEdit_GetLineCount

; ====================================================================================================
; Description ..: _RichEdit_GetBold
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns True or False
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetBold($hWnd)
    ;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	_SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
    Return BitAND(DllStructGetData($tcharformat, 3), $CFE_BOLD)/ 1
EndFunc   ;==>_RichEdit_GetBold

; ====================================================================================================
; Description ..: _RichEdit_GetItalic
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns True or False
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetItalic($hWnd)
    ;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	 _SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
    Return BitAND(DllStructGetData($tcharformat, 3), $CFE_ITALIC)/ 2
EndFunc   ;==>_RichEdit_GetItalic

; ====================================================================================================
; Description ..: _RichEdit_GetUnderline
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns True or False
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetUnderline($hWnd)
    ;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	 _SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
    Return BitAND(DllStructGetData($tcharformat, 3), $CFE_Underline)/4
EndFunc   ;==>_RichEdit_GetUnderline

; ====================================================================================================
; Description ..: _RichEdit_GetStrikeOut
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns True or False
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetStrikeOut($hWnd)
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	 _SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
    Return BitAND(DllStructGetData($tcharformat, 3), $CFE_STRIKEOUT)/8
EndFunc   ;==>_RichEdit_GetStrikeOut

; ====================================================================================================
; Description ..: _RichEdit_GetFontColor
; Parameters ...: $hWnd         - Handle to the control
; Return values : Font color (Hex)
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetFontColor($hWnd)
    ;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	 _SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
    Return 0 & "x" & StringTrimLeft(Hex(DllStructGetData($tcharformat, 6)), 2)
EndFunc   ;==>_RichEdit_GetFontColor

; ====================================================================================================
; Description ..: _RichEdit_GetBkColor
; Parameters ...: $hWnd         - Handle to the control
; Return values : Background color (Hex)
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetBkColor($hWnd)
    ;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	_SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
    Return 0 & "x" & StringTrimLeft(Hex(DllStructGetData($tcharformat, 12)), 2)
EndFunc   ;==>_RichEdit_GetBkColor

; ====================================================================================================
; Description ..: _RichEdit_GetFormat
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns an Array with font format
;							index 0: bold-italic-underline-strikeout
;								  1: fontcolor			
;								  2: backgroundcolor				
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetFormat($hWnd)
    Local $Array[3]
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	 _SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
    $Array[0] = BitAND(DllStructGetData($tcharformat, 3), $CFE_BOLD)/1 & _
				BitAND(DllStructGetData($tcharformat, 3), $CFE_ITALIC)/2 & _
				BitAND(DllStructGetData($tcharformat, 3), $CFE_Underline)/4 & _
				BitAND(DllStructGetData($tcharformat, 3), $CFE_STRIKEOUT)/8
	$Array[1] = 0 & "x" & StringTrimLeft(Hex(DllStructGetData($tcharformat, 6)), 2)
	$Array[2] = 0 & "x" & StringTrimLeft(Hex(DllStructGetData($tcharformat, 12)), 2)
	Return $Array
EndFunc   ;==>_RichEdit_getformat

; ====================================================================================================
; Description ..: _RichEdit_GetSelection
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns the beginning and the ending position of the selection
; Author .......: 
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetSelection($hWnd)
	Local $tcharrange = DllStructCreate($tagCHARRANGE), $Array[2]
	_SendMessage ($hWnd, $EM_EXGETSEL, 0, DllStructGetPtr($tcharrange))
	$Array[0] = DllStructGetData($tcharrange, 1)
	$Array[1] = DllStructGetData($tcharrange, 2)
	Return $Array
EndFunc	;==>_RichEdit_GetSelection

; ====================================================================================================
; Description ..: _RichEdit_GetText
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns a text form a RTC as plain text
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetText($hWnd)
	Local $textex = DllStructCreate($tagTEXTEX)
	Local $Buffer = DllStructCreate("wchar[" & _SendMessage($hWnd, $WM_GETTEXTLENGTH, 0, 0)+1 & "]")
	;DllStructSetData($textex, 1, DllStructGetSize($Buffer))
	DllStructSetData($textex, 2, $GT_DEFAULT)
	DllStructSetData($textex, 3, 1200)
	DllStructSetData($textex, 4, 0)
	DllStructSetData($textex, 5, 0)
	_SendMessage ($hWnd, $EM_GETTEXTEX, DllStructGetPtr($textex), DllStructGetPtr($Buffer));
	Return DllStructGetData($Buffer, 1)
EndFunc ;==>_RichEdit_GetText

; ====================================================================================================
; Description ..: _RichEdit_GetSelText
; Parameters ...: $hWnd         - Handle to the control
; Return values : Returns a portion of a text selected
; Author .......: grham
; Notes ........: 
; ====================================================================================================
Func _RichEdit_GetSelText($hWnd)
	Local $Sel = _RichEdit_GetSelection($hWnd)
	Local $buffer = DllStructCreate("wchar[" & ($Sel[1]-$Sel[0])+1 & "]")
	DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $EM_GETSELTEXT, "int", 0, "ptr", DllStructGetPtr($buffer))
	Return DllStructGetData($buffer, 1)
EndFunc ;==>_RichEdit_GetSelText

; ====================================================================================================
; Description ..: Increase or decrease the font size
; Parameters ...: $hWnd         - Handle to the control
;                 $hDelta       - Value of incrementation, Negative ==> decrementation
; Return values : Returns True if successful, or False otherwise
; Author .......: 
; Notes ........: Apllied to the the end of text
; ====================================================================================================
Func _RichEdit_IncreaseFontSize($hWnd, $hDelta = 1)										
    Local $textlength = _SendMessage ($hWnd, $WM_GETTEXTLENGTH, 0, 0)
	_RichEdit_SetSel($hWnd, $textlength, $textlength, 1)
	Return _SendMessage ($hWnd, $EM_SETFONTSIZE, $hDelta, 0)
EndFunc   ;==>_RichEdit_IncreaseFontSize

; ====================================================================================================
; Description ..: Limit the control to N chararacters
; Parameters ...: $hWnd         - Handle to the control
;                 $hLimitTo     - Number of characters
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Notes ........: Set 0 to disable the limit
; ====================================================================================================
Func _RichEdit_LimitText($hWnd, $hLimitTo)
    Return _SendMessage($hWnd, $EM_LIMITTEXT, $hLimitTo, 0)
EndFunc   ;==>_RichEdit_LimitText

; ====================================================================================================
; Description ..: Paragraph alignment.
; Parameters ...: $hWnd         - Handle to the control
;                 $iAlignment   Values: 
;                               1 or $PFA_LEFT		Paragraphs are aligned with the left margin.
;                               2 or $PFA_RIGHT     Paragraphs are aligned with the right margin.
;                               3 or $PFA_CENTER    Paragraphs are centered.
;                               4 or $PFA_JUSTIFY 	Paragraphs are justified. This value is 
;													+included for compatibility with TOM interfaces; 
;													+rich edit controls earlier than Rich Edit 3.0 
;													+display the text aligned with the left margin.
; Return values : None
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetAlignment($hWnd, $iAlignment)		; 1 ==> Left, 2 ==> Right, 3 ==> Center, 4 ==> Justify 
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tparaformat, 2, $PFM_ALIGNMENT)
	DllStructSetData($tparaformat, 8, $iAlignment)
	_SendMessage($hWnd, $EM_SETPARAFORMAT, 0, DllStructGetPtr($tparaformat))
EndFunc

; ====================================================================================================
; Description ..: Select the Font Name
; Parameters ...: $hWnd         - Handle to the control
;           	  $hFontName    - Name of the Font
;                 $iSelec       - Modify entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Modified .....: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetFontName($hWnd, $hFontName, $iSelec = True)
    ;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_FACE)
	DllStructSetData($tcharformat, 9, $hFontName)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc   ;==>_RichEdit_SetFontName

; ====================================================================================================
; Description ..: _RichEdit_SetFontSize
; Parameters ...: $hWnd        - Handle to the control
;                 $iSize       - Size of the Font
;              	  $iSelec       - Modify entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Modified .....: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetFontSize($hWnd, $iSize , $iSelec = True)
    ;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_SIZE)
	DllStructSetData($tcharformat, 4, $iSize*20)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc ;==>_RichEdit_SetFontSize

; ====================================================================================================
; Description ..: Toggle the Bold effect
; Parameters ...: $hWnd         - Handle to the control
;                 $iStyle		- True = Set; False = Unset
;                 $iSelec       - Modify entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Modified ....:  grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetBold($hWnd, $iStyle = True, $iSelec = True, $iHL = True)
	If $iStyle Then $iStyle = $CFE_BOLD
	If $iHL Then $iHL = $CFE_LINK
	DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_BOLD)
	DllStructSetData($tcharformat, 3, $iStyle)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc   ;==>_RichEdit_SetBold

; ====================================================================================================
; Description ..: Toggle the Italic effect
; Parameters ...: $hWnd         - Handle to the control
;                 $iStyle		- True = Set; False = Unset
;                 $iSelec       - Modify entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Modified ....:  grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetItalic($hWnd, $iStyle = True, $iSelec = True)
	If $iStyle Then $iStyle = $CFE_ITALIC
	DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_ITALIC)
	DllStructSetData($tcharformat, 3, $iStyle)
    Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc   ;==>_RichEdit_SetItalic

; ====================================================================================================
; Description ..: Type of line spacing.
; Parameters ...: $hWnd         - Handle to the control
;                 $iNum	        Values:	
;                               0					Single spacing.
;                               1                   One-and-a-half spacing.
;								2                   Double spacing.
; Return values : None
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetLineSpacing($hWnd, $iNum, $iTwips = 0)	; 0 => 1, 1 => 1+1/2; 2 => 2
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tparaformat, 2, BitOr($PFM_LINESPACING, $PFM_SPACEAFTER))
	If $iTwips <> 0 Then DllStructSetData($tparaformat, 13, $iTwips*20)
	DllStructSetData($tparaformat, 15, $iNum)
	_SendMessage($hWnd, $EM_SETPARAFORMAT, 0, DllStructGetPtr($tparaformat))
EndFunc	;==> _RichEdit_SetLineSpacing

; ====================================================================================================
; Description ..: Toggle the Underline effect
; Parameters ...: $hWnd         - Handle to the control
;                 $iStyle		- True = Set; False = Unset
;                 $iSelec       - Modify entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetLink($hWnd, $iStyle = True, $iSelec = True)
    If $iStyle Then $iStyle = $CFE_LINK
	DllStructSetData($tcharformat, 2, $CFM_LINK)
	DllStructSetData($tcharformat, 3, $iStyle)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc   ;==>_RichEdit_SetLink

; ====================================================================================================
; Description ..: Indentation of the second and subsequent lines, 
;				  +relative to the indentation of the first line, in twips.
; Parameters ...: $hWnd         - Handle to the control
;                 $iOffset - (here: twips/100)
; Return values : None
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetOffSet($hWnd, $iOffset)
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tparaformat, 2, $PFM_OFFSET)
	DllStructSetData($tparaformat, 7, $iOffset*100)
	_SendMessage($hWnd, $EM_SETPARAFORMAT, 0, DllStructGetPtr($tparaformat))
EndFunc

; ====================================================================================================
; Description ..: Characters are protected; 
;				  +an attempt to modify them will cause an EN_PROTECTED notification message.
; Parameters ...: $hWnd         - Handle to the control
;                 $iStyle		- True = Set; False = Unset
;                 $iSelec       - Modify entire text or selection (default)
; Return values : None
; Author .......: grham
; Notes ........:
; ====================================================================================================

Func _RichEdit_SetProtected($hWnd, $iStyle = True, $iSelec = True)		
	If $iStyle Then $iStyle = $CFE_PROTECTED
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tcharformat, 2, $CFM_PROTECTED)
	DllStructSetData($tcharformat, 3, $iStyle)
	_SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc ;==> _RichEdit_SetProtected

; ====================================================================================================
; Description ..: Characters are marked as revised.
; Parameters ...: $hWnd         - Handle to the control
;                 $iStyle		- True = Set; False = Unset
;                 $iSelec       - Modify entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetRevised($hWnd, $iStyle = True, $iSelec = True)		
	If $iStyle Then $iStyle = $CFE_REVISED
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tcharformat, 2, $CFM_REVISED)
	DllStructSetData($tcharformat, 3, $iStyle)
	_SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc ;==> _RichEdit_SetProtected

; ====================================================================================================
; Description ..: Toggle the Underline effect
; Parameters ...: $hWnd         - Handle to the control
;                 $iStyle		- True = Set; False = Unset
;                 $iSelec       - Modify entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetUnderline($hWnd, $iStyle = True, $iSelec = True)
    If $iStyle Then $iStyle = $CFE_UNDERLINE
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_UNDERLINE)
	DllStructSetData($tcharformat, 3, $iStyle)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc   ;==>_RichEdit_SetUnderline

; ====================================================================================================
; Description ..: Toggle the Strike Out effect
; Parameters ...: $hWnd         - Handle to the control
;                 $iStyle		- True = Set; False = Unset
;                 $iSelec       - Modify entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Rewritten ....: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetStrikeOut($hWnd, $iStyle = True, $iSelec = True)
    If $iStyle Then $iStyle = $CFE_STRIKEOUT
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_STRIKEOUT)
	DllStructSetData($tcharformat, 3, $iStyle)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc

; ====================================================================================================
; Description ..: Select the text color
; Parameters ...: $hWnd         - Handle to the control
;           	  $hColor       - Color value
;                 $iSelect      - Color entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Rewritten ....: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetFontColor($hWnd, $hColor, $iSelec = True)
    ;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_COLOR)
	DllStructSetData($tcharformat, 6, $hColor)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc   ;==>_RichEdit_SetColor

; ====================================================================================================
; Description ..: Select the Background text color										
; Parameters ...: $hWnd         - Handle to the control
;           	  $hColor       - Color value
;                 $iSelec       - Color entire text or selection (default)
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Rewritten ....: grham (works)
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetBkColor($hWnd, $hColor, $iSelec = True)
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_BACKCOLOR)
	DllStructSetData($tcharformat, 12, $hColor)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc   ;==>_RichEdit_SetBkColor

; ====================================================================================================
; Description ..: The EM_SETEVENTMASK message sets the event mask for a rich edit control.
;           The event mask specifies which notification messages the control sends to its parent window
; Parameters ...: $hWnd         - Handle to the control
;                 $hMin         - Character Number start
;                 $hMax         - Character Number stop
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetEventMask($hWnd, $hFunction)
    Return _SendMessage ($hWnd, $EM_SETEVENTMASK, 0, $hFunction)
EndFunc   ;==>_RichEdit_SetEventMask

; ====================================================================================================
; Description ..: Sets paragraph numbering and numbering type
; Parameters ...: $hWnd         - Handle to the control
;                 $iChar        - Characters used for numbering:
;								0 					No numbering
;                               1 or $PFN_BULLET    Inserts a bullet
;                               2                   Arabic numbres (1,2,3 ...)
;                               3                   Lowercase tetters
;                               4                   Uppercase letters
;                               5                   Lowercase roman numerals (i,ii,iii...)
;                               6                   Uppercase roman numerals (I, II, ...)
;                               7                   Uses a sequence of characters beginning with 
;													+the Unicode character specified by 
;													+the wNumberingStart member
;                 $iFormat      - Numbering style used with numbered paragraphs
;                               0                   Follows the number with a right parenthesis.
;                               0x100               Encloses the number in parentheses. 
;                               0x200               Follows the number with a period.
;                               0x300               Displays only the number.
;                               0x400               Continues a numbered list without 
;													+applying the next number or bullet. 
;                               0x8000              Starts a new number with wNumberingStart.
;                 $iStart       - Starting number or Unicode value used for numbered paragraphs.
;                 $iTab         - Minimum space between a paragraph number and the paragraph text, in twips.
; Return values : None
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetNumbering($hWnd, $iChar = 0, $iFormat = 0x200, $iStart = 1, $iTab = 300)	
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tparaformat, 2, BitOr($PFM_NUMBERING, $PFM_NUMBERINGSTART, $PFM_NUMBERINGSTYLE, $PFM_NUMBERINGTAB))
	DllStructSetData($tparaformat, 3, $iChar)
	DllStructSetData($tparaformat, 19, $iStart)
	DllStructSetData($tparaformat, 20, $iFormat)
	DllStructSetData($tparaformat, 21, $iTab)
	_SendMessage($hWnd, $EM_SETPARAFORMAT, 0, DllStructGetPtr($tparaformat))
EndFunc ;==> _RichEdit_SetNumbering

; ====================================================================================================
; Description ..: Set the control in ReadOnly Mode
; Parameters ...: $hWnd         - Handle to the control
;                 $hBool        - True = Enabled, False = Disabled
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetReadOnly($hWnd, $hBool = True)
    Return _SendMessage ($hWnd, $EM_SETREADONLY, $hBool, 0)
EndFunc   ;==>_RichEdit_SetReadOnly

; ====================================================================================================
; Description ..: Select some text
; Parameters ...: $hWnd         - Handle to the control
;           	  $hMin         - Character Number start
;                 $hMax         - Character Number stop
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetSel($hWnd, $hMin, $hMax, $HideSel = 0)
    _SendMessage ($hWnd, $EM_SETSEL, $hMin, $hMax)
	_SendMessage($hWnd, $EM_HIDESELECTION, $HideSel)
EndFunc   ;==>_RichEdit_SetSel

; ====================================================================================================
; Description ..: Size of the spacing below the paragraph, in twips.
; Parameters ...: $hWnd         - Handle to the control
;                 $iNum         - The value must be greater than or equal to zero. (here: twips/100)
; Return values : None
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetSpaceAfter($hWnd, $iNum)
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tparaformat, 2, $PFM_SPACEAFTER)
	DllStructSetData($tparaformat, 12, $iNum*100)
	_SendMessage($hWnd, $EM_SETPARAFORMAT, 0, DllStructGetPtr($tparaformat))
EndFunc ;==> _RichEdit_SetSpaceAfter

; ====================================================================================================
; Description ..: Size of the spacing above the paragraph, in twips.
; Parameters ...: $hWnd         - Handle to the control
;                 $iNum         - The value must be greater than or equal to zero. (here: twips/100)
; Return values : None
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetSpaceBefore($hWnd, $iNum)
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tparaformat, 2, $PFM_SPACEBEFORE)
	DllStructSetData($tparaformat, 11, $iNum*100)
	_SendMessage($hWnd, $EM_SETPARAFORMAT, 0, DllStructGetPtr($tparaformat))
EndFunc ;==>_RichEdit_SetSpaceBefore

; ====================================================================================================
; Description ..: Indentation of the paragraph's first line, in twips.
; Parameters ...: $hWnd         - Handle to the control
;                 $iStartIndent - (here: twips/100)
; Return values : None
; Author .......: grham
; Notes ........:
; ====================================================================================================
Func _RichEdit_SetStartIndent($hWnd, $iStartIndent)
	;DllStructSetData($tparaformat, 1, DllStructGetSize($tparaformat))
	DllStructSetData($tparaformat, 2, $PFM_STARTINDENT)
	DllStructSetData($tparaformat, 5, $iStartIndent*100)
	_SendMessage($hWnd, $EM_SETPARAFORMAT, 0, DllStructGetPtr($tparaformat))
EndFunc ;==> _RichEdit_SetStartIndent

; ====================================================================================================
; Description ..: _RichEdit_ToggleBold
; Parameters ...: $hWnd         - Handle to the control
; Return values : none
; Author .......: 
; Notes ........: 
; ====================================================================================================
Func _RichEdit_ToggleBold($hWnd)
	_RichEdit_SetBold($hWnd, Not _RichEdit_GetBold($hWnd))
EndFunc	;==>_RichEdit_ToggleBold

; ====================================================================================================
; Description ..: _RichEdit_ToggleItalic
; Parameters ...: $hWnd         - Handle to the control
; Return values : none
; Author .......: 
; Notes ........: 
; ====================================================================================================
Func _RichEdit_ToggleItalic($hWnd)
	_RichEdit_SetItalic($hWnd, Not _RichEdit_GetItalic($hWnd))
EndFunc ;==>_RichEdit_ToggleItalic

; ====================================================================================================
; Description ..: _RichEdit_ToggleUnderline
; Parameters ...: $hWnd         - Handle to the control
; Return values : none
; Author .......: 
; Notes ........: 
; ====================================================================================================
Func _RichEdit_ToggleUnderline($hWnd)
	_RichEdit_SetUnderline($hWnd, Not _RichEdit_GetUnderline($hWnd))
EndFunc ;==>_RichEdit_ToggleUnderline

; ====================================================================================================
; Description ..: _RichEdit_ToggleStrikeOut
; Parameters ...: $hWnd         - Handle to the control
; Return values : none
; Author .......: 
; Notes ........: 
; ====================================================================================================
Func _RichEdit_ToggleStrikeOut($hWnd)
	_RichEdit_SetStrikeOut($hWnd, Not _RichEdit_GetStrikeOut($hWnd))
EndFunc ;==>_RichEdit_ToggleStrikeOut

; ====================================================================================================
; Description ..: Undo
; Parameters ...: $hWnd         - Handle to the control
;                 $hMin         - Character Number start
;                 $hMax         - Character Number stop
; Return values : True on success, otherwise False
; Author .......: Yoan Roblet (Arcker)
; Notes ........:
; ====================================================================================================
Func _RichEdit_Undo($hWnd)
    Return _SendMessage ($hWnd, $EM_UNDO, 0, 0)
EndFunc   ;==>_RichEdit_Undo

;=============================================================================================================
;	for experiments	only	
;=============================================================================================================

Func _RichEdit_SetUnderlineDouble($hWnd, $iStyle = True, $iSelec = True)		; doesn't show!!!
    If $iStyle Then $iStyle = $CFU_UNDERLINEDOUBLE
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	DllStructSetData($tcharformat, 2, $CFM_UNDERLINETYPE)
	DllStructSetData($tcharformat, 17, $iStyle)
	Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $iSelec, DllStructGetPtr($tcharformat))
EndFunc   ;==>_RichEdit_SetUnderline

Func _ReadStruct($hWnd)
	;DllStructSetData($tcharformat, 1, DllStructGetSize($tcharformat))
	_SendMessage ($hWnd, $EM_GETCHARFORMAT, $SCF_SELECTION, DllStructGetPtr($tcharformat))
    For $x = 1 To 20
		ConsoleWrite("Index " & $x & ": " & DllStructGetData($tcharformat, $x) & @CRLF)
	Next	
EndFunc	

Opt("MustDeclareVars", 0)