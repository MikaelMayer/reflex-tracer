#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2009/01/14

 Script Function:
    Assistant generator


Wish list:
Translations.
#ce ----------------------------------------------------------------------------
#include-once

#include "GlobalUtils.au3"
#include "RenderVideoIniConfig.au3"
#include <GUIConstants.au3>
;#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>

Global Enum $AS_FIELD_TYPE, $AS_SECTION, $AS_COMMENT, $AS_DATA, $AS_ADVANCED
Global Enum $AS_TYPE_INTEGER, $AS_TYPE_STRING, $AS_TYPE_FILE, $AS_TYPE_TAB, $AS_TYPE_TITLE, $AS_TYPE_BOOL

Func generateAssistant(ByRef $values)
  $prevOnEventMode = Opt("GUIOnEventMode", 0)
  Local $mapping = emptySizedArray()
  Local $w, $tabs, $y = 0, $x = 15, $tabbing = 65, $ystep = 25
  Local $window
  Local $tabs = emptySizedArray(), $tabgenerator=0
  Local $indextab = 1
  Local $maxdim[2] = [0, 0]
  For $i = 1 To $values[0]
    $tab = $values[$i]
    $w = 0
    Switch $tab[$AS_FIELD_TYPE]
    Case $AS_TYPE_TITLE
      $w = GUICreate($tab[$AS_COMMENT], 413, 298, 303, 219)
      $window = $w
      $all_tabs = GUICtrlCreateTab(8, 8, 396, 256)
      GUICtrlSetResizing(-1, $GUI_DOCKALL)
    Case $AS_TYPE_TAB
      $w = GUICtrlCreateTabItem($tab[$AS_COMMENT])
      GUICtrlSetResizing(-1, $GUI_DOCKALL)
      push($tabs, $w)
      $tabgenerator = $w
      $y = 35
    Case $AS_TYPE_INTEGER, $AS_TYPE_STRING, $AS_TYPE_FILE
      $l = GUICtrlCreateLabel($tab[$AS_COMMENT], $x, $y+3)
      GUICtrlSetResizing(-1, $GUI_DOCKALL)
      updateMaxDim($maxdim, $window, $l)
      $p = ControlGetPos($window, "", $l)
      $w = GUICtrlCreateInput($tab[$AS_DATA], tabbing($p[0]+$p[2]+2, $tabbing), $y, 100)
      GUICtrlSetResizing(-1, $GUI_DOCKALL)
      GUICtrlSetTip(-1, $tab[$AS_COMMENT])
      updateMaxDim($maxdim, $window, $w)
      If $tab[$AS_FIELD_TYPE] = $AS_TYPE_FILE Then ContinueCase
      $y += $p[3]
    Case $AS_TYPE_FILE
      $p2 = ControlGetPos($window, "", $w)
      $b = GUICtrlCreateButton("...", $p2[0]+$p2[2]+5, $y)
      GUICtrlSetResizing(-1, $GUI_DOCKALL)
      updateMaxDim($maxdim, $window, $b)
      push($mapping, _ArrayCreate($b, $i, $w))
      $y += $p[3]
    Case $AS_TYPE_BOOL
      $w = GUICtrlCreateCheckbox($tab[$AS_COMMENT], $x, $y)
      GUICtrlSetResizing(-1, $GUI_DOCKALL)
      updateMaxDim($maxdim, $window, $w)
      If $tab[$AS_DATA] Then GUICtrlSetState(-1, $GUI_CHECKED)      
      $y += $ystep
    EndSwitch
    If $w <> 0 Then push($mapping, _ArrayCreate($w, $i))
  Next
  $___next___ = "&Next>"
  $__ge_nerate___ = "Ge&nerate!"
  
  GUICtrlCreateTabItem("")
  Local $dx = $maxdim[0] - 396
  Local $dy = $maxdim[1] - 256
  ;$dx = 0
  ;$dy = 0
  
  GUICtrlSetPos($all_tabs, 8, 8, 396 + $dx, 256 + $dy)
  
  Global $as_previous = GUICtrlCreateButton("<&Previous", 166 + $dx, 272 + $dy, 75, 25, 0)
  GUICtrlSetResizing(-1, $GUI_DOCKALL)
  Global $as_next = GUICtrlCreateButton($___next___, 246 + $dx, 272 + $dy, 75, 25, 0)
  GUICtrlSetResizing(-1, $GUI_DOCKALL)
  Global $as_cancel = GUICtrlCreateButton("&Cancel", 328 + $dx, 272 + $dy, 75, 25, 0)
  GUICtrlSetResizing(-1, $GUI_DOCKALL)

  WinMove($window, "", 303, 219, 413+$dx, 335+$dy)
  ;WinSetOnTop($window, "", 1)
  GUISetState(@SW_SHOW)
  
  $cancel = False
  While 1
    $nMsg = GUIGetMsg()
    If $nMsg == $GUI_EVENT_CLOSE Or $nMsg == $as_cancel Then
      $cancel = True
      ExitLoop
    EndIf
    If $nMsg <= 0 Then ContinueLoop
    If $nMsg == $as_next Then
      If $indextab == size($tabs) Then
        ExitLoop
      Else
        $indextab += 1
        GUICtrlSetState($tabs[$indextab],$GUI_SHOW)
      EndIf
    EndIf
    If $nMsg == $as_previous Then
      If $indextab > 1 Then
        $indextab -= 1
        GUICtrlSetState($tabs[$indextab],$GUI_SHOW)
      EndIf
    EndIf
    If $nMsg == $all_tabs Then
      $indextab = GUICtrlRead($all_tabs)+1
    EndIf
    If $indextab == size($tabs) Then
      GUICtrlSetData($as_next, $__ge_nerate___)
    Else
      GUICtrlSetData($as_next, $___next___)
    EndIf
    
    For $i = 1 To $mapping[0]
      $m = $mapping[$i]
      If $nMsg == $m[0] Then
        $tab = $values[$m[1]]
        Switch $tab[$AS_FIELD_TYPE]
        Case $AS_TYPE_TITLE
        Case $AS_TYPE_TAB
        Case $AS_TYPE_INTEGER, $AS_TYPE_STRING, $AS_TYPE_FILE
          If UBound($m) == 3 Then
            $file_decriptor = "All (*.*)"
            If UBound($tab) >= $AS_ADVANCED + 1 Then
              $file_decriptor = $tab[$AS_ADVANCED]
            EndIf
            $r = FileOpenDialog("Set file", "init dir", $file_decriptor, 2, GUICtrlRead($m[2]))
            If @error == 0 Then
              GUICtrlSetData($m[2], $r)
            EndIf
          EndIf
        Case $AS_TYPE_FILE
        Case $AS_TYPE_BOOL
        EndSwitch
        ExitLoop
      EndIf
    Next
  WEnd
  Opt("GUIOnEventMode", $prevOnEventMode)
  If $cancel Then
    GUIDelete($window)
    Return False
  EndIf
  For $i = 1 To $mapping[0]
    $m = $mapping[$i]
    $tab = $values[$m[1]]
    Switch $tab[$AS_FIELD_TYPE]
    Case $AS_TYPE_TITLE
    Case $AS_TYPE_TAB
    Case $AS_TYPE_INTEGER
      $tab[$AS_DATA] = Int(GUICTrlRead($m[0]))
    Case $AS_TYPE_STRING, $AS_TYPE_FILE
      $tab[$AS_DATA] = GUICTrlRead($m[0])
    Case $AS_TYPE_BOOL
      $tab[$AS_DATA] = BitAnd(GUICTrlRead($m[0]), $GUI_CHECKED)
    EndSwitch
    $values[$m[1]] = $tab
  Next
  GUIDelete($window)
  Return True
EndFunc

Func updateMaxdim(ByRef $maxdim, $win, $control, $line = @ScriptLineNumber)
  $p = ControlGetPos($win, "", $control)
  If $p[0]+$p[2] > $maxdim[0] Then $maxdim[0] = $p[0]+$p[2]
  If $p[1]+$p[3] > $maxdim[1] Then $maxdim[1] = $p[1]+$p[3]
EndFunc

Func tabbing($pos, $tab)
  Return $tab * Ceiling($pos / $tab)
EndFunc