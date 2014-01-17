#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2009/01/11

 Script Function:
    Another Main script, to be compiled apart.
	Given an ini file, renders a video.


Wish list:
- Which frames we are rendering?
- Remaining time + finish time

- Custom button language
- Cancel button while rendering
- Output errors if there are some and stop to render the script.
- Align the "=" signs in the config file

#ce ----------------------------------------------------------------------------

#include-once
#include "GlobalUtils.au3"
#include "translations.au3"
#include "JpegHandling.au3"
#include "PngHandling.au3"
#include "RenderVideoIniConfig.au3"
#include <Math.au3>
#Include <File.au3>
Global $lines

$RenderReflexExe = "RenderReflex.exe";@TempDir&"\RenderReflex.exe"

FileInstall("Release\RenderReflex.exe", $RenderReflexExe, 1)

Func OnAutoItExit()
  FileDelete($RenderReflexExe)
EndFunc

Global Enum $INI_N_VARNAME, $INI_N_SECTION, $INI_N_SECTIONVAR, $INI_N_DEFAULT
Global Const $TOCALCULATE_STRING = "TOCALC"
Global Const $WAIT_CYCLE = 250

Global $ini_file = getIniFile()
;Global $ini_file = "C:\Documents and Settings\Mikaël\Mes documents\Mes images\Reflex\Videos\TestI\Test1.ini"
Global $total_of_frames = 0 ; Set up in ConvertAndCheckEverything()
Global $video_framestorender = ""

Global $ini_video_parameters = emptySizedArray()
Global $video_formula, $video_varname, $video_startvalue, $video_endvalue, $video_startframe, $video_lastframe, $video_numframes, $video_framestorender, $video_inclastframe, $video_output_model, $video_output_type, $image_width, $image_height, $image_winmin, $image_winmax, $image_colornan
push($ini_video_parameters, _ArrayCreate("video_formula", $INI_VIDEO, $INI_VIDEO_FORMULA, ""))
push($ini_video_parameters, _ArrayCreate("video_varname", $INI_VIDEO, $INI_VIDEO_VARNAME, ""))
push($ini_video_parameters, _ArrayCreate("video_startvalue", $INI_VIDEO, $INI_VIDEO_STARTVALUE, ""))
push($ini_video_parameters, _ArrayCreate("video_endvalue", $INI_VIDEO, $INI_VIDEO_ENDVALUE, ""))
push($ini_video_parameters, _ArrayCreate("video_startframe", $INI_VIDEO, $INI_VIDEO_STARTFRAME, "0"))
push($ini_video_parameters, _ArrayCreate("video_lastframe", $INI_VIDEO, $INI_VIDEO_LASTFRAME, $TOCALCULATE_STRING))
push($ini_video_parameters, _ArrayCreate("video_numframes", $INI_VIDEO, $INI_VIDEO_NUMFRAMES, $TOCALCULATE_STRING))
push($ini_video_parameters, _ArrayCreate("video_framestorender", $INI_VIDEO, $INI_VIDEO_RENDEREDFRAMES, $TOCALCULATE_STRING))

push($ini_video_parameters, _ArrayCreate("video_inclastframe", $INI_VIDEO, $INI_VIDEO_INCLASTFRAME, "1"))
push($ini_video_parameters, _ArrayCreate("video_output_model", $INI_VIDEO, $INI_VIDEO_OUTPUT_MODEL, ""))
push($ini_video_parameters, _ArrayCreate("video_output_type", $INI_VIDEO, $INI_VIDEO_OUTPUT_TYPE, ""))

push($ini_video_parameters, _ArrayCreate("image_width", $INI_IMAGE, $INI_IMAGE_WIDTH,   "401"))
push($ini_video_parameters, _ArrayCreate("image_height", $INI_IMAGE, $INI_IMAGE_HEIGHT,  "401"))
push($ini_video_parameters, _ArrayCreate("image_winmin", $INI_IMAGE, $INI_IMAGE_WINMIN,  "-4-4i"))
push($ini_video_parameters, _ArrayCreate("image_winmax", $INI_IMAGE, $INI_IMAGE_WINMAX,  "4+4i"))
push($ini_video_parameters, _ArrayCreate("image_colornan", $INI_IMAGE, $INI_IMAGE_COLORNAN, "0xFFFFFF"))

