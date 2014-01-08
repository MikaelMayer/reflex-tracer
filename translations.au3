#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           05/07/2008

 Script Function:
  Generates string variables for traduction.

#ce ----------------------------------------------------------------------------
#include-once
#include "IniHandling.au3"
#include "GlobalUtils.au3"
#include <GUIListBox.au3>
#include <GuiConstantsEx.au3>
#include <Array.au3>

Global $lang_folder = 'lang' ;TODO: To externalize?
Global $translation_ini = ""
Global $ini_section = 'Messages'
Global $gui_section = 'GUI'
Global $translation_current_language = 'en'
Global $languages = emptySizedArray()

Global $Reflex_name
Global $affectations_messages
Global $Bitmap_24_bits____bmp__All______
Global $My_nice_function
Global $Quick_save
Global $Give_a_comment_for_this_reflex_
Global $To_change_the_saving_directory__go_to
Global $Error_while_quick_saving_in_file
Global $Errors
Global $Error_title
Global $Could_not_copy_from___s__to___s_
Global $Could_not_convert_from___s__to___s_
Global $Formula_File
Global $Formula_file____txt__All______
Global $Jpeg_Reflex_File
Global $Jpeg_Reflex_File____jpg__All______
Global $I_love_the_Reflex_Renderer
Global $Open_Formula_file
Global $New_Formula_file
Global $New_Reflex_file
Global $Bitmap_24_bits____bmp__Jpeg____jpg_
Global $__s__is_not_a_valid_filename__s_Saving_canceled_
Global $changement_langue_titre
Global $changement_langue_text__s
Global $No_xp_comments_in_this_jpeg_image
Global $Bad_formatting_in_xp_comment
Global $no_algorithm_to_import_data_from_this_kind_of_file__s
Global $error_while_importing_from__s
Global $No_comments_found_in_this_image

  ;=============== GUI ===================;
  ; Reflex Renderer Interface
Global $__reflex__
Global $affectations
Global $__creating_options__
Global $__formula__
Global $__width_height__
Global $__preview__
Global $__winmin__
Global $__winmax__
Global $__auto_render__
Global $__temp_file__
Global $__render_reflex__
Global $__rendering__
Global $__reset_resolution__
Global $__reset_window__
Global $__quick_save__
Global $__noquick_save__
Global $__reflex_renderer_interface__
Global $__navigation__
Global $__visit_click__
Global $__visit_rectangle__
Global $__previous_window__
Global $__next_window__
Global $__zoom_in_factor__
Global $__zoom_out_factor__
Global $__zoom_factor__
Global $__zoom_absolute__
Global $__tools__
Global $__menu_save__
Global $__menu_windows__
Global $__menu_resolutions__
Global $__menu_about__
Global $__menu_quit__
Global $__formula_menu__
Global $__menu_formula_editor__
Global $__menu_formula_import__
  ;Savebox
