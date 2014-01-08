#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           August 08, 2008
 Script Function:
   Writes/Reads XP comments from a Jpeg file.

#ce ----------------------------------------------------------------------------
#include-once
#include <Array.au3>
#include "GlobalUtils.au3"
#include "ImageHandling.au3"

Global Const $JPEG_DATA_BEGIN = "FFDA", $JPEG_STG_BEGIN = "FFDB", $JPEG_START = "FFD8", $JPEG_END = "FFD9", $JPEG_EXIF_TAG = "FFE1", $XP_COMMENT_START = "9C9C"

;XpExifTags("C:\Documents and Settings\Mikaël\Mes documents\Mes images\Reflex\ReflexRendererMik\comments\Viorangel tree-100.jpg")


; Returns an array A where A[0] is the size,
; and each line A[i] is an array B
; so that B[0] is the type of the extracted field (title, author, comment, keywords, subject) and B[1] is the extracted field
Func XpExifTags($filename)
  $ERROR_DECODE_HANDLING = ""
  Dim $informations = emptySizedArray()
  $reader = FileOpen($filename, 16)
  If $reader <> -1 Then
    If ReadXpExifTags($reader, $informations) Then
    Else
      ErrorDecodeDisplay()
    EndIf
  Else
    If FileExists($filename) Then
      logging("Error while opening file, even if it exists :"&$filename)
    Else
      logging("This file does not exists: "&$filename)
    EndIf
  EndIf
  FileClose($reader)
  Return $informations
EndFunc

;Writes the Xp exif tags into informations
Func ReadXpExifTags($reader, ByRef $informations)
  If Not FileReadOpenJpegTag($reader) Then Return False
  While True
    Dim $section
    If Not FileReadJpegSection($reader, $section) Then Return False
    ;logging("Section read : "&$section[0])
    If $section[0] == $JPEG_END or $section[0] == $JPEG_DATA_BEGIN or $section[0] == $JPEG_STG_BEGIN Then ExitLoop
    If $section[0] == $JPEG_EXIF_TAG Then
      If Not GetXPInformationsFromExifTag($section[1], $section[2], $informations) Then Return ErrorDecodeAdd("Nothing available (neither Title, Comment, nor Author)")
      Return True
    EndIf
  WEnd
  Return True
EndFunc

Func FileReadOpenJpegTag($reader)
  $head = FileRead($reader, 2)
  If @error <> 0                       Then Return ErrorDecodeAdd("Empty file : Error "&@error)
  If String($head) <> "0x"&$JPEG_START Then Return ErrorDecodeAdd("Invalid Jpeg file, begins with "&String($head))
  Return True
EndFunc

;Returns an array {Section_type, size, content]
Func FileReadJpegSection($reader, ByRef $section)
  $section = _ArrayCreate(0, 0, "")
  $head = StringRight(FileRead($reader, 2), 4)
  If @error <> 0 Then Return ErrorDecodeAdd("End of file reached while reading section : Error "&@error)
  $section[0] = $head
  If $head == $JPEG_END Or $head == $JPEG_DATA_BEGIN Or $head == $JPEG_STG_BEGIN Then
    Return True
  EndIf
  $count_string = StringRight(FileRead($reader, 2), 4)
  $count = Dec($count_string)
  If $count <= 1 Then Return ErrorDecodeAdd("Empty section in jpeg file : "&$count_string)
  If $count == 2 Then Return True
  $section[1] = $count - 2
  $data = StringRight(FileRead($reader, $section[1]), $section[1]*2)
  If @error <> 0 Then Return ErrorDecodeAdd("Error while reading data in section : Error "&@error)
  $section[2] = $data
  Return True
EndFunc

Global Const $JPEG_TIFF_TAG = "49492A0008000000", $JPEG_EXIF_STRING = "457869660000"