Global $percent = 0
Global $maintext = "Rendering video "
Global $subtext = "Rendering video, please wait."&@CRLF&"CTRL+SHIFT+ALT+E : cancel/exit, CTRL+SHIFT+ALT+P : pause/resume"
Global $subtext_pause = "Rendering paused."&@CRLF&"CTRL+SHIFT+ALT+E : cancel/exit, CTRL+SHIFT+ALT+P : pause/resume"
Global $state_rendering = True

HotKeySet("^+!e", "RenderVideoExit")
HotKeySet("^+!p", "RenderVideoPauseResume")

main()
Exit

Func main()
  If Not AssignVideoParameters($ini_file, $ini_video_parameters) Then
    $ini_file = getIniFile(True)
    If Not AssignVideoParameters($ini_file, $ini_video_parameters) Then
      Return
    EndIf
  EndIf
  If Not ConvertAndCheckEverything() Then Return
  RenderVideo()
EndFunc

Func RenderVideoPauseResume()
  If $state_rendering Then
    $state_rendering = False
    ProgressSet($percent, $subtext_pause, $maintext&$percent&"%")
  Else
    $state_rendering = True
    ProgressSet($percent, $subtext, $maintext&$percent&"%")
  EndIf
EndFunc
Func RenderVideoExit()
  Exit
EndFunc

Func RenderVideo()
  $n = getNumberOfProcessors()
  Local $thread_pid     = emptySizedArray()      ; PID array
  Local $thread_output  = emptySizedArray()      ; output array
  ;Local $thread_custom_output  = emptySizedArray()      ; output array
  Local $thread_formula = emptySizedArray()      ; Formula array

  ;We launch as many rendering as there are available processors.
  Local $list_frames_to_render = $video_framestorender
  Local $done = 0

  ProgressOn($maintext, $maintext, $subtext, Default, Default, 16); +2 if not on top wanted.
  ProgressSet(0)

  While Not ($list_frames_to_render = "" and size($thread_pid) = 0)
    While size($thread_pid) == $n Or ($list_frames_to_render = "" And size($thread_pid) > 0)
      $i = 1
      While $i <= size($thread_pid)
        While Not $state_rendering
          Sleep(1000)
        WEnd
        If ProcessWaitClose($thread_pid[$i], 1) Then
          $done += 1
          $percent = Int(100 * $done / $total_of_frames)
          ProgressSet($percent, $subtext, $maintext&$percent&"%")
          Local $formula = getFormulaFromPid($thread_pid[$i])
          $output  = $thread_output[$i]
          If $formula == "" Then
            $formula = $thread_formula[$i]
            If StringInStr($formula, "randf") <> 0 Or StringInStr($formula, "randh") <> 0 Then
              FileWrite("Error_log.txt", "Unable to read formula from :"&@CRLF&$lines&@CRLF)
              FileWrite("Error_log.txt", "Remaining output :"&@CRLF&StdoutRead($thread_pid[$i]))
              postTreatment($output, $formula)
              Exit
            EndIf
          EndIf
          postTreatment($output, $formula)

          deleteAt($thread_pid, $i)
          deleteAt($thread_formula, $i)
          deleteAt($thread_output, $i)
        Else
          $i += 1
        EndIf
      WEnd
    WEnd
    If $list_frames_to_render <> "" Then
      ;logging("la:"&$list_frames_to_render)
      $frame = popFrameNumber($list_frames_to_render)
      ;logging("lp:"&$list_frames_to_render)

      $formula = getFormulaForFrame($frame)
      $output = getOutputForFrame($frame)
      If Not FileExists(FileGetDir($output)) Then
        DirCreate(FileGetDir($output))
      EndIf
      ;$custom_output = getCustomOutputForFrame($frame) ; Contains the true extension
      ;logging("computing formula "&$formula&" at frame "&$frame)

      $cmd = getRenderingCommandForFormulaOutput($formula, $output)

      $pid = Run($cmd, "", @SW_HIDE, 0x2)
      push($thread_pid, $pid)
      push($thread_formula, $formula)
      push($thread_output, $output)
      ;push($thread_custom_output, $custom_output)
    EndIf
  WEnd
  ProgressOff()
  Return
