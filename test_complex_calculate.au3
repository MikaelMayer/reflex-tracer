
#include "GlobalUtils.au3"

For $i = 1 To 10000
  $part = (257 - (0)) / (3250 - (0))
  $varvalue = complex_calculate(StringFormat("%s*(%s)+%s*(%s)", 1-$part, (-30), $part, 100))
  $formula = replaceVariableString("o(oo((z)^(cos(cos(argsh(z))))+((((0.44-3.86i)+z)-z^2)*z)^-2,5),z*exp($x))", "$x", $varvalue)
  logging($formula)
  If $varvalue >= 0 Then Exit
Next