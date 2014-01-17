#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           September 23, 2008
 Script Function:
   Writes/Reads comments from a PNG file.
   Specifications taken from http://www.w3.org/TR/REC-png.pdf

  To read/write in tEXt fields: Title + Software
  To write near the beginning.

  To read: verify CRC at the end. Write: Compute this CRC
  
  100000100110000010001110110110111 => 0x104C11DB7
  
#ce ----------------------------------------------------------------------------

#include-once
#include "GlobalUtils.au3"
#include "ImageHandling.au3"

Global Const $PNG_START = "89504E470D0A1A0A", $PNG_TEXT_TAG = "tEXt", $PNG_END = "IEND"
Global Const $formula_keyword = "Comment", $software_keyword = "Software", $title_keyword = "Title"
Global $crc_table[256], $crc_table_computed = False

;length
;Keyword : 1-79 butes (without NULL char)
;null separator: 1 byte
;tEXt : n bytes (without NULL char). No trailing nor leading whitespace allowed.
;CRC

;$result = PngReflexTags("C:\Documents and Settings\Mikaël\Mes documents\Mes images\Reflex\ReflexRendererMik\comments\Viorangel tree-2.PNG")
;For $i = 1 To $result[0]
;  $tab = $result[$i]
;  logging($tab[0] & " => " & $tab[1])
;Next

Func PngReflexTags($filename)
  $ERROR_DECODE_HANDLING = ""
  Dim $informations = emptySizedArray()
  $reader = FileOpen($filename, 16)
  If $reader <> -1 Then
    If ReadPngReflexTags($reader, $informations) Then
      ;logging("Rien !")
    Else
      ErrorDecodeDisplay()
    EndIf
    ;logging("Fini ! ")
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

Func ReadPngReflexTags($reader, ByRef $informations)
  If Not FileReadOpenPngTag($reader) Then Return False
  Dim $section = _ArrayCreate("NOTIEND")
  While $section[0] <> $PNG_END
    ;logging("section à lire")
    If Not FileReadPngSection($reader, $section) Then Return False
    ;logging("section lue sans encombre:" & $section[0])
    If $section[0] == $PNG_TEXT_TAG Then
      GetReflexInformationsFromPngTextChunk($section, $informations)
    EndIf
  WEnd
  Return True
EndFunc

Func FileReadOpenPngTag($reader)
  $head = FileRead($reader, StringLen($PNG_START)/2)
  If @error <> 0              Then Return ErrorDecodeAdd("Empty file : Error "&@error)
  If $head <> "0x"&$PNG_START Then Return ErrorDecodeAdd("Invalid Png file, begins with "&$head&" instead of "&$PNG_START)
  Return True
EndFunc

Func FileReadPngTagSize($reader, ByRef $size)
  $size_string = FileRead($reader, 4)
  If @error <> 0 Then Return ErrorDecodeAdd("End of file reached while reading section : Error " & @error)
  $size_string = StringMid($size_string, 3)
  $size = ReadNumberOverBytes($size_string, 4, False)
  Return True
EndFunc

Func FileReadPngTagHeader($reader, ByRef $header_hex_string)
  $header_hex_string = FileRead($reader, 4)
  If @error <> 0 Then Return ErrorDecodeAdd("End of file reached while reading section : Error " & @error)
  $header_hex_string = StringMid($header_hex_string, 3)
  Return True
EndFunc

