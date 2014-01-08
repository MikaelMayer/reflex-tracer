#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         Mikaël Mayer
 Date:           2009.XX.XX

 Script Function:


#ce ----------------------------------------------------------------------------


; *** Start added by AutoIt3Wrapper ***
#include <WindowsConstants.au3>
; *** End added by AutoIt3Wrapper ***
#AutoIt3Wrapper_Add_Constants=n
Global Const $WM_ENTERSIZEMOVE = 0x231, $WM_EXITSIZEMOVE = 0x232


$gp = GUICreate("main gui", 300, 300, 200, 200)
GUISetState()
$gs = GUICreate("dragged gui", 200, 150, 400, 400)
GUISetState()


Global $RelPos[2]
GUIRegisterMsg($WM_ENTERSIZEMOVE, "setrelpos")
GUIRegisterMsg($WM_MOVE, "followme")

While 1
    If GUIGetMsg() = -3 Then Exit
WEnd

Func followme($hW, $iM, $wp, $lp)

    If $hW <> $gp Then Return

    Local $xypos = WinGetPos($gp);use WingetPos rather than the values in $lP
    WinMove($gs, "", $xypos[0] - $RelPos[0], $xypos[1] - $RelPos[1])

EndFunc ;==>followme


;When the primary window starts moving we want to know the relative position of the secondary window.
Func SetRelPos($hW, $iM, $wp, $lp)

    If $hW <> $gp Then Return

    Local $gpp = WinGetPos($gp)
    Local $gsp = WinGetPos($gs)

    $RelPos[0] = $gpp[0] - $gsp[0]
    $RelPos[1] = $gpp[1] - $gsp[1]


EndFunc ;==>SetRelPos