EndFunc


; For input "4-100;14;2,1" returns 4 and set up the entry variable to "5-100;14;2;1"
; For input "99-100;14;2,1" returns 99 and set up the entry variable to "100;14;2;1"
; For input "100;14;2,1" returns 100 and set up the entry variable to "14;2;1"
; For input "1" returns 1 and set up the entry variable to ""
Func popFrameNumber(ByRef $list_frames_to_render)
  Local $result
  $remaining = StringSplit($list_frames_to_render, ",;")
  For $i = 1 To $remaining[0]
    $torender = $remaining[$i]
    $delimiters = StringSplit($torender, "-")
    If $delimiters[0] == 1 Then
      $result = Int(pop($remaining))
      If $remaining[0] == 0 then
        $list_frames_to_render = ""
      Else
        toBasicArray($remaining)
        $list_frames_to_render = _ArrayToString($remaining, ";")
      EndIf
      Return $result
    EndIf
    If $delimiters[0] == 2 Then
      $result = Int($delimiters[1])
      $after = Int($delimiters[2])
      If $result + 1 = $after Then
        $remaining[$i] = ""&$after
      Else
        $remaining[$i] = ($result+1)&"-"&$after
      EndIf
      toBasicArray($remaining)
      $list_frames_to_render = _ArrayToString($remaining, ";")
      Return $result
    EndIf
  Next
  failWith("Unable to locate next frame to render in sequence"&@CRLF&$list_frames_to_render)
  Exit
EndFunc

Func ConvertAndCheckEverything()
  $video_startvalue = Number($video_startvalue)
  $video_endvalue   = Number($video_endvalue)
  $video_startframe = Int($video_startframe)

  If $video_lastframe = $TOCALCULATE_STRING Then
    If $video_numframes = $TOCALCULATE_STRING Then
      Return failwith("You have to specify one of the keys '"&$INI_VIDEO_LASTFRAME&"' or '"&$INI_VIDEO_NUMFRAMES&"' in section "&$INI_VIDEO)
    EndIf
    $video_numframes = Int($video_numframes)
    $video_lastframe = $video_startframe + $video_numframes - 1
  Else
    $video_lastframe  = Int($video_lastframe)
  EndIf
  If $video_numframes = $TOCALCULATE_STRING Then
    $video_numframes = $video_lastframe - $video_startframe + 1
  EndIf


  $video_numframes  = Int($video_numframes)

  If $video_lastframe - $video_startframe + 1 <> $video_numframes Then
    Return failWith("The number of frames given by start("&$video_startvalue&"), last("&$video_lastframe&") and num of frames("&$video_numframes&") are not coherent.")
  EndIf

  If $video_framestorender = $TOCALCULATE_STRING Then
    $video_framestorender = $video_startframe&"-"&$video_lastframe
  EndIf

  $video_framestorender_arrray = StringSplit($video_framestorender, ",;")

  ;Checks the format like 15-19;3,5,6 of the frames to render.
  For $i = 1 To $video_framestorender_arrray[0]
    $torender = $video_framestorender_arrray[$i]
    $delimiters = StringSplit($torender, "-")
    $frame_previous = -1
    For $j = 1 To $delimiters[0]
      $frame = Int($delimiters[$j])
      If $frame <= $frame_previous Or $frame > $video_lastframe Or $frame < $video_startframe Then
        Return failWith("The frame "&$frame&" to be rendered is not valid")
      EndIf
      If $frame_previous <> -1 and $delimiters[0] = 2 Then
        $total_of_frames += $frame - $frame_previous + 1
      ElseIf $delimiters[0] = 1 Then
        $total_of_frames += 1
      EndIf
      $frame_previous = $frame

    Next
  Next
  Return True
