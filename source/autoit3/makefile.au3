#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer

 Script Function:
  Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <Array.au3>
#include "GlobalUtils.au3"
$zip_file = "Versions\ReflexRenderer"&$VERSION_NUMER&".zip"

$folderout = "Versions\ReflexRenderer"&$VERSION_NUMER
increase_version_number()
$filescript1 = "ReflexRenderer.au3"
$filescript2 = "LoadFormulaFromFile.au3"
$filescript3 = "AboutBox.au3"
$filescript4 = "SaveBox.au3"
$filescript6 = "EditFormula.au3"
$filescript5 = "IniHandling.au3"
$filescript7 = "translations.au3"
$filescript8 = "JpegHandling.au3"
$filescript9 = "RenderVideo.au3"
$filescript10= "RenderVideoIniConfig.au3"

$filescript9_exploded = "RenderVideoExploded.au3"

$filebinout  = $folderout&"\ReflexRenderer.exe"
$fileini     = "ReflexRenderer.ini"
$filereadme  = "Readme.txt"
$filebin     = "Release\RenderReflex.exe"
$filenoir    = "Release\black.bmp"
$filegris    = "Release\gray.bmp"
$fileimg    =  "Release\nice_function.jpg"
$fileico    =  "Release\nice_function.ico"
$filecolcod =  "Release\RenderCodeColor.JPG"
$filecolico =  "Release\RenderCodeColor.ico"

$dirtrad    = "lang"

$dependencies = _ArrayCreate($filescript1)
_ArrayAdd($dependencies, $filescript2)
_ArrayAdd($dependencies, $filescript3)
_ArrayAdd($dependencies, $filescript4)
_ArrayAdd($dependencies, $filescript5)
_ArrayAdd($dependencies, $filescript6)
_ArrayAdd($dependencies, $filescript7)
_ArrayAdd($dependencies, $filescript8)
_ArrayAdd($dependencies, $filescript9)
_ArrayAdd($dependencies, $filescript10)
;_ArrayAdd($dependencies, $filetrad)
;_ArrayAdd($dependencies, $filetrad_en)
_ArrayAdd($dependencies, $fileini)
_ArrayAdd($dependencies, $filereadme)
_ArrayAdd($dependencies, $filebin)
_ArrayAdd($dependencies, $filenoir)
_ArrayAdd($dependencies, $filegris)
_ArrayAdd($dependencies, $fileimg)
_ArrayAdd($dependencies, $fileico)
_ArrayAdd($dependencies, $dirtrad)
_ArrayAdd($dependencies, $filecolcod)
_ArrayAdd($dependencies, $filecolico)

;$fileini, _
$tocopy =  _ArrayCreate($filebin)
_ArrayAdd($tocopy, $filecolico)
_ArrayAdd($tocopy, $filereadme)
_ArrayAdd($tocopy, $filenoir)
_ArrayAdd($tocopy, $filegris)
_ArrayAdd($tocopy, $fileimg)
_ArrayAdd($tocopy, $filecolcod)
_ArrayAdd($tocopy, $filecolico)
;$filetrad_en, _
;$filetrad)

$dirtocopy = _ArrayCreate($dirtrad)

$initocopy = _ArrayCreate($fileini)

assertAllFilesExist($dependencies)
If Not FileExists($folderout) Then
  DirCreate($folderout)
EndIf

RunWait('"'&@AutoItExe&'" "'&@ScriptDir&'\ExplodeIncludes.au3"'); Creates RenderVideoExploded.au3

