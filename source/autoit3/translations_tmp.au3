$translation_ini = @ScriptDir&"\translations.ini"
$ini_section = "Messages"
$gui_section = "GUI"
$Reflex_name= IniRead($translation_ini, $ini_section, _
"Reflex name", _
"Reflex name")
$Bitmap_24_bits____bmp__All______= IniRead($translation_ini, $ini_section, _
"Bitmap 24 bits (*.bmp)|All (*.*)", _
"Bitmap 24 bits (*.bmp)|All (*.*)")
$My_nice_function= IniRead($translation_ini, $ini_section, _
"My nice function", _
"My nice function")
$Quick_save= IniRead($translation_ini, $ini_section, _
"Quick save", _
"Quick save")
$Give_a_comment_for_this_reflex_= IniRead($translation_ini, $ini_section, _
"Give a comment for this reflex.", _
"Give a comment for this reflex.")
$To_change_the_saving_directory__go_to= IniRead($translation_ini, $ini_section, _
"To change the saving directory, go to %s>%s", _
"To change the saving directory, go to %s>%s")
$Error_while_quick_saving_in_file= IniRead($translation_ini, $ini_section, _
"Error while quick saving in file", _
"Error while quick saving in file")
$Errors= IniRead($translation_ini, $ini_section, _
"Errors", _
"Errors")
$Error_title= IniRead($translation_ini, $ini_section, _
"Error", _
"Error")
$Could_not_copy_from___s__to___s_= IniRead($translation_ini, $ini_section, _
"Could not copy from '%s' to '%s'", _
"Could not copy from '%s' to '%s'")
$Could_not_convert_from___s__to___s_= IniRead($translation_ini, $ini_section, _
"Could not convert from '%s' to '%s'", _
"Could not convert from '%s' to '%s'")
$Formula_File= IniRead($translation_ini, $ini_section, _
"Formula File", _
"Formula File")
$Formula_file____txt__All______= IniRead($translation_ini, $ini_section, _
"Formula file (*.txt)|All (*.*)", _
"Formula file (*.txt)|All (*.*)")
$I_love_the_Reflex_Renderer= IniRead($translation_ini, $ini_section, _
"I love the Reflex Renderer", _
"I love the Reflex Renderer")
$Open_Formula_file= IniRead($translation_ini, $ini_section, _
"Open Formula file", _
"Open Formula file")
$New_Formula_file= IniRead($translation_ini, $ini_section, _
"New Formula file", _
"New Formula file")
$New_Reflex_file= IniRead($translation_ini, $ini_section, _
"New Reflex file", _
"New Reflex file")
$Bitmap_24_bits____bmp__Jpeg____jpg_= IniRead($translation_ini, $ini_section, _
"Bitmap 24 bits (*.bmp)|Jpeg (*.jpg)", _
"Bitmap 24 bits (*.bmp)|Jpeg (*.jpg)")
$__s__is_not_a_valid_filename__s_Saving_canceled_= IniRead($translation_ini, $ini_section, _
"'%s' is not a valid filename.%s Saving canceled.", _
"'%s' is not a valid filename.%s Saving canceled.")

;=============== GUI ===================;
; Reflex Renderer Interface