EndFunc

;Returns True if all required variables were set
Func AssignVideoParameters($ini_file, $ini_video_parameters)
  Local $errors = emptySizedArray()
  If $ini_file == "" Then
    push($errors, "No *.ini file specified. Exactly one is needed to render the video")
  Else
    For $i = 1 To $ini_video_parameters[0]
      $tab = $ini_video_parameters[$i]
      $varname = $tab[$INI_N_VARNAME]

      $section = $tab[$INI_N_SECTION]
      $sectionvar = $tab[$INI_N_SECTIONVAR]
      $default = $tab[$INI_N_DEFAULT]

      $value = IniRead($ini_file, $section, $sectionvar, $default)
      ;logging("new value:"&$value)
      If $value == "" Then
        push($errors, "Missing required field "&$section&">"&$sectionvar&" in "&FileBaseName($ini_file))
      EndIf
      Assign($varname, $value, 2)
    Next
  EndIf
  If size($errors)>0 Then
    toBasicArray($errors)
    MsgBox(0, "Errors while generating", _ArrayToString($errors, @CRLF)&@CRLF&@CRLF&"If you remove this ini file, this programm will automatically generate a new correct one.")
    Return False
  EndIf
  Return True
EndFunc

Func failWith($msg)
  MsgBox(0, "Error", $msg)
  Return False
EndFunc

Func FileGetDir($file)
  Dim $szDrive, $szDir, $szFName, $szExt
  $TestPath = _PathSplit($file, $szDrive, $szDir, $szFName, $szExt)
  Return $szDrive&$szDir
EndFunc

Func getFormulaForFrame($frame)
  Local $varvalue
  If $video_lastframe == $video_startframe Then
    $varvalue = $video_startvalue
  Else
    $part = ($frame - $video_startframe) / ($video_lastframe - $video_startframe)
    $varvalue = complex_calculate(StringFormat("%s*(%s)+%s*(%s)", 1-$part, $video_startvalue, $part, $video_endvalue))
  EndIf
  $formula = replaceVariableString($video_formula, $video_varname, $varvalue)
  Return $formula
EndFunc

Func getOutputForFrame($frame)
  Return ReplaceSharpsByValue($video_output_model, $frame, $video_lastframe)&".bmp"
EndFunc

Func getRenderingCommandForFormulaOutput($formula, $output)
  Local $flags = ""
  addFlag($flags, "render")
  addFlag($flags, "formula", $formula)
  addFlag($flags, "width", $image_width)
  addFlag($flags, "height", $image_height)
  addFlag($flags, "winmin", $image_winmin)
  addFlag($flags, "winmax", $image_winmax)
  addFlag($flags, "color_nan", $image_colornan)

  addFlag($flags, "output", $output)
  addFlag($flags, "seed", String(Random(0, 2147483647, 1)))

  $cmd = @ScriptDir&"\"&$RenderReflexExe&" "&$flags
  ;logging($cmd)

  Return $cmd
EndFunc

Func getFormulaFromPid($pid)
  Local $formula = ""
  Global $lines = ""

  Do
    $lines = $lines & StdoutRead($pid)
  Until @error and Not ($lines == "") ; End of File reached.

  $lines_array = StringSplit($lines, @LF)
  For $i = 1 To $lines_array[0]
    If StringStartsWith($lines_array[$i], 'formula:') Then
      $formula = StringStripWS(StringMid($lines_array[$i], 9),1+2)
      ExitLoop
    EndIf
  Next
  Return $formula
EndFunc


