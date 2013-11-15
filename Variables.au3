#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2008 /10/21
 Script Function:
  The variable window to controll a variable in the Editor of Formula.

#ce ----------------------------------------------------------------------------
#include-once
#include "Translations.au3"
#include "GlobalUtils.au3"
#include "WindowManager.au3"
#include "RenderingBox.au3"
#include <GuiConstants.au3>

Global $vm_variable_windows = emptySizedArray(), $Variables__update_function = ""
Global $vaw_slidermin=0, $vaw_slidermax=100, $Variables__current_window_indice
Global $vaw_window, $vaw_varmin, $vaw_varmax, $vaw_varcurrent, $vaw_slider
Global $VARIABLES_PARENT = 0

Global enum $N_VAW_WINDOW = 0, _
            $N_VAW_CURRENT, _
            $N_VAW_SLIDER, _
            $N_VAW_SLIDERMIN, _
            $N_VAW_SLIDERMAX, _
            $N_VAW_VARMIN, _
            $N_VAW_VARMAX, _
            $N_VAW_VARNAME, _
            $N_VAW_RENDER, _
            $N_VAW_HANDLE, _
            $N_VAW_SET_MIN, _
            $N_VAW_SET_MAX, _
            $N_VAW_INCREASE_RANGE, _
            $N_VAW_SIZE

Func VariableManager__registerVariable($vaw_window, $vaw_varcurrent, $vaw_slider, $vaw_varmin, $vaw_varmax, $vaw_varname, $vaw_render, $vaw_set_min, $vaw_set_max, $vaw_increase_range)
  Local $new_window[$N_VAW_SIZE]
  $new_window[$N_VAW_WINDOW]  = $vaw_window
  $new_window[$N_VAW_CURRENT] = $vaw_varcurrent
  $new_window[$N_VAW_SLIDER]  = $vaw_slider
  $new_window[$N_VAW_SLIDERMIN]  = 0
  $new_window[$N_VAW_SLIDERMAX]  = 100
  $new_window[$N_VAW_VARMIN]  = $vaw_varmin
  $new_window[$N_VAW_VARMAX]  = $vaw_varmax
  $new_window[$N_VAW_VARNAME] = $vaw_varname
  $new_window[$N_VAW_RENDER]  = $vaw_render
  $new_window[$N_VAW_SET_MIN] = $vaw_set_min
  $new_window[$N_VAW_SET_MAX] = $vaw_set_max
  $new_window[$N_VAW_INCREASE_RANGE] = $vaw_increase_range
  push($vm_variable_windows, $new_window)
  $Variables__current_window_indice = $vm_variable_windows[0]
EndFunc

Func VariableManager__unregisterVariable($vaw_window)
  For $i = 1 To $vm_variable_windows[0]
    Local $vm = $vm_variable_windows[$i]
    If $vm[$N_VAW_WINDOW] == $vaw_window Then
      deleteAt($vm_variable_windows, $i)
      Return
    EndIf
  Next
EndFunc

Func VariableManager__setCurrentVariable($win_handle)
  ;logging("Loading variable "&$win_handle)
  If $vaw_window = $win_handle Then Return
  For $i = 1 To $vm_variable_windows[0]
    Local $vw = $vm_variable_windows[$i]
    If $vw[0] == $win_handle Then
      ;logging("Variable "&$i&" loaded")
      $vaw_window = $vw[$N_VAW_WINDOW]
      $vaw_varcurrent = $vw[$N_VAW_CURRENT]
      $vaw_slider     = $vw[$N_VAW_SLIDER]
      $vaw_slidermin  = $vw[$N_VAW_SLIDERMIN]
      $vaw_slidermax  = $vw[$N_VAW_SLIDERMAX]
      $vaw_varmin     = $vw[$N_VAW_VARMIN]
      $vaw_varmax     = $vw[$N_VAW_VARMAX]
      $vaw_varname    = $vw[$N_VAW_VARNAME]
      $vaw_render     = $vw[$N_VAW_RENDER]
      $vaw_set_min    = $vw[$N_VAW_SET_MIN]
      $vaw_set_max    = $vw[$N_VAW_SET_MAX]
      $vaw_increase_range = $vw[$N_VAW_INCREASE_RANGE]
      $Variables__current_window_indice = $i
      Return
    EndIf
  Next
