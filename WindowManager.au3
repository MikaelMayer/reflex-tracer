#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2008 /10/21
 Script Function:
  Controlls the available windows of the project.

#ce ----------------------------------------------------------------------------
#include-once
#include "translations.au3"
#include "GlobalUtils.au3"
#include <GuiConstants.au3>
#Include <GuiMenu.au3>

Global Enum $N_WLS_TYPE, $N_WLS_LOAD, $N_WLS_SAVE, $N_WLS_COUNT
Global $wm_load_save_methods = emptySizedArray()

Global Enum $N_WIN_HANDLE, $N_WIN_TYPE, $N_WIN_CLOSE, $N_WIN_COUNT
Global $wm_registered_windows = emptySizedArray()

; Registers a window and also the parameters that have to be stored with,
; along with the methods to re-create them.
; Parameters:
; $win_handle: The handle of the window. Useful to minimize/maximize windows. Not stored at closing time.
; $create_method: A string containing a expression whose evaluation creates the window.
; $parameters_map is a SizedArray where each row is as follow:
;   [parameter_set_function, parameter_get_function, ini_section, ini_value]
;   where the elements are:
;   * parameter_set_function : A string containing a function taking one argument to set the field.
;   * parameter_get_function : A string containing a function returning the value of the field (to be stored in the ini file)
;   * ini_section : A string containing the section where the value has to be stored at closing time.
;   * ini_variable : The corresponding variable name
Func WindowManager__registerWindow($win_handle, $win_type="", $win_close="")
  ;logging("Registering window type "&$win_type&" ("&$win_handle&")")
  Local $t[$N_WIN_COUNT]
  $t[$N_WIN_HANDLE] = $win_handle
  $t[$N_WIN_TYPE]   = $win_type
  $t[$N_WIN_CLOSE]  = $win_close
  push($wm_registered_windows, $t)
EndFunc

Func WindowManager__unregisterWindow($win_handle)
  ;logging("Unregistering window ("&$win_handle&")")
  For $i = 1 To $wm_registered_windows[0]
    $t = $wm_registered_windows[$i]
    If $t[$N_WIN_HANDLE] = $win_handle Then
      deleteAt($wm_registered_windows, $i)
      ExitLoop
    EndIf
  Next
EndFunc

Func WindowManager__getAllWindowHandles()
  return $wm_registered_windows
EndFunc

Func WindowManager__AllWinSetState($flag)
  For $i = 1 To $wm_registered_windows[0]
    ;_SendMessage($wm_registered_windows[$i], $WM_SYSCOMMAND, 0xF020, 0)
    $t = $wm_registered_windows[$i]
    Switch $flag
    Case @SW_MINIMIZE
      DllCall("user32.dll", "int", "PostMessage", "hwnd", $t[$N_WIN_HANDLE], "int", $WM_SYSCOMMAND, "int", 0xF020, "long", 0)
    Case @SW_MAXIMIZE
      DllCall("user32.dll", "int", "PostMessage", "hwnd", $t[$N_WIN_HANDLE], "int", $WM_SYSCOMMAND, "int", 0xF030, "long", 0)
    Case @SW_RESTORE
      DllCall("user32.dll", "int", "PostMessage", "hwnd", $t[$N_WIN_HANDLE], "int", $WM_SYSCOMMAND, "int", 0xF120, "long", 0)
    Case Else
      WinSetState($t[$N_WIN_HANDLE], "", $flag)
    EndSwitch
  Next
EndFunc

Func WindowManager__minimizeAll()
  WindowManager__AllWinSetState(@SW_MINIMIZE)
EndFunc

Func WindowManager__restoreAll()
  WindowManager__AllWinSetState(@SW_RESTORE)
EndFunc

