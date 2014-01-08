#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           05/07/2008

 Script Function:
  Presents a dialog box to edit a formula.

#ce ----------------------------------------------------------------------------
#include-once

#include <WinAPI.au3>
#include "WindowManager.au3"
#include "GlobalUtils.au3"
#include "IniHandling.au3"
#include "translations.au3"
#include "Variables.au3"
#include "rich_edit\Include\DllCallBack.au3"
#include "rich_edit\Include\_RichEdit_912.au3"

Global $EDIT_FORMULA_EXISTS = False, $EDIT_FORMULA_PREVIOUS_TEXT = "", $LOCK_SYNTAX_COLORING = False
Global $EDIT_FORMULA_CALLBACK = "", $EDIT_FORMULA_PARENT_WINDOW = 0

#Region ### Form Variables
Global $ID_EDITFORMULA=0, $IDC_EDIT1=0, $IDC_F_Z=0, $IDC_F_X=0, $IDC_F_Y=0, $IDC_F_LEFT_PARENTHESIS=0, $IDC_F_RIGHT_PARENTHESIS=0, $IDC_F_RETOUR_ARRIERE=0, $ID_DRAW=0, $IDC_F_PLUS=0, $IDC_F_MOINS=0, $IDC_F_FOIS=0, $IDC_F_DIV=0, $IDC_F_EXPOSANT=0, $IDC_F_SUPPRIMER=0, $ID_CANCEL=0, $IDC_F_SIN=0, $IDC_F_COS=0, $IDC_F_TAN=0, $ID_INV=0, $IDC_F_RESET=0, $IDC_F_SINH=0, $IDC_F_COSH=0, $IDC_F_TANH=0, $IDC_F_LN=0, $IDC_F_EXP=0, $IDC_F_SQRT=0, $IDC_F_O=0, $IDC_F_OO=0, $IDC_F_RANDF=0, $IDC_F_RANDF_AUTO=0, $IDC_F_SUM=0, $IDC_F_PROD=0, $IDC_F_RANDH=0, $IDC_F_RANDH_AUTO=0, $IDC_F_COMP=0, $IDC_F_CIRCLE=0, $IDC_CHIFFRE7=0, $IDC_CHIFFRE8=0, $IDC_CHIFFRE9=0, $IDC_CHIFFRE_PI=0, $IDC_CHIFFRE4=0, $IDC_CHIFFRE5=0, $IDC_CHIFFRE6=0, $IDC_CHIFFRE_J=0, $IDC_CHIFFRE1=0, $IDC_CHIFFRE2=0, $IDC_CHIFFRE3=0, $IDC_CHIFFRE_I=0, $IDC_CHIFFRE0=0, $IDC_POINT=0, $IDC_VIRGULE=0, $IDC_DOLLARS=0, $IDC_F_REAL=0, $IDC_F_IMAG=0, $IDC_F_CONJ=0, $IDC_F_SEED=0, $IDC_INSERTVAR=0, $ID_RANDSEED=0
#EndRegion ### Form Variables
Global $IDC_EDIT1_OLD

;EditFormula("13", "0")

;Compatibility
Func TEXT($i)
  Return $i
Endfunc

Func insertText($hEdit, $text)
  $LOCK_SYNTAX_COLORING = True
  $function = GUICtrlRead($hEdit)
  $size = StringLen($text)
  $aSel = _GUICtrlEdit_GetSel($hEdit)
  $begin = $aSel[0]+1
  $end = $aSel[1]+1
  ;MsgBox(0, $begin, $end)
  ;On commence par récuperer la sélection dans funcStringTemp, pour s'en servir par la suite.
  $sizeSelection = $end-$begin
  $funcStringTemp = _RichEdit_GetSelText($hEdit)
;  StringMid($function, $begin, $sizeSelection)

  Dim $j = $begin
  For $i=1 To $size
    $c = StringMid($text, $i, 1)
    Switch $c
    Case '_'
      _GUICtrlEdit_ReplaceSel($hEdit, $funcStringTemp)
      $j += $sizeSelection
    Case '{'
      if $sizeSelection==0 Then $begin = $j
    Case '}'
      if($sizeSelection==0) Then $end = $j
    Case '['
      if $sizeSelection<>0 Then $begin = $j
    Case ']'
      if($sizeSelection<>0) Then $end = $j
    Case Else
      _GUICtrlEdit_ReplaceSel($hEdit, $c)
      $j += 1
    EndSwitch
  Next
  ;MsgBox(0, $begin, $end)
  ;SetFocus($hEdit)
  ;On fait de la coloration syntaxique.
  $LOCK_SYNTAX_COLORING = False
  colorationSyntaxique($hEdit)
  _WinAPI_SetFocus($hEdit)
  _RichEdit_SetSel($hEdit, $begin-1, $end-1)
 EndFunc

Func deleteText($hEdit, $count)
  If $count==0  Then
    _GUICtrlEdit_SetSel($hEdit, 0, -1)
    _GUICtrlEdit_ReplaceSel($hEdit, '')
    _WinAPI_SetFocus($hEdit)
    Return
  EndIf
  Dim $begin, $end
  $aSel = _GUICtrlEdit_GetSel($hEdit)
  $begin = $aSel[0]
  $end = $aSel[1]

  If $begin<>$end Then    ;On supprime ce qui est sélectionné.
    _GUICtrlEdit_ReplaceSel($hEdit, '')
  Else
    if $count>0 And $begin>0  Then    ;On revient en arrière
      _GUICtrlEdit_SetSel($hEdit, $begin-1, $begin)
      _GUICtrlEdit_ReplaceSel($hEdit, '')
    ElseIf $count < 0 Then            ;On supprime un caractère à droite.
      _GUICtrlEdit_SetSel($hEdit, $begin, $begin+1)
      _GUICtrlEdit_ReplaceSel($hEdit, '')
    EndIf
  EndIf
  colorationSyntaxique($hEdit)
  _WinAPI_SetFocus($hEdit)