Func formula_and_options($formula)
  Local $options = emptySizedArray()

  push($options, 'winmin='&$image_winmin)
  push($options, 'winmax='&$image_winmax)
  push($options, 'width='&$image_width)
  push($options, 'height='&$image_height)
  toBasicArray($options)
  $options_string = _ArrayToString($options, "; ")

  Return $formula&@CRLF&$options_line_string&$options_string
EndFunc

; Checks output format, adds informations inside the image
Func postTreatment($output, $formula)
  If StringCompare($video_output_type, "bmp") <> 0 Then
    $output_with_extension = StringReplace($output, ".bmp", "."&StringLower($video_output_type))
    ImageConvert($output, $output_with_extension)
    If Not FileExists($output_with_extension) Then
      failWith("Failed to convert from"&@CRLF&$output&@CRLF&"to"&@CRLF&$output_with_extension&@CRLF&"Script cancelled")
      Exit
    EndIf
    FileDelete($output)

    $isJpeg = StringEndsWith($output_with_extension, '.jpeg') Or StringEndsWith($output_with_extension, '.jpg')
    $isPng =  StringEndsWith($output_with_extension, '.png')

    If $isJpeg Then
      $formula_and_options = formula_and_options($formula)
      Dim $informations = _ArrayCreate(2, _ArrayCreate("title", "Reflex"), _ArrayCreate("comment", $formula_and_options))
      WriteXPSections($output_with_extension, $informations)
    ElseIf $isPng Then
      $formula_and_options = formula_and_options($formula)
      Dim $informations = _ArrayCreate(3, _ArrayCreate("Title", "Reflex"), _ArrayCreate("Comment", $formula_and_options), _ArrayCreate("Software", "ReflexRenderer v."&$VERSION_NUMER))
      WritePngTextChunks($output_with_extension, $informations)
    EndIf
  EndIf
EndFunc

; Input ("myfile####", 15, 120) output "myfile0015"
; Input ("myfile##", 115, 1200) output "myfile0115"
Func ReplaceSharpsByValue($file, $number, $max)
  StringReplace($file, '#', "")
  $size_sharps = @extended
  $size_max = StringLen(""&$max)

  ;We keep only one sharp
  If $size_sharps >= 2 Then
    $file = StringReplace($file, '#', "", $size_sharps - 1)
  EndIf

  $size_number = _Max($size_sharps, $size_max)
  $number_sized = ""&$number
  While StringLen($number_sized) < $size_number
    $number_sized = "0"&$number_sized
  WEnd

  If $size_sharps == 0 Then
    Return $file&$number_sized
  Else
    Return StringReplace($file, '#', $number_sized)
  EndIf
EndFunc

;Gets the ini file that will be used to generate all the processes.
Func getIniFile($force_choose=False)
  ;Either by argument
  Local $ini_file = ""
  If $CmdLine[0] > 0 and Not $force_choose Then
    Local $arg_provided = $CmdLine[1]
    If FileExists($arg_provided) Then
      If StringEndsWith($arg_provided, ".ini") Then
        $ini_file = $arg_provided
      EndIf
    EndIf
  EndIf
  ;Or by FileDialog
  If $ini_file == "" or $force_choose Then
    ;TODO:Find itself the first ini file in this directory
    $search = FileFindFirstFile("*.ini")
    $default = FileFindNextFile($search)
    If @error <> 0 and not $force_choose Then
      FileInstall("___INI_VIDEO_FULLFILE___", "___INI_VIDEO_FILE_BASENAME___")
      Return "___INI_VIDEO_FILE_BASENAME___" ; No file terminating with *.ini, so we install the one that we contains
    Else
      FileFindNextFile($search)
      If @error <> 0 and Not $force_choose Then ; Only one file, we take it without asking.
        Return $default
      EndIf
    EndIf
    FileClose($search)
    $result = FileOpenDialog("Render Video ini file", @ScriptDir, "ini file (*.ini)|All files (*.*)", 1, $default)
    FileChangeDir(@SCriptDir)
    If @error = 1 Then Exit
    FileChangeDir(@ScriptDir)
    $ini_file = $result
  EndIf

  Return $ini_file
EndFunc
