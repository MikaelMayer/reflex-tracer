#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         Mikaël Mayer
 Date:           2010.01.06

 Script Function:


#ce ----------------------------------------------------------------------------

HotKeySet("{F7}", "convert")
HotKeySet("+{F7}", "relaunch")
normalStatus()

While True
  Sleep(1000)
WEnd

Func normalStatus()
  ToolTip("Waiting for {F7} to convert caml formula to normal.", 0, 0)
EndFunc

Func convert()
  ClipPut("___")
  $p = ClipGet()
  Send("^c")
  Sleep(500)
  $f = ClipGet()
  If $f == "" or $f == "___" Then
    ToolTip("Nothing in clipboard nor selected.", 0, 0)
    Sleep(1000)
    normalStatus()
    Return
  EndIf

  $f = StringRegExpReplace($f, "\r|\n", "")
  $f = StringReplace($f, "pluscplx", "+")
  $f = StringReplace($f, "sincplx", "sin")
  $f = StringReplace($f, "coscplx", "cos")
  $f = StringReplace($f, "coshcplx", "cosh")
  $f = StringReplace($f, "sinhcplx", "sinh")
  $f = StringReplace($f, "tancplx", "tan")
  $f = StringReplace($f, "tanhcplx", "tanh")
  $f = StringReplace($f, "foiscplx", "*")
  $f = StringReplace($f, "divcplx", "/")
  $f = StringReplace($f, "moinscplx", "-")
  $f = StringReplace($f, "moincplx", "-")
  $f = StringReplace($f, "puissance", "^")
  $f = StringReplace($f, "exposant", "^")
  $f = StringReplace($f, "expocplx", "exp")
  $f = StringReplace($f, "realcplx", "real")
  $f = StringReplace($f, "conjcplx", "conj")
  $f = StringReplace($f, "imagcplx", "imag")
  $f = StringReplace($f, "imag2", "i*imag")
  $f = StringReplace($f, "invscplx", "1/")
  $f = StringReplace($f, "rfoicplx", "*")
  $f = StringReplace($f, "*.", "*")
  $f = StringReplace($f, "+.", "+")
  $f = StringReplace($f, "-.", "-")
  $f = StringReplace($f, "/.", "/")
  $f = StringReplace($f, "I", "i", 0, 1)
  $f = StringReplace($f, "UN", "1", 0, 1)
  $f = StringReplace($f, "J", "j", 0, 1)
  $f = StringReplace($f, "modulecplx (", "o(sqrt(z*conj(z)),")
  $f = StringReplace($f, "unitaire (", "o(z/sqrt(z*conj(z)),")
  $f = StringReplace($f, "cercle", "circle")

  If StringInStr($f, "tracerfonction") and StringInStr($f, ";;") Then
    If StringInStr($f, "tracerfonction (oo 5 (fun z->") Then
      $f = StringReplace($f, "tracerfonction (oo 5 (fun z->", "oo(")
      $f = StringReplace($f, "));;", ",5)")
    Else
      $f = StringReplace($f, "tracerfonction (fun z->", "")
      $f = StringReplace($f, ");;", "")
    EndIf
  EndIf
  $f = replaceBySuffix($f, "au_carré", "^2")
  $f = replaceBySuffix($f, "argumentcplx", ")", "imag(ln")
  $f = replaceBySuffix($f, "circle2", ")", "conj(circle")
  $f = replaceBySuffix($f, "au_cube", "^3")
  $f = replacePuiscplx($f)
  $f = replaceComplexNumbers($f)
  $f = StringReplace($f, "real z", "x")
  $f = StringReplace($f, "imag z", "y")

  $f = StringStripWS($f, 8)
  ClipPut($f)
  Send("^v")
  ToolTip($f, 0, 0, "Conversion done")
  Sleep(1000)
  normalStatus()
EndFunc

Func relaunch()
  ToolTip("Relaunching ...", 0, 0)
  HotKeySet("{F8}")
  HotKeySet("+{F8}")
  Sleep(1000)
  Run('"'&@AutoItExe&'" "'&@ScriptFullPath&'"')
  Exit
EndFunc

Func replaceBySuffix($f, $prefix, $suffix, $prefix_replaced="")
  While StringInStr($f, $prefix)
    $s1 = StringInStr($f, $prefix)+StringLen($prefix)+1
    ; au_carré ( .... )  => ( .... )^2
    $s2 = getMatchingParenthesis($f, $s1)
    If $s2 == -1 Then ExitLoop
    $f = StringReplace(StringMid($f, 1, $s1), $prefix, $prefix_replaced)&SubString($f, $s1+1, $s2-1)&")"&$suffix&StringMid($f, $s2+1)
    ConsoleWrite($f&@CRLF)
  WEnd
  Return $f
EndFunc

Func SubString($f, $s1, $s2) ; $s2 inclus
  Return StringMid($f, $s1, $s2 - $s1 + 1)
EndFunc

Func replacePuiscplx($f, $prefix = "puiscplx")
   While StringInStr($f, $prefix)
    $s1 = StringInStr($f, $prefix)+StringLen($prefix)+1
    ; puiscplx (1) (2) => (2) ^ (1)
    $s2 = getMatchingParenthesis($f, $s1)
    $s3 = $s2 + 2
    $s4 = getMatchingParenthesis($f, $s3)
    If $s2 == -1 Or $s4 == -1 Then ExitLoop
    $part1 = StringReplace(StringMid($f, 1, $s1-1), $prefix, "")
    $exponent    = SubString($f, $s1 + 1, $s2 - 1)
    $subexponent = SubString($f, $s3 + 1, $s4 - 1)
    $part2 = StringMid($f, $s4 + 1)
    $f = $part1&"("&$subexponent&")^("&$exponent&")"&$part2
    ConsoleWrite($f&@CRLF)
  WEnd
  Return $f
EndFunc

Func replaceComplexNumbers($f)
  While StringInStr($f, "[|")
    $s1 = StringInStr($f, "[|")
    ; puiscplx (1) (2) => (2) ^ (1)
    $s2 = getMatchingParenthesis($f, $s1, "[|", ";")
    $s3 = getMatchingParenthesis($f, $s2, ";", "|]")
    If $s2 == -1 Or $s3 == -1 Then ExitLoop
    $part1 = StringMid($f, 1, $s1-1)
    $real = SubString($f, $s1 + 2, $s2 - 1)
    $imag = SubString($f, $s2 + 1, $s3 - 1)
    $part2 = StringMid($f, $s3 + 2)
    $realimag = $real&$imag
    If StringInStr($realimag, "(") Or StringInStr($realimag, "+") Or StringInStr($realimag, "-") Then
      $real = "("&$real&")"
      $imag = "("&$imag&")"
    EndIf
    $f = $part1&"("&$real&"+"&$imag&"i)"&$part2
  WEnd
  Return $f
EndFunc

Func getMatchingParenthesis($f, $pos, $lpar="(", $rpar=")")
  If StringMid($f, $pos, StringLen($lpar)) <> $lpar Then
    ToolTip("Not a parenthesis "&$lpar&" at position "&$pos&" of "&$f, 0, 0)
    Sleep(1000)
    normalStatus()
    Return -1
  EndIf
  $p = 1
  $c = $pos
  While $p > 0 And $c < StringLen($f)
    ConsoleWrite("looking at position "&$c&@CRLF)
    $c += 1
    If StringMid($f, $c, StringLen($lpar)) == $lpar Then $p += 1
    If StringMid($f, $c, StringLen($rpar)) == $rpar Then $p -= 1
  WEnd
  Return $c
EndFunc
