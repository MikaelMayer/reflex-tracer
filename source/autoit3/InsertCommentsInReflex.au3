#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:          13/08/2008

 Script Function:
	Given a formula file, parses it and add comments to all corresponding
    jpeg reflex files.

#ce ----------------------------------------------------------------------------

#include "JpegHandling.au3"

While True
  $files = FileOpenDialog("Open formula files", "", "Formula file (*.txt)|All files (*.*)", 1+4)
  If @error == 1 or $files == "" Then ExitLoop
  ConvertFiles($files)
WEnd

Func ConvertFiles($files)
  $files = StringSplit($files, "|")
  $dir = pop($files) ; Directory
  If $files[0]==0 Then
    ConvertAllJpegReflexInFile($dir)
    Return
  EndIf
  While $files[0]<>0
    $file = pop($files)
    ConvertAllJpegReflexInFile($dir&"\"&$file)
  WEnd
EndFunc

Func ConvertAllJpegReflexInFile($file_path)
  jpegDebug($file_path)
  $f = FileOpen($file_path, 0)
  Dim $line_to_consider = False
  While True
    If not $line_to_consider Then
      $line = FileReadLine($f)
    Else
      $line_to_consider = False
    EndIf
    If @error == -1 Then ExitLoop
    If $line == "" Then ContinueLoop
    $r = reflexFileNameFromComment($line, $file_path, ".jpg")
    If FileExists($r) Then
      $toUpdate = _ArrayCreate($line)
      While True
        $line = FileReadLine($f)
        If @error == -1 Then ExitLoop
        If $line == "" Then ExitLoop
        If FileExists(reflexFileNameFromComment($line, $file_path, ".jpg")) Then
          $line_to_consider = True
          ExitLoop
        EndIf
        _ArrayAdd($toUpdate, $line)
      WEnd
      $string = _ArrayToString($toUpdate, @CRLF)
      AddFormulaInJpegReflexFile($r, $string)
      ;AddFormulaInJpegReflexFile($r, 
    EndIf
  WEnd
  FileClose($f)
EndFunc

Func AddFormulaInJpegReflexFile($jpeg_reflex_file, $formula_and_options)
  Dim $informations = _ArrayCreate(2, _ArrayCreate("title", "Reflex"), _ArrayCreate("comment", $formula_and_options))
  jpegDebug("Going to update: "&$jpeg_reflex_file&" and put"&@CRLF&$formula_and_options)
  WriteXPSections($jpeg_reflex_file, $informations)  
EndFunc