Global $__save_reflex_and_or_formula__
Global $__saving_parameters__
Global $__save_formula_reflex__
Global $__save_only_formula__
Global $__save_only_reflex__
Global $__save_button__
Global $__cancel_button__
Global $__save_formula_group__
Global $__my_nice_function__
Global $__save_comment__
Global $__formula_file_name__
Global $__comment__
Global $__save_reflex_group__
Global $__high_resolution_reflex__
Global $__copy_last_reflex__
Global $__low_resolution_reflex__
Global $__reflex_file_name__
Global $__use_formula_comment__
Global $__just_save_settings__
;About box
Global $__about_box__
Global $__version__
Global $__copyright__
Global $__ok_button__
;LoadFormulaFromFile
Global $__formula_chooser__
Global $__choose_a_formula__
Global $__other_file__
;EditFormula (hints to be put in the traduction file)
Global $__edit_formula__
Global $__set_button__
Global $__del_button__
Global $__reset_formula__
Global $__x_hint__
Global $__y_hint__
Global $__sin_hint__
Global $__cos_hint__
Global $__tan_hint__
Global $__sinh_hint__
Global $__cosh_hint__
Global $__tanh_hint__
Global $__ln_hint__
Global $__exp_hint__
Global $__sqrt_hint__
Global $__randf_hint__
Global $__randh_hint__
Global $__inv_hint__
Global $__real_hint__
Global $__imag_hint__
Global $__conj_hint__
Global $__dollar_hint__
;Misc
Global $__language_menu__
Global $__auto_render_hint__
Global $__quicksave_hint__
Global $__noquick_save_hint__
Global $__zoom_factor_hint__
Global $__zoom_absolute_hint__
Global $__menu_quitnosave__
Global $__import_window__
Global $__import_resolution__
Global $__formula_chooser_hint__
Global $__import_comment__
Global $__save_window__
Global $__save_resolution__
Global $__save_with__
Global $__seed_hint__
Global $__quit_button__
Global $__menu_formula_import_reflex__
Global $__hint_color_code_button__
Global $__hint_save_all_button__
Global $__hint_use_formula_comment__
Global $__hint_save_options_button__
Global $__real_mode__
Global $__set_button_hint__
Global $__menu_formula_history__
Global $__variable__
Global $__variable_name__
Global $__render_along_variable__
Global $__set_min__
Global $__set_max__
Global $__increase_range__
Global $__minimum__
Global $__maximum__
Global $__variable_editor__
Global $__insert_var__
Global $__randomize_seed__
Global $__decrease_range__
Global $__export_formula__
Global $__formula_exported__
Global $__formula_correctly_exported_to_clipboard__
Global $__next__
Global $__play__
Global $__previous__
Global $__stop__
Global $__tutorial__
Global $__autoplay__
Global $__error__
Global $__tutorial_section_misformed_aborting_loading__
Global $__open_tutorial__
Global $__randf_auto_hint__
Global $__randh_auto_hint__
Global $__randomize_seed_hint__
Global $__customize_menu__
Global $__customize_menu_all_parameters__
Global $__reset_menu__
Global $__confirmation_reset_title__
Global $__confirmation_reset_message__
Global $__menu_formula_small_history__
Global $__lucky_func__
Global $__lucky_func_hint__
Global $__lucky_fractal__
Global $__lucky_fractal_hint__
Global $__switch_fractal__
Global $__switch_fractal_hint__
Global $__autoplay_plus_action__
Global $__switch_function__
Global $__wait_while_generating__
Global $__display_folder__
Global $__display_folder_hint__
Global $__if_error_formula__
Global $__variable_already_opened__
Global $__unknown_file_format_s__
  Global $__quick_save_that__
  Global $__ok__
  Global $__percent_done__
  Global $__time_remaining__
  Global $__converting_to_jpeg__
  Global $__writing_reflex_informations__
  Global $__removing_temporary_files__
  Global $__converting_to_png__
  Global $__problems_while_computing_coordinates__
  Global $__formula_not_exported__
  Global $__exporting_formula__
  Global $__formula_postfix__
  Global $__rri_percent_hint__
  Global $__details__
  Global $__rri_ratio11_hint__
  Global $__rri_ratio43_hint__
  Global $__rri_ratioA4_hint__
  Global $__rri_ratio85_hint__
  Global $__rri_ratio21_hint__
  Global $__colornan__
  Global $__colornan_hint__
  Global $__render_background__
  Global $__render_background_hint__
  ;ADD_DECLARATION

LoadTranslations()

Func LoadTranslations()
  ; Code to retrieve the main user language. 'Hack' found in the Autoit3 documentation of _GUICtrlListBox_GetLocalePrimLang
  Local $hlistBox, $default_language = 'en', $default_language_number
  Local $win = GUICreate("Dummy list box", 400, 296)
  $hListBox = GUICtrlCreateList("", 2, 2, 396, 296)
  Local $default_language_number = _GUICtrlListBox_GetLocalePrimLang($hListBox)
  GUIDelete($win)
  Switch Int($default_language_number)
  Case 09
    $default_language = 'en'
  Case 12
    $default_language = 'fr'
  EndSwitch

  ;Detection of the language file
  $translation_current_language = IniRead($ini_file, $ini_file_session, 'language', $default_language)
  Local $updates = True
  $translation_ini = globalTranslationIni($translation_current_language)
  If not FileExists($translation_ini) Then
    $translation_current_language = 'en'
    $translation_ini = globalTranslationIni($translation_current_language)
  EndIf

  ;Builds the list of all available languages (all *.ini files in the 'lang' folder)
  If not listLanguages() Then $languages = False


