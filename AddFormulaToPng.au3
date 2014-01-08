#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         Mikaël Mayer
 Date:           2009.XX.XX

 Script Function:


#ce ----------------------------------------------------------------------------
#include 'GlobalUtils.au3'
#include 'LoadFormulaFromFile.au3'

$reflex_file = FileOpenDialog("Ouvre une Reflex", @WorkingDir, "PNG pictures (*.png)", 1)
If @error Then Exit

ClipPut("")

Do
  $res = MsgBox(1, "Préparez la formule", "Mettez la formule et les options dans le presse-papier, puis appuyez sur ENTREE")
  If $res == 2 Then Exit
  If ClipGet() <> "" Then ExitLoop
Until False

$formula_and_options = ClipGet()

Dim $informations = _ArrayCreate(3, _ArrayCreate("Title", "Reflex"), _ArrayCreate("Comment", $formula_and_options), _ArrayCreate("Software", "ReflexRenderer v."&$VERSION_NUMER))
WritePngTextChunks($reflex_file, $informations)
