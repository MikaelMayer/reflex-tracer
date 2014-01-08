#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer

 Script Function:
  ;Generates a language file for all strings in a file.
  This file is not used anymore. It was used to extract constant strings from files and replace them by variables.
  
  If the string  either:
  - ends with "Click", "Change" or ".au3"
  - contains a "\"
  - is surrounded by '' instead of ""
  it will not be taken into account.

#ce ----------------------------------------------------------------------------

#include <Array.au3>

$filescript1 = "ReflexRenderer.au3"
$filescript2 = "LoadFormulaFromFile.au3"
$filescript3 = "AboutBox.au3"
$filescript4 = "SaveBox.au3"
$filescript5 = "IniHandling.au3"
$filescript6 = "EditFormula.au3"

$filestoextract = _ArrayCreate( _
$filescript1, _
$filescript2, _
$filescript3, _
$filescript4, _
$filescript5, _
$filescript6)

$output = "translations.au3"
$initranslation = "translations.ini"

$strings = _ArrayCreate(0)

;parseAllFiles($filestoextract)
;dumpAll()

Func makeVar($str)
  $tab = StringSplit($str, "")
  _ArrayDelete($tab, 0)
  $result = "$"
  $letter = False
  For $char in $tab
    If StringInStr("abcdefghijklmnopqrstuvwxyz1234567890",$char) <> 0 Then
      $result = $result & $char
      $letter = True
    Else
      $result = $result & "_"
    EndIf
  Next
  If $letter Then
    Return $result
  Else
    Return ""
  EndIf
EndFunc

Func dumpAll()
  $f=FileOpen($output, 2)
  FileWriteLine($f, StringFormat('$translation_ini = "%s"', $initranslation))
  FileWriteLine($f, StringFormat('$ini_section = "Messages"', $initranslation))
  For $i = 1 To $strings[0]
    $var = makeVar($strings[$i])
    If $var <> "" Then
      FileWriteLine($f, StringFormat('%s= IniRead($translation_ini, $ini_section, _'&@CRLF&'"%s", _'&@CRLF&'"%s")', $var,$strings[$i],$strings[$i]))
      IniWrite($initranslation, "Messages", $strings[$i], $strings[$i])
    EndIf
  Next
  FileClose($f)
EndFunc

Func addString($string)
  If StringRight($string, 5) == "Click" _
Or StringRight($string, 6) == "Change" _
Or StringRight($string, 4) == ".au3" _
Or StringLen($string)==0 Then Return
  For $i = 1 To $strings[0]
    If $strings[$i] == $string Then Return
  Next
  _ArrayAdd($strings, $string)
  $strings[0] += 1
EndFunc

Func extractStrings($line)
  $characters = StringSplit($line, "")
  $inStringSingle = False
  $inStringDouble = False
  $stringDouble = ""
  For $i = 1 To $characters[0]
    $c = $characters[$i]
    If $c == "'" and Not ($inStringSingle Or $inStringDouble) Then
      $inStringSingle = True
    ElseIf $c == '"'and Not ($inStringSingle Or $inStringDouble) Then
      $inStringDouble = True
    ElseIf $inStringSingle and $c == "'" Then
      $inStringSingle = False
    ElseIf $inStringDouble and $c == '"' Then
      $inStringDouble = False
      addString($stringDouble)
      $stringDouble = ""
    Else
      If $inStringDouble Then
        $stringDouble = $stringDouble & $c
      EndIf
    EndIf
  Next
EndFunc

Func parseFile($file)
  $f = FileOpen($file, 0) 
  $region = False
  While True
    $line = FileReadLine($f)
    If @error == -1 Then ExitLoop
    If StringLeft(StringStripWS($line, 1), 7)=="#Region" Then $region=True
    If not $region Then
      extractStrings($line)
    EndIf
    If StringLeft(StringStripWS($line, 1), 10)=="#EndRegion" Then $region=False
  WEnd
  FileClose($f)
EndFunc

Func parseAllFiles($fileArray)
  For $file in $fileArray
    parseFile($file)
  Next
EndFunc