Global $affectations_messages                = _ArrayCreate( _ArrayCreate('Reflex_name', $ini_section, 'Reflex name', 'Reflex name'))
add($affectations_messages, "Bitmap_24_bits____bmp__All______", $ini_section, 'Bitmap 24 bits (*.bmp)|All (*.*)', 'Bitmap 24 bits (*.bmp)|All (*.*)')
add($affectations_messages, "My_nice_function", $ini_section, 'My nice function', 'My nice function')
add($affectations_messages, "Quick_save", $ini_section, 'Quick save', 'Quick save')
add($affectations_messages, "Give_a_comment_for_this_reflex_", $ini_section, 'Give a comment for this reflex.', 'Give a comment for this reflex.')
add($affectations_messages, "To_change_the_saving_directory__go_to", $ini_section, 'To change the saving directory, go to %s>%s', 'To change the saving directory, go to %s>%s')
add($affectations_messages, "Error_while_quick_saving_in_file", $ini_section, 'Error while quick saving in file', 'Error while quick saving in file')
add($affectations_messages, "Errors", $ini_section, 'Errors', 'Errors')
add($affectations_messages, "Error", $ini_section, 'Error', 'Error')
add($affectations_messages, "Could_not_copy_from___s__to___s_", $ini_section, "Could not copy from '%s' to '%s'", "Could not copy from '%s' to '%s'")
add($affectations_messages, "Could_not_convert_from___s__to___s_", $ini_section, "Could not convert from '%s' to '%s'", "Could not convert from '%s' to '%s'")
add($affectations_messages, "Formula_File", $ini_section, "Formula File", "Formula File")
add($affectations_messages, "Formula_file____txt__All______", $ini_section, "Formula file (*.txt)|All (*.*)", "Formula file (*.txt)|All (*.*)")
add($affectations_messages, "Jpeg_Reflex_File", $ini_section, "Jpeg Reflex File", "Jpeg Reflex File")
add($affectations_messages, "Jpeg_Reflex_File____jpg__All______", $ini_section, "Jpeg Reflex file (*.jpg;*.jpeg)|All (*.*)", "Jpeg Reflex file (*.jpg;*.jpeg)|All (*.*)")
add($affectations_messages, "I_love_the_Reflex_Renderer", $ini_section, "I love the Reflex Renderer", "I love the Reflex Renderer")
add($affectations_messages, "Open_Formula_file", $ini_section, "Open Formula file", "Open Formula file")
add($affectations_messages, "New_Formula_file", $ini_section, "New Formula file", "New Formula file")
add($affectations_messages, "New_Reflex_file", $ini_section, "New Reflex file", "New Reflex file")
add($affectations_messages, "Bitmap_24_bits____bmp__Jpeg____jpg_", $ini_section, "Bitmap 24 bits (*.bmp)|Jpeg (*.jpg)", "Bitmap 24 bits (*.bmp)|Jpeg (*.jpg)")
add($affectations_messages, "__s__is_not_a_valid_filename__s_Saving_canceled_", $ini_section, "'%s' is not a valid filename.%s Saving canceled.", "'%s' is not a valid filename.%s Saving canceled.")
add($affectations_messages, "changement_langue_titre", $ini_section, "New language set", "New language set")
add($affectations_messages, "changement_langue_text__s", $ini_section, "Please restart the application to have it in %s.", "Please restart the application to have it in %s.")
add($affectations_messages, "No_xp_comments_in_this_jpeg_image", $ini_section, "No XP comments corresponding to a formula in this jpeg image.", "No XP comments corresponding to a formula in this jpeg image.")
add($affectations_messages, "Bad_formatting_in_xp_comment", $ini_section, "Bad formatting in xp comment", "Bad formatting in xp comment")
add($affectations_messages, "no_algorithm_to_import_data_from_this_kind_of_file__s", $ini_section, "No possible import from %s", "No possible import from %s")
add($affectations_messages, "error_while_importing_from__s", $ini_section, "Error occured when importing from %s", "Error occured when importing from %s")
add($affectations_messages, "No_comments_found_in_this_image", $ini_section, "No comments corresponding to a formula in this image.", "No comments corresponding to a formula in this image.")

  ;=============== GUI ===================;
  ; Reflex Renderer Interface
  Global $affectations = _ArrayCreate( _ArrayCreate("__reflex__", $gui_section, 'Reflex', 'Reflex'))