$Aut2Exe = StringReplace(@AutoItExe, "AutoIt3.exe", "Aut2Exe\Aut2Exe.exe")
$cmd = StringFormat('%s /in "%s" /out "%s" /icon "%s" /nopack', $Aut2Exe, @ScriptDir&'\'&$filescript1, @ScriptDir&'\'&$filebinout, @ScriptDir&'\'&$fileico)
;MsgBox(0, "", $cmd)
RunWait($cmd)
copyAllMissingIniConfig($initocopy, $folderout)
copyAllFiles($tocopy, $folderout)
copyAllDirectories($dirtocopy, $folderout)
compressAll($folderout, $zip_file)
updateDropBox(@ScriptDir&"\"&$zip_file)

Func assertFileExists($filename)
  If FileExists($filename)== 0 Then
    MsgBox(0, "Erreur", "The file '"&$filename&"' does not exist but is required!"&@CR&"Cancelling compilation process...")
    Exit
  EndIf
EndFunc

Func assertAllFilesExist($listfilename)
  For $filename In $listfilename
    assertFileExists($filename)
  Next
EndFunc

Func copyAllFiles($arrayFiles, $folder)
  For $filename In $arrayFiles
    FileCopy($filename, $folder&"\"&$filename, 9)
  Next
EndFunc

Func copyAllDirectories($arrayDirs, $folder)
  For $dirname In $arrayDirs
    DirCopy($dirname, $folder&"\"&$dirname, 1)
    DirRemove($folder&"\"&$dirname&"\.svn", 1)
  Next
EndFunc

Func copyAllMissingIniConfig($arrayIniFiles, $folder)
  Return
  $default_string = "/\/\/%ùl^^*"
  For $iniFilename In $arrayIniFiles
    $other_iniFilename = $folder&"\"&$iniFilename
    $sectionNames = IniReadSectionNames($iniFilename)
    toBasicArray($sectionNames)
    For $sectionName In $sectionNames
      $section = IniReadSection($iniFilename, $sectionName)
      If @error == 1 Then
        logging("Unable to read sections of "&$iniFilename&" on "&$sectionName)
      EndIf
      For $i = 1 To $section[0][0]
        If IniRead($other_iniFilename, $sectionName, $section[$i][0], $default_string) == $default_string Then
          IniWrite($other_iniFilename, $sectionName, $section[$i][0], $section[$i][1])
          logging("Written to "&$sectionName&" : "&$section[$i][0]&" = " & $section[$i][1])
        EndIf
      Next
    Next
  Next
EndFunc

Func compressAll($folderout, $zip_file)
  Local $cmd = "zip.exe -r """&$zip_file&""" """&$folderout&""""
  RunWait($cmd)
  Return
EndFunc

Func updateDropBox($path_zip_file)
  Local $base_folder = "C:\Documents and Settings\Mikaël\Mes documents\My Dropbox\Reflex\Reflex Tracer"
  Local $base_folder_old = $base_folder&"\old\"
  Local $save_working_dir = @WorkingDir
  FileChangeDir($base_folder)
  $search = FileFindFirstFile("Reflex*.zip")
  ; Check if the search was successful
  While 1
      $file = FileFindNextFile($search)
      If @error Then ExitLoop
      logging("File moved : "&$file&" to "&$base_folder_old)
      FileMove($file, $base_folder_old, 8+1)
  WEnd
  FileCopy($path_zip_file, $base_folder)
  ; Close the search handle
  FileClose($search)
  ; Move all versions to the "old" folder
  FileChangeDir($save_working_dir)
EndFunc

Func increase_version_number()
  Local $globalutils = "GlobalUtils.au3"
  $content = FileRead($globalutils)
  StringRegExp('Global Const $VERSION_NUMER = "2.8.14 beta"', 'VERSION_NUMER = "(\d)\.(\d)\.(\d+)', 2)
  $versions = StringRegExp($content, 'VERSION_NUMER = "(\d)\.(\d)\.(\d+)', 2)
  $versions[3] = Int($versions[3]) + 1
  $content = StringReplace($content, $versions[0], 'VERSION_NUMER = "'&$versions[1]&'.'&$versions[2]&'.'&$versions[3])
  FileDelete($globalutils)
  FileWrite($globalutils, $content)
EndFunc
