#----------------------------------------------------------------
# Generated CMake target import file for configuration "".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "png16" for configuration ""
set_property(TARGET png16 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(png16 PROPERTIES
  IMPORTED_IMPLIB_NOCONFIG "${_IMPORT_PREFIX}/lib/libpng16.dll.a"
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "/usr/lib/libz.dll.a;/usr/lib/libm.a"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/cygpng16-16.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS png16 )
list(APPEND _IMPORT_CHECK_FILES_FOR_png16 "${_IMPORT_PREFIX}/lib/libpng16.dll.a" "${_IMPORT_PREFIX}/bin/cygpng16-16.dll" )

# Import target "png16_static" for configuration ""
set_property(TARGET png16_static APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(png16_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "C"
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "/usr/lib/libz.dll.a;/usr/lib/libm.a"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libpng16.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS png16_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_png16_static "${_IMPORT_PREFIX}/lib/libpng16.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