;Returns an array {Section_type, size, content, crc_string]
Func FileReadPngSection($reader, ByRef $section, $external_size_max=1000)
  Local $size = 0, $header, $header_hex_string = ""
  $section = _ArrayCreate(0, 0, "", 0)
  If Not FileReadPngTagSize($reader, $size) Then Return False
  If Not FileReadPngTagHeader($reader, $header_hex_string) Then Return False
  $header = ReadAsciiStringOverBytes($header_hex_string, 4)
  ;logging($header)
  ;Read section and compute CRC at the same time.
  
  Local $verify_crc = ($size < $external_size_max Or StringCompare($header, $PNG_TEXT_TAG, 1) == 0)
  Local $data = "", $crc_string
  
  If $verify_crc Then
    Dim $crc_computing = 0xFFFFFFFF
    $crc_computing = update_crc($crc_computing, ToByteArray($header_hex_string))
    For $i = 1 To $size
      $c = StringMid(FileRead($reader, 1), 3)
      $data &= $c
      $crc_computing = update_crc($crc_computing, _ArrayCreate(Dec($c)))
    Next
    $self_crc = BitXOR($crc_computing, 0xFFFFFFFF)
    $crc_string_aux = StringMid(FileRead($reader, 4), 3)
    $crc_string = $crc_string_aux
    $crc_number = ReadNumberOverBytes($crc_string_aux, 4, False)
    If $self_crc <> $crc_number Then Return ErrorDecodeAdd("CRC is not valid for chunk "&$header&" on this file. Got "&Hex($crc_number)&" instead of calculated "&Hex($self_crc))
  Else
    $data = StringMid(FileRead($reader, $size), 3)
    $crc_string = StringMid(FileRead($reader, 4), 3)
  EndIf  
  $section[0]=$header
  $section[1]=$size
  $section[2]=$data
  $section[3]=$crc_string
  ;logging("Returning section "&toString($section))
  Return True
EndFunc

;$section=[Section_type, size, content, crc_string]
Func GetReflexInformationsFromPngTextChunk(ByRef $section, ByRef $results)
  Local $i, $text = $section[2], $n = StringLen($text) , $keyword, $content
  $i = 1
  For $i = 1 To $n *2-1 Step 2
    If StringMid($text, $i, 2) == "00" Then
      $keyword = ReadAsciiStringOverBytes($text, ($i - 1)/2)
      $content_bytes = StringMid($text, $i + 2)
      $content = ReadAsciiStringOverBytes($content_bytes, StringLen($content_bytes)/2)
      $content = StringAddCR($content)
      push($results, _ArrayCreate($keyword, $content))
      ;logging("One tEXt chunk!=>"&$keyword&":"&$content)
      Return True
    EndIf
  Next
  Return ErrorDecodeAdd("Corrupted tEXt chunk in PNG file: "&$section[0])
EndFunc

;==================== Writing tEXt chunks ===================;

;Dim $sections = _ArrayCreate(1, _ArrayCreate("Title", "My title is good and on "&@CRLF&" several lines"))
;WritePngTextChunks("C:\Documents and Settings\Mikaël\Mes documents\Mes images\Reflex\ReflexRendererMik\comments\Viorangel tree-2.PNG", $sections)

;Writes the XP sections in the file, overwriting those already existing.
Func WritePngTextChunks($file, ByRef $sections)
  $file1 = $file
  $file2 = $file&"copy.png"
  $handleFileOriginal = FileOpen($file1, 0+16)
  $handleFileCopy = FileOpen($file2, 2+16)
  $no_errors = WritePngSectionsBinary($handleFileOriginal, $handleFileCopy, $sections)
  FileClose($handleFileOriginal)
  FileClose($handleFileCopy)
  If $no_errors Then
    ;logging("No errors")
    FileMove($file2, $file1, 1)
  Else
    ;logging("Errors")
    ErrorDecodeDisplay()
    FileDelete($file2)
  EndIf
EndFunc

Func WritePngSectionsBinary($being_read, $being_written, ByRef $sections_to_write)
  Dim $section
  If Not FileReadOpenPngTag($being_read) Then Return ErrorDecodeAdd("No open PNG tag in this file")
  FileWriteHex($being_written, $PNG_START)
  Dim $section = _ArrayCreate("NOTIEND")
  While $section[0] <> $PNG_END
    If Not FileReadPngSection($being_read, $section) Then Return ErrorDecodeAdd("Impossible to read chunk")
    If $section[0] == $PNG_END Then ExitLoop ; PNG_END to be written.
    If $section[0] == $PNG_TEXT_TAG Then
      Local $result = emptySizedArray(), $foundold = 0
      GetReflexInformationsFromPngTextChunk($section, $result)
      $result = $result[1]
      For $i = 1 To $sections_to_write[0]
        $t = $sections_to_write[$i]
        If StringCompare($t[0], $result[0]) == 0 Then
          $foundold = $i
          ExitLoop
        EndIf
      Next
      If $foundold >= 1 Then
        WriteTextSection($being_written, $sections_to_write[$i])
        deleteAt($sections_to_write, $i)
      Else
        WriteSection($being_written, $section) ; Copies the previous section.
      EndIf
    Else
      ;logging("Copying section : "&toString($section))
      WriteSection($being_written, $section) ; Copies the previous section.
    EndIf
  WEnd
  For $i = 1 To $sections_to_write[0]
    WriteTextSection($being_written, $sections_to_write[$i])
  Next
  WriteSection($being_written, $section) ; Contains $PNG_END
  Return True