add($affectations, "__creating_options__", $gui_section, 'Creating options', 'Creating options')
add($affectations, "__formula__", $gui_section, 'Formula :', 'Formula :')
add($affectations, "__width_height__", $gui_section, 'Width x Height :', 'Width x Height :')
add($affectations, "__preview__", $gui_section, 'Preview', 'Preview')
add($affectations, "__winmin__", $gui_section, 'Window Minimum:', 'Window Minimum:')
add($affectations, "__winmax__", $gui_section, 'Window Maximum:', 'Window Maximum:')
add($affectations, "__auto_render__", $gui_section, 'Auto Render', 'Auto Render')
add($affectations, "__temp_file__", $gui_section, 'Temp file:', 'Temp file:')
add($affectations, "__render_reflex__", $gui_section, '&Render Reflex', '&Render Reflex')
add($affectations, "__rendering__", $gui_section, 'Rendering...', 'Rendering...')
add($affectations, "__reset_resolution__", $gui_section, 'Reset [resolution/window]', 'Reset')
add($affectations, "__reset_window__", $gui_section, 'Reset [resolution/window]', 'Reset')
add($affectations, "__quick_save__", $gui_section, 'Quick save...', 'Quick save...')
add($affectations, "__noquick_save__", $gui_section, 'Options...', 'Options...')
add($affectations, "__reflex_renderer_interface__", $gui_section, 'Reflex Renderer', 'Reflex Renderer')
add($affectations, "__navigation__", $gui_section, 'Navigation', 'Navigation')
add($affectations, "__visit_click__", $gui_section, '&Visit click', '&Visit click')
add($affectations, "__visit_rectangle__", $gui_section, 'Visit r&ectangle', 'Visit r&ectangle')
add($affectations, "__previous_window__", $gui_section, 'P&revious window', 'P&revious window')
add($affectations, "__next_window__", $gui_section, 'Nex&t window', 'Nex&t window')
add($affectations, "__zoom_in_factor__", $gui_section, 'Zoom &in', 'Zoom &in')
add($affectations, "__zoom_out_factor__", $gui_section, 'Zoom &out', 'Zoom &out')
add($affectations, "__zoom_factor__", $gui_section, 'Zoom Factor:', 'Zoom Factor:')
add($affectations, "__zoom_absolute__", $gui_section, 'Absolute Zoom:', 'Absolute Zoom:')
add($affectations, "__tools__", $gui_section, '&Tools', '&Tools')
add($affectations, "__menu_save__", $gui_section, '&Saving options...', '&Saving options...')
add($affectations, "__menu_windows__", $gui_section, '&Windows', '&Windows')
add($affectations, "__menu_resolutions__", $gui_section, '&Resolutions', '&Resolutions')
add($affectations, "__menu_about__", $gui_section, '&About...', '&About...')
add($affectations, "__menu_quit__", $gui_section, 'Quit [menu]', 'Quit')
add($affectations, "__formula_menu__", $gui_section, '&Formula', '&Formula')
add($affectations, "__menu_formula_editor__", $gui_section, '&Editor...', '&Editor...')
add($affectations, "__menu_formula_import__", $gui_section, '&Import...', '&Import...')
  ;Savebox
