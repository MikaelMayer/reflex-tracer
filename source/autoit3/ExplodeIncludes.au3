#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2009/01/13

 Script Function:
    Explodes all "includes" of another script.

#ce ----------------------------------------------------------------------------

#include "GlobalUtils.au3"

Global $input_name = "RenderVideo.au3"
Global $output_name = "RenderVideoExploded.au3"

$fi = FileOpen($input_name, 0)
$fo = FileOpen($output_name, 2)
Dim $p = emptySizedArray()
includeFile($p, $fi, $input_name)
FileClose($fi)
FileClose($fo)

Func includeFile(ByRef $parsedFiles, $input, $name)
  logging(toString($parsedFiles)&"<="&$name)
  For $i = 1 To size($parsedFiles)
    If StringCompare($parsedFiles[$i], $name) == 0 Then Return
  Next
  ;logging("Continuing")
  Dim $comment = False
  While True
    $l = FileReadLine($input)
    If @error <> 0 Then ExitLoop
    If $l == "" Then
    ElseIf StringStartsWith($l, "#cs") Then
      $comment = True
    ElseIf $comment and Not StringStartsWith($l, "#ce") Then
    ElseIf StringStartsWith($l, "#ce") Then
      $comment = False
    ElseIf StringStartsWith($l, "#include ") Then
      logging("one include")
      $l = StringMid($l, 10)
      If StringMid($l, 1, 1) == "<" Then
        $d = StringInStr($l, ">")
        $name = "C:\Program Files\AutoIt3\Include\"&StringMid($l, 2, $d-2)
        logging($name)
        $f = FileOpen($name, 0)
        includeFile($parsedfiles, $f, $name)
        FileClose($f)
      Else
        $d = StringInStr($l, """", 1, 2)
        $name = StringMid($l, 2, $d-2)
        logging($name)
        $f = FileOpen($name, 0)
        includeFile($parsedfiles, $f, $name)
        FileClose($f)
      EndIf
    ElseIf StringStartsWith($l, "#include-once") Then
      push($parsedFiles, $name)
    ElseIf StringStartsWith($l, ";") Then
    Else
      FileWriteLine($fo, $l)
    EndIf
  WEnd
EndFunc





