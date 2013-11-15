#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           September 24, 2008
 Script Function:
	Contains common functions used in PngHandling.au3 and JpegHandling.au3 for example

#ce ----------------------------------------------------------------------------

#include-once


;Removes $count chars from $string and return them as a string
Func ReadNChars(ByRef $string, $count)
  $chars = StringLeft($string, $count)
  $string = StringMid($string, 1+$count)
  Return $chars
EndFunc

;Removes $count bytes from $hex_string and return them.
Func ReadNBytes(ByRef $hex_string, $count)
  Return ReadNChars($hex_string, 2*$count)
EndFunc

;Removes 1 byte from $hex_string and return it.
Func ReadOneByte(ByRef $hex_string)
  Return ReadNChars($hex_string, 2)
EndFunc

;Removes 2 bytes from $hex_string and return them.
Func ReadTwoBytes(ByRef $hex_string)
  Return ReadNChars($hex_string, 4)
EndFunc

; Removes $count bytes from $hex_string and return the corresponding number.
; Si $intel == True, 1234 => 0x1234, sinon, 1234 => 0x3412
Func ReadNumberOverBytes(ByRef $hex_string, $count, $intel = True)
  $number_string = ""
  While $count > 0
    If $intel Then
      $number_string = ReadOneByte($hex_string) & $number_string
    Else
      $number_string &= ReadOneByte($hex_string)
    EndIf
    $count -= 1
  WEnd
  Return Dec($number_string)
EndFunc

Func ReadAsciiStringOverBytes($hex_string, $count)
  $string = ""
  While $count > 0
    $string &= Chr(Dec(ReadOneByte($hex_string)))
    $count -= 1
  WEnd
  Return $string
EndFunc

Func ToByteArray($hex_string)
  Dim $count = StringLen($hex_string)/2
  Dim $array[$count], $i=0
  While $i < $count
    $n = Dec(StringMid($hex_string, $i*2 + 1, 2))
    $array[$i] = $n
    $i += 1
  WEnd
  Return $array
EndFunc

; Shifts the bits of 32bits $number to the right.
Func BitShiftSigned($number, $dir)
  Local $m = 0x80000000, $m2 = 0x40000000
  If $dir = 0 Then Return $number
  If Not BitAND($m, $number) Then
    Return BitShift($number, $dir)
  Else ; Negative number! Be careful.
    $number = BitXOR($number, $m)
    If $dir > 0 Then
      $number = BitOR(BitShift($number, $dir), BitShift($m2, $dir - 1)) ; Add the remaining 1.
    Else
      $number = BitShift($number, $dir)
    EndIf
    Return $number
  EndIf
EndFunc

Func TransformUnicodeDataToString($unicode_data)
  $result = ""
  While $unicode_data <> ""
    $code = ReadNumberOverBytes($unicode_data, 2)
    If $code == 0 Then ExitLoop
    $result &= ChrW($code)
  WEnd
  Return $result
EndFunc

Func TransformStringToUnicodeData($string)
  $result = ""
  While $string <> ""
    $char = ReadNChars($string, 1)
    $result &= NumberHexInverted(AscW($char), 2)
  WEnd
  $result &= "0000"
  Return $result
EndFunc

Func TransformStringToPngData($string)
  $result = ""
  $string = StringReplace($string, @CRLF, @LF)
  While $string <> ""
    $char = ReadNChars($string, 1)
    $result &= Hex(AscW($char), 2)
  WEnd  
  Return $result
EndFunc

Func NumberHexInverted($number, $n)
  $str = Hex($number, $n * 2)
  $str_inverted = ""
  For $i = 1 To $n
    $str_inverted = StringLeft($str, 2) & $str_inverted
    $str = StringMid($str, 3)
  Next
  Return $str_inverted
EndFunc

Func CopyNBytes($handleFileOriginal, $handleFileCopy, $n)
  ;MsgBox(0,"Bytescopy",$n)
  ;logging("Reading "&$n&" bytes...")
  If $n <> Default Then
    $content = Binary(FileRead($handleFileOriginal, $n))
    ;MsgBox(0,"test",$content)
    ;logging("Copying "&$n&" bytes...")
    if(FileWrite($handleFileCopy, $content)==0) Then
      Return ErrorDecodeAdd("Impossible to copy bytes")
    EndIf
  Else
    While True
      $non_binary_content = FileRead($handleFileOriginal, 1)
      If @error == -1 Then ExitLoop
      $content = Binary($non_binary_content)
      ;MsgBox(0,"test",$content)
      ;jpegDebug("Copying "&$n&" bytes...")
      if(FileWrite($handleFileCopy, $content)==0) Then
        Return ErrorDecodeAdd("Impossible to copy bytes in while loop")
      EndIf
    WEnd
  EndIf
  logging("Copied...")
  Return True
EndFunc

Func FileWriteHex($being_written, $string)
  FileWrite($being_written, Binary("0x"&$string))
EndFunc