Func GetXPInformationsFromExifTag($count, $exif_tag, ByRef $informations)
  If Not ReadInExifTag($exif_tag, $JPEG_EXIF_STRING) Then Return ErrorDecodeAdd("Exif tag does not begin with 'Exif'")
  If Not ReadInExifTag($exif_tag, $JPEG_TIFF_TAG) Then Return ErrorDecodeAdd("Exif tag does not have a correct TIFF tag")
  $offset = StringLen($JPEG_TIFF_TAG)/2
  $number_of_fields = ReadNumberOverBytes($exif_tag, 2)
  ;logging("Exif Tag before parsing tags: "&$exif_tag)
  ;logging($number_of_fields&" fields to parse")
  $offset += 2
  If $number_of_fields == 0 Then
    $informations = _ArrayCreate(0)
    Return True
  EndIf
  Dim $field[$number_of_fields]
  For $i = 0 To $number_of_fields - 1
    $current_field = _ArrayCreate("type", "size", "(offset and then )data")
    $type = ReadTwoBytes($exif_tag)
    $current_field[0] = $type
    $number_one = ReadNumberOverBytes($exif_tag, 2)
    If $number_one <> 1 Then Return ErrorDecodeAdd("Weird error: expected 1, got "&$number_one)
    $size = ReadNumberOverBytes($exif_tag, 4)
    $current_field[1] = $size
    If $size > 4 Then
      $offset_local = ReadNumberOverBytes($exif_tag, 4)
      $current_field[2] = $offset_local
    ElseIf $size == 4 Then
      ;The data is directly stored into the header
      $data = TransformUnicodeDataToString(ReadNBytes($exif_tag, 4))
      $current_field[2] = $data
      ;logging("Quick Field found: "&$current_field[0]&" => "&$current_field[1])
    Else
      Return ErrorDecodeAdd("Unexpected size "&$size&" less than 4")
    EndIf
    
    $field[$i] = $current_field
    $offset += 12
  Next
  If Not ReadInExifTag($exif_tag, "00000000") Then Return ErrorDecodeAdd("Zeros missing")
  $offset += 4
  ;logging("Exif Tag before parsing strings: "&$exif_tag)
  For $i = 0 To $number_of_fields - 1
    MaybeDecompressXPData($field[$i], $exif_tag, $offset)
    $current_field = $field[$i]
    ;logging("Field found: "&$current_field[0]&" => "&$current_field[1])
  Next
  $informations = $field
  _ArrayInsert($informations, 0, UBound($informations))
  ;"05 00";5 = number of fields over 2 bytes
  ;"9b 9c 01 00 0c 00 00 00 4a 00 00 00";Title
  ;"9c 9c 01 00 4c 00 00 00 56 00 00 00";Comment
  ;"9d 9c 01 00 0e 00 00 00 a2 00 00 00";Author
  ;"9e 9c 01 00 10 00 00 00 b0 00 00 00";Keywords
  ;"9f 9c 01 00 0c 00 00 00 c0 00 00 00";Subject
  ;TAG(2),1(2),Length(4),Position from the |4949 marker (4)
  ;"00 00 00 00";Start
  ;"74 00 69 00 74 00 72 00 65 00 00 00"
  ;"63 00 6f 00 6d 00 6d 00 65 00 6e 00 74 00 61 00 69 00 72 00 65 00 20 00 72 00 e9 00 63 00 75 00 70 00 e9 00 72 00 e9 00 21 00 0d 00 0a 00 44 00 65 00 75 00 78 00 69 00 e8 00 6d 00 65 00 20 00 6c 00 69 00 67 00 6e 00 65 00 00 00"
  ;"61 00 75 00 74 00 65 00 75 00 72 00 00 00"
  ;"6d 00 6f 00 74 00 63 00 6c 00 65 00 66 00 00 00"
  ;"6f 00 62 00 6a 00 65 00 74 00 00 00"
  ;Titre, commentaire, auteur, mot-clef, objet
  
  ;Si la chaîne peut être incluse dans l'entête (taille de 4 octets), alors elle sera directement incluse sans passer par une référence.
  ;9b 9c 01 00 04 00 00 00 4a 00 00 00 + 00 00 00 00 (contient la lettre directement dans l'entête)
  
  ;logging($exif_tag)
  Return True
EndFunc

Func MaybeDecompressXPData(ByRef $current_field, $exif_tag, $offset)
  $size = $current_field[1]
  If $size > 4 Then
    $offset_local = $current_field[2]
    ;logging("etag : "&$exif_tag)
    ;logging("Offset : "&$offset&", Offset_local : "&$offset_local&", Size : "&$size)
    $string_hex = StringMid($exif_tag, 2*($offset_local - $offset) + 1, $size*2)
    $string = TransformUnicodeDataToString($string_hex)
    $current_field[2] = $string
  EndIf
  $current_field[0] = PutNameOnXPCode($current_field[0])
  _ArrayDelete($current_field, 1)
EndFunc

Global $xpcode_name_map = _ArrayCreate( _
_ArrayCreate("9B9C", "title"), _
_ArrayCreate("9C9C", "comment"), _
_ArrayCreate("9D9C", "author"), _
_ArrayCreate("9E9C", "keywords"), _
_ArrayCreate("9F9C", "subject"))

Func PutNameOnXPCode($xpcode)
  For $mapping in $xpcode_name_map
    If $mapping[0] == $xpcode Then Return $mapping[1]
  Next
  Return "unknown xpcode"
EndFunc

Func PutXPCodeOnName($name)
  For $mapping in $xpcode_name_map
    If $mapping[1] == $name Then Return $mapping[0]
    Next
    logging("Unknown name : "&$name)
  Return "ABCD"
EndFunc
 
Func ReadInExifTag(ByRef $exif_tag, $str)
  If StringCompare(StringLeft($exif_tag, StringLen($str)), $str) <> 0 Then Return ErrorDecodeAdd("No exif_tag")
  $exif_tag = StringMid($exif_tag, StringLen($str) + 1)
  Return True
EndFunc

; ============================== Writing into Reflex jpeg ===========================

;Dim $sections = _ArrayCreate(0)
;WriteXPSections("C:\Documents and Settings\Mikaël\Mes documents\Mes images\Reflex\ReflexRendererMik\comments\Viorangel tree-4.jpg", $sections)

;Writes the XP sections in the file, overwriting those already existing.
Func WriteXPSections($file, ByRef $sections)
  $file1 = $file
  $file2 = $file&"copy.jpg"
  $handleFileOriginal = FileOpen($file1, 0+16)
  $handleFileCopy = FileOpen($file2, 2+16)
  $no_errors = WriteXPSectionsBinary($handleFileOriginal, $handleFileCopy, $sections)
  FileClose($handleFileOriginal)
  FileClose($handleFileCopy)
  If $no_errors Then
    logging("No errors")
    FileMove($file2, $file1, 1)
  Else
    logging("Errors")
    ErrorDecodeDisplay()
    FileDelete($file2)
  EndIf
EndFunc

Func WriteXPSectionsBinary($being_read, $being_written, ByRef $sections)
  Dim $section
  Dim $exif_has_been_replaced = False, $success= True
  If Not FileReadOpenJpegTag($being_read) Then Return ErrorDecodeAdd("No opening Jpeg tag "&$JPEG_START)
  FileWriteHex($being_written, $JPEG_START)
  While True
    If Not FileReadJpegSection($being_read, $section) Then Return ErrorDecodeAdd("Unable to read section")
    ;logging("Section read : "&$section[0])
    If $section[0] == $JPEG_END or $section[0] == $JPEG_DATA_BEGIN or $section[0] == $JPEG_STG_BEGIN Then
      If not $exif_has_been_replaced Then
        $success = SetXpInformationsInExifTag($being_written, $sections)
        $exif_has_been_replaced = True
      EndIf
      FileWriteHex($being_written, $section[0])
      ExitLoop
    EndIf
    ;logging("Comparing "&$section[0]&" to "&$JPEG_EXIF_TAG)
    If $section[0] == $JPEG_EXIF_TAG Then
      Dim $informations = _ArrayCreate(0)
      ;logging("Retrieving informations...")
      If Not GetXPInformationsFromExifTag($section[1], $section[2], $informations) Then Return ErrorDecodeAdd("Impossible to get Xp tags")
      ;logging("Merging informations...")
      MergeInformationsSections($informations, $sections)
      $success = SetXpInformationsInExifTag($being_written, $sections)
      $exif_has_been_replaced = True
    Else
      JpegFileWriteSection($being_written, $section)
    EndIf
  WEnd
  CopyNBytes($being_read, $being_written, Default)
  Return $exif_has_been_replaced and $success
EndFunc

Func MergeInformationsSections(ByRef $informations, ByRef $sections)
  ;logging("Merging...")
  ;Priority of the informations in $section than in $informations.
  For $i = 1 To $informations[0]
    $current_information = $informations[$i]
    Dim $found = False
    For $j = 1 To $sections[0]
      $current_section = $sections[$j]
      If $current_information[0] == $current_section[0] Then
        $found = True
        ExitLoop
      EndIf
    Next
    If Not $found Then
      ;logging("Pushed "&$current_information[0]&" = "&$current_information[1]&" into queue")
      push($sections, $current_information)
    EndIf
  Next
EndFunc

Func SetXpInformationsInExifTag($being_written, $informations)
  $number_of_fields = $informations[0]
  If $number_of_fields == 0 Then Return True
  
  FileWriteHex($being_written, $JPEG_EXIF_TAG)
  
  ;Il mangue la taille, qui sera rajoutée à la fin.
  $string_to_write = $JPEG_EXIF_STRING & $JPEG_TIFF_TAG
  $offset = StringLen($JPEG_TIFF_TAG)/2
  
  $string_to_write &= NumberHexInverted($number_of_fields, 2)
  $offset += 2
  ;Put the offset to beginning of the strings
  $offset += $number_of_fields * 12 + 4
  
  ;Write XP tags
  For $i = 1 To $number_of_fields
    $field = $informations[$i]
    $code = PutXPCodeOnName($field[0])
    If $code == "ABCD" Then
      Return ErrorDecodeAdd("Field not recognized as a code : "&$field[0])
    EndIf
    ;Code of the Xp tag
    $string_to_write &= $code
    $data = TransformStringToUnicodeData($field[1])
    ;Size
    $string_to_write &= "0100"
    $string_to_write &= NumberHexInverted(StringLen($data)/2, 4)
    If(StringLen($data) == 8) Then
      $string_to_write &= $data
    Else
      $string_to_write &= NumberHexInverted($offset, 4)
      $offset += StringLen($data)/2
    EndIf
    $field[1] = $data
    $informations[$i] = $field
  Next
  ;The raw string contents
  $string_to_write &= "00000000"
  For $i = 1 To $number_of_fields
    $field = $informations[$i]
    $data = $field[1]
    If StringLen($data) > 8 Then
      $string_to_write &= $data
    EndIf
  Next
  ;+2 Because the size itself it counted for the length of the tag
  $string_to_write = Hex(StringLen($string_to_write)/2+2, 4) & $string_to_write
  FileWriteHex($being_written, $string_to_write)
  Return True
EndFunc

Func JpegFileWriteSection($being_written, $section)
  ;section[0] == Tag without 0x
  ;section[1] == Size
  ;Section[2] == Data
  FileWriteHex($being_written, $section[0])
  FileWriteHex($being_written, Hex($section[1]+2, 4))
  FileWriteHex($being_written, $section[2])
EndFunc