EndFunc

Func Variables__setParentWindow($win_handle)
  $VARIABLES_PARENT = $win_handle
EndFunc

Func Variables__setUpdateFunction($update_function)
  $Variables__update_function = $update_function
EndFunc

#Region ### Form Variables
Global $vaw_window=0, $vaw_Label5=0, $vaw_Label1=0, $vaw_Label2=0, $vaw_varcurrent=0, $vaw_varmin=0, $vaw_varmax=0, $vaw_slider=0, $vaw_render=0, $vaw_set_min=0, $vaw_set_max=0, $vaw_Label3=0, $vaw_increase_range=0, $vaw_Label4=0, $vaw_decrease_range=0, $vaw_varname=0
#EndRegion ### Form Variables

Func GenerateVariableWindow($for_formula = "")
  Opt('GUIOnEventMode', 1)
  #Region ### START Koda GUI section ### Form=C:\Documents and Settings\Mikaël\Mes documents\Reflex\LogicielOrdi\RenderReflex\ReflexRendererVariables.kxf
  $vaw_window = GUICreate($__variable__, 310, 138, 639, 162, BitOR($WS_MAXIMIZEBOX,$WS_MINIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_SYSMENU,$WS_CAPTION,$WS_OVERLAPPEDWINDOW,$WS_TILEDWINDOW,$WS_POPUP,$WS_POPUPWINDOW,$WS_GROUP,$WS_TABSTOP,$WS_BORDER,$WS_CLIPSIBLINGS))
  GUISetOnEvent($GUI_EVENT_CLOSE, "vaw_windowClose")
  GUISetOnEvent($GUI_EVENT_MINIMIZE, "vaw_windowMinimize")
  GUISetOnEvent($GUI_EVENT_MAXIMIZE, "vaw_windowMaximize")
  GUISetOnEvent($GUI_EVENT_RESTORE, "vaw_windowRestore")
  $vaw_Label5 = GUICtrlCreateLabel($__variable_editor__, 8, 8, 177, 17, $SS_CENTER)
  GUICtrlSetOnEvent($vaw_Label5, "vaw_Label5Click")
  $vaw_Label1 = GUICtrlCreateLabel($__variable_name__, 6, 34, 73, 17, $SS_RIGHT)
  GUICtrlSetOnEvent($vaw_Label1, "vaw_Label1Click")
  $vaw_Label2 = GUICtrlCreateLabel("=", 117, 33, 13, 24)
  GUICtrlSetFont($vaw_Label2, 12, 400, 0, "MS Sans Serif")
  GUICtrlSetOnEvent($vaw_Label2, "vaw_Label2Click")
  $vaw_varcurrent = GUICtrlCreateInput("0.5", 130, 32, 56, 21, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
  GUICtrlSetOnEvent($vaw_varcurrent, "vaw_varcurrentChange")
  $vaw_varmin = GUICtrlCreateInput("-1", 130, 56, 56, 21)
  GUICtrlSetOnEvent($vaw_varmin, "vaw_varminChange")
  $vaw_varmax = GUICtrlCreateInput("1", 130, 80, 56, 21, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
  GUICtrlSetOnEvent($vaw_varmax, "vaw_varmaxChange")
  $vaw_slider = GUICtrlCreateSlider(8, 104, 292, 25)
  GUICtrlSetData($vaw_slider, 75)
  GUICtrlSetOnEvent($vaw_slider, "vaw_sliderChange")
  $vaw_render = GUICtrlCreateButton($__render_along_variable__, 196, 4, 97, 25, 0)
  GUICtrlSetResizing($vaw_render, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($vaw_render, "vaw_renderClick")
  $vaw_set_min = GUICtrlCreateButton($__set_min__, 189, 30, 57, 25, 0)
  GUICtrlSetResizing($vaw_set_min, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($vaw_set_min, "vaw_set_minClick")
  $vaw_set_max = GUICtrlCreateButton($__set_max__, 247, 30, 57, 25, 0)
  GUICtrlSetResizing($vaw_set_max, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($vaw_set_max, "vaw_set_maxClick")
  $vaw_Label3 = GUICtrlCreateLabel($__minimum__, 37, 58, 92, 17, $SS_RIGHT)
  GUICtrlSetOnEvent($vaw_Label3, "vaw_Label3Click")
  $vaw_increase_range = GUICtrlCreateButton($__increase_range__, 189, 55, 115, 25, 0)
  GUICtrlSetResizing($vaw_increase_range, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($vaw_increase_range, "vaw_increase_rangeClick")
  $vaw_Label4 = GUICtrlCreateLabel($__maximum__, 37, 82, 92, 17, $SS_RIGHT)
  GUICtrlSetOnEvent($vaw_Label4, "vaw_Label4Click")
  $vaw_decrease_range = GUICtrlCreateButton($__decrease_range__, 189, 79, 115, 25, 0)
  GUICtrlSetResizing($vaw_decrease_range, $GUI_DOCKAUTO)
  GUICtrlSetOnEvent($vaw_decrease_range, "vaw_decrease_rangeClick")
  $vaw_varname = GUICtrlCreateInput("$x", 81, 32, 33, 21, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
  GUICtrlSetOnEvent($vaw_varname, "vaw_varnameChange")
  #EndRegion ### END Koda GUI section ###
  GUICtrlSetData($vaw_varname, Variables__detectVariableName($for_formula))
  vawUpdateTitle()

  Local $pos = _ArrayCreate(0, @DesktopHeight + 1, 0, 0)
  Local $pos_current = WinGetPos($vaw_window)
  If $vm_variable_windows[0] <> 0 Then
    $tab = $vm_variable_windows[$vm_variable_windows[0]]
    $pos = WinGetPos($tab[$N_VAW_WINDOW])
  EndIf
  If $pos[1]+$pos[3]+$pos_current[3] > @DesktopHeight Then
    If WinExists($VARIABLES_PARENT) Then
      $pos = WinGetPos($VARIABLES_PARENT, "")
    Else
      $pos = _ArrayCreate(0, 0, 0, 0)
    EndIf
  EndIf
  WinMove($vaw_window, "", $pos[0], $pos[1]+$pos[3])

  AnimateFromTop($vaw_window)
  GUISetState(@SW_SHOW, $vaw_window)
  GUISetOnEvent($GUI_EVENT_RESIZED, 'vaw_windowResized')
  WindowManager__registerWindow($vaw_window, "Variable", "vaw_windowClose")
  VariableManager__registerVariable($vaw_window, $vaw_varcurrent, $vaw_slider, $vaw_varmin, $vaw_varmax, $vaw_varname, $vaw_render, $vaw_set_min, $vaw_set_max, $vaw_increase_range)
EndFunc

WindowManager__addLoadSaveFunctionForType("Variable", "Variables__LoadFromIni", "Variables__SaveToIni")
Func Variables__LoadFromIni($value)
  $parsed = StringRegExp($value, "(?i)([^\s]*)\s?=\s?([^\s]*) from (.*) to (.*)", 1)
  If @Error<>0 Then
    logging("Error: variable not loaded ("&$value&")")
    Return
  EndIf
  GenerateVariableWindow()
  GUICtrlSetData($vaw_varname, $parsed[0])
  GUICtrlSetData($vaw_varcurrent, $parsed[1])
  GUICtrlSetData($vaw_varmin, $parsed[2])
  GUICtrlSetData($vaw_varmax, $parsed[3])
  vaw_update_slider_raw()
EndFunc
Func Variables__SaveToIni($win_handle)
  loadVariable($win_handle)

  $name = GUICtrlRead($vaw_varname)
  $val  = GUICtrlRead($vaw_varcurrent)
  $min  = GUICtrlRead($vaw_varmin)
  $max  = GUICtrlRead($vaw_varmax)

  Return StringFormat("%s = %s from %s to %s", $name, $val, $min, $max)
EndFunc

Func Variables__detectVariableName($for_formula)
  $array = StringRegExp($for_formula, "(?i)(\$(?:.*?))(?:[^[:alnum:]]|\z)", 3)
  For $i = 0 To UBound($array) - 1
    For $j = 1 To $vm_variable_windows[0]
      $tab = $vm_variable_windows[$j]
      If $array[$i] == GUICtrlRead($tab[$N_VAW_VARNAME]) Then ContinueLoop 2
    Next
    ; Good news here, this variable is in the formule and not yet used.
    Return $array[$i]
  Next
  Local $j = 0
  While True
    $j += 1
    For $i = 1 To $vm_variable_windows[0]
      $tab = $vm_variable_windows[$i]
      If StringCompare("$x"&$j, GUICtrlRead($tab[$N_VAW_VARNAME]))==0 Then ContinueLoop 2
    Next
    ExitLoop
  WEnd
  Return "$x"&$j
EndFunc

Func Variables__updateString($string, $except_variable=0)
  ;Replace the variables in $string by their value.
  ;logging("Variable_replacement in "&$string)
  For $i = 1 To $vm_variable_windows[0]
    $tab = $vm_variable_windows[$i]
    ;loadVariable($tab[$N_VAW_WINDOW])
    ;logging("Name: "& GUICtrlRead($tab[$N_VAW_VARNAME])&"=="&$except_variable&":"&(GUICtrlRead($tab[$N_VAW_VARNAME]) == $except_variable)&", value: " & GUICtrlRead($tab[$N_VAW_CURRENT]))
    If Not (GUICtrlRead($tab[$N_VAW_VARNAME]) == $except_variable) Then
      $string = replaceVariableString($string, GUICtrlRead($tab[$N_VAW_VARNAME]), GUICtrlRead($tab[$N_VAW_CURRENT]));
    EndIf
    ;logging("Replaced:"& $string)
  Next
  Return $string
EndFunc

Func loadVariable($window = @GUI_WinHandle)
  VariableManager__setCurrentVariable($window)
EndFunc

Func vawUpdateTitle()
  WinSetTitle($vaw_window, "", GUICtrlRead($vaw_varname)&" = "&GUICtrlRead($vaw_varcurrent))
EndFunc

Func vawUpdate($history_save=True)
  vawUpdateTitle()
  If $Variables__update_function <> "" Then
    Call($Variables__update_function, $history_save)
  EndIf
EndFunc

Func vaw_windowClose($win_handle = @GUI_WinHandle)
  If Not IsDeclared("win_handle") Then $win_handle = @GUI_WinHandle
  loadVariable($win_handle)
  ;MsgBox(0, "@GUI_CtrlId", @GUI_WinHandle == $vaw_window)
  VariableManager__unregisterVariable($win_handle)
  WindowManager__unregisterWindow($win_handle)
  AnimateToTop($vaw_window)
  GUIDelete($vaw_window)
EndFunc
Func vaw_windowMinimize()
  vaw_windowResized()
EndFunc
Func vaw_windowMaximize()
  vaw_windowResized()
EndFunc
Func vaw_windowRestore()
  vaw_windowResized()
EndFunc
Func vaw_windowResized()
  loadVariable()
  ;logging("GUI: "&@GUI_WinHandle)
  $tab = $vm_variable_windows[1]
  ;logging("GUI: "&$tab[0])
  $p = ControlGetPos($vaw_window, "", $vaw_slider)
  If Not IsArray($p) Then Return ; TODO : say that the variable has been deleted
  $min = 0
  $max = $p[2]
  GUICtrlSetLimit($vaw_slider, $max, $min)
  ;logging("variable resized:"&$Variables__current_window_indice)
  $tab = $vm_variable_windows[$Variables__current_window_indice]
  $tab[$N_VAW_SLIDERMIN] = $min
  $tab[$N_VAW_SLIDERMAX] = $max
  $vm_variable_windows[$Variables__current_window_indice] = $tab
  $vaw_slidermin = $min
  $vaw_slidermax = $max
  vaw_update_slider_raw()
EndFunc

Func vaw_update_slider($min, $max, $current)
  $rangemin = $vaw_slidermin
  $rangemax = $vaw_slidermax
  Local $calc = complex_calculate(StringFormat("%s*real(((%s)-(%s))/((%s)-(%s)))+%s", $rangemax - $rangemin, $current, $min, $max, $min, $rangemin))
  Local $result = Int($calc)
  GUICtrlSetData($vaw_slider, $result)
EndFunc
Func vaw_update_slider_raw()
  vaw_update_slider(GUICtrlRead($vaw_varmin), GUICtrlRead($vaw_varmax), GUICtrlRead($vaw_varcurrent))
EndFunc

Func vaw_multiply_range($coef)
  loadVariable()
  Local $min = GUICtrlRead($vaw_varmin)
  Local $max = GUICtrlRead($vaw_varmax)
  Local $middle = complex_calculate(StringFormat("(%s+%s)/2", $min, $max))
  Local $newmin = complex_calculate(StringFormat("%s*(%s-%s)+%s", $coef, $min, $middle, $middle))
  Local $newmax = complex_calculate(StringFormat("%s*(%s-%s)+%s", $coef, $max, $middle, $middle))
  GUICtrlSetData($vaw_varmin, $newmin)
  GUICtrlSetData($vaw_varmax, $newmax)
  vaw_update_slider($newmin, $newmax, GUICtrlRead($vaw_varcurrent))
EndFunc

Func vaw_increase_rangeClick()
  vaw_multiply_range(2)
EndFunc

Func vaw_decrease_rangeClick()
  vaw_multiply_range(0.5)
EndFunc

Func vaw_renderClick()
  loadVariable()
  Local $formula = EditFormula__getFormulaText()
  $formula = Variables__updateString($formula, GUICtrlRead($vaw_varname))
  Local $varname = GUICtrlRead($vaw_varname)
  Local $varmin = GUICtrlRead($vaw_varmin)
  Local $varmax = GUICtrlRead($vaw_varmax)
  RenderingBox__create($formula, $varname, $varmin, $varmax)
  ;MsgBox(0, "Sorry", "Feature not available for the moment... coming soon!"&@CRLF&$formula)
EndFunc

Func vaw_set_maxClick()
  loadVariable()
  GUICtrlSetData($vaw_varmax, GUICtrlRead($vaw_varcurrent))
  vaw_update_slider_raw()
EndFunc

Func vaw_set_minClick()
  loadVariable()
  GUICtrlSetData($vaw_varmin, GUICtrlRead($vaw_varcurrent))
  vaw_update_slider_raw()
EndFunc

Func vaw_sliderChange()
  loadVariable()
  Local $part = (GUICtrlRead($vaw_slider)-$vaw_slidermin)/($vaw_slidermax - $vaw_slidermin)
  Local $min = GUICtrlRead($vaw_varmin)
  Local $max = GUICtrlRead($vaw_varmax)
  Local $newcurrent = complex_calculate(StringFormat("%s*(%s)+%s*(%s)", 1-$part, $min, $part, $max))
  GUICtrlSetData($vaw_varcurrent, $newcurrent)
  vawUpdate(False)
EndFunc
Func vaw_varcurrentChange()
  loadVariable()
  vaw_update_slider_raw()
  vawUpdate()
EndFunc
Func vaw_varmaxChange()
  loadVariable()
  vaw_update_slider_raw()
  ;vawUpdate()
EndFunc
Func vaw_varminChange()
  loadVariable()
  vaw_update_slider_raw()
  ;vawUpdate()
EndFunc
Func vaw_varnameChange()
  loadVariable()
  ;Check if this variable is not used elsewhere.
  For $j = 1 To $vm_variable_windows[0]
    $tab = $vm_variable_windows[$j]
    If GUICtrlRead($vaw_varname) == GUICtrlRead($tab[$N_VAW_VARNAME]) And $vaw_window <> $tab[$N_VAW_WINDOW] Then
      ToolTip(StringReplace($__variable_already_opened__, "%s", GUICtrlRead($vaw_varname)))
      clear_tooltip_after_ms(2000)
      GUICtrlSetData($vaw_varname, Variables__detectVariableName(EditFormula__getFormulaText()))
      WinActivate($tab[$N_VAW_WINDOW])
      Return
    EndIf
  Next
  vawUpdate()
EndFunc

Func vaw_Label1Click()
EndFunc
Func vaw_Label2Click()
EndFunc
Func vaw_Label3Click()
EndFunc
Func vaw_Label4Click()
EndFunc
Func vaw_Label5Click()
EndFunc

; To run the main program from this file
#include "ReflexRenderer.au3"
