#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         Mikaël Mayer

 Script Function:
	Parse files and add missing informations

Specifications (with alignment?):
The text for the arguments / purpose can be customized, not the one for "called by :"..

; my_func : My function purpose text
; $arg1   : An integer / string / boolean / integer array, etc which
; $arg2   :
; $arg3   :
Func my_func($arg1, $arg2, $arg3)

EndFunc ;==>my_func

#ce ----------------------------------------------------------------------------
#include-once
#include <Math.au3>
#include "GlobalUtils.au3"

;MsgBox(0, "", toString(getArgumentArray("Func test($arg1,   ByRef   $arg2, _"&@CRLF&"      $arg3)")))
repairFile("ReflexRenderer.au3")

; Add ;==>my_func and argument statements over the given file.au" and puts the result into file.au3.au3
Func repairFile($fileread)
  $filewrite = $fileread&"_style_repaired.au3"
  $fr = FileOpen($fileread, 0)
  $fw = FileOpen($filewrite, 2)
  
  Local $p = emptySizedArray()
  Local $inFunction = False
  Local $func_name = ""
  Local $line_prev = "", $l = ""
  While True
    $line_prev = $l
    $l = FileReadLine($fr)
    If @error <> 0 Then ExitLoop
    If isFunc($l) Then
      $inFunction = True
      $func_name = getFuncName($l)
      $func_args = uniformizeLength(getArgumentArray($l))
      ;If isEndFunc($line_prev) Then FileWriteLine($fw, "")
      ;FileWriteLine($fw, "; ")
      For $i = 1 To size($func_args)
        $s = $func_args[$i]
        FileWriteLine($fw, ";   "&$s&" : ")
      Next
      FileWriteLine($fw, $l)
    ElseIf isEndFunc($l) Then
      FileWriteLine($fw, "EndFunc   ;==>"&$func_name)
    Else
      FileWriteLine($fw, $l)
    EndIf
  WEnd
  FileClose($fileread)
  FileClose($filewrite)
EndFunc

Func isCommentLine($l)
  Return StringStartsWith($l, ";")
EndFunc

Func isFunc($l)
  Return StringStartsWith($l, "Func")
EndFunc

; Returns the function name
; Assumes isFunc($l)
Func getFuncName($l)
  $n = StringInStr($l, "(")
  Return StringMid($l, 6, $n-6)
EndFunc

; Returns the argument array of the function
; Assumes isFunc($l)
Func getArgumentArray($l)
  $n = StringInStr($l, "(")
  $a = StringSplit(StringMid($l, $n+1, StringLen($l)-$n-1), ",")
  For $i = 1 To size($a)
    $s = $a[$i]
    $s = StringReplace($s, @CR, " ")
    $s = StringReplace($s, @LF, " ")
    $s = StringReplace($s, "_ ", "")
    $s = StringReplace($s, "ByRef", "")
    $s = StringReplace($s, "Const", "")
    $s = StringStripWS($s, 1+2)
    $a[$i] = $s
  Next
  If size($a) == 1 and $a[1] == "" Then
    pop($a)
  EndIf
  return $a
EndFunc

Func uniformizeLength($sized_array)
  $length = 0
  For $i = 1 to size($sized_array)
    $length  = _Max(StringLen($sized_array[$i]), $length)
  Next
  For $i = 1 to size($sized_array)
    $sized_array[$i] = StringSizeMin($sized_array[$i], $length, " ")
  Next
  Return $sized_array
EndFunc

Func isEndFunc($l)
  Return StringStartsWith($l, "EndFunc")
EndFunc
