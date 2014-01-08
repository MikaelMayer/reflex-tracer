#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer

 Script Function:
	Stores all customizable parameters of ReflexRenderer

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include-once
#include "GlobalUtils.au3"

Global $Global_Parameters = emptySizedArray()
Global Enum $PARAM_STRING, $PARAM_DROPDOWN, $PARAM_BOOL, $PARAM_INT
Global Enum $N_PARAM_VANAME, $N_PARAM_TYPE, $N_PARAM_DEFAULTVALUE, $N_PARAM_PRIORITY ; Priority to determine (for useless properties for example)
; Serves to disregard warnings
Global $lang_folder, $bin_dir, $color_out_zooming_box, $color_in_zooming_box, $color_NaN_complex, $animated_zoom, $threshold_zoom_drag, $history_formula_filename, $lucky_func_default, $lucky_frac_default
Global $resolutions_11, $resolutions_43, $resolutions_A4, $resolutions_85, $resolutions_21

push($Global_Parameters, _ArrayCreate("lang_folder",            $PARAM_STRING,      "lang"))
push($Global_Parameters, _ArrayCreate("bin_dir",                $PARAM_STRING,      @ScriptDir&'\Release\'))
push($Global_Parameters, _ArrayCreate("color_out_zooming_box",  $PARAM_DROPDOWN,    "gray.bmp", _ArrayCreate("black.bmp", "gray.bmp")))
push($Global_Parameters, _ArrayCreate("color_in_zooming_box",   $PARAM_DROPDOWN,    "black.bmp", _ArrayCreate("black.bmp", "gray.bmp")))
push($Global_Parameters, _ArrayCreate("color_NaN_complex",      $PARAM_STRING,      "0xFFFFFF"))
push($Global_Parameters, _ArrayCreate("animated_zoom",          $PARAM_BOOL,        True))
push($Global_Parameters, _ArrayCreate("threshold_zoom_drag",    $PARAM_INT,         2))
push($Global_Parameters, _ArrayCreate("history_formula_filename",$PARAM_STRING,     @ScriptDir&"\"&"history_formulas.txt"))
push($Global_Parameters, _ArrayCreate("resolutions_11",  $PARAM_STRING,     "|400x400|800x800|1024x10241280x1280|1640x1640|3280x3280|Custom"))
push($Global_Parameters, _ArrayCreate("resolutions_43",  $PARAM_STRING,     "|640x480|800x600|1024x768|1280x960|1680x1260|3280x2460|Custom"))
push($Global_Parameters, _ArrayCreate("resolutions_A4",  $PARAM_STRING,     "|594x420|800x566|1024x724|1280x905|1640x1160|3280x2319|6560x4638|Custom"))
push($Global_Parameters, _ArrayCreate("resolutions_85",  $PARAM_STRING,     "|640x400|800x500|1024x640|1280x800|1640x1025|3280x2050|Custom"))
push($Global_Parameters, _ArrayCreate("resolutions_21",  $PARAM_STRING,     "|640x320|800x400|1024x512|1280x640|1640x820|3280x1640|Custom"))
push($Global_Parameters, _ArrayCreate("lucky_func_default",     $PARAM_STRING,     "(randf(9)+randh(9))/2"))
push($Global_Parameters, _ArrayCreate("lucky_frac_default",     $PARAM_STRING,     "oo((randf(9)+randh(9))/2, 5)"))


GetParameters()
AssignParameters()

Global $RenderReflexExe = $bin_dir&"RenderReflex.exe"

;Open ini file and read it.
Func GetParameters()
EndFunc

Func AssignParameters()
  For $i=1 To $Global_Parameters[0]
    $tab = $Global_Parameters[$i]
    Assign($tab[$N_PARAM_VANAME], $tab[$N_PARAM_DEFAULTVALUE], 2)
  Next
EndFunc

Func ResetParameter($name)
  For $i=1 To $Global_Parameters[0]
    $tab = $Global_Parameters[$i]
    If $name == $tab[$N_PARAM_VANAME] Then Assign($name, $tab[$N_PARAM_DEFAULTVALUE], 2)
  Next
EndFunc