EndFunc

; $section = [type, size, hex_content, crc_string]
Func WriteSection($being_written, $section)
  ;TODO: Size, header, content, CRC.
  $chunktype = TransformStringToPngData($section[0])
  $chunksize = $section[1]
  $chunkdata = $section[2]
  $chunkcrc  = $section[3]
  FileWriteHex($being_written, Hex($chunksize, 8))
  FileWriteHex($being_written, $chunktype)
  FileWriteHex($being_written, $chunkdata)
  FileWriteHex($being_written, $chunkcrc)
EndFunc

; $section = ["keyword", "content"]
Func WriteTextSection($being_written, $section)
  Local $real_section = _ArrayCreate($PNG_TEXT_TAG, 0, "", 0)
  Local $keyword = $section[0]
  Local $content = $section[1]
  $hex_content = TransformStringToPngData($keyword)&"00"&TransformStringToPngData($content)
  ;logging("Computing CRC on "&TransformStringToPngData($PNG_TEXT_TAG)&$hex_content)
  $crc = Hex(crc(ToByteArray(TransformStringToPngData($PNG_TEXT_TAG)&$hex_content)), 8)
  $real_section[1] = StringLen($hex_content)/2
  $real_section[2] = $hex_content
  $real_section[3] = $crc
  WriteSection($being_written, $real_section)
EndFunc




;================== CRC algorithms =========================;
; Source: http://www.w3.org/TR/REC-png.pdf page 75

make_crc_table()
; Make the table for a fast CRC.
Func make_crc_table()
  Local $c, $n, $k;
  For $n = 0 To 255
    $c = $n;
    For $k = 0 To 7
      if BitAND($c, 1) Then
        $c = BitXOR(0xedb88320, BitShiftSigned($c, 1))
      Else
        $c = BitShiftSigned($c, 1)
      EndIf
    Next
    $crc_table[$n] = $c
  Next
  $crc_table_computed = True;
EndFunc


; Update a running CRC with the bytes buf[0..len-1]-the CRC
; should be initialized to all 1’s, and the transmitted value
; is the 1’s complement of the final running CRC (see the
; crc() routine below)).
Func update_crc($crc, $buf) ;buf = Array<Char>
  Dim $c = $crc, $n, $len = UBound($buf)
  If Not $crc_table_computed Then make_crc_table()
  For $n = 0 To $len - 1
    ;logging(Hex($c)&": "&Hex($buf[$n])&" => "&Hex(BitXOR($c, $buf[$n]))&" => "&Hex(BitAND(BitXOR($c, $buf[$n]), 0xff))&" => "&Hex($crc_table[BitAND(BitXOR($c, $buf[$n]), 0xff)])&" => "& _
;Hex(BitShiftSigned($c, 8))&" => "&Hex(BitXOR($crc_table[BitAND(BitXOR($c, $buf[$n]), 0xff)], BitShiftSigned($c, 8))))
    $c = BitXOR($crc_table[BitAND(BitXOR($c, $buf[$n]), 0xff)], BitShiftSigned($c, 8))
  Next
  return $c
EndFunc

; Return the CRC of the bytes buf[0..len-1].
Func crc($buf)
  Return BitXOR(update_crc(0xffffffff, $buf), 0xffffffff)
EndFunc