EndFunc

;_RichEdit_SetEventMask
Func colorationSyntaxique($hEdit)
  ;logging("coloration syntaxique")
  $sauv_sel = _GUICtrlEdit_GetSel($hEdit)
  $contenu = _GUICtrlEdit_GetText($IDC_EDIT1)
  $p = -1
  Dim $functions =        _ArrayCreate("sin", "cos", "tan", "exp", "sinh", "cosh", "tanh", "ln", "sqrt")
  concatenate($functions, _ArrayCreate("argsh", "argch", "argth", "arcsin", "arccos", "arctan", "real"))
  concatenate($functions, _ArrayCreate("imag", "conj", "circle", "oo", "o", "randf", "randh", "sum", "prod", "comp"))
  Dim $specialchars = _ArrayCreate("i", "j", "pi", "x", "y", "z")
  Dim $operators = _ArrayCreate("+", "-", "*", "/", "^")
  Dim $variable_indicator = "$"
  Dim $color_parenthesis = _ArrayCreate(0x00A000, 0x0000A0, 0xA000A0, 0xA0A000, 0x00A0A0), $color_bad_parenthesis = 0x0000FF
  Dim                                 $bold_parenthesis  = True,  $italic_parenthesis  = False
  Dim $color_vars         = 0xCFA000, $bold_vars         = False, $italic_vars         = True
  Dim $color_functions    = 0xFF0000, $bold_functions    = False, $italic_functions    = False
  Dim $color_specialchars = 0x000000, $bold_specialchars = True, $italic_specialchars = True
  Dim $color_otherstrings = 0x000000, $bold_otherstrings = False, $italic_otherstrings = False
  Dim $color_operators    = 0x6000A0, $bold_operators    = False, $italic_operators    = False
  Dim $color_numbers      = 0x000000, $bold_numbers      = False, $italic_numbers      = False

  Dim $n = StringLen($contenu)
  ;Parentheses
  Dim $string = ""
  Dim $variab = ""
  For $i = 1 To $n
    $c = StringMid($contenu, $i, 1)
    If $c == '(' Then $p += 1
    If StringIsAlNum($c) Then
      If $variab <> "" Then
        $variab &= $c
      ElseIf $string <> "" Or StringIsAlpha($c) Then
        $string &= $c
      EndIf
    Else
      If $variab <> "" Then
        _RichEdit_SetSel($hEdit, $i - StringLen($variab) - 1, $i - 1, True)
        setColorHedit($hEdit, $color_vars, $bold_vars, $italic_vars)
        $variab = ""
      ElseIf $string <> "" Then
        _RichEdit_SetSel($hEdit, $i - StringLen($string) - 1, $i - 1, True)
        If _ArraySearch($functions, $string) <> -1 Then
          setColorHedit($hEdit, $color_functions, $bold_functions, $italic_functions)
        ElseIf _ArraySearch($specialchars, $string) <> -1 Then
          setColorHedit($hEdit, $color_specialchars, $bold_specialchars, $italic_specialchars)
        Else
          setColorHedit($hEdit, $color_otherstrings, $bold_otherstrings, $italic_otherstrings)
        EndIf
        $string = ""
      EndIf
      If $c == '(' Or $c == ')' Then
        _RichEdit_SetSel($hEdit, $i - 1, $i, True)
        setColorHedit($hEdit, _Iif($p < 0, $color_bad_parenthesis, $color_parenthesis[Abs(Mod($p, 5))]), $bold_parenthesis, $italic_parenthesis)
      ElseIf _ArraySearch($operators, $c) <> -1 Then
        _RichEdit_SetSel($hEdit, $i - 1, $i, True)
        setColorHedit($hEdit, $color_operators, $bold_operators, $italic_operators)
      ElseIf StringIsDigit($c) Or $c == "." Then
        _RichEdit_SetSel($hEdit, $i - 1, $i, True)
        setColorHedit($hEdit, $color_numbers, $bold_numbers, $italic_numbers)
      ElseIf $c == $variable_indicator Then
        $variab = $c
      EndIf
    EndIf
    If $c == ')' Then $p = _Max($p - 1, -1)
  Next
  ;_RichEdit_SetSel($hEdit, $n, $n, True)
  ;setColorHedit($hEdit, 0x000000, False, False)
  _GUICtrlEdit_SetSel($hEdit, $sauv_sel[0], $sauv_sel[1])
EndFunc

Func setColorHedit($hEdit, $col=0x000000, $bold=False, $italic=False)
  _RichEdit_SetFontColor($hEdit, $col)
  _RichEdit_SetBold($hEdit, $bold, True)
  _RichEdit_SetItalic($hEdit, $italic, True)
EndFunc

Func EditFormulaActivate()
  WinActivate($ID_EDITFORMULA)
EndFunc