Dim $__reflex__ = _
IniRead($translation_ini, $gui_section, 'Reflex', 'Reflex')
Dim $__creating_options__ = _
IniRead($translation_ini, $gui_section, "Creating options", "Creating options")
Dim $__formula__ = _
IniRead($translation_ini, $gui_section, "Formula :", "Formula :")
Dim $__width_height__ = _
IniRead($translation_ini, $gui_section, 'Width x Height :', 'Width x Height :')
Dim $__preview__ = _
IniRead($translation_ini, $gui_section, 'Preview', 'Preview')
Dim $__winmin__ = _
IniRead($translation_ini, $gui_section, 'Window Minimum:', 'Window Minimum:')
Dim $__winmax__ = _
IniRead($translation_ini, $gui_section, 'Window Maximum:', 'Window Maximum:')
Dim $__auto_render__ = _
IniRead($translation_ini, $gui_section, 'Auto Render', 'Auto Render')
Dim $__temp_file__ = _
IniRead($translation_ini, $gui_section, 'Temp file:', 'Temp file:')
Dim $__render_reflex__ = _
IniRead($translation_ini, $gui_section, '&Render Reflex', '&Render Reflex')
Dim $__rendering__ = _
IniRead($translation_ini, $gui_section, 'Rendering...', 'Rendering...')
Dim $__reset_resolution__ = _
IniRead($translation_ini, $gui_section, 'Reset', 'Reset')
Dim $__reset_window__ = _
IniRead($translation_ini, $gui_section, 'Reset', 'Reset')
Dim $__quick_save__ = _
IniRead($translation_ini, $gui_section, 'Quick save...', 'Quick save...')
Dim $__noquick_save__ = _
IniRead($translation_ini, $gui_section, 'Save...', 'Save...')
Dim $__reflex_renderer_interface__ = _
IniRead($translation_ini, $gui_section, 'Reflex Renderer Interface', 'Reflex Renderer Interface')
Dim $__navigation__ = _
IniRead($translation_ini, $gui_section, 'Navigation', 'Navigation')
Dim $__drag_reflex__ = _
IniRead($translation_ini, $gui_section, 'Dr&ag reflex', 'Dr&ag reflex')
Dim $__zoom_rectangle_in__ = _
IniRead($translation_ini, $gui_section, '&Zoom rectangle in', '&Zoom rectangle in')
Dim $__zoom_rectangle_out__ = _
IniRead($translation_ini, $gui_section, 'Zoom r&ectangle out', 'Zoom r&ectangle out')
Dim $__previous_window__ = _
IniRead($translation_ini, $gui_section, 'P&revious window', 'P&revious window')
Dim $__next_window__ = _
IniRead($translation_ini, $gui_section, 'Nex&t window', 'Nex&t window')
Dim $__zoom_in_factor__ = _
IniRead($translation_ini, $gui_section, 'Zoom &in', 'Zoom &in')
Dim $__zoom_out_factor__ = _
IniRead($translation_ini, $gui_section, 'Zoom &out', 'Zoom &out')
Dim $__zoom_factor__ = _
IniRead($translation_ini, $gui_section, 'Zoom Factor:', 'Zoom Factor:')
Dim $__zoom_absolute__ = _
IniRead($translation_ini, $gui_section, 'Absolute Zoom:', 'Absolute Zoom:')
Dim $__tools__ = _
IniRead($translation_ini, $gui_section, '&Tools', '&Tools')
Dim $__menu_save__ = _
IniRead($translation_ini, $gui_section, '&Save reflex / formula...', '&Save reflex / formula...')
Dim $__menu_windows__= _
IniRead($translation_ini, $gui_section, '&Windows', '&Windows')
Dim $__menu_resolutions__= _
IniRead($translation_ini, $gui_section, '&Resolutions', '&Resolutions')
Dim $__menu_about__= _
IniRead($translation_ini, $gui_section, '&About...', '&About...')
Dim $__menu_quit__= _
IniRead($translation_ini, $gui_section, 'Quit', 'Quit')
Dim $__formula_menu__= _
IniRead($translation_ini, $gui_section, '&Formula', '&Formula')
Dim $__menu_formula_editor__= _
IniRead($translation_ini, $gui_section, '&Editor...', '&Editor...')
Dim $__menu_formula_import__= _
IniRead($translation_ini, $gui_section, '&Import...', '&Import...')

; Savebox
Dim $__save_reflex_and_or_formula__= _
IniRead($translation_ini, $gui_section, 'Save Reflex and/or Formula', 'Save Reflex and/or Formula')
Dim $__saving_parameters__= _
IniRead($translation_ini, $gui_section, 'Saving parameters', 'Saving parameters')
Dim $__save_formula_reflex__= _
IniRead($translation_ini, $gui_section, 'Save Formula && Reflex', 'Save Formula && Reflex')
Dim $__save_only_formula__= _
IniRead($translation_ini, $gui_section, 'Save only Formula', 'Save only Formula')
Dim $__save_only_reflex__= _
IniRead($translation_ini, $gui_section, 'Save only Reflex', 'Save only Reflex')
Dim $__save_button__= _
IniRead($translation_ini, $gui_section, 'Save', 'Save')
Dim $__cancel_button__= _
IniRead($translation_ini, $gui_section, 'Cancel', 'Cancel')
Dim $__save_formula_group__= _
IniRead($translation_ini, $gui_section, 'Save Formula', 'Save Formula')
Dim $__my_nice_function__= _
IniRead($translation_ini, $gui_section, 'My nice function', 'My nice function')
Dim $__save_comment__= _
IniRead($translation_ini, $gui_section, 'Save comment', 'Save comment')
Dim $__formula_file_name__= _
IniRead($translation_ini, $gui_section, 'Formula File Name:', 'Formula File Name:')
Dim $__comment__= _
IniRead($translation_ini, $gui_section, 'Comment:', 'Comment:')
Dim $__save_reflex_group__= _
IniRead($translation_ini, $gui_section, 'Save Reflex', 'Save Reflex')
Dim $__high_resolution_reflex__= _
IniRead($translation_ini, $gui_section, 'High-resolution reflex', 'High-resolution reflex')
Dim $__copy_last_reflex__= _
IniRead($translation_ini, $gui_section, 'Copy last reflex', 'Copy last reflex')
Dim $__low_resolution_reflex__= _
IniRead($translation_ini, $gui_section, 'Low-resolution reflex', 'Low-resolution reflex')
Dim $__reflex_file_name__= _
IniRead($translation_ini, $gui_section, 'Reflex file name:', 'Reflex file name:')
Dim $__use_formula_comment__= _
IniRead($translation_ini, $gui_section, 'Use Formula comment as the Reflex name', 'Use Formula comment as the Reflex name')
Dim $__just_save_settings__= _
IniRead($translation_ini, $gui_section, 'Just save settings', 'Just save settings')