add($affectations, "__save_reflex_and_or_formula__", $gui_section, 'Save Reflex and/or Formula', 'Save Reflex and/or Formula')
add($affectations, "__saving_parameters__", $gui_section, 'Saving parameters', 'Saving parameters')
add($affectations, "__save_formula_reflex__", $gui_section, 'Save Formula && Reflex', 'Save Formula && Reflex')
add($affectations, "__save_only_formula__", $gui_section, 'Save only Formula', 'Save only Formula')
add($affectations, "__save_only_reflex__", $gui_section, 'Save only Reflex', 'Save only Reflex')
add($affectations, "__save_button__", $gui_section, 'Save all', 'Save all')
add($affectations, "__cancel_button__", $gui_section, 'Cancel', 'Cancel')
add($affectations, "__save_formula_group__", $gui_section, 'Save Formula', 'Save Formula')
add($affectations, "__my_nice_function__", $gui_section, 'My nice function', 'My nice function')
add($affectations, "__save_comment__", $gui_section, 'Comment', 'Comment')
add($affectations, "__formula_file_name__", $gui_section, 'Formula File Name:', 'Formula File Name:')
add($affectations, "__comment__", $gui_section, 'Comment:', 'Comment:')
add($affectations, "__save_reflex_group__", $gui_section, 'Save Reflex', 'Save Reflex')
add($affectations, "__high_resolution_reflex__", $gui_section, 'High-resolution reflex', 'High-resolution reflex')
add($affectations, "__copy_last_reflex__", $gui_section, 'Copy last reflex', 'Copy last reflex')
add($affectations, "__low_resolution_reflex__", $gui_section, 'Low-resolution reflex', 'Low-resolution reflex')
add($affectations, "__reflex_file_name__", $gui_section, 'Reflex file name:', 'Reflex file name:')
add($affectations, "__use_formula_comment__", $gui_section, 'Use Formula comment as the Reflex name', 'Use Formula comment as the Reflex name')
add($affectations, "__just_save_settings__", $gui_section, 'Just save settings', 'Just save settings')
;About box
add($affectations, "__about_box__", $gui_section, 'About', 'About')
add($affectations, "__version__", $gui_section, 'Version %s', 'Version %s')
add($affectations, "__copyright__", $gui_section, 'Copyright 2008', 'Copyright 2008')
add($affectations, "__ok_button__", $gui_section, '&OK', '&OK')
;LoadFormulaFromFile
add($affectations, "__formula_chooser__", $gui_section, 'Formula Chooser', 'Formula Chooser')
add($affectations, "__choose_a_formula__", $gui_section, 'Choose a formula :', 'Choose a formula :')
add($affectations, "__other_file__", $gui_section, 'Other file', 'Other file')
;EditFormula (hints to be put in the traduction file)
add($affectations, "__edit_formula__", $gui_section, 'Edit Formula', 'Edit Formula')
add($affectations, "__set_button__", $gui_section, 'Set', 'Set')
add($affectations, "__del_button__", $gui_section, 'del', 'del')
add($affectations, "__reset_formula__", $gui_section, 'Reset [formula]', 'Reset')
add($affectations, "__x_hint__", $gui_section, 'The real part of z', 'The real part of z')
add($affectations, "__y_hint__", $gui_section, 'The imaginary part of z', 'The imaginary part of z')
add($affectations, "__sin_hint__", $gui_section, 'Sinus', 'Sinus')
add($affectations, "__cos_hint__", $gui_section, 'Cosinus', 'Cosinus')
add($affectations, "__tan_hint__", $gui_section, 'Tangent', 'Tangent')
add($affectations, "__sinh_hint__", $gui_section, 'Hyperbolic sinus', 'Hyperbolic sinus')
add($affectations, "__cosh_hint__", $gui_section, 'Hyperbolic cosinus', 'Hyperbolic cosinus')
add($affectations, "__tanh_hint__", $gui_section, 'Hyperbolic tangent', 'Hyperbolic tangent')
add($affectations, "__ln_hint__", $gui_section, 'Natural logarithm', 'Natural logarithm')
add($affectations, "__exp_hint__", $gui_section, 'Exponential function', 'Exponential function')
add($affectations, "__sqrt_hint__", $gui_section, 'Square root', 'Square root')
add($affectations, "__randf_hint__", $gui_section, 'Random function', 'Random function')
add($affectations, "__randh_hint__", $gui_section, 'Random holomorphic function', 'Random holomorphic function')
add($affectations, "__inv_hint__", $gui_section, 'Inverse function', 'Inverse function')
add($affectations, "__real_hint__", $gui_section, 'Real part', 'Real part')
add($affectations, "__imag_hint__", $gui_section, 'Imaginary part', 'Imaginary part')
add($affectations, "__conj_hint__", $gui_section, 'Complex conjugation', 'Complex conjugation')
add($affectations, "__dollar_hint__", $gui_section, 'Prefix of a variable', 'Prefix of a variable')
;Misc
add($affectations, "__language_menu__", $gui_section, 'Languages', 'Languages')
add($affectations, "__auto_render_hint__", $gui_section, 'Renders automatically when something is modified.', 'Renders automatically when something is modified.')
add($affectations, "__quicksave_hint__", $gui_section, 'Give a comment and save!', 'Give a comment and save!')
add($affectations, "__noquick_save_hint__", $gui_section, 'Set saving options.', 'Set saving options.')
add($affectations, "__zoom_factor_hint__", $gui_section, 'Zoom factor hint', '"Zoom in" or "Zoom out" are using this multiplier.')
add($affectations, "__zoom_absolute_hint__", $gui_section, 'Zoom absolute hint', 'Move this to view the function at different scales')
add($affectations, "__menu_quitnosave__", $gui_section, 'Quit without saving', 'Quit without saving')
add($affectations, "__import_window__", $gui_section, 'Import window', 'Import window')
add($affectations, "__import_resolution__", $gui_section, 'Import resolution', 'Import resolution')
add($affectations, "__formula_chooser_hint__", $gui_section, 'Formula chooser hint', '')
add($affectations, "__import_comment__", $gui_section, 'Import comment', 'Import comment')
add($affectations, "__save_window__", $gui_section, 'Window', 'Window')
add($affectations, "__save_resolution__", $gui_section, 'Resolution', 'Resolution')
add($affectations, "__save_with__", $gui_section, 'Save with...', 'Save with...')
add($affectations, "__seed_hint__", $gui_section, 'Seed hint', 'The seed used in randf and randh functions')
add($affectations, "__quit_button__", $gui_section, 'Quit', 'Quit')
add($affectations, "__menu_formula_import_reflex__", $gui_section, 'Import from Reflex in Jpeg', 'Import from Reflex in Jpeg')
add($affectations, "__hint_color_code_button__", $gui_section, 'Reflex color code', 'Reflex color code')
add($affectations, "__hint_save_all_button__", $gui_section, 'Hint save all button', 'Hint save all button')
add($affectations, "__hint_use_formula_comment__", $gui_section, 'Hint use formula comment', 'Hint use formula comment')
add($affectations, "__hint_save_options_button__", $gui_section, 'Hint save options button', 'Hint save options button')
add($affectations, "__real_mode__", $gui_section, 'Real mode', 'Real mode')
add($affectations, "__set_button_hint__", $gui_section, 'Updates the main formula field', 'Updates the main formula field')
add($affectations, "__menu_formula_history__", $gui_section, 'Formula history', 'Formula history')
add($affectations, "__variable__", $gui_section, 'Variable', 'Variable')
add($affectations, "__variable_name__", $gui_section, 'Variable name', 'Variable name')
add($affectations, "__render_along_variable__", $gui_section, 'Render video', 'Render video')
add($affectations, "__set_min__", $gui_section, 'Set min', 'Set min')
add($affectations, "__set_max__", $gui_section, 'Set Max', 'Set Max')
add($affectations, "__increase_range__", $gui_section, 'Increase range', 'Increase range')
add($affectations, "__minimum__", $gui_section, 'Minimum', 'Minimum')
add($affectations, "__maximum__", $gui_section, 'Maximum', 'Maximum')
add($affectations, "__variable_editor__", $gui_section, 'Variable Editor', 'Variable Editor')
add($affectations, "__insert_var__", $gui_section, 'Insert variable', 'Insert variable')
add($affectations, "__randomize_seed__", $gui_section, 'Randomize seed', 'Randomize seed')
add($affectations, "__decrease_range__", $gui_section, 'Decrease range', 'Decrease range')
add($affectations, "__export_formula__", $gui_section, 'Export formula...', 'Export formula...')
add($affectations, "__formula_exported__", $gui_section, 'Formule exportée', 'Formule exportée')
add($affectations, "__formula_correctly_exported_to_clipboard__", $gui_section, 'La formule a été mise dans le presse-papier au format OpenOffice.', 'La formule a été mise dans le presse-papier au format OpenOffice.')
add($affectations, "__next__", $gui_section, 'Next', 'Next')
add($affectations, "__play__", $gui_section, 'Play', 'Play')
add($affectations, "__previous__", $gui_section, 'Previous', 'Previous')
add($affectations, "__stop__", $gui_section, 'Stop', 'Stop')
add($affectations, "__tutorial__", $gui_section, 'Reflex Renderer Tutorial', 'Reflex Renderer Tutorial')
add($affectations, "__autoplay__", $gui_section, 'Autoplay', 'Automated actions')
add($affectations, "__error__", $gui_section, 'Error', 'Error')
add($affectations, "__tutorial_section_misformed_aborting_loading__", $gui_section, 'Tutorial section misformed', 'Tutorial section misformed')
add($affectations, "__open_tutorial__", $gui_section, 'Tutorial...', 'Tutorial...')
add($affectations, "__randf_auto_hint__", $gui_section, 'randf_auto_hint', 'randf_auto_hint')
add($affectations, "__randh_auto_hint__", $gui_section, 'randh_auto_hint', 'randh_auto_hint')
add($affectations, "__randomize_seed_hint__", $gui_section, 'Randomize_seed_hint', 'Randomize_seed_hint')
add($affectations, "__customize_menu__", $gui_section, 'Customize', 'Customize')
add($affectations, "__customize_menu_all_parameters__", $gui_section, 'General parameters', 'General parameters')
add($affectations, "__reset_menu__", $gui_section, 'Reset All', 'Reset All')
add($affectations, "__confirmation_reset_title__", $gui_section, 'confirmation reset title', 'Confirm reset')
add($affectations, "__confirmation_reset_message__", $gui_section, 'Do you confirm to reset all fields?', 'Do you confirm to reset all fields?')
add($affectations, "__menu_formula_small_history__", $gui_section, 'menu small history', 'Small History')
add($affectations, "__lucky_func__", $gui_section, 'Lucky function', 'Lucky function')
add($affectations, "__lucky_func_hint__", $gui_section, 'Lucky func hint', 'Generates a random complex function')
add($affectations, "__lucky_fractal__", $gui_section, 'Lucky fractal', 'Lucky fractal')
add($affectations, "__lucky_fractal_hint__", $gui_section, 'Lucky fractal hint', 'Generates a random complex function and compose it by itself')
add($affectations, "__switch_fractal__", $gui_section, '(Un)fractalize!', '(Un)fractalize!')
add($affectations, "__switch_fractal_hint__", $gui_section, 'Switch fractal hint', 'Toggles betweens fractal and function')
add($affectations, "__autoplay_plus_action__", $gui_section, 'Autoplay action', 'Automated actions (1 planified action)')
add($affectations, "__switch_function__", $gui_section, 'Unfractalize !', 'Unfractalize !')
add($affectations, "__wait_while_generating__", $gui_section, 'Wait while generating', 'Please wait while the function is generated')
  add($affectations, "__display_folder__", $gui_section, 'Display folder', 'Display Reflex Folder')
  add($affectations, "__display_folder_hint__", $gui_section, 'Display folder hint', 'Opens the folder where the Reflex are currently stored')
  add($affectations, "__if_error_formula__", $gui_section, 'if error formula', '[In a formula error, the second line stops at the error point]')
  add($affectations, "__variable_already_opened__", $gui_section, 'Variable already opened', 'Variable already opened')
  add($affectations, "__unknown_file_format_s__", $gui_section, 'Unknown file format %s', 'Unknown file format %s')
  add($affectations, "__quick_save_that__", $gui_section, 'quick save that', 'quick save that')
  add($affectations, "__ok__", $gui_section, 'OK', 'OK')
  add($affectations, "__percent_done__", $gui_section, 'percent done', '% done')
  add($affectations, "__time_remaining__", $gui_section, 'time remaining', 'remaining')
  add($affectations, "__converting_to_jpeg__", $gui_section, 'Converting to Jpeg...', 'Converting to Jpeg...')
  add($affectations, "__writing_reflex_informations__", $gui_section, 'Writing Reflex informations...', 'Writing Reflex informations...')
  add($affectations, "__removing_temporary_files__", $gui_section, 'Removing temporary files...', 'Removing temporary files...')
  add($affectations, "__converting_to_png__", $gui_section, 'Converting to PNG...', 'Converting to PNG...')
  add($affectations, "__problems_while_computing_coordinates__", $gui_section, 'Problems winminmax', 'Problems occured while computing winmin and winmax. Please send the content of the clipboard to mikael.mayer_reflexrenderer@polytechnique.org')
  add($affectations, "__formula_not_exported__", $gui_section, 'formula not exported', 'I could not ask the website to convert the formula. Please check your internet connection.')
  add($affectations, "__exporting_formula__", $gui_section, 'exporting formula', 'Exporting formula...')
  add($affectations, "__formula_postfix__", $gui_section, 'formula postfix', 'formula')
  add($affectations, "__rri_percent_hint__", $gui_section, 'rri percent hint', 'Detail level')
  add($affectations, "__details__", $gui_section, 'Details:', 'Details:')
  add($affectations, "__rri_ratio11_hint__", $gui_section, 'ratio11 hint', 'Squared picture')
  add($affectations, "__rri_ratio43_hint__", $gui_section, 'ratio43 hint', '1024x768,1280x960,1600x1200')
  add($affectations, "__rri_ratioA4_hint__", $gui_section, 'ratioA4 hint', 'A4 or A5 paper (2.1:2:97)')
  add($affectations, "__rri_ratio85_hint__", $gui_section, 'ratio85 hint', '1024x640,1280x800,1600x1000,2048x1280')
  add($affectations, "__rri_ratio21_hint__", $gui_section, 'ratio21 hint', '640x320,1024x512,2000x1000 ...')
  add($affectations, "__colornan__", $gui_section, 'colorNaN', 'ColorNaN')
  add($affectations, "__colornan_hint__", $gui_section, 'colornan hint', 'The color to use when the computation fails')
  add($affectations, "__render_background__", $gui_section, 'Background', 'Background')
  add($affectations, "__render_background_hint__", $gui_section, 'render background hint', 'Renders the Reflex in a separate independent process')
  ;ADD_AFFECTATION

  If $updates and Not @Compiled Then
    update($affectations)
    update($affectations_messages)
  EndIf

  For $var In $affectations_messages
    Assign($var[0], IniRead($translation_ini, $var[1], $var[2], $var[3]), 2)
  Next
  For $var In $affectations
    Assign($var[0], IniRead($translation_ini, $var[1], $var[2], $var[3]), 2)
  Next