Func GenerateEditFormulaBox()
  If $EDIT_FORMULA_EXISTS Then
    EditFormulaActivate()
    Return
  EndIf
  $EDIT_FORMULA_EXISTS = True
  #Region ### START Koda GUI section ### Form=C:\Documents and Settings\Mikaël\Mes documents\Reflex\LogicielOrdi\RenderReflex\ReflexRendererEditFormula.kxf
  $ID_EDITFORMULA = GUICreate($__edit_formula__, 248, 351, 301, 132, BitOR($WS_MAXIMIZEBOX,$WS_MINIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_SYSMENU,$WS_CAPTION,$WS_OVERLAPPEDWINDOW,$WS_TILEDWINDOW,$WS_POPUP,$WS_POPUPWINDOW,$WS_GROUP,$WS_TABSTOP,$WS_BORDER,$WS_CLIPSIBLINGS))
  GUISetOnEvent($GUI_EVENT_CLOSE, "ID_EDITFORMULAClose")
  GUISetOnEvent($GUI_EVENT_MINIMIZE, "ID_EDITFORMULAMinimize")
  GUISetOnEvent($GUI_EVENT_MAXIMIZE, "ID_EDITFORMULAMaximize")
  GUISetOnEvent($GUI_EVENT_RESTORE, "ID_EDITFORMULARestore")
  $IDC_EDIT1 = GUICtrlCreateEdit("", 8, 8, 233, 113, BitOR($ES_AUTOVSCROLL,$ES_WANTRETURN,$WS_VSCROLL))
  GUICtrlSetData($IDC_EDIT1, "Edit1")
  GUICtrlSetOnEvent($IDC_EDIT1, "ef_insertionClick")
  GUICtrlSetState($IDC_EDIT1, $GUI_HIDE)
  $IDC_F_Z = GUICtrlCreateButton("z", 8, 128, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_Z, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_Z, "ef_insertionClick")
  $IDC_F_X = GUICtrlCreateButton("x", 32, 128, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_X, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_X, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_X, $__x_hint__)
  $IDC_F_Y = GUICtrlCreateButton("y", 56, 128, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_Y, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_Y, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_Y, $__y_hint__)
  $IDC_F_LEFT_PARENTHESIS = GUICtrlCreateButton("( )", 80, 128, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_LEFT_PARENTHESIS, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_LEFT_PARENTHESIS, "ef_insertionClick")
  $IDC_F_RIGHT_PARENTHESIS = GUICtrlCreateButton(")", 104, 128, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_RIGHT_PARENTHESIS, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_RIGHT_PARENTHESIS, "ef_insertionClick")
  $IDC_F_RETOUR_ARRIERE = GUICtrlCreateButton("<-", 136, 128, 49, 25, 0)
  GUICtrlSetResizing($IDC_F_RETOUR_ARRIERE, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_RETOUR_ARRIERE, "ef_insertionClick")
  $ID_DRAW = GUICtrlCreateButton($__set_button__, 192, 128, 49, 25, 0)
  GUICtrlSetResizing($ID_DRAW, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($ID_DRAW, "ID_DRAWClick")
  GUICtrlSetTip($ID_DRAW, $__set_button_hint__)
  $IDC_F_PLUS = GUICtrlCreateButton("+", 8, 152, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_PLUS, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_PLUS, "ef_insertionClick")
  $IDC_F_MOINS = GUICtrlCreateButton("-", 32, 152, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_MOINS, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_MOINS, "ef_insertionClick")
  $IDC_F_FOIS = GUICtrlCreateButton("*", 56, 152, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_FOIS, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_FOIS, "ef_insertionClick")
  $IDC_F_DIV = GUICtrlCreateButton("/", 80, 152, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_DIV, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_DIV, "ef_insertionClick")
  $IDC_F_EXPOSANT = GUICtrlCreateButton("^", 104, 152, 25, 25, 0)
  GUICtrlSetResizing($IDC_F_EXPOSANT, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_EXPOSANT, "ef_insertionClick")
  $IDC_F_SUPPRIMER = GUICtrlCreateButton($__del_button__, 136, 152, 49, 25, 0)
  GUICtrlSetResizing($IDC_F_SUPPRIMER, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_SUPPRIMER, "ef_insertionClick")
  $ID_CANCEL = GUICtrlCreateButton($__quit_button__, 192, 152, 49, 25, 0)
  GUICtrlSetResizing($ID_CANCEL, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($ID_CANCEL, "ID_CANCELClick")
  $IDC_F_SIN = GUICtrlCreateButton("sin", 8, 176, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_SIN, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_SIN, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_SIN, $__sin_hint__)
  $IDC_F_COS = GUICtrlCreateButton("cos", 44, 176, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_COS, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_COS, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_COS, $__cos_hint__)
  $IDC_F_TAN = GUICtrlCreateButton("tan", 80, 176, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_TAN, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_TAN, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_TAN, $__tan_hint__)
  $ID_INV = GUICtrlCreateCheckbox("inv", 120, 179, 65, 17)
  GUICtrlSetResizing($ID_INV, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($ID_INV, "ef_insertionClick")
  GUICtrlSetTip($ID_INV, $__inv_hint__)
  $IDC_F_RESET = GUICtrlCreateButton($__reset_formula__, 192, 176, 49, 25, 0)
  GUICtrlSetResizing($IDC_F_RESET, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_RESET, "ef_insertionClick")
  $IDC_F_SINH = GUICtrlCreateButton("sinh", 8, 200, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_SINH, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_SINH, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_SINH, $__sinh_hint__)
  $IDC_F_COSH = GUICtrlCreateButton("cosh", 44, 200, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_COSH, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_COSH, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_COSH, $__cosh_hint__)
  $IDC_F_TANH = GUICtrlCreateButton("tanh", 80, 200, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_TANH, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_TANH, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_TANH, $__tanh_hint__)
  $IDC_F_LN = GUICtrlCreateButton("ln", 8, 224, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_LN, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_LN, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_LN, $__ln_hint__)
  $IDC_F_EXP = GUICtrlCreateButton("exp", 44, 224, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_EXP, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_EXP, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_EXP, $__exp_hint__)
  $IDC_F_SQRT = GUICtrlCreateButton("sqrt", 80, 224, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_SQRT, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_SQRT, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_SQRT, $__sqrt_hint__)
  $IDC_F_O = GUICtrlCreateButton("o", 8, 248, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_O, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_O, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_O, "o(f(z), g(z)) = f(g(z))")
  $IDC_F_OO = GUICtrlCreateButton("oo", 44, 248, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_OO, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_OO, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_OO, "oo(f(z), 4) = f(f(f(f(z))))")
  $IDC_F_RANDF = GUICtrlCreateButton("randf", 80, 248, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_RANDF, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_RANDF, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_RANDF, $__randf_hint__)
  $IDC_F_RANDF_AUTO = GUICtrlCreateButton(">", 116, 248, 17, 25, 0)
  GUICtrlSetOnEvent($IDC_F_RANDF_AUTO, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_RANDF_AUTO, $__randf_auto_hint__)
  $IDC_F_SUM = GUICtrlCreateButton("sum", 8, 272, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_SUM, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_SUM, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_SUM, "sum(f($x, z), $x, 4, 10, 3) = f(4, z) + f(7, z) + f(10, z)")
  $IDC_F_PROD = GUICtrlCreateButton("prod", 44, 272, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_PROD, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_PROD, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_PROD, "prod(f($x, z), $x, 5, 9, 2) = f(5, z) * f(7, z) * f(9, z)")
  $IDC_F_RANDH = GUICtrlCreateButton("randh", 80, 272, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_RANDH, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_RANDH, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_RANDH, $__randh_hint__)
  $IDC_F_RANDH_AUTO = GUICtrlCreateButton(">", 116, 272, 17, 25, 0)
  GUICtrlSetOnEvent($IDC_F_RANDH_AUTO, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_RANDH_AUTO, $__randh_auto_hint__)
  $IDC_F_COMP = GUICtrlCreateButton("comp", 8, 296, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_COMP, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_COMP, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_COMP, "Comp(f($x, z), $x, 5, 3) = f(f(f(5, z), z), z)")
  $IDC_F_CIRCLE = GUICtrlCreateButton("circle", 44, 296, 37, 25, 0)
  GUICtrlSetResizing($IDC_F_CIRCLE, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_CIRCLE, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_CIRCLE, "circle(z) = conj(z) - 1/z")
  $IDC_CHIFFRE7 = GUICtrlCreateButton("7", 144, 200, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE7, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE7, "ef_insertionClick")
  $IDC_CHIFFRE8 = GUICtrlCreateButton("8", 168, 200, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE8, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE8, "ef_insertionClick")
  $IDC_CHIFFRE9 = GUICtrlCreateButton("9", 192, 200, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE9, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE9, "ef_insertionClick")
  $IDC_CHIFFRE_PI = GUICtrlCreateButton("p", 216, 200, 25, 25, 0)
  GUICtrlSetFont($IDC_CHIFFRE_PI, 10, 400, 0, "Symbol")
  GUICtrlSetResizing($IDC_CHIFFRE_PI, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE_PI, "ef_insertionClick")
  $IDC_CHIFFRE4 = GUICtrlCreateButton("4", 144, 224, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE4, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE4, "ef_insertionClick")
  $IDC_CHIFFRE5 = GUICtrlCreateButton("5", 168, 224, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE5, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE5, "ef_insertionClick")
  $IDC_CHIFFRE6 = GUICtrlCreateButton("6", 192, 224, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE6, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE6, "ef_insertionClick")
  $IDC_CHIFFRE_J = GUICtrlCreateButton("j", 216, 224, 25, 25, 0)
  GUICtrlSetFont($IDC_CHIFFRE_J, 10, 400, 2, "Times New Roman")
  GUICtrlSetResizing($IDC_CHIFFRE_J, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE_J, "ef_insertionClick")
  GUICtrlSetTip($IDC_CHIFFRE_J, "exp(i*2pi/3)")
  $IDC_CHIFFRE1 = GUICtrlCreateButton("1", 144, 248, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE1, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE1, "ef_insertionClick")
  $IDC_CHIFFRE2 = GUICtrlCreateButton("2", 168, 248, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE2, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE2, "ef_insertionClick")
  $IDC_CHIFFRE3 = GUICtrlCreateButton("3", 192, 248, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE3, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE3, "ef_insertionClick")
  $IDC_CHIFFRE_I = GUICtrlCreateButton("i", 216, 248, 25, 25, 0)
  GUICtrlSetFont($IDC_CHIFFRE_I, 10, 400, 2, "Times New Roman")
  GUICtrlSetResizing($IDC_CHIFFRE_I, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE_I, "ef_insertionClick")
  $IDC_CHIFFRE0 = GUICtrlCreateButton("0", 144, 272, 25, 25, 0)
  GUICtrlSetResizing($IDC_CHIFFRE0, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_CHIFFRE0, "ef_insertionClick")
  $IDC_POINT = GUICtrlCreateButton(".", 168, 272, 25, 25, 0)
  GUICtrlSetFont($IDC_POINT, 8, 800, 0, "MS Sans Serif")
  GUICtrlSetResizing($IDC_POINT, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_POINT, "ef_insertionClick")
  $IDC_VIRGULE = GUICtrlCreateButton(",", 192, 272, 25, 25, 0)
  GUICtrlSetResizing($IDC_VIRGULE, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_VIRGULE, "ef_insertionClick")
  $IDC_DOLLARS = GUICtrlCreateButton("$", 216, 272, 25, 25, 0)
  GUICtrlSetResizing($IDC_DOLLARS, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_DOLLARS, "ef_insertionClick")
  GUICtrlSetTip($IDC_DOLLARS, $__dollar_hint__)
  $IDC_F_REAL = GUICtrlCreateButton("Â", 144, 296, 33, 25, 0)
  GUICtrlSetFont($IDC_F_REAL, 8, 400, 0, "Symbol")
  GUICtrlSetResizing($IDC_F_REAL, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_REAL, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_REAL, $__real_hint__)
  $IDC_F_IMAG = GUICtrlCreateButton("Á", 176, 296, 33, 25, 0)
  GUICtrlSetFont($IDC_F_IMAG, 8, 400, 0, "Symbol")
  GUICtrlSetResizing($IDC_F_IMAG, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_IMAG, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_IMAG, $__imag_hint__)
  $IDC_F_CONJ = GUICtrlCreateButton("conj", 208, 296, 33, 25, 0)
  GUICtrlSetResizing($IDC_F_CONJ, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_CONJ, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_CONJ, $__conj_hint__)
  $IDC_F_SEED = GUICtrlCreateInput("68742091", 82, 298, 61, 21, BitOR($ES_RIGHT,$ES_AUTOHSCROLL,$ES_NUMBER))
  GUICtrlSetResizing($IDC_F_SEED, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_F_SEED, "ef_insertionClick")
  GUICtrlSetTip($IDC_F_SEED, $__seed_hint__)
  $IDC_INSERTVAR = GUICtrlCreateButton($__insert_var__, 167, 320, 74, 25, 0)
  GUICtrlSetResizing($IDC_INSERTVAR, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($IDC_INSERTVAR, "ef_insertionClick")
  $ID_RANDSEED = GUICtrlCreateCheckbox($__randomize_seed__, 8, 323, 137, 17)
  GUICtrlSetResizing($ID_RANDSEED, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($ID_RANDSEED, "ef_insertionClick")
  GUICtrlSetTip($ID_RANDSEED, $__randomize_seed_hint__)
  #EndRegion ### END Koda GUI section ###
  GUISetOnEvent($GUI_EVENT_RESIZED, 'ID_EDITFORMULAResize')

  $IDC_EDIT1_OLD = $IDC_EDIT1
  $pos = ControlGetPos($ID_EDITFORMULA, '', $IDC_EDIT1_OLD)
  ;GUICtrlDelete($IDC_EDIT1)
  ;logging($pos[0] &","& $pos[1] &","& $pos[2] &","& $pos[3])
  $IDC_EDIT1 = _GuiCtrl_RichEdit_Create($ID_EDITFORMULA, $pos[0], $pos[1], $pos[2], $pos[3])
  GUICtrlSetOnEvent($IDC_EDIT1, "ef_insertionClick")
  ;logging(GUICtrlSetResizing($IDC_EDIT1, $GUI_DOCKBORDERS))
  ;-------------------------------------To receive EN_LINK and $EN_PROTECTED Notifications
  _RichEdit_LimitText($IDC_EDIT1, 512000)
  _GUICtrlEdit_SetMargins ($IDC_EDIT1, BitOR($EC_LEFTMARGIN, $EC_RIGHTMARGIN), 3, 3)
  _RichEdit_SetFont($IDC_EDIT1, 0000, 0x000000, 0xFFFFFF, "Times New Roman", 12, 0)
  _RichEdit_BkColor($IDC_EDIT1, 0xFFFFFF)
  _RichEdit_SetEventMask($IDC_EDIT1 , BitOr($ENM_LINK, $ENM_PROTECTED, $ENM_MOUSEEVENTS, $ENM_KEYEVENTS, $ENM_SELCHANGE))
  GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

  Variables__setParentWindow($ID_EDITFORMULA)
  WindowManager__registerWindow($ID_EDITFORMULA, "EditFormula", "DeleteEditFormulaBox")
EndFunc

Func resizeIDC_EDIT1()
  $pos = ControlGetPos($ID_EDITFORMULA, '', $IDC_EDIT1_OLD)
  WinMove($IDC_EDIT1, "", $pos[0], $pos[1], $pos[2], $pos[3])
EndFunc

Func DeleteEditFormulaBox($win_handle=$ID_EDITFORMULA)
  logging("EditFormula.au3 : "&$win_handle)
  If $EDIT_FORMULA_EXISTS Then
    AnimateToLeft($win_handle)
    GUIDelete($win_handle)
    $EDIT_FORMULA_EXISTS = False
    GUIRegisterMsg($WM_NOTIFY, "")
    WindowManager__unregisterWindow($win_handle)
    Variables__setParentWindow(0)
  EndIf
EndFunc

Func EditFormula__setCallbackFunction($callbackfunction)
  $EDIT_FORMULA_CALLBACK = $callbackfunction
EndFunc
Func EditFormula__setParentWindow($main_window_handle)
  $EDIT_FORMULA_PARENT_WINDOW = $main_window_handle
EndFunc

Func EditFormula__stickToParentWindow()
  If WinExists($EDIT_FORMULA_PARENT_WINDOW) Then
    $pos = WinGetPos($EDIT_FORMULA_PARENT_WINDOW, "")
    WinMove($ID_EDITFORMULA, "", $pos[0]+$pos[2], $pos[1])
  EndIf
EndFunc

Func EditFormula($formula, $seed)
  ;Opt('GUIOnEventMode', 0)
  $efe_save = $EDIT_FORMULA_EXISTS
  GenerateEditFormulaBox()
  _GUICtrlEdit_SetText($IDC_EDIT1, $formula)
  colorationSyntaxique($IDC_EDIT1)
  GUICtrlSetData($IDC_F_SEED, $seed)
  If Not $efe_save Then
    EditFormula__stickToParentWindow()
    AnimateFromLeft($ID_EDITFORMULA)
  EndIf
  _WinAPI_RedrawWindow($IDC_EDIT1)
  GUISetState(@SW_SHOW, $ID_EDITFORMULA)
  _RichEdit_SetSel($IDC_EDIT1, 0, 0)
  _WinAPI_SetFocus($IDC_EDIT1)
EndFunc

; Functions to save and load the EditFormula window

WindowManager__addLoadSaveFunctionForType("EditFormula", "EditFormula__LoadFromIni", "EditFormula__SaveKeyValue")
Func EditFormula__LoadFromIni($value)
  $values = StringSplit($value, ";;", 1)
  $formula = pop($values)
  $seed = pop($values)
  EditFormula($formula, $seed)
EndFunc
Func EditFormula__SaveKeyValue($win_handle)
  $formula = EditFormula__getFormulaText()
  $seed = GUICtrlRead($IDC_F_SEED)
  Return $formula&";;"&$seed
EndFunc

; randh()*$x => randh()*0.10 => cos(sin(x))*0.10 =>

Func EditFormula__UpdateFormulaFromApplication($formula)
  If $EDIT_FORMULA_EXISTS Then
    _GUICtrlEdit_SetText($IDC_EDIT1, $formula)
    colorationSyntaxique($IDC_EDIT1)
  EndIf
EndFunc

Func EditFormula__HighlightError($start, $end)
  EditFormulaActivate()
  _RichEdit_SetSel($IDC_EDIT1, $start, $end)
EndFunc

Func EditFormula__getFormulaText()
  If $EDIT_FORMULA_EXISTS Then
    $sauv_sel = _GUICtrlEdit_GetSel($IDC_EDIT1)
    $formula  = _GUICtrlEdit_GetText($IDC_EDIT1)
    _GUICtrlEdit_SetSel($IDC_EDIT1, $sauv_sel[0], $sauv_sel[1])
  Else
    $formula = ""
  EndIf
  return $formula
EndFunc

Variables__setUpdateFunction("ID_DRAWClick")
Func ID_DRAWClick($history_save = True)
  If Not IsDeclared("history_save") Then $history_save = True
  $result_formula  = EditFormula__getFormulaText()

  $result_seed = GUICtrlRead($IDC_F_SEED)
  $result = _ArrayCreate(2, $result_formula, $result_seed)

  ;logging("Going to callback on "&$result_formula)

  Call($EDIT_FORMULA_CALLBACK, $result_formula, $result_seed, $history_save)
EndFunc
Func ID_CANCELClick()
  ID_EDITFORMULAClose()
EndFunc

Func ID_EDITFORMULAClose()
  logging("Asking Edit Formula to be closed...")
  DeleteEditFormulaBox()
EndFunc
Func ID_EDITFORMULAMinimize()
EndFunc
Func ID_EDITFORMULAMaximize()
EndFunc
Func ID_EDITFORMULARestore()
EndFunc

Func ID_EDITFORMULAResize()
  resizeIDC_EDIT1()
EndFunc

Func ef_insertionClick()
  $nMsg = @GUI_CtrlId
  Local $r = isChecked($ID_INV)
  Local $randseed = isChecked($ID_RANDSEED)

  Local $inverse_map = _ArrayCreate($IDC_F_SIN, $IDC_F_COS, $IDC_F_TAN, $IDC_F_SINH, $IDC_F_COSH, $IDC_F_TANH)
  Switch $nMsg
    Case $IDC_F_SIN
      insertText($IDC_EDIT1, _Iif($r, TEXT('arcsin({[_]})'), TEXT('sin({[_]})')))
    Case $IDC_F_COS
      insertText($IDC_EDIT1, _Iif($r, TEXT('arccos({[_]})'), TEXT('cos({[_]})')))
    Case $IDC_F_TAN
      insertText($IDC_EDIT1, _Iif($r, TEXT('arctan({[_]})'), TEXT('tan({[_]})')))
    Case $IDC_F_SINH
      insertText($IDC_EDIT1, _Iif($r, TEXT('argsh({[_]})'), TEXT('sinh({[_]})')))
    Case $IDC_F_COSH
      insertText($IDC_EDIT1, _Iif($r, TEXT('argch({[_]})'), TEXT('cosh({[_]})')))
    Case $IDC_F_TANH
      insertText($IDC_EDIT1, _Iif($r, TEXT('argth({[_]})'), TEXT('tanh({[_]})')))
    Case $IDC_F_LN
      insertText($IDC_EDIT1, TEXT('ln({[_]})'))
    Case $IDC_F_EXP
      insertText($IDC_EDIT1, TEXT('exp({[_]})'))
    Case $IDC_F_OO
      insertText($IDC_EDIT1, TEXT('oo({_},[5])'))
    Case $IDC_F_O
      insertText($IDC_EDIT1, TEXT('o({_},[z])'))
    Case $IDC_F_Z
      insertText($IDC_EDIT1, TEXT('z{[]}'))
    Case $IDC_F_X
      insertText($IDC_EDIT1, TEXT('x{[]}'))
    Case $IDC_F_Y
      insertText($IDC_EDIT1, TEXT('y{[]}'))
    Case $IDC_F_LEFT_PARENTHESIS
      insertText($IDC_EDIT1, TEXT('({_})[]'))
    Case $IDC_F_RIGHT_PARENTHESIS
      insertText($IDC_EDIT1, TEXT('_){[]}'))
    Case $IDC_F_REAL
      insertText($IDC_EDIT1, TEXT('real({[_]})'))
    Case $IDC_F_IMAG
      insertText($IDC_EDIT1, TEXT('imag({[_]})'))
    Case $IDC_F_CONJ
      insertText($IDC_EDIT1, TEXT('conj({[_]})'))
    Case $IDC_F_CIRCLE
      insertText($IDC_EDIT1, TEXT('circle({[_]})'))
    Case $IDC_F_PLUS
      insertText($IDC_EDIT1, TEXT('_+{[]}'))
    Case $IDC_F_MOINS
      insertText($IDC_EDIT1, TEXT('_-{[]}'))
    Case $IDC_F_FOIS
      insertText($IDC_EDIT1, TEXT('_*{[]}'))
    Case $IDC_F_DIV
      insertText($IDC_EDIT1, TEXT('_/{[]}'))
    Case $IDC_F_SQRT
      insertText($IDC_EDIT1, TEXT('sqrt({[_]})'))
    Case $IDC_F_EXPOSANT
      insertText($IDC_EDIT1, TEXT('_^{[]}'))
    Case $IDC_F_SUM
      insertText($IDC_EDIT1, TEXT('sum({_},[$x,1,9])'))
    Case $IDC_F_PROD
      insertText($IDC_EDIT1, TEXT('prod({_},[$x,1,9])'))
    Case $IDC_F_COMP
      insertText($IDC_EDIT1, TEXT('comp({_},[$x,z,12])'))
    Case $IDC_CHIFFRE1
      insertText($IDC_EDIT1, TEXT('1{[]}'))
    Case $IDC_CHIFFRE2
      insertText($IDC_EDIT1, TEXT('2{[]}'))
    Case $IDC_CHIFFRE3
      insertText($IDC_EDIT1, TEXT('3{[]}'))
    Case $IDC_CHIFFRE4
      insertText($IDC_EDIT1, TEXT('4{[]}'))
    Case $IDC_CHIFFRE5
      insertText($IDC_EDIT1, TEXT('5{[]}'))
    Case $IDC_CHIFFRE6
      insertText($IDC_EDIT1, TEXT('6{[]}'))
    Case $IDC_CHIFFRE7
      insertText($IDC_EDIT1, TEXT('7{[]}'))
    Case $IDC_CHIFFRE8
      insertText($IDC_EDIT1, TEXT('8{[]}'))
    Case $IDC_CHIFFRE9
      insertText($IDC_EDIT1, TEXT('9{[]}'))
    Case $IDC_CHIFFRE0
      insertText($IDC_EDIT1, TEXT('0{[]}'))
    Case $IDC_POINT
      insertText($IDC_EDIT1, TEXT('_.{[]}'))
    Case $IDC_VIRGULE
      insertText($IDC_EDIT1, TEXT('_,{[]}'))
    Case $IDC_CHIFFRE_I
      insertText($IDC_EDIT1, TEXT('i{[]}'))
    Case $IDC_CHIFFRE_J
      insertText($IDC_EDIT1, TEXT('j{[]}'))
    Case $IDC_CHIFFRE_PI
      insertText($IDC_EDIT1, TEXT('pi{[]}'))
    Case $IDC_DOLLARS
      insertText($IDC_EDIT1, TEXT('${[var]}'))
    Case $IDC_F_RANDF
      insertText($IDC_EDIT1, TEXT('randf([{5}])'))
      If $randseed Then GUICtrlSetData($IDC_F_SEED, EditFormula__newSeed())
    Case $IDC_F_RANDH
      insertText($IDC_EDIT1, TEXT('randh([{5}])'))
      If $randseed Then GUICtrlSetData($IDC_F_SEED, EditFormula__newSeed())
    Case $IDC_F_RANDF_AUTO
      deleteText($IDC_EDIT1, 0)
      insertText($IDC_EDIT1, TEXT('randf([{15}])'))
      GUICtrlSetData($IDC_F_SEED, EditFormula__newSeed())
      Sleep(500)
      ID_DRAWClick()
    Case $IDC_F_RANDH_AUTO
      deleteText($IDC_EDIT1, 0)
      insertText($IDC_EDIT1, TEXT('randh([{15}])'))
      GUICtrlSetData($IDC_F_SEED, EditFormula__newSeed())
      Sleep(500)
      ID_DRAWClick()
    Case $IDC_F_RETOUR_ARRIERE
      deleteText($IDC_EDIT1, 1)
    Case $IDC_F_SUPPRIMER
      deleteText($IDC_EDIT1, -1)
    Case $IDC_F_RESET
      deleteText($IDC_EDIT1, 0)
    Case $ID_INV
      For $inverse_function in $inverse_map
        GUICtrlSetFont($inverse_function, 8.5, 400, _Iif($r, 2, 0))
      Next
      _WinAPI_SetFocus($IDC_EDIT1)
    Case $IDC_INSERTVAR
      GenerateVariableWindow(EditFormula__getFormulaText())
    Case $ID_RANDSEED
      GUICtrlSetState($IDC_F_SEED, _Iif($randseed, $GUI_DISABLE, $GUI_ENABLE))
    Case $ID_DRAW
      ID_DRAWClick()
    Case $IDC_F_SEED
      If GUICtrlRead($IDC_F_SEED) == '' Then GUICtrlSetData($IDC_F_SEED, '0')
    Case Else
      logging("Message non id in editformula: "&$nMsg)
      If Not WinActive($ID_EDITFORMULA) Then WinActivate($ID_EDITFORMULA)
  EndSwitch
EndFunc

Func EditFormula__newSeed()
  ;Return 1679895117;
  Return Random(0, 2147483647, 1)
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
  Local $hWndFrom, $idFrom, $iCode
  Local $tNMHDR, $tENLINK, $tENPROTECTED, $MousePos[2], $OldMousePos[2]
  $hWndRichEdit = $IDC_EDIT1
  If Not IsHWnd($IDC_EDIT1) Then $hWndRichEdit = GUICtrlGetHandle($IDC_EDIT1)

  $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
  $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
  $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
  $iCode = DllStructGetData($tNMHDR, "Code")

  Switch $hWndFrom
  Case $IDC_EDIT1, $hWndRichEdit
    Switch $iCode
    Case $EN_LINK
      Local $tENLINK = DllStructCreate($tagENLINK, $ilParam)
      Local $iMessage = DllStructGetData($tENLINK, 4)
      Local $cpMin = DllStructGetData($tENLINK, 7)
      Local $cpMax = DllStructGetData($tENLINK, 8)
      $Sel = _RichEdit_GetSelection($IDC_EDIT1)
      Local $LinkText = StringLeft(StringTrimLeft(_RichEdit_GetText($hwndFrom), $cpMin), $cpMax - $cpMin)
      Select
        Case BitAND($iMessage, $WM_LBUTTONDBLCLK) = $WM_LBUTTONDBLCLK
          ;GuiCtrlSetData($Label, "Double-Clik on: " & $LinkText & @CRLF)
        Case BitAND($iMessage, $WM_RBUTTONDOWN) = $WM_RBUTTONDOWN
          ;GuiCtrlSetData($Label, "R-Clik on: " & $LinkText & @CRLF)
        Case BitAND($iMessage, $WM_LBUTTONDOWN) = $WM_LBUTTONDOWN
          ;GuiCtrlSetData($Label, "L-Clik on: " & $LinkText & @CRLF)
      EndSelect
      ;_RichEdit_SetSel($hWndFrom, $Sel[0], $Sel[0])
    Case $EN_PROTECTED
      ;MsgBox(64, "", "Texto protegido")
      ;Send("^z")
    Case $EN_SELCHANGE
      Local $tSELCHANGE = DllStructCreate($tagSELCHANGE, $ilParam)
      Local $cpMin = DllStructGetData($tSELCHANGE, 4)
      Local $cpMax = DllStructGetData($tSELCHANGE, 5)
      If $cpMin == $cpMax and Not $LOCK_SYNTAX_COLORING Then
        $NEW_TEXT = _GUICtrlEdit_GetText($IDC_EDIT1)
        $submit = StringCompare(StringMid($NEW_TEXT, $cpMin, 2), @CRLF)
        ;logging($submit&":"&StringMid($NEW_TEXT, $cpMin, 1) )
        If $EDIT_FORMULA_PREVIOUS_TEXT <> $NEW_TEXT Then
          If $submit==0 Then
            logging("REPLACESEL")
            _RichEdit_SetSel($IDC_EDIT1, $cpMin-1, $cpMin)
            _GUICtrlEdit_ReplaceSel($IDC_EDIT1, "")
          EndIf
          colorationSyntaxique($IDC_EDIT1)
          If $submit==0 Then
            ID_DRAWClick()
          EndIf
          ;logging("Color activation")
          $EDIT_FORMULA_PREVIOUS_TEXT = $NEW_TEXT
        EndIf
        _WinAPI_SetFocus($IDC_EDIT1)
        $sel = _Iif($submit==0, $cpMin - 1, $cpMin)
        _RichEdit_SetSel($IDC_EDIT1, $sel, $sel)
      EndIf
      ;logging("Sel change:" & $cpMin & " --- " & $cpMax)
    #cs
    Case $EN_MSGFILTER
      Local $tEN_MSGFILTER = DllStructCreate($tagEN_MSGFILTER, $ilParam)
      Local $iMessage = DllStructGetData($tEN_MSGFILTER, 4)
      $OldSel = _RichEdit_GetSelection($IDC_EDIT1)
      ;logging("iMessage="&$iMessage)
      Select
        Case $iMessage = 513
            logging("Left Click")
        Case $iMessage = 514
            logging("Left Up")
        Case $iMessage = 515
            logging("Left Double")
        Case $iMessage = 516
            logging("Right Click")
        Case $iMessage = 517
            logging("Right Up")
        Case $iMessage = 519
            logging("Wheel Click")
        Case $iMessage = 520
            logging("Wheel Up")
        Case $iMessage = 522
            logging("Wheel Scroll")
        Case $iMessage = 256
            logging("Key Down")
        Case $iMessage = 258
            logging("Key Still Down")
        Case $iMessage = 257
            logging("Key Up")
        ;Case $iMessage = 512 or $iMessage = 33
            ;Return
        ;Case Else
            ;ConsoleWrite($iMessage)
      EndSelect
      #ce
    EndSwitch
  Case Else
  EndSwitch
  Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

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
