#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.10.0
 Author:         Mikaël Mayer
 Date:           2009/01/11

 Script Function:
    Defines the interface for *.ini files to render a video.

#ce ----------------------------------------------------------------------------
#include-once

Global $INI_VIDEO               = "Video"
Global $INI_IMAGE               = "Image"

Global $INI_VIDEO_FORMULA       = "Formula"
Global $INI_VIDEO_VARNAME       = "Variable name"
Global $INI_VIDEO_STARTVALUE    = "Start value"
Global $INI_VIDEO_ENDVALUE      = "End value"
Global $INI_VIDEO_STARTFRAME    = "Start frame"
Global $INI_VIDEO_LASTFRAME     = "Last frame "
Global $INI_VIDEO_NUMFRAMES     = "Num of frames"
Global $INI_VIDEO_RENDEREDFRAMES= "Frames to render"
Global $INI_VIDEO_INCLASTFRAME  = "Include last frame"
Global $INI_VIDEO_OUTPUT_MODEL  = "Output filename model"
Global $INI_VIDEO_OUTPUT_TYPE   = "Output type"

Global $INI_IMAGE_WIDTH    = "Width"
Global $INI_IMAGE_HEIGHT   = "Height"
Global $INI_IMAGE_WINMIN   = "Winmin"
Global $INI_IMAGE_WINMAX   = "Winmax"
Global $INI_IMAGE_COLORNAN = "Color of NaN"