;AboutBox
Dim $__about_box__= _
IniRead($translation_ini, $gui_section, 'About', 'About')
Dim $__version__= _
IniRead($translation_ini, $gui_section, 'Version 2.0 beta', 'Version 2.0 beta')
Dim $__copyright__= _
IniRead($translation_ini, $gui_section, 'Copyright 2008', 'Copyright 2008')
Dim $__ok_button__= _
IniRead($translation_ini, $gui_section, '&OK', '&OK')

;LoadFormulaFromFile
Dim $__formula_chooser__ = _
IniRead($translation_ini, $gui_section, 'Formula Chooser', 'Formula Chooser')
Dim $__choose_a_formula__ = _
IniRead($translation_ini, $gui_section, 'Choose a formula :', 'Choose a formula :')
Dim $__other_file__ = _
IniRead($translation_ini, $gui_section, 'Other file', 'Other file')

;EditFormula (hints to be put in the traduction file.)
Dim $__edit_formula__ = _
IniRead($translation_ini, $gui_section, 'Edit Formula', 'Edit Formula')
Dim $__set_button__ = _
IniRead($translation_ini, $gui_section, 'Set', 'Set')
Dim $__del_button__ = _
IniRead($translation_ini, $gui_section, 'del', 'del')
;IniRead($translation_ini, $gui_section, 'Cancel', 'Cancel')
Dim $__reset_formula__ = _
IniRead($translation_ini, $gui_section, 'Reset', 'Reset')


Dim $__x_hint__ = _
IniRead($translation_ini, $gui_section, 'The real part of z', 'The real part of z')
Dim $__y_hint__ = _
IniRead($translation_ini, $gui_section, 'The imaginary part of z', 'The imaginary part of z')

Dim $__sin_hint__ = _
IniRead($translation_ini, $gui_section, 'Sinus', 'Sinus')
Dim $__cos_hint__ = _
IniRead($translation_ini, $gui_section, 'Cosinus', 'Cosinus')
Dim $__tan_hint__ = _
IniRead($translation_ini, $gui_section, 'Tangent', 'Tangent')
Dim $__sinh_hint__ = _
IniRead($translation_ini, $gui_section, 'Hyperbolic sinus', 'Hyperbolic sinus')
Dim $__cosh_hint__ = _
IniRead($translation_ini, $gui_section, 'Hyperbolic cosinus', 'Hyperbolic cosinus')
Dim $__tanh_hint__ = _
IniRead($translation_ini, $gui_section, 'Hyperbolic tangent', 'Hyperbolic tangent')

Dim $__ln_hint__ = _
IniRead($translation_ini, $gui_section, 'Natural logarithm', 'Natural logarithm')
Dim $__exp_hint__ = _
IniRead($translation_ini, $gui_section, 'Exponential function', 'Exponential function')
Dim $__sqrt_hint__ = _
IniRead($translation_ini, $gui_section, 'Square root', 'Square root')

Dim $__randf_hint__ = _
IniRead($translation_ini, $gui_section, 'Random function', 'Random function')
Dim $__randh_hint__ = _
IniRead($translation_ini, $gui_section, 'Random holomorphic function', 'Random holomorphic function')

Dim $__inv_hint__ = _
IniRead($translation_ini, $gui_section, 'Inverse function', 'Inverse function')

Dim $__real_hint__ = _
IniRead($translation_ini, $gui_section, 'Real part', 'Real part')
Dim $__imag_hint__ = _
IniRead($translation_ini, $gui_section, 'Imaginary part', 'Imaginary part')
Dim $__conj_hint__ = _
IniRead($translation_ini, $gui_section, 'Complex conjugation', 'Complex conjugation')
Dim $__dollar_hint__ = _
IniRead($translation_ini, $gui_section, 'Prefix of a variable', 'Prefix of a variable')