EndFunc

Func update($affectations)
  If $languages == False Then Return
  For $var In $affectations
    For $language In $languages
      Local $ini_translation = $lang_folder&'\'&translationFile($language[2])
      If IniRead($ini_translation, $var[1], $var[2], 'ZXW')=='ZXW' Then
        IniWrite($ini_translation, $var[1], $var[2], $var[3])
      EndIf
    Next
  Next
EndFunc

Func globalTranslationIni($translation_current_language)
  Return @ScriptDir&'\'&$lang_folder&'\'&translationFile($translation_current_language)
EndFunc

Func translationFile($str)
  Local $result = "translations_"&$str&".ini"
  Return $result
EndFunc

Func listLanguages()
  $languages = emptySizedArray()
  FileChangeDir(@ScriptDir&"\"&$lang_folder)
  $search = FileFindFirstFile(translationFile("*"))
  ; Check if the search was successful
  If $search = -1 Then
    FileClose($search)
    FileChangeDir(@ScriptDir)
    Return False
  EndIf
  While 1
    $file = FileFindNextFile($search)
    If @error Then ExitLoop
    ; 'Français', 'fr_lang', 'fr'
    $language_name = StringReplace(FileReadLine($file, 1), ';', '')
    $array = StringRegExp($file, "_(\w*?).ini", 1)
    $language_code = $array[0]
    $language_var  = $language_code&"_lang"
    _ArrayAdd($languages, _ArrayCreate($language_name, $language_var, $language_code))
  WEnd
  _ArrayDelete($languages, 0)
  _ArraySort($languages)
  ; Close the search handle
  FileClose($search)
  FileChangeDir(@ScriptDir)
  Return True
EndFunc

Func add(ByRef $tab, $var_name, $section, $word, $traduction)
  _ArrayAdd($tab, _ArrayCreate($var_name, $section, $word, $traduction))
EndFunc