Func WindowManager__closeAll()
  Local $size
  While $wm_registered_windows[0] > 0
    ;logging("State : "&toString($wm_registered_windows))
    $t = $wm_registered_windows[1]
    $size = $wm_registered_windows[0]
    Call($t[$N_WIN_CLOSE], $t[$N_WIN_HANDLE])
    If $size == $wm_registered_windows[0] Then ; Was not deleted
      deleteAt($wm_registered_windows, 1)
    EndIf
  WEnd
EndFunc

Func WindowManager__resizeAll($pos_before, $pos_after)
  For $i = 1 To $wm_registered_windows[0]
    $t = $wm_registered_windows[$i]
    _WindowManager__resizeOne($t[$N_WIN_HANDLE], $pos_before, $pos_after)
  Next
EndFunc

Func _WindowManager__resizeOne($win_handle, $pos_before, $pos_after)
    $pos_child = WinGetPos($win_handle)
    ;logging("Resize one:"&toString($pos_before)&";"&toString($pos_after)&";"&toString($pos_child))
    $pos_after_ltrb        = leftTopWithHeight_to_leftTopRightBottom($pos_after)
    $pos_before_ltrb = leftTopWithHeight_to_leftTopRightBottom($pos_before)
    $pos_child_ltrb     = leftTopWithHeight_to_leftTopRightBottom($pos_child)

    move_ltrb($pos_child_ltrb, $pos_before_ltrb, $pos_after_ltrb)

    $pos_child = leftTopRightBottom_to_leftTopWithHeight($pos_child_ltrb)

    WinMove($win_handle, "", $pos_child[0], $pos_child[1], $pos_child[2], $pos_child[3])
EndFunc


;=== Methods to save and load all small windows from a previous version ===;

; Register functions to load / save certain type of windows.
; A load method should accept one argument, the value to load.
; A save method should accept one argument, the window handle
Func WindowManager__addLoadSaveFunctionForType($type, $load_function_name, $save_function_name)
  Local $t[$N_WLS_COUNT]
  $t[$N_WLS_TYPE] = $type
  $t[$N_WLS_LOAD] = $load_function_name
  $t[$N_WLS_SAVE] = $save_function_name
  push($wm_load_save_methods, $t)
EndFunc

Func _WindowManager__loadWindow($type, $value)
  ;logging("Loading window "&$type&" with parameter "&$value)
  For $i = 1 To $wm_load_save_methods[0]
    $t = $wm_load_save_methods[$i]
    If $t[$N_WLS_TYPE] == $type Then
      Call($t[$N_WLS_LOAD], $value)
      ExitLoop
    EndIf
  Next
EndFunc

Func _WindowManager__maybeSaveWindow($registered_window, ByRef $key_value_pairs)
  $type = $registered_window[$N_WIN_TYPE]
  For $i = 1 To $wm_load_save_methods[0]
    $t = $wm_load_save_methods[$i]
    If $t[$N_WLS_TYPE] == $type and $t[$N_WLS_SAVE] <> "" Then
      $value = Call($t[$N_WLS_SAVE], $registered_window[$N_WIN_HANDLE])
      push($key_value_pairs, $type&"="&$value)
    EndIf
  Next
EndFunc

Func WindowManager__loadAll()
  Local $windows_to_restore = IniReadSection($ini_file, $ini_file_windows)
  If @error Then Return
  For $i = 1 To $windows_to_restore[0][0]
    _WindowManager__loadWindow($windows_to_restore[$i][0], $windows_to_restore[$i][1])
  Next
  ;WinActivate($rri_win)
EndFunc

Func WindowManager__saveAll()
  Local $key_value_pairs = emptySizedArray()
  For $i = 1 To $wm_registered_windows[0]
    $t = $wm_registered_windows[$i]
    _WindowManager__maybeSaveWindow($t, $key_value_pairs)
  Next
  If $key_value_pairs[0] > 0 Then
    toBasicArray($key_value_pairs)
    $section_to_write = _ArrayToString($key_value_pairs, @LF)
    IniWriteSection($ini_file, $ini_file_windows, $section_to_write)
  EndIf
EndFunc


