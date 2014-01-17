Global $Global_Parameters = emptySizedArray()
Global Enum $PARAM_STRING, $PARAM_DROPDOWN, $PARAM_BOOL, $PARAM_INT
Global Enum $N_PARAM_VANAME, $N_PARAM_TYPE, $N_PARAM_DEFAULTVALUE, $N_PARAM_PRIORITY ; Priority to determine (for useless properties for example)
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
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_EVENT_MINIMIZE = -4
Global Const $GUI_EVENT_RESTORE = -5
Global Const $GUI_EVENT_MAXIMIZE = -6
Global Const $GUI_EVENT_PRIMARYDOWN = -7
Global Const $GUI_EVENT_PRIMARYUP = -8
Global Const $GUI_EVENT_SECONDARYDOWN = -9
Global Const $GUI_EVENT_SECONDARYUP = -10
Global Const $GUI_EVENT_MOUSEMOVE = -11
Global Const $GUI_EVENT_RESIZED = -12
Global Const $GUI_EVENT_DROPPED = -13
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $GUI_AVISTOP = 0
Global Const $GUI_AVISTART = 1
Global Const $GUI_AVICLOSE = 2
Global Const $GUI_CHECKED = 1
Global Const $GUI_INDETERMINATE = 2
Global Const $GUI_UNCHECKED = 4
Global Const $GUI_DROPACCEPTED = 8
Global Const $GUI_NODROPACCEPTED = 4096
Global Const $GUI_ACCEPTFILES = $GUI_DROPACCEPTED	; to be suppressed
Global Const $GUI_SHOW = 16
Global Const $GUI_HIDE = 32
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $GUI_FOCUS = 256
Global Const $GUI_NOFOCUS = 8192
Global Const $GUI_DEFBUTTON = 512
Global Const $GUI_EXPAND = 1024
Global Const $GUI_ONTOP = 2048
Global Const $GUI_FONTITALIC = 2
Global Const $GUI_FONTUNDER = 4
Global Const $GUI_FONTSTRIKE = 8
Global Const $GUI_DOCKAUTO = 0x0001
Global Const $GUI_DOCKLEFT = 0x0002
Global Const $GUI_DOCKRIGHT = 0x0004
Global Const $GUI_DOCKHCENTER = 0x0008
Global Const $GUI_DOCKTOP = 0x0020
Global Const $GUI_DOCKBOTTOM = 0x0040
Global Const $GUI_DOCKVCENTER = 0x0080
Global Const $GUI_DOCKWIDTH = 0x0100
Global Const $GUI_DOCKHEIGHT = 0x0200
Global Const $GUI_DOCKSIZE = 0x0300	; width+height
Global Const $GUI_DOCKMENUBAR = 0x0220	; top+height
Global Const $GUI_DOCKSTATEBAR = 0x0240	; bottom+height
Global Const $GUI_DOCKALL = 0x0322	; left+top+width+height
Global Const $GUI_DOCKBORDERS = 0x0066	; left+top+right+bottom
Global Const $GUI_GR_CLOSE = 1
Global Const $GUI_GR_LINE = 2
Global Const $GUI_GR_BEZIER = 4
Global Const $GUI_GR_MOVE = 6
Global Const $GUI_GR_COLOR = 8
Global Const $GUI_GR_RECT = 10
Global Const $GUI_GR_ELLIPSE = 12
Global Const $GUI_GR_PIE = 14
Global Const $GUI_GR_DOT = 16
Global Const $GUI_GR_PIXEL = 18
Global Const $GUI_GR_HINT = 20
Global Const $GUI_GR_REFRESH = 22
Global Const $GUI_GR_PENSIZE = 24
Global Const $GUI_GR_NOBKCOLOR = -2
Global Const $GUI_BKCOLOR_DEFAULT = -1
Global Const $GUI_BKCOLOR_TRANSPARENT = -2
Global Const $GUI_BKCOLOR_LV_ALTERNATE = 0xFE000000
Global Const $GUI_WS_EX_PARENTDRAG = 0x00100000
Global Const $tagNMHDR = "hwnd hWndFrom;int IDFrom;int Code"
Global Const $tagCOMBOBOXINFO = "dword Size;int EditLeft;int EditTop;int EditRight;int EditBottom;int BtnLeft;int BtnTop;" & _
		"int BtnRight;int BtnBottom;dword BtnState;hwnd hCombo;hwnd hEdit;hwnd hList"
Global Const $tagCOMBOBOXEXITEM = "int Mask;int Item;ptr Text;int TextMax;int Image;int SelectedImage;int OverlayImage;" & _
		"int Indent;int Param"
Global Const $tagNMCBEDRAGBEGIN = $tagNMHDR & ";int ItemID;char Text[1024]"
Global Const $tagNMCBEENDEDIT = $tagNMHDR & ";int fChanged;int NewSelection;char Text[1024];int Why"
Global Const $tagNMCOMBOBOXEX = $tagNMHDR & ";int Mask;int Item;ptr Text;int TextMax;int Image;" & _
		"int SelectedImage;int OverlayImage;int Indent;int Param"
Global Const $tagDTPRANGE = "short MinYear;short MinMonth;short MinDOW;short MinDay;short MinHour;short MinMinute;" & _
		"short MinSecond;short MinMSecond;short MaxYear;short MaxMonth;short MaxDOW;short MaxDay;short MaxHour;" & _
		"short MaxMinute;short MaxSecond;short MaxMSecond;int MinValid;int MaxValid"
Global Const $tagDTPTIME = "short Year;short Month;short DOW;short Day;short Hour;short Minute;short Second;short MSecond"
Global Const $tagNMDATETIMECHANGE = $tagNMHDR & ";int Flag;short Year;short Month;short DOW;short Day;" & _
		"short Hour;short Minute;short Second;short MSecond"
Global Const $tagNMDATETIMEFORMAT = $tagNMHDR & ";ptr Format;short Year;short Month;short DOW;short Day;" & _
		"short Hour;short Minute;short Second;short MSecond;ptr pDisplay;char Display[64]"
Global Const $tagNMDATETIMEFORMATQUERY = $tagNMHDR & ";ptr Format;int SizeX;int SizeY"
Global Const $tagNMDATETIMEKEYDOWN = $tagNMHDR & ";int VirtKey;ptr Format;short Year;short Month;short DOW;" & _
		"short Day;short Hour;short Minute;short Second;short MSecond"
Global Const $tagNMDATETIMESTRING = $tagNMHDR & ";ptr UserString;short Year;short Month;short DOW;short Day;" & _
		"short Hour;short Minute;short Second;short MSecond;int Flags"
Global Const $tagEDITBALLOONTIP = "dword Size;ptr Title;ptr Text;int Icon"
Global Const $tagEVENTLOGRECORD = "int Length;int Reserved;int RecordNumber;int TimeGenerated;int TimeWritten;int EventID;" & _
		"short EventType;short NumStrings;short EventCategory;short ReservedFlags;int ClosingRecordNumber;int StringOffset;" & _
		"int UserSidLength;int UserSidOffset;int DataLength;int DataOffset"
Global Const $tagEVENTREAD = "byte Buffer[4096];int BytesRead;int BytesMin"
Global Const $tagGDIPBITMAPDATA = "uint Width;uint Height;int Stride;uint Format;ptr Scan0;ptr Reserved"
Global Const $tagGDIPENCODERPARAM = "byte GUID[16];dword Count;dword Type;ptr Values"
Global Const $tagGDIPENCODERPARAMS = "dword Count;byte Params[0]"
Global Const $tagGDIPRECTF = "float X;float Y;float Width;float Height"
Global Const $tagGDIPSTARTUPINPUT = "int Version;ptr Callback;int NoThread;int NoCodecs"
Global Const $tagGDIPSTARTUPOUTPUT = "ptr HookProc;ptr UnhookProc"
Global Const $tagGDIPIMAGECODECINFO = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & _
		"ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"
Global Const $tagGDIPPENCODERPARAMS = "dword Count;byte Params[0]"
Global Const $tagHDHITTESTINFO = "int X;int Y;int Flags;int Item"
Global Const $tagHDITEM = "int Mask;int XY;ptr Text;hwnd hBMP;int TextMax;int Fmt;int Param;int Image;int Order;int Type;ptr pFilter;int State"
Global Const $tagHDLAYOUT = "ptr Rect;ptr WindowPos"
Global Const $tagHDTEXTFILTER = "ptr Text;int TextMax"
Global Const $tagNMHDDISPINFO = "hwnd WndFrom;int IDFrom;int Code;int Item;int Mask;ptr Text;int TextMax;int Image;int lParam"
Global Const $tagNMHDFILTERBTNCLICK = $tagNMHDR & ";int Item;int Left;int Top;int Right;int Bottom"
Global Const $tagNMHEADER = $tagNMHDR & ";int Item;int Button;ptr pItem"
Global Const $tagGETIPAddress = "ubyte Field4;ubyte Field3;ubyte Field2;ubyte Field1"
Global Const $tagNMIPADDRESS = $tagNMHDR & ";int Field;int Value"
Global Const $tagLVBKIMAGE = "int Flags;hwnd hBmp;int Image;int ImageMax;int XOffPercent;int YOffPercent"
Global Const $tagLVCOLUMN = "int Mask;int Fmt;int CX;ptr Text;int TextMax;int SubItem;int Image;int Order"
Global Const $tagLVFINDINFO = "int Flags;ptr Text;int Param;int X;int Y;int Direction"
Global Const $tagLVGROUP = "int Size;int Mask;ptr Header;int HeaderMax;ptr Footer;int FooterMax;int GroupID;int StateMask;int State;int Align"
Global Const $tagLVHITTESTINFO = "int X;int Y;int Flags;int Item;int SubItem"
Global Const $tagLVINSERTMARK = "uint Size;dword Flags;int Item;dword Reserved"
Global Const $tagLVITEM = "int Mask;int Item;int SubItem;int State;int StateMask;ptr Text;int TextMax;int Image;int Param;" & _
		"int Indent;int GroupID;int Columns;ptr pColumns"
Global Const $tagNMLISTVIEW = $tagNMHDR & ";int Item;int SubItem;int NewState;int OldState;int Changed;" & _
		"int ActionX;int ActionY;int Param"
Global Const $tagNMLVCUSTOMDRAW = $tagNMHDR & ";dword dwDrawStage;hwnd hdc;int Left;int Top;int Right;int Bottom;" & _
		"dword dwItemSpec;uint uItemState;long lItemlParam;int clrText;int clrTextBk;int iSubItem;dword dwItemType;int clrFace;int iIconEffect;" & _
		"int iIconPhase;int iPartId;int iStateId;int TextLeft;int TextTop;int TextRight;int TextBottom;uint uAlign"
Global Const $tagNMLVDISPINFO = $tagNMHDR & ";int Mask;int Item;int SubItem;int State;int StateMask;" & _
		"ptr Text;int TextMax;int Image;int Param;int Indent;int GroupID;int Columns;ptr pColumns"
Global Const $tagNMLVFINDITEM = $tagNMHDR & ";int Start;int Flags;ptr Text;int Param;int X;int Y;int Direction"
Global Const $tagNMLVGETINFOTIP = $tagNMHDR & ";int Flags;ptr Text;int TextMax;int Item;int SubItem;int lParam"
Global Const $tagNMITEMACTIVATE = $tagNMHDR & ";int Index;int SubItem;int NewState;int OldState;" & _
		"int Changed;int X;int Y;int lParam;int KeyFlags"
Global Const $tagNMLVKEYDOWN = $tagNMHDR & ";int VKey;int Flags"
Global Const $tagNMLVSCROLL = $tagNMHDR & ";int DX;int DY"
Global Const $tagLVSETINFOTIP = "int Size;int Flags;ptr Text;int Item;int SubItem"
Global Const $tagMCHITTESTINFO = "int Size;int X;int Y;int Hit;short Year;short Month;short DOW;short Day;short Hour;" & _
		"short Minute;short Second;short MSeconds"
Global Const $tagMCMONTHRANGE = "short MinYear;short MinMonth;short MinDOW;short MinDay;short MinHour;short MinMinute;short MinSecond;" & _
		"short MinMSeconds;short MaxYear;short MaxMonth;short MaxDOW;short MaxDay;short MaxHour;short MaxMinute;short MaxSecond;" & _
		"short MaxMSeconds;short Span"
Global Const $tagMCRANGE = "short MinYear;short MinMonth;short MinDOW;short MinDay;short MinHour;short MinMinute;short MinSecond;" & _
		"short MinMSeconds;short MaxYear;short MaxMonth;short MaxDOW;short MaxDay;short MaxHour;short MaxMinute;short MaxSecond;" & _
		"short MaxMSeconds;short MinSet;short MaxSet"
Global Const $tagMCSELRANGE = "short MinYear;short MinMonth;short MinDOW;short MinDay;short MinHour;short MinMinute;short MinSecond;" & _
		"short MinMSeconds;short MaxYear;short MaxMonth;short MaxDOW;short MaxDay;short MaxHour;short MaxMinute;short MaxSecond;" & _
		"short MaxMSeconds"
Global Const $tagNMDAYSTATE = $tagNMHDR & ";short Year;short Month;short DOW;short Day;short Hour;" & _
		"short Minute;short Second;short MSeconds;int DayState;ptr pDayState"
Global Const $tagNMSELCHANGE = $tagNMHDR & ";short BegYear;short BegMonth;short BegDOW;short BegDay;" & _
		"short BegHour;short BegMinute;short BegSecond;short BegMSeconds;short EndYear;short EndMonth;short EndDOW;" & _
		"short EndDay;short EndHour;short EndMinute;short EndSecond;short EndMSeconds"
Global Const $tagNMOBJECTNOTIFY = $tagNMHDR & ";int Item;ptr piid;ptr pObject;int Result"
Global Const $tagNMTCKEYDOWN = $tagNMHDR & ";int VKey;int Flags"
Global Const $tagTCITEM = "int Mask;int State;int StateMask;ptr Text;int TextMax;int Image;int Param"
Global Const $tagTCHITTESTINFO = "int X;int Y;int Flags"
Global Const $tagTVITEMEX = "int Mask;int hItem;int State;int StateMask;ptr Text;int TextMax;int Image;int SelectedImage;" & _
		"int Children;int Param;int Integral"
Global Const $tagNMTREEVIEW = $tagNMHDR & ";int Action;int OldMask;int OldhItem;int OldState;int OldStateMask;" & _
		"ptr OldText;int OldTextMax;int OldImage;int OldSelectedImage;int OldChildren;int OldParam;int NewMask;int NewhItem;" & _
		"int NewState;int NewStateMask;ptr NewText;int NewTextMax;int NewImage;int NewSelectedImage;int NewChildren;" & _
		"int NewParam;int PointX; int PointY"
Global Const $tagNMTVCUSTOMDRAW = $tagNMHDR & ";uint DrawStage;hwnd HDC;int Left;int Top;int Right;int Bottom;" & _
		"ptr ItemSpec;uint ItemState;int ItemParam;int ClrText;int ClrTextBk;int Level"
Global Const $tagNMTVDISPINFO = $tagNMHDR & ";int Mask;int hItem;int State;int StateMask;" & _
		"ptr Text;int TextMax;int Image;int SelectedImage;int Children;int Param"
Global Const $tagNMTVGETINFOTIP = $tagNMHDR & ";ptr Text;int TextMax;hwnd hItem;int lParam"
Global Const $tagTVHITTESTINFO = "int X;int Y;int Flags;int Item"
Global Const $tagTVINSERTSTRUCT = "hwnd Parent;int InsertAfter;int Mask;hwnd hItem;int State;int StateMask;ptr Text;int TextMax;" & _
		"int Image;int SelectedImage;int Children;int Param"
Global Const $tagNMTVKEYDOWN = $tagNMHDR & ";int VKey;int Flags"
Global Const $tagNMTTDISPINFO = $tagNMHDR & ";ptr pText;char aText[80];hwnd Instance;int Flags;int Param"
Global Const $tagTOOLINFO = "int Size;int Flags;hwnd hWnd;int ID;int Left;int Top;int Right;int Bottom;hwnd hInst;ptr Text;int Param;ptr Reserved"
Global Const $tagTTGETTITLE = "int Size;int Bitmap;int TitleMax;ptr Title"
Global Const $tagTTHITTESTINFO = "hwnd Tool;int X;int Y;int Size;int Flags;hwnd hWnd;int ID;int Left;int Top;int Right;int Bottom;" & _
		"hwnd hInst;ptr Text;int Param;ptr Reserved"
Global Const $tagNMMOUSE = $tagNMHDR & ";dword ItemSpec;dword ItemData;int X;int Y;dword HitInfo"
Global Const $tagPOINT = "int X;int Y"
Global Const $tagRECT = "int Left;int Top;int Right;int Bottom"
Global Const $tagMargins = "int cxLeftWidth;int cxRightWidth;int cyTopHeight;int cyBottomHeight"
Global Const $tagSIZE = "int X;int Y"
Global Const $tagTOKEN_PRIVILEGES = "int Count;int64 LUID;int Attributes"
Global Const $tagIMAGEINFO = "hwnd hBitmap;hwnd hMask;int Unused1;int Unused2;int Left;int Top;int Right;int Bottom"
Global Const $tagIMAGELISTDRAWPARAMS = "int Size;hwnd hWnd;int Image;hwnd hDC;int X;int Y;int CX;int CY;int XBitmap;int YBitmap;" & _
		"int BK;int FG;int Style;int ROP;int State;int Frame;int Effect"
Global Const $tagMEMMAP = "hwnd hProc;int Size;ptr Mem"
Global Const $tagMDINEXTMENU = "hwnd hMenuIn;hwnd hMenuNext;hwnd hWndNext"
Global Const $tagMENUBARINFO = "int Size;int Left;int Top;int Right;int Bottom;int hMenu;int hWndMenu;int Focused"
Global Const $tagMENUEX_TEMPLATE_HEADER = "short Version;short Offset;int HelpID"
Global Const $tagMENUEX_TEMPLATE_ITEM = "int HelpID;int Type;int State;int MenuID;short ResInfo;ptr Text"
Global Const $tagMENUGETOBJECTINFO = "int Flags;int Pos;hwnd hMenu;ptr RIID;ptr Obj"
Global Const $tagMENUINFO = "int Size;int Mask;int Style;int YMax;int hBack;int ContextHelpID;ptr MenuData"
Global Const $tagMENUITEMINFO = "int Size;int Mask;int Type;int State;int ID;int SubMenu;int BmpChecked;int BmpUnchecked;" & _
		"int ItemData;ptr TypeData;int CCH;int BmpItem"
Global Const $tagMENUITEMTEMPLATE = "short Option;short ID;ptr String"
Global Const $tagMENUITEMTEMPLATEHEADER = "short Version;short Offset"
Global Const $tagTPMPARAMS = "short Version;short Offset"
Global Const $tagCONNECTION_INFO_1 = "int ID;int Type;int Opens;int Users;int Time;ptr Username;ptr NetName"
Global Const $tagFILE_INFO_3 = "int ID;int Permissions;int Locks;ptr Pathname;ptr Username"
Global Const $tagSESSION_INFO_2 = "ptr CName;ptr Username;int Opens;int Time;int Idle;int Flags;ptr TypeName"
Global Const $tagSESSION_INFO_502 = "ptr CName;ptr Username;int Opens;int Time;int Idle;int Flags;ptr TypeName;ptr Transport"
Global Const $tagSHARE_INFO_2 = "ptr NetName;int Type;ptr Remark;int Permissions;int MaxUses;int CurrentUses;ptr Path;ptr Password"
Global Const $tagSTAT_SERVER_0 = "int Start;int FOpens;int DevOpens;int JobsQueued;int SOpens;int STimedOut;int SErrorOut;" & _
		"int PWErrors;int PermErrors;int SysErrors;int64 ByteSent;int64 ByteRecv;int AvResponse;int ReqBufNeed;int BigBufNeed"
Global Const $tagSTAT_WORKSTATION_0 = "int64 StartTime;int64 BytesRecv;int64 SMBSRecv;int64 PageRead;int64 NonPageRead;" & _
		"int64 CacheRead;int64 NetRead;int64 BytesTran;int64 SMBSTran;int64 PageWrite;int64 NonPageWrite;int64 CacheWrite;" & _
		"int64 NetWrite;int InitFailed;int FailedComp;int ReadOp;int RandomReadOp;int ReadSMBS;int LargeReadSMBS;" & _
		"int SmallReadSMBS;int WriteOp;int RandomWriteOp;int WriteSMBS;int LargeWriteSMBS;int SmallWriteSMBS;" & _
		"int RawReadsDenied;int RawWritesDenied;int NetworkErrors;int Sessions;int FailedSessions;int Reconnects;" & _
		"int CoreConnects;int LM20Connects;int LM21Connects;int LMNTConnects;int ServerDisconnects;int HungSessions;" & _
		"int UseCount;int FailedUseCount;int CurrentCommands"
Global Const $tagFILETIME = "dword Lo;dword Hi"
Global Const $tagSYSTEMTIME = "short Year;short Month;short Dow;short Day;short Hour;short Minute;short Second;short MSeconds"
Global Const $tagTIME_ZONE_INFORMATION = "long Bias;byte StdName[64];ushort StdDate[8];long StdBias;byte DayName[64];ushort DayDate[8];long DayBias"
Global Const $tagPBRANGE = "int Low;int High"
Global Const $tagREBARBANDINFO = "uint cbSize;uint fMask;uint fStyle;dword clrFore;dword clrBack;ptr lpText;uint cch;" & _
		"int iImage;hwnd hwndChild;uint cxMinChild;uint cyMinChild;uint cx;hwnd hbmBack;uint wID;uint cyChild;uint cyMaxChild;" & _
		"uint cyIntegral;uint cxIdeal;int lParam;uint cxHeader"
Global Const $tagNMREBARAUTOBREAK = $tagNMHDR & ";uint uBand;uint wID;int lParam;uint uMsg;uint fStyleCurrent;int fAutoBreak"
Global Const $tagNMRBAUTOSIZE = $tagNMHDR & ";int fChanged;int TargetLeft;int TargetTop;int TargetRight;int TargetBottom;" & _
		"int ActualLeft;int ActualTop;int ActualRight;int ActualBottom"
Global Const $tagNMREBAR = $tagNMHDR & ";dword dwMask;uint uBand;uint fStyle;uint wID;int lParam"
Global Const $tagNMREBARCHEVRON = $tagNMHDR & ";uint uBand;uint wID;int lParam;int Left;int Top;int Right;int Bottom;int lParamNM"
Global Const $tagNMREBARCHILDSIZE = $tagNMHDR & ";uint uBand;uint wID;int CLeft;int CTop;int CRight;int CBottom;" & _
		"int BLeft;int BTop;int BRight;int BBottom"
Global Const $tagREBARINFO = "uint cbSize;uint fMask;hwnd himl"
Global Const $tagRBHITTESTINFO = "int X;int Y;uint flags;int iBand"
Global Const $tagCOLORSCHEME = "int Size;int BtnHighlight;int BtnShadow"
Global Const $tagTBADDBITMAP = "int hInst;int ID"
Global Const $tagNMTOOLBAR = $tagNMHDR & ";int iItem;int iBitmap;int idCommand;" & _
		"byte fsState;byte fsStyle;byte bReserved1;byte bReserved2;dword dwData;int iString;int cchText;" & _
		"ptr pszText;int Left;int Top;int Right;int Bottom"
Global Const $tagNMTBHOTITEM = $tagNMHDR & ";int idOld;int idNew;dword dwFlags"
Global Const $tagTBBUTTON = "int Bitmap;int Command;byte State;byte Style;short Reserved;int Param;int String"
Global Const $tagTBBUTTONINFO = "int Size;int Mask;int Command;int Image;byte State;byte Style;short CX;int Param;ptr Text;int TextMax"
Global Const $tagTBINSERTMARK = "int Button;int Flags"
Global Const $tagTBMETRICS = "int Size;int Mask;int XPad;int YPad;int XBarPad;int YBarPad;int XSpacing;int YSpacing"
Global Const $tagCONNECTDLGSTRUCT = "int Size;hwnd hWnd;ptr Resource;int Flags;int DevNum"
Global Const $tagDISCDLGSTRUCT = "int Size;hwnd hWnd;ptr LocalName;ptr RemoteName;int Flags"
Global Const $tagNETCONNECTINFOSTRUCT = "int Size;int Flags;int Speed;int Delay;int OptDataSize"
Global Const $tagNETINFOSTRUCT = "int Size;int Version;int Status;int Char;int Handle;short NetType;int Printers;int Drives;short Reserved"
Global Const $tagNETRESOURCE = "int Scope;int Type;int DisplayType;int Usage;ptr LocalName;ptr RemoteName;ptr Comment;ptr Provider"
Global Const $tagREMOTENAMEINFO = "ptr Universal;ptr Connection;ptr Remaining"
Global Const $tagOVERLAPPED = "int Internal;int InternalHigh;int Offset;int OffsetHigh;int hEvent"
Global Const $tagOPENFILENAME = "dword StructSize;hwnd hwndOwner;hwnd hInstance;ptr lpstrFilter;ptr lpstrCustomFilter;" & _
		"dword nMaxCustFilter;dword nFilterIndex;ptr lpstrFile;dword nMaxFile;ptr lpstrFileTitle;int nMaxFileTitle;" & _
		"ptr lpstrInitialDir;ptr lpstrTitle;dword Flags;short nFileOffset;short nFileExtension;ptr lpstrDefExt;ptr lCustData;" & _
		"ptr lpfnHook;ptr lpTemplateName;ptr pvReserved;dword dwReserved;dword FlagsEx"
Global Const $tagBITMAPINFO = "dword Size;long Width;long Height;ushort Planes;ushort BitCount;dword Compression;dword SizeImage;" & _
		"long XPelsPerMeter;long YPelsPerMeter;dword ClrUsed;dword ClrImportant;dword RGBQuad"
Global Const $tagBLENDFUNCTION = "byte Op;byte Flags;byte Alpha;byte Format"
Global Const $tagBORDERS = "int BX;int BY;int RX"
Global Const $tagCHOOSECOLOR = "dword Size;hwnd hWndOwnder;hwnd hInstance;int rgbResult;int_ptr CustColors;dword Flags;int_ptr lCustData;" & _
		"ptr lpfnHook;ptr lpTemplateName"
Global Const $tagCHOOSEFONT = "dword Size;hwnd hWndOwner;hwnd hDC;ptr LogFont;int PointSize;dword Flags;int rgbColors;int_ptr CustData;" & _
		"ptr fnHook;ptr TemplateName;hwnd hInstance;ptr szStyle;ushort FontType;int SizeMin;int SizeMax"
Global Const $tagTEXTMETRIC = "long tmHeight;long tmAscent;long tmDescent;long tmInternalLeading;long tmExternalLeading;" & _
		"long tmAveCharWidth;long tmMaxCharWidth;long tmWeight;long tmOverhang;long tmDigitizedAspectX;long tmDigitizedAspectY;" & _
		"char tmFirstChar;char tmLastChar;char tmDefaultChar;char tmBreakChar;byte tmItalic;byte tmUnderlined;byte tmStruckOut;" & _
		"byte tmPitchAndFamily;byte tmCharSet"
Global Const $tagCURSORINFO = "int Size;int Flags;hwnd hCursor;int X;int Y"
Global Const $tagDISPLAY_DEVICE = "int Size;char Name[32];char String[128];int Flags;char ID[128];char Key[128]"
Global Const $tagFLASHWINDOW = "int Size;hwnd hWnd;int Flags;int Count;int TimeOut"
Global Const $tagGUID = "int Data1;short Data2;short Data3;byte Data4[8]"
Global Const $tagICONINFO = "int Icon;int XHotSpot;int YHotSpot;hwnd hMask;hwnd hColor"
Global Const $tagWINDOWPLACEMENT = "UINT length; UINT flags; UINT showCmd; int ptMinPosition[2]; int ptMaxPosition[2]; int rcNormalPosition[4]"
Global Const $tagWINDOWPOS = "hwnd hWnd;int InsertAfter;int X;int Y;int CX;int CY;int Flags"
Global Const $tagSCROLLINFO = "uint cbSize;uint fMask;int  nMin;int  nMax;uint nPage;int  nPos;int  nTrackPos"
Global Const $tagSCROLLBARINFO = "dword cbSize;int Left;int Top;int Right;int Bottom;int dxyLineButton;int xyThumbTop;" & _
		"int xyThumbBottom;int reserved;dword rgstate[6]"
Global Const $tagLOGFONT = "int Height;int Width;int Escapement;int Orientation;int Weight;byte Italic;byte Underline;" & _
		"byte Strikeout;byte CharSet;byte OutPrecision;byte ClipPrecision;byte Quality;byte PitchAndFamily;char FaceName[32]"
Global Const $tagKBDLLHOOKSTRUCT = "dword vkCode;dword scanCode;dword flags;dword time;ulong_ptr dwExtraInfo"
Global Const $tagPROCESS_INFORMATION = "hwnd hProcess;hwnd hThread;int ProcessID;int ThreadID"
Global Const $tagSTARTUPINFO = "int Size;ptr Reserved1;ptr Desktop;ptr Title;int X;int Y;int XSize;int YSize;int XCountChars;" & _
		"int YCountChars;int FillAttribute;int Flags;short ShowWindow;short Reserved2;ptr Reserved3;int StdInput;" & _
		"int StdOutput;int StdError"
Global Const $tagSECURITY_ATTRIBUTES = "int Length;ptr Descriptor;int InheritHandle"
Global Const $FW_DONTCARE = 0
Global Const $FW_THIN = 100
Global Const $FW_EXTRALIGHT = 200
Global Const $FW_ULTRALIGHT = 200
Global Const $FW_LIGHT = 300
Global Const $FW_NORMAL = 400
Global Const $FW_REGULAR = 400
Global Const $FW_MEDIUM = 500
Global Const $FW_SEMIBOLD = 600
Global Const $FW_DEMIBOLD = 600
Global Const $FW_BOLD = 700
Global Const $FW_EXTRABOLD = 800
Global Const $FW_ULTRABOLD = 800
Global Const $FW_HEAVY = 900
Global Const $FW_BLACK = 900
Global Const $CF_EFFECTS = 0x100
Global Const $CF_PRINTERFONTS = 0x2
Global Const $CF_SCREENFONTS = 0x1
Global Const $CF_NOSCRIPTSEL = 0x800000
Global Const $CF_INITTOLOGFONTSTRUCT = 0x40
Global Const $LOGPIXELSX = 88
Global Const $LOGPIXELSY = 90
Global Const $ANSI_CHARSET = 0
Global Const $BALTIC_CHARSET = 186
Global Const $CHINESEBIG5_CHARSET = 136
Global Const $DEFAULT_CHARSET = 1
Global Const $EASTEUROPE_CHARSET = 238
Global Const $GB2312_CHARSET = 134
Global Const $GREEK_CHARSET = 161
Global Const $HANGEUL_CHARSET = 129
Global Const $MAC_CHARSET = 77
Global Const $OEM_CHARSET = 255
Global Const $RUSSIAN_CHARSET = 204
Global Const $SHIFTJIS_CHARSET = 128
Global Const $SYMBOL_CHARSET = 2
Global Const $TURKISH_CHARSET = 162
Global Const $VIETNAMESE_CHARSET = 163
Global Const $OUT_CHARACTER_PRECIS = 2
Global Const $OUT_DEFAULT_PRECIS = 0
Global Const $OUT_DEVICE_PRECIS = 5
Global Const $OUT_OUTLINE_PRECIS = 8
Global Const $OUT_PS_ONLY_PRECIS = 10
Global Const $OUT_RASTER_PRECIS = 6
Global Const $OUT_STRING_PRECIS = 1
Global Const $OUT_STROKE_PRECIS = 3
Global Const $OUT_TT_ONLY_PRECIS = 7
Global Const $OUT_TT_PRECIS = 4
Global Const $CLIP_CHARACTER_PRECIS = 1
Global Const $CLIP_DEFAULT_PRECIS = 0
Global Const $CLIP_EMBEDDED = 128
Global Const $CLIP_LH_ANGLES = 16
Global Const $CLIP_MASK = 0xF
Global Const $CLIP_STROKE_PRECIS = 2
Global Const $CLIP_TT_ALWAYS = 32
Global Const $ANTIALIASED_QUALITY = 4
Global Const $DEFAULT_QUALITY = 0
Global Const $DRAFT_QUALITY = 1
Global Const $NONANTIALIASED_QUALITY = 3
Global Const $PROOF_QUALITY = 2
Global Const $DEFAULT_PITCH = 0
Global Const $FIXED_PITCH = 1
Global Const $VARIABLE_PITCH = 2
Global Const $FF_DECORATIVE = 80
Global Const $FF_DONTCARE = 0
Global Const $FF_MODERN = 48
Global Const $FF_ROMAN = 16
Global Const $FF_SCRIPT = 64
Global Const $FF_SWISS = 32
Global Const $__MISCCONSTANT_CC_ANYCOLOR = 0x100
Global Const $__MISCCONSTANT_CC_FULLOPEN = 0x2
Global Const $__MISCCONSTANT_CC_RGBINIT = 0x1
Func _ChooseColor($iReturnType = 0, $iColorRef = 0, $iRefType = 0, $hWndOwnder = 0)
	Local $custcolors = "int[16]", $tcc, $tChoose, $color_picked, $iResult
	$tChoose = DllStructCreate($tagCHOOSECOLOR)
	$tcc = DllStructCreate($custcolors)
	If ($iRefType == 1) Then ; BGR hex color to colorref
		$iColorRef = Int($iColorRef)
	ElseIf ($iRefType == 2) Then ; RGB hex color to colorref
		$iColorRef = Hex(String($iColorRef), 6)
		$iColorRef = '0x' & StringMid($iColorRef, 5, 2) & StringMid($iColorRef, 3, 2) & StringMid($iColorRef, 1, 2)
	EndIf
	DllStructSetData($tChoose, "Size", DllStructGetSize($tChoose))
	DllStructSetData($tChoose, "hWndOwnder", $hWndOwnder)
	DllStructSetData($tChoose, "rgbResult", $iColorRef)
	DllStructSetData($tChoose, "CustColors", DllStructGetPtr($tcc))
	DllStructSetData($tChoose, "Flags", BitOR($__MISCCONSTANT_CC_ANYCOLOR, $__MISCCONSTANT_CC_FULLOPEN, $__MISCCONSTANT_CC_RGBINIT))
	$iResult = DllCall("comdlg32.dll", "long", "ChooseColor", "ptr", DllStructGetPtr($tChoose))
	If ($iResult[0] == 0) Then Return SetError(-3, -3, -1) ; user selected cancel or struct settings incorrect
	$color_picked = DllStructGetData($tChoose, "rgbResult")
	If ($iReturnType == 1) Then ; return Hex BGR Color
		Return '0x' & Hex(String($color_picked), 6)
	ElseIf ($iReturnType == 2) Then ; return Hex RGB Color
		$color_picked = Hex(String($color_picked), 6)
		Return '0x' & StringMid($color_picked, 5, 2) & StringMid($color_picked, 3, 2) & StringMid($color_picked, 1, 2)
	ElseIf ($iReturnType == 0) Then ; return RGB COLORREF
		Return $color_picked
	Else
		Return SetError(-4, -4, -1)
	EndIf
EndFunc   ;==>_ChooseColor
Func _ChooseFont($sFontName = "Courier New", $iPointSize = 10, $iColorRef = 0, $iFontWeight = 0, $iItalic = False, $iUnderline = False, $iStrikethru = False, $hWndOwner = 0)
	Local $tLogFont, $tChooseFont, $lngDC, $lfHeight, $iResult
	Local $fontname, $italic = 0, $underline = 0, $strikeout = 0
	Local $attributes, $size, $weight, $colorref, $color_picked
	$lngDC = _MISC_GetDC(0)
	$lfHeight = Round(($iPointSize * _MISC_GetDeviceCaps($lngDC, $LOGPIXELSX)) / 72, 0)
	_MISC_ReleaseDC(0, $lngDC)
	$tChooseFont = DllStructCreate($tagCHOOSEFONT)
	$tLogFont = DllStructCreate($tagLOGFONT)
	DllStructSetData($tChooseFont, "Size", DllStructGetSize($tChooseFont))
	DllStructSetData($tChooseFont, "hWndOwner", $hWndOwner)
	DllStructSetData($tChooseFont, "LogFont", DllStructGetPtr($tLogFont))
	DllStructSetData($tChooseFont, "PointSize", $iPointSize)
	DllStructSetData($tChooseFont, "Flags", BitOR($CF_SCREENFONTS, $CF_PRINTERFONTS, $CF_EFFECTS, $CF_INITTOLOGFONTSTRUCT, $CF_NOSCRIPTSEL))
	DllStructSetData($tChooseFont, "rgbColors", $iColorRef)
	DllStructSetData($tChooseFont, "FontType", 0)
	DllStructSetData($tLogFont, "Height", $lfHeight)
	DllStructSetData($tLogFont, "Weight", $iFontWeight)
	DllStructSetData($tLogFont, "Italic", $iItalic)
	DllStructSetData($tLogFont, "Underline", $iUnderline)
	DllStructSetData($tLogFont, "Strikeout", $iStrikethru)
	DllStructSetData($tLogFont, "FaceName", $sFontName)
	$iResult = DllCall("comdlg32.dll", "long", "ChooseFont", "ptr", DllStructGetPtr($tChooseFont))
	If ($iResult[0] == 0) Then Return SetError(-3, -3, -1) ; user selected cancel or struct settings incorrect
	$fontname = DllStructGetData($tLogFont, "FaceName")
	If (StringLen($fontname) == 0 And StringLen($sFontName) > 0) Then $fontname = $sFontName
	If (DllStructGetData($tLogFont, "Italic")) Then $italic = 2
	If (DllStructGetData($tLogFont, "Underline")) Then $underline = 4
	If (DllStructGetData($tLogFont, "Strikeout")) Then $strikeout = 8
	$attributes = BitOR($italic, $underline, $strikeout)
	$size = DllStructGetData($tChooseFont, "PointSize") / 10
	$colorref = DllStructGetData($tChooseFont, "rgbColors")
	$weight = DllStructGetData($tLogFont, "Weight")
	$color_picked = Hex(String($colorref), 6)
	Return StringSplit($attributes & "," & $fontname & "," & $size & "," & $weight & "," & $colorref & "," & '0x' & $color_picked & "," & '0x' & StringMid($color_picked, 5, 2) & StringMid($color_picked, 3, 2) & StringMid($color_picked, 1, 2), ",")
EndFunc   ;==>_ChooseFont
Func _ClipPutFile($sFile, $sSeperator = "|")
	Local $vDllCallTmp, $nGlobMemSize, $hGlobal, $DROPFILES, $i, $hLock
	Local $GMEM_MOVEABLE = 0x0002, $CF_HDROP = 15
	$sFile &= $sSeperator & $sSeperator
	$nGlobMemSize = (StringLen($sFile) + 20)
	$vDllCallTmp = DllCall("user32.dll", "int", "OpenClipboard", "hwnd", 0)
	If @error Or $vDllCallTmp[0] = 0 Then Return SetError(1, 1, False)
	$vDllCallTmp = DllCall("user32.dll", "int", "EmptyClipboard")
	If @error Or $vDllCallTmp[0] = 0 Then Return SetError(2, 2, False)
	$vDllCallTmp = DllCall("kernel32.dll", "hwnd", "GlobalAlloc", "int", $GMEM_MOVEABLE, "int", $nGlobMemSize)
	If @error Or $vDllCallTmp[0] < 1 Then Return SetError(3, 3, False)
	$hGlobal = $vDllCallTmp[0]
	$vDllCallTmp = DllCall("kernel32.dll", "hwnd", "GlobalLock", "long", $hGlobal)
	If @error Or $vDllCallTmp[0] < 1 Then Return SetError(4, 4, False)
	$hLock = $vDllCallTmp[0]
	$DROPFILES = DllStructCreate("dword;ptr;int;int;int;char[" & StringLen($sFile) + 1 & "]", $hLock)
	If @error Then Return SetError(5, 6, False)
	Local $tempStruct = DllStructCreate("dword;ptr;int;int;int")
	DllStructSetData($DROPFILES, 1, DllStructGetSize($tempStruct))
	DllStructSetData($DROPFILES, 2, 0)
	DllStructSetData($DROPFILES, 3, 0)
	DllStructSetData($DROPFILES, 4, 0)
	DllStructSetData($DROPFILES, 5, 0)
	DllStructSetData($DROPFILES, 6, $sFile)
	For $i = 1 To StringLen($sFile)
		If DllStructGetData($DROPFILES, 6, $i) = $sSeperator Then DllStructSetData($DROPFILES, 6, Chr(0), $i)
	Next
	$vDllCallTmp = DllCall("user32.dll", "long", "SetClipboardData", "int", $CF_HDROP, "long", $hGlobal)
	If @error Or $vDllCallTmp[0] < 1 Then Return SetError(6, 6, False)
	$vDllCallTmp = DllCall("user32.dll", "int", "CloseClipboard")
	If @error Or $vDllCallTmp[0] = 0 Then Return SetError(7, 7, False)
	$vDllCallTmp = DllCall("kernel32.dll", "int", "GlobalUnlock", "long", $hGlobal)
	If @error Then Return SetError(8, 8, False)
	$vDllCallTmp = DllCall("kernel32.dll", "int", "GetLastError")
	If $vDllCallTmp = 0 Then Return SetError(8, 9, False)
	Return True
EndFunc   ;==>_ClipPutFile
Func _Iif($fTest, $vTrueVal, $vFalseVal)
	If $fTest Then
		Return $vTrueVal
	Else
		Return $vFalseVal
	EndIf
EndFunc   ;==>_Iif
Func _MouseTrap($iLeft = 0, $iTop = 0, $iRight = 0, $iBottom = 0)
	Local $iResult, $tRect
	If @NumParams == 0 Then
		$iResult = DllCall("user32.dll", "int", "ClipCursor", "int", 0)
	Else
		If @NumParams == 2 Then
			$iRight = $iLeft + 1
			$iBottom = $iTop + 1
		EndIf
		$tRect = DllStructCreate($tagRect)
		If @error Then Return 0
		DllStructSetData($tRect, "Left", $iLeft)
		DllStructSetData($tRect, "Top", $iTop)
		DllStructSetData($tRect, "Right", $iRight)
		DllStructSetData($tRect, "Bottom", $iBottom)
		$iResult = DllCall("user32.dll", "int", "ClipCursor", "ptr", DllStructGetPtr($tRect))
	EndIf
	Return $iResult[0] <> 0
EndFunc   ;==>_MouseTrap
Func _Singleton($sOccurenceName, $iFlag = 0)
	Local Const $ERROR_ALREADY_EXISTS = 183
	Local Const $SECURITY_DESCRIPTOR_REVISION = 1
	Local $handle, $lastError, $pSecurityAttributes = 0
	If BitAND($iFlag, 2) Then
		; The size of SECURITY_DESCRIPTOR is 20 bytes.  We just
		; need a block of memory the right size, we aren't going to
		; access any members directly so it's not important what
		; the members are, just that the total size is correct.
		Local $structSecurityDescriptor = DllStructCreate("dword[5]")
		Local $pSecurityDescriptor = DllStructGetPtr($structSecurityDescriptor)
		; Initialize the security descriptor.
		Local $aRet = DllCall("advapi32.dll", "int", "InitializeSecurityDescriptor", _
				"ptr", $pSecurityDescriptor, "dword", $SECURITY_DESCRIPTOR_REVISION)
		If Not @error And $aRet[0] Then
			; Add the NULL DACL specifying access to everybody.
			$aRet = DllCall("advapi32.dll", "int", "SetSecurityDescriptorDacl", _
					"ptr", $pSecurityDescriptor, "int", 1, "ptr", 0, "int", 0)
			If Not @error And $aRet[0] Then
				; Create a SECURITY_ATTRIBUTES structure.
				Local $structSecurityAttributes = DllStructCreate("dword;ptr;int")
				; Assign the members.
				DllStructSetData($structSecurityAttributes, 1, DllStructGetSize($structSecurityAttributes))
				DllStructSetData($structSecurityAttributes, 2, $pSecurityDescriptor)
				DllStructSetData($structSecurityAttributes, 3, 0)
				; Everything went okay so update our pointer to point to our structure.
				$pSecurityAttributes = DllStructGetPtr($structSecurityAttributes)
			EndIf
		EndIf
	EndIf
	$handle = DllCall("kernel32.dll", "int", "CreateMutex", "ptr", $pSecurityAttributes, "long", 1, "str", $sOccurenceName)
	$lastError = DllCall("kernel32.dll", "int", "GetLastError")
	If $lastError[0] = $ERROR_ALREADY_EXISTS Then
		If BitAND($iFlag, 1) Then
			Return SetError($lastError[0], $lastError[0], 0)
		Else
			Exit -1
		EndIf
	EndIf
	Return $handle[0]
EndFunc   ;==>_Singleton
Func _IsPressed($sHexKey, $vDLL = 'user32.dll')
	; $hexKey must be the value of one of the keys.
	; _Is_Key_Pressed will return 0 if the key is not pressed, 1 if it is.
	Local $a_R = DllCall($vDLL, "int", "GetAsyncKeyState", "int", '0x' & $sHexKey)
	If Not @error And BitAND($a_R[0], 0x8000) = 0x8000 Then Return 1
	Return 0
EndFunc   ;==>_IsPressed
Func _VersionCompare($sVersion1, $sVersion2)
	If $sVersion1 = $sVersion2 Then Return 0
	Local $sep = "."
	If StringInStr($sVersion1, $sep) = 0 Then $sep = ","
	Local $aVersion1 = StringSplit($sVersion1, $sep)
	Local $aVersion2 = StringSplit($sVersion2, $sep)
	If UBound($aVersion1) <> UBound($aVersion2) Or UBound($aVersion1) = 0 Then
		; Compare as strings
		SetExtended(1)
		If $sVersion1 > $sVersion2 Then
			Return 1
		ElseIf $sVersion1 < $sVersion2 Then
			Return -1
		EndIf
	Else
		For $i = 1 To UBound($aVersion1) - 1
			; Compare this segment as numbers
			If StringIsDigit($aVersion1[$i]) And StringIsDigit($aVersion2[$i]) Then
				If Number($aVersion1[$i]) > Number($aVersion2[$i]) Then
					Return 1
				ElseIf Number($aVersion1[$i]) < Number($aVersion2[$i]) Then
					Return -1
				EndIf
			Else ; Compare the segment as strings
				SetExtended(1)
				If $aVersion1[$i] > $aVersion2[$i] Then
					Return 1
				ElseIf $aVersion1[$i] < $aVersion2[$i] Then
					Return -1
				EndIf
			EndIf
		Next
	EndIf
	; This point should never be reached
	SetError(2)
	Return 0
EndFunc   ;==>_VersionCompare
Func _MISC_GetDC($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetDC", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_MISC_GetDC
Func _MISC_GetDeviceCaps($hDC, $iIndex)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "GetDeviceCaps", "hwnd", $hDC, "int", $iIndex)
	Return $aResult[0]
EndFunc   ;==>_MISC_GetDeviceCaps
Func _MISC_ReleaseDC($hWnd, $hDC)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "ReleaseDC", "hwnd", $hWnd, "hwnd", $hDC)
	Return $aResult[0] <> 0
EndFunc   ;==>_MISC_ReleaseDC
Global $ini_file = @ScriptDir&'\ReflexRenderer.ini'
Global $ini_file_session = 'Session'
Global $ini_file_default = 'Default'
Global $ini_file_windows = 'Windows'
Global Const $options_line_string = '@Options:' ; Do not modify. Synchronized with the C++ version.
Func LoadParameter($type, $name, $control, $default='')
  $w = IniRead($ini_file, $type, $name, $default)
  If $w <> '' Then
    GUICtrlSetData($control, $w)
    Return True
  EndIf
  Return False
EndFunc
Func LoadCheckBox($type, $name, $control, $default='')
  $w = IniRead($ini_file, $type, $name, $default)
  If $w <> '' Then
    GUICtrlSetState($control, _Iif($w=='TRUE', $GUI_CHECKED, $GUI_UNCHECKED))
    Return True
  EndIf
  Return False
EndFunc
Func SaveCustomParameter($type, $name, $value)
  IniWrite($ini_file, $type, $name, $value)
EndFunc
Func SaveParameter($type, $name, $control)
  SaveCustomParameter($type, $name, GUICtrlRead($control))
EndFunc
Func SaveCustomCheckBox($type, $name, $value)
  IniWrite($ini_file, $type, $name, $value)
EndFunc
Func SaveCheckBox($type, $name, $control)
  SaveCustomCheckBox($type, $name, _Iif(BitAnd(GUICtrlRead($control),$GUI_CHECKED), 'TRUE', 'FALSE'))
EndFunc
Func LoadSessionParameter($name, $control, $default)
  Return LoadParameter($ini_file_session, $name, $control, $default)
EndFunc
Func LoadDefaultParameter($name, $control)
  Return LoadParameter($ini_file_default, $name, $control)
EndFunc
Func LoadSessionCheckBox($name, $control, $default)
  Return LoadCheckBox($ini_file_session, $name, $control, $default)
EndFunc
Func LoadDefaultCheckBox($name, $control)
  Return LoadCheckBox($ini_file_default, $name, $control)
EndFunc
Func SaveSessionParameter($name, $control)
  SaveParameter($ini_file_session, $name, $control)
EndFunc
Func SaveDefaultParameter($name, $value)
  SaveCustomParameter($ini_file_default, $name, $value)
EndFunc
Func SaveSessionCheckBox($name, $control)
  SaveCheckBox($ini_file_session, $name, $control)
EndFunc
Func SaveDefaultCheckBox($name, $value)
  SaveCustomCheckBox($ini_file_default, $name, $value)
EndFunc
Func LoadSaveboxParameter($name, $control, $default)
  Return LoadParameter('Savebox', $name, $control, $default)
EndFunc
Func LoadSaveboxCheckBox($name, $control, $default)
  Return LoadCheckBox('Savebox', $name, $control, $default)
EndFunc
Func SaveSaveboxParameter($name, $control)
  Return SaveParameter('Savebox', $name, $control)
EndFunc
Func SaveSaveboxCheckBox($name, $control)
  Return SaveCheckBox('Savebox', $name, $control)
EndFunc
Func IniReadSavebox($p1, $p2)
  Return IniRead($ini_file, 'Savebox', $p1, $p2)
EndFunc
Func IniReadSession($p1, $p2)
  Return IniRead($ini_file, 'Session', $p1, $p2)
EndFunc
Func IniWriteSavebox($p1, $p2)
  IniWrite($ini_file, 'Savebox', $p1, $p2)
EndFunc
Func isSavebox($parameter)
  Return IniReadSaveBox($parameter,'FALSE')=='TRUE'
EndFunc
Global Const $ERROR_NO_TOKEN = 1008
Global Const $SE_ASSIGNPRIMARYTOKEN_NAME = "SeAssignPrimaryTokenPrivilege"
Global Const $SE_AUDIT_NAME = "SeAuditPrivilege"
Global Const $SE_BACKUP_NAME = "SeBackupPrivilege"
Global Const $SE_CHANGE_NOTIFY_NAME = "SeChangeNotifyPrivilege"
Global Const $SE_CREATE_GLOBAL_NAME = "SeCreateGlobalPrivilege"
Global Const $SE_CREATE_PAGEFILE_NAME = "SeCreatePagefilePrivilege"
Global Const $SE_CREATE_PERMANENT_NAME = "SeCreatePermanentPrivilege"
Global Const $SE_CREATE_TOKEN_NAME = "SeCreateTokenPrivilege"
Global Const $SE_DEBUG_NAME = "SeDebugPrivilege"
Global Const $SE_ENABLE_DELEGATION_NAME = "SeEnableDelegationPrivilege"
Global Const $SE_IMPERSONATE_NAME = "SeImpersonatePrivilege"
Global Const $SE_INC_BASE_PRIORITY_NAME = "SeIncreaseBasePriorityPrivilege"
Global Const $SE_INCREASE_QUOTA_NAME = "SeIncreaseQuotaPrivilege"
Global Const $SE_LOAD_DRIVER_NAME = "SeLoadDriverPrivilege"
Global Const $SE_LOCK_MEMORY_NAME = "SeLockMemoryPrivilege"
Global Const $SE_MACHINE_ACCOUNT_NAME = "SeMachineAccountPrivilege"
Global Const $SE_MANAGE_VOLUME_NAME = "SeManageVolumePrivilege"
Global Const $SE_PROF_SINGLE_PROCESS_NAME = "SeProfileSingleProcessPrivilege"
Global Const $SE_REMOTE_SHUTDOWN_NAME = "SeRemoteShutdownPrivilege"
Global Const $SE_RESTORE_NAME = "SeRestorePrivilege"
Global Const $SE_SECURITY_NAME = "SeSecurityPrivilege"
Global Const $SE_SHUTDOWN_NAME = "SeShutdownPrivilege"
Global Const $SE_SYNC_AGENT_NAME = "SeSyncAgentPrivilege"
Global Const $SE_SYSTEM_ENVIRONMENT_NAME = "SeSystemEnvironmentPrivilege"
Global Const $SE_SYSTEM_PROFILE_NAME = "SeSystemProfilePrivilege"
Global Const $SE_SYSTEMTIME_NAME = "SeSystemtimePrivilege"
Global Const $SE_TAKE_OWNERSHIP_NAME = "SeTakeOwnershipPrivilege"
Global Const $SE_TCB_NAME = "SeTcbPrivilege"
Global Const $SE_UNSOLICITED_INPUT_NAME = "SeUnsolicitedInputPrivilege"
Global Const $SE_UNDOCK_NAME = "SeUndockPrivilege"
Global Const $SE_PRIVILEGE_ENABLED_BY_DEFAULT = 0x00000001
Global Const $SE_PRIVILEGE_ENABLED = 0x00000002
Global Const $SE_PRIVILEGE_REMOVED = 0x00000004
Global Const $SE_PRIVILEGE_USED_FOR_ACCESS = 0x80000000
Global Const $TOKENUSER = 1
Global Const $TOKENGROUPS = 2
Global Const $TOKENPRIVILEGES = 3
Global Const $TOKENOWNER = 4
Global Const $TOKENPRIMARYGROUP = 5
Global Const $TOKENDEFAULTDACL = 6
Global Const $TOKENSOURCE = 7
Global Const $TOKENTYPE = 8
Global Const $TOKENIMPERSONATIONLEVEL = 9
Global Const $TOKENSTATISTICS = 10
Global Const $TOKENRESTRICTEDSIDS = 11
Global Const $TOKENSESSIONID = 12
Global Const $TOKENGROUPSANDPRIVILEGES = 13
Global Const $TOKENSESSIONREFERENCE = 14
Global Const $TOKENSANDBOXINERT = 15
Global Const $TOKENAUDITPOLICY = 16
Global Const $TOKENORIGIN = 17
Global Const $TOKENELEVATIONTYPE = 18
Global Const $TOKENLINKEDTOKEN = 19
Global Const $TOKENELEVATION = 20
Global Const $TOKENHASRESTRICTIONS = 21
Global Const $TOKENACCESSINFORMATION = 22
Global Const $TOKENVIRTUALIZATIONALLOWED = 23
Global Const $TOKENVIRTUALIZATIONENABLED = 24
Global Const $TOKENINTEGRITYLEVEL = 25
Global Const $TOKENUIACCESS = 26
Global Const $TOKENMANDATORYPOLICY = 27
Global Const $TOKENLOGONSID = 28
Global Const $__SECURITYCONTANT_FORMAT_MESSAGE_FROM_SYSTEM = 0x1000
Func _Security__AdjustTokenPrivileges($hToken, $fDisableAll, $pNewState, $iBufferLen, $pPrevState = 0, $pRequired = 0)
	Local $aResult
	$aResult = DllCall("Advapi32.dll", "int", "AdjustTokenPrivileges", "hwnd", $hToken, "int", $fDisableAll, "ptr", $pNewState, _
			"int", $iBufferLen, "ptr", $pPrevState, "ptr", $pRequired)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Security__AdjustTokenPrivileges
Func _Security__GetAccountSid($sAccount, $sSystem = "")
	Local $aAcct
	$aAcct = _Security__LookupAccountName($sAccount, $sSystem)
	If @error Then Return SetError(@error, 0, 0)
	Return _Security__StringSidToSid($aAcct[0])
EndFunc   ;==>_Security__GetAccountSid
Func _Security__GetLengthSid($pSID)
	Local $aResult
	If Not _Security__IsValidSid($pSID) Then Return SetError(-1, 0, 0)
	$aResult = DllCall("AdvAPI32.dll", "int", "GetLengthSid", "ptr", $pSID)
	Return $aResult[0]
EndFunc   ;==>_Security__GetLengthSid
Func _Security__GetTokenInformation($hToken, $iClass)
	Local $pBuffer, $tBuffer, $aResult
	$aResult = DllCall("Advapi32.dll", "int", "GetTokenInformation", "hwnd", $hToken, "int", $iClass, "ptr", 0, "int", 0, "int*", 0)
	$tBuffer = DllStructCreate("byte[" & $aResult[5] & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$aResult = DllCall("Advapi32.dll", "int", "GetTokenInformation", "hwnd", $hToken, "int", $iClass, "ptr", $pBuffer, _
			"int", $aResult[5], "int*", 0)
	If $aResult[0] = 0 Then Return SetError(-1, 0, 0)
	Return SetError(0, 0, $tBuffer)
EndFunc   ;==>_Security__GetTokenInformation
Func _Security__ImpersonateSelf($iLevel = 2)
	Local $aResult
	$aResult = DllCall("Advapi32.dll", "int", "ImpersonateSelf", "int", $iLevel)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Security__ImpersonateSelf
Func _Security__IsValidSid($pSID)
	Local $aResult
	$aResult = DllCall("AdvAPI32.dll", "int", "IsValidSid", "ptr", $pSID)
	Return $aResult[0] <> 0
EndFunc   ;==>_Security__IsValidSid
Func _Security__LookupAccountName($sAccount, $sSystem = "")
	Local $tData, $pDomain, $pSID, $pSize1, $pSize2, $pSNU, $aResult, $aAcct[3]
	$tData = DllStructCreate("byte SID[256];char Domain[256];int SNU;int Size1;int Size2")
	$pSID = DllStructGetPtr($tData, "SID")
	$pDomain = DllStructGetPtr($tData, "Domain")
	$pSNU = DllStructGetPtr($tData, "SNU")
	$pSize1 = DllStructGetPtr($tData, "Size1")
	$pSize2 = DllStructGetPtr($tData, "Size2")
	DllStructSetData($tData, "Size1", 256)
	DllStructSetData($tData, "Size2", 256)
	$aResult = DllCall("AdvAPI32.dll", "int", "LookupAccountName", "str", $sSystem, "str", $sAccount, "ptr", $pSID, "ptr", $pSize1, _
			"ptr", $pDomain, "ptr", $pSize2, "ptr", $pSNU)
	If $aResult[0] <> 0 Then
		$aAcct[0] = _Security__SidToStringSid($pSID)
		$aAcct[1] = DllStructGetData($tData, "Domain")
		$aAcct[2] = DllStructGetData($tData, "SNU")
	EndIf
	Return SetError($aResult[0] = 0, 0, $aAcct)
EndFunc   ;==>_Security__LookupAccountName
Func _Security__LookupAccountSid($vSID)
	Local $tData, $pDomain, $pName, $pSID, $tSID, $pSize1, $pSize2, $pSNU, $aResult, $aAcct[3]
	If IsString($vSID) Then
		$tSID = _Security__StringSidToSid($vSID)
		$pSID = DllStructGetPtr($tSID)
	Else
		$pSID = $vSID
	EndIf
	If Not _Security__IsValidSid($pSID) Then Return SetError(-1, 0, 0)
	$tData = DllStructCreate("char Name[256];char Domain[256];int SNU;int Size1;int Size2")
	$pName = DllStructGetPtr($tData, "Name")
	$pDomain = DllStructGetPtr($tData, "Domain")
	$pSNU = DllStructGetPtr($tData, "SNU")
	$pSize1 = DllStructGetPtr($tData, "Size1")
	$pSize2 = DllStructGetPtr($tData, "Size2")
	DllStructSetData($tData, "Size1", 256)
	DllStructSetData($tData, "Size2", 256)
	$aResult = DllCall("AdvAPI32.dll", "int", "LookupAccountSid", "int", 0, "ptr", $pSID, "ptr", $pName, "ptr", $pSize1, _
			"ptr", $pDomain, "ptr", $pSize2, "ptr", $pSNU)
	$aAcct[0] = DllStructGetData($tData, "Name")
	$aAcct[1] = DllStructGetData($tData, "Domain")
	$aAcct[2] = DllStructGetData($tData, "SNU")
	Return SetError($aResult[0] = 0, 0, $aAcct)
EndFunc   ;==>_Security__LookupAccountSid
Func _Security__LookupPrivilegeValue($sSystem, $sName)
	Local $tData, $aResult
	$tData = DllStructCreate("int64 LUID")
	$aResult = DllCall("Advapi32.dll", "int", "LookupPrivilegeValue", "str", $sSystem, "str", $sName, "ptr", DllStructGetPtr($tData))
	Return SetError($aResult[0] = 0, 0, DllStructGetData($tData, "LUID"))
EndFunc   ;==>_Security__LookupPrivilegeValue
Func _Security__OpenProcessToken($hProcess, $iAccess)
	Local $aResult
	$aResult = DllCall("Advapi32.dll", "int", "OpenProcessToken", "hwnd", $hProcess, "dword", $iAccess, "int*", 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_Security__OpenProcessToken
Func _Security__OpenThreadToken($iAccess, $hThread = 0, $fOpenAsSelf = False)
	Local $tData, $pToken, $aResult
	If $hThread = 0 Then $hThread = _WinAPI_GetCurrentThread()
	$tData = DllStructCreate("int Token")
	$pToken = DllStructGetPtr($tData, "Token")
	$aResult = DllCall("Advapi32.dll", "int", "OpenThreadToken", "int", $hThread, "int", $iAccess, "int", $fOpenAsSelf, "ptr", $pToken)
	Return SetError($aResult[0] = 0, 0, DllStructGetData($tData, "Token"))
EndFunc   ;==>_Security__OpenThreadToken
Func _Security__OpenThreadTokenEx($iAccess, $hThread = 0, $fOpenAsSelf = False)
	Local $hToken
	$hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
	If $hToken = 0 Then
		If _WinAPI_GetLastError() = $ERROR_NO_TOKEN Then
			If Not _Security__ImpersonateSelf() Then Return SetError(-1, _WinAPI_GetLastError(), 0)
			$hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
			If $hToken = 0 Then Return SetError(-2, _WinAPI_GetLastError(), 0)
		Else
			Return SetError(-3, _WinAPI_GetLastError(), 0)
		EndIf
	EndIf
	Return SetError(0, 0, $hToken)
EndFunc   ;==>_Security__OpenThreadTokenEx
Func _Security__SetPrivilege($hToken, $sPrivilege, $fEnable)
	Local $pRequired, $tRequired, $iLUID, $iAttributes, $iCurrState, $pCurrState, $tCurrState, $iPrevState, $pPrevState, $tPrevState
	$iLUID = _Security__LookupPrivilegeValue("", $sPrivilege)
	If $iLUID = 0 Then Return SetError(-1, 0, False)
	$tCurrState = DllStructCreate($tagTOKEN_PRIVILEGES)
	$pCurrState = DllStructGetPtr($tCurrState)
	$iCurrState = DllStructGetSize($tCurrState)
	$tPrevState = DllStructCreate($tagTOKEN_PRIVILEGES)
	$pPrevState = DllStructGetPtr($tPrevState)
	$iPrevState = DllStructGetSize($tPrevState)
	$tRequired = DllStructCreate("int Data")
	$pRequired = DllStructGetPtr($tRequired)
	; Get current privilege setting
	DllStructSetData($tCurrState, "Count", 1)
	DllStructSetData($tCurrState, "LUID", $iLUID)
	If Not _Security__AdjustTokenPrivileges($hToken, False, $pCurrState, $iCurrState, $pPrevState, $pRequired) Then
		Return SetError(-2, @error, False)
	EndIf
	; Set privilege based on prior setting
	DllStructSetData($tPrevState, "Count", 1)
	DllStructSetData($tPrevState, "LUID", $iLUID)
	$iAttributes = DllStructGetData($tPrevState, "Attributes")
	If $fEnable Then
		$iAttributes = BitOR($iAttributes, $SE_PRIVILEGE_ENABLED)
	Else
		$iAttributes = BitAND($iAttributes, BitNOT($SE_PRIVILEGE_ENABLED))
	EndIf
	DllStructSetData($tPrevState, "Attributes", $iAttributes)
	If Not _Security__AdjustTokenPrivileges($hToken, False, $pPrevState, $iPrevState, $pCurrState, $pRequired) Then
		Return SetError(-3, @error, False)
	EndIf
	Return SetError(0, 0, True)
EndFunc   ;==>_Security__SetPrivilege
Func _Security__SidToStringSid($pSID)
	Local $tPtr, $tBuffer, $sSID, $aResult
	If Not _Security__IsValidSid($pSID) Then Return SetError(-1, 0, "")
	$tPtr = DllStructCreate("ptr Buffer")
	$aResult = DllCall("AdvAPI32.dll", "int", "ConvertSidToStringSid", "ptr", $pSID, "ptr", DllStructGetPtr($tPtr))
	If $aResult[0] = 0 Then Return SetError(-2, 0, "")
	$tBuffer = DllStructCreate("char Text[256]", DllStructGetData($tPtr, "Buffer"))
	$sSID = DllStructGetData($tBuffer, "Text")
	_WinAPI_LocalFree(DllStructGetData($tPtr, "Buffer"))
	Return $sSID
EndFunc   ;==>_Security__SidToStringSid
Func _Security__SidTypeStr($iType)
	Switch $iType
		Case 1
			Return "User"
		Case 2
			Return "Group"
		Case 3
			Return "Domain"
		Case 4
			Return "Alias"
		Case 5
			Return "Well Known Group"
		Case 6
			Return "Deleted Account"
		Case 7
			Return "Invalid"
		Case 8
			Return "Invalid"
		Case 9
			Return "Computer"
		Case Else
			Return "Unknown SID Type"
	EndSwitch
EndFunc   ;==>_Security__SidTypeStr
Func _Security__StringSidToSid($sSID)
	Local $tPtr, $iSize, $tBuffer, $tSID, $aResult
	$tPtr = DllStructCreate("ptr Buffer")
	$aResult = DllCall("AdvAPI32.dll", "int", "ConvertStringSidToSid", "str", $sSID, "ptr", DllStructGetPtr($tPtr))
	If $aResult = 0 Then Return SetError(-1, 0, 0)
	$iSize = _Security__GetLengthSid(DllStructGetData($tPtr, "Buffer"))
	$tBuffer = DllStructCreate("byte Data[" & $iSize & "]", DllStructGetData($tPtr, "Buffer"))
	$tSID = DllStructCreate("byte Data[" & $iSize & "]")
	DllStructSetData($tSID, "Data", DllStructGetData($tBuffer, "Data"))
	_WinAPI_LocalFree(DllStructGetData($tPtr, "Buffer"))
	Return $tSID
EndFunc   ;==>_Security__StringSidToSid
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lparam")
	Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessage", "hwnd", $hWnd, "int", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
	If @error Then Return SetError(@error, @extended, "")
	If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
	Return $aResult
EndFunc   ;==>_SendMessage
Func _SendMessageA($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lparam")
	Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageA", "hwnd", $hWnd, "int", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
	If @error Then Return SetError(@error, @extended, "")
	If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
	Return $aResult
EndFunc   ;==>_SendMessageA
Global $winapi_gaInProcess[64][2] = [[0, 0]]
Global $winapi_gaWinList[64][2] = [[0, 0]]
Global Const $__WINAPCONSTANT_WM_SETFONT = 0x0030
Global Const $__WINAPCONSTANT_FW_NORMAL = 400
Global Const $__WINAPCONSTANT_DEFAULT_CHARSET = 1
Global Const $__WINAPCONSTANT_OUT_DEFAULT_PRECIS = 0
Global Const $__WINAPCONSTANT_CLIP_DEFAULT_PRECIS = 0
Global Const $__WINAPCONSTANT_DEFAULT_QUALITY = 0
Global Const $__WINAPCONSTANT_FORMAT_MESSAGE_FROM_SYSTEM = 0x1000
Global Const $__WINAPCONSTANT_INVALID_SET_FILE_POINTER = -1
Global Const $__WINAPCONSTANT_TOKEN_ADJUST_PRIVILEGES = 0x00000020
Global Const $__WINAPCONSTANT_TOKEN_QUERY = 0x00000008
Global Const $__WINAPCONSTANT_LOGPIXELSX = 88
Global Const $__WINAPCONSTANT_LOGPIXELSY = 90
Global Const $__WINAPCONSTANT_FLASHW_CAPTION = 0x00000001
Global Const $__WINAPCONSTANT_FLASHW_TRAY = 0x00000002
Global Const $__WINAPCONSTANT_FLASHW_TIMER = 0x00000004
Global Const $__WINAPCONSTANT_FLASHW_TIMERNOFG = 0x0000000C
Global Const $__WINAPCONSTANT_GW_HWNDNEXT = 2
Global Const $__WINAPCONSTANT_GW_CHILD = 5
Global Const $__WINAPCONSTANT_DI_MASK = 0x0001
Global Const $__WINAPCONSTANT_DI_IMAGE = 0x0002
Global Const $__WINAPCONSTANT_DI_NORMAL = 0x0003
Global Const $__WINAPCONSTANT_DI_COMPAT = 0x0004
Global Const $__WINAPCONSTANT_DI_DEFAULTSIZE = 0x0008
Global Const $__WINAPCONSTANT_DI_NOMIRROR = 0x0010
Global Const $__WINAPCONSTANT_DISPLAY_DEVICE_ATTACHED_TO_DESKTOP = 0x00000001
Global Const $__WINAPCONSTANT_DISPLAY_DEVICE_PRIMARY_DEVICE = 0x00000004
Global Const $__WINAPCONSTANT_DISPLAY_DEVICE_MIRRORING_DRIVER = 0x00000008
Global Const $__WINAPCONSTANT_DISPLAY_DEVICE_VGA_COMPATIBLE = 0x00000010
Global Const $__WINAPCONSTANT_DISPLAY_DEVICE_REMOVABLE = 0x00000020
Global Const $__WINAPCONSTANT_DISPLAY_DEVICE_MODESPRUNED = 0x08000000
Global Const $__WINAPCONSTANT_CREATE_NEW = 1
Global Const $__WINAPCONSTANT_CREATE_ALWAYS = 2
Global Const $__WINAPCONSTANT_OPEN_EXISTING = 3
Global Const $__WINAPCONSTANT_OPEN_ALWAYS = 4
Global Const $__WINAPCONSTANT_TRUNCATE_EXISTING = 5
Global Const $__WINAPCONSTANT_FILE_ATTRIBUTE_READONLY = 0x00000001
Global Const $__WINAPCONSTANT_FILE_ATTRIBUTE_HIDDEN = 0x00000002
Global Const $__WINAPCONSTANT_FILE_ATTRIBUTE_SYSTEM = 0x00000004
Global Const $__WINAPCONSTANT_FILE_ATTRIBUTE_ARCHIVE = 0x00000020
Global Const $__WINAPCONSTANT_FILE_SHARE_READ = 0x00000001
Global Const $__WINAPCONSTANT_FILE_SHARE_WRITE = 0x00000002
Global Const $__WINAPCONSTANT_FILE_SHARE_DELETE = 0x00000004
Global Const $__WINAPCONSTANT_GENERIC_EXECUTE = 0x20000000
Global Const $__WINAPCONSTANT_GENERIC_WRITE = 0x40000000
Global Const $__WINAPCONSTANT_GENERIC_READ = 0x80000000
Global Const $NULL_BRUSH = 5 ; Null brush (equivalent to HOLLOW_BRUSH)
Global Const $NULL_PEN = 8 ; NULL pen. The null pen draws nothing
Global Const $BLACK_BRUSH = 4 ; Black brush
Global Const $DKGRAY_BRUSH = 3 ; Dark gray brush
Global Const $DC_BRUSH = 18 ; Windows 2000/XP: Solid color brush. The default color is white
Global Const $GRAY_BRUSH = 2 ; Gray brush
Global Const $HOLLOW_BRUSH = $NULL_BRUSH ; Hollow brush (equivalent to NULL_BRUSH)
Global Const $LTGRAY_BRUSH = 1 ; Light gray brush
Global Const $WHITE_BRUSH = 0 ; White brush
Global Const $BLACK_PEN = 7 ; Black pen
Global Const $DC_PEN = 19 ; Windows 2000/XP: Solid pen color. The default color is white
Global Const $WHITE_PEN = 6 ; White pen
Global Const $ANSI_FIXED_FONT = 11 ; Windows fixed-pitch (monospace) system font
Global Const $ANSI_VAR_FONT = 12 ; Windows variable-pitch (proportional space) system font
Global Const $DEVICE_DEFAULT_FONT = 14 ; Windows NT/2000/XP: Device-dependent font
Global Const $DEFAULT_GUI_FONT = 17 ; Default font for user interface objects such as menus and dialog boxes
Global Const $OEM_FIXED_FONT = 10 ; Original equipment manufacturer (OEM) dependent fixed-pitch (monospace) font
Global Const $SYSTEM_FONT = 13 ; System font. By default, the system uses the system font to draw menus, dialog box controls, and text
Global Const $SYSTEM_FIXED_FONT = 16 ; Fixed-pitch (monospace) system font. This stock object is provided only for compatibility with 16-bit Windows versions earlier than 3.0
Global Const $DEFAULT_PALETTE = 15 ; Default palette. This palette consists of the static colors in the system palette
Global Const $MB_PRECOMPOSED = 0x1
Global Const $MB_COMPOSITE = 0x2
Global Const $MB_USEGLYPHCHARS = 0x4
Global Const $ULW_ALPHA = 0x2
Global Const $ULW_COLORKEY = 0x1
Global Const $ULW_OPAQUE = 0x4
Global Const $WH_CALLWNDPROC = 4
Global Const $WH_CALLWNDPROCRET = 12
Global Const $WH_CBT = 5
Global Const $WH_DEBUG = 9
Global Const $WH_FOREGROUNDIDLE = 11
Global Const $WH_GETMESSAGE = 3
Global Const $WH_JOURNALPLAYBACK = 1
Global Const $WH_JOURNALRECORD = 0
Global Const $WH_KEYBOARD = 2
Global Const $WH_KEYBOARD_LL = 13
Global Const $WH_MOUSE = 7
Global Const $WH_MOUSE_LL = 14
Global Const $WH_MSGFILTER = -1
Global Const $WH_SHELL = 10
Global Const $WH_SYSMSGFILTER = 6
Global Const $WPF_ASYNCWINDOWPLACEMENT = 0x4
Global Const $WPF_RESTORETOMAXIMIZED = 0x2
Global Const $WPF_SETMINPOSITION = 0x1
Global Const $KF_EXTENDED = 0x100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_INJECTED = 0x10
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Global Const $OFN_ALLOWMULTISELECT = 0x200
Global Const $OFN_CREATEPROMPT = 0x2000
Global Const $OFN_DONTADDTORECENT = 0x2000000
Global Const $OFN_ENABLEHOOK = 0x20
Global Const $OFN_ENABLEINCLUDENOTIFY = 0x400000
Global Const $OFN_ENABLESIZING = 0x800000
Global Const $OFN_ENABLETEMPLATE = 0x40
Global Const $OFN_ENABLETEMPLATEHANDLE = 0x80
Global Const $OFN_EXPLORER = 0x80000
Global Const $OFN_EXTENSIONDIFFERENT = 0x400
Global Const $OFN_FILEMUSTEXIST = 0x1000
Global Const $OFN_FORCESHOWHIDDEN = 0x10000000
Global Const $OFN_HIDEREADONLY = 0x4
Global Const $OFN_LONGNAMES = 0x200000
Global Const $OFN_NOCHANGEDIR = 0x8
Global Const $OFN_NODEREFERENCELINKS = 0x100000
Global Const $OFN_NOLONGNAMES = 0x40000
Global Const $OFN_NONETWORKBUTTON = 0x20000
Global Const $OFN_NOREADONLYRETURN = 0x8000
Global Const $OFN_NOTESTFILECREATE = 0x10000
Global Const $OFN_NOVALIDATE = 0x100
Global Const $OFN_OVERWRITEPROMPT = 0x2
Global Const $OFN_PATHMUSTEXIST = 0x800
Global Const $OFN_READONLY = 0x1
Global Const $OFN_SHAREAWARE = 0x4000
Global Const $OFN_SHOWHELP = 0x10
Global Const $OFN_EX_NOPLACESBAR = 0x1
Func _WinAPI_AttachConsole($iProcessID = -1)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "AttachConsole", "dword", $iProcessID)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_AttachConsole
Func _WinAPI_AttachThreadInput($iAttach, $iAttachTo, $fAttach)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "AttachThreadInput", "int", $iAttach, "int", $iAttachTo, "int", $fAttach)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_AttachThreadInput
Func _WinAPI_Beep($iFreq = 500, $iDuration = 1000)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "Beep", "dword", $iFreq, "dword", $iDuration)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_Beep
Func _WinAPI_BitBlt($hDestDC, $iXDest, $iYDest, $iWidth, $iHeight, $hSrcDC, $iXSrc, $iYSrc, $iROP)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "BitBlt", "hwnd", $hDestDC, "int", $iXDest, "int", $iYDest, "int", $iWidth, "int", $iHeight, _
			"hwnd", $hSrcDC, "int", $iXSrc, "int", $iYSrc, "int", $iROP)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_BitBlt
Func _WinAPI_CallNextHookEx($hhk, $iCode, $wParam, $lParam)
	Local $iResult = DllCall("user32.dll", "lparam", "CallNextHookEx", "hwnd", $hhk, "int", $iCode, "wparam", $wParam, "lparam", $lParam)
	If @error Then Return SetError(@error, @extended, -1)
	Return $iResult[0]
EndFunc   ;==>_WinAPI_CallNextHookEx
Func _WinAPI_CallWindowProc($lpPrevWndFunc, $hWnd, $Msg, $wParam, $lParam)
	Local $aResult
	$aResult = DllCall('user32.dll', 'int', 'CallWindowProc', 'ptr', $lpPrevWndFunc, 'hwnd', $hWnd, 'uint', $Msg, 'wparam', $wParam, 'lparam', $lParam)
	If @error Then Return SetError(-1, 0, -1)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CallWindowProc
Func _WinAPI_Check($sFunction, $fError, $vError, $fTranslate = False)
	If $fError Then
		If $fTranslate Then $vError = _WinAPI_GetLastErrorMessage()
		_WinAPI_ShowError($sFunction & ": " & $vError)
	EndIf
EndFunc   ;==>_WinAPI_Check
Func _WinAPI_ClientToScreen($hWnd, ByRef $tPoint)
	Local $pPoint, $aResult
	$pPoint = DllStructGetPtr($tPoint)
	$aResult = DllCall("User32.dll", "int", "ClientToScreen", "hwnd", $hWnd, "ptr", $pPoint)
	If @error Then Return SetError(@error, 0, $tPoint)
	Return SetError($aResult[0] <> 0, 0, $tPoint)
EndFunc   ;==>_WinAPI_ClientToScreen
Func _WinAPI_CloseHandle($hObject)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "CloseHandle", "int", $hObject)
	_WinAPI_Check("_WinAPI_CloseHandle", ($aResult[0] = 0), 0, True)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_CloseHandle
Func _WinAPI_CombineRgn($hRgnDest, $hRgnSrc1, $hRgnSrc2, $iCombineMode)
	Local $aResult = DllCall("gdi32.dll", "int", "CombineRgn", "hwnd", $hRgnDest, "hwnd", $hRgnSrc1, "hwnd", $hRgnSrc2, "int", $iCombineMode)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CombineRgn
Func _WinAPI_CommDlgExtendedError()
	Local Const $CDERR_DIALOGFAILURE = 0xFFFF
	Local Const $CDERR_FINDRESFAILURE = 0x6
	Local Const $CDERR_INITIALIZATION = 0x2
	Local Const $CDERR_LOADRESFAILURE = 0x7
	Local Const $CDERR_LOADSTRFAILURE = 0x5
	Local Const $CDERR_LOCKRESFAILURE = 0x8
	Local Const $CDERR_MEMALLOCFAILURE = 0x9
	Local Const $CDERR_MEMLOCKFAILURE = 0xA
	Local Const $CDERR_NOHINSTANCE = 0x4
	Local Const $CDERR_NOHOOK = 0xB
	Local Const $CDERR_NOTEMPLATE = 0x3
	Local Const $CDERR_REGISTERMSGFAIL = 0xC
	Local Const $CDERR_STRUCTSIZE = 0x1
	Local Const $FNERR_BUFFERTOOSMALL = 0x3003
	Local Const $FNERR_INVALIDFILENAME = 0x3002
	Local Const $FNERR_SUBCLASSFAILURE = 0x3001
	Local $iResult = DllCall("comdlg32.dll", "dword", "CommDlgExtendedError")
	If @error Then Return SetError(@error, @extended, "")
	SetError($iResult[0])
	Switch @error
		Case $CDERR_DIALOGFAILURE
			Return SetError(@error, 0, "The dialog box could not be created." & @LF & _
					"The common dialog box function's call to the DialogBox function failed." & @LF & _
					"For example, this error occurs if the common dialog box call specifies an invalid window handle.")
		Case $CDERR_FINDRESFAILURE
			Return SetError(@error, 0, "The common dialog box function failed to find a specified resource.")
		Case $CDERR_INITIALIZATION
			Return SetError(@error, 0, "The common dialog box function failed during initialization." & @LF & "This error often occurs when sufficient memory is not available.")
		Case $CDERR_LOADRESFAILURE
			Return SetError(@error, 0, "The common dialog box function failed to load a specified resource.")
		Case $CDERR_LOADSTRFAILURE
			Return SetError(@error, 0, "The common dialog box function failed to load a specified string.")
		Case $CDERR_LOCKRESFAILURE
			Return SetError(@error, 0, "The common dialog box function failed to lock a specified resource.")
		Case $CDERR_MEMALLOCFAILURE
			Return SetError(@error, 0, "The common dialog box function was unable to allocate memory for internal structures.")
		Case $CDERR_MEMLOCKFAILURE
			Return SetError(@error, 0, "The common dialog box function was unable to lock the memory associated with a handle.")
		Case $CDERR_NOHINSTANCE
			Return SetError(@error, 0, "The ENABLETEMPLATE flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & _
					"but you failed to provide a corresponding instance handle.")
		Case $CDERR_NOHOOK
			Return SetError(@error, 0, "The ENABLEHOOK flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & _
					"but you failed to provide a pointer to a corresponding hook procedure.")
		Case $CDERR_NOTEMPLATE
			Return SetError(@error, 0, "The ENABLETEMPLATE flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & _
					"but you failed to provide a corresponding template.")
		Case $CDERR_REGISTERMSGFAIL
			Return SetError(@error, 0, "The RegisterWindowMessage function returned an error code when it was called by the common dialog box function.")
		Case $CDERR_STRUCTSIZE
			Return SetError(@error, 0, "The lStructSize member of the initialization structure for the corresponding common dialog box is invalid")
		Case $FNERR_BUFFERTOOSMALL
			Return SetError(@error, 0, "The buffer pointed to by the lpstrFile member of the OPENFILENAME structure is too small for the file name specified by the user." & @LF & _
					"The first two bytes of the lpstrFile buffer contain an integer value specifying the size, in TCHARs, required to receive the full name.")
		Case $FNERR_INVALIDFILENAME
			Return SetError(@error, 0, "A file name is invalid.")
		Case $FNERR_SUBCLASSFAILURE
			Return SetError(@error, 0, "An attempt to subclass a list box failed because sufficient memory was not available.")
	EndSwitch
EndFunc   ;==>_WinAPI_CommDlgExtendedError
Func _WinAPI_CopyIcon($hIcon)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "CopyIcon", "hwnd", $hIcon)
	_WinAPI_Check("_WinAPI_CopyIcon", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CopyIcon
Func _WinAPI_CreateBitmap($iWidth, $iHeight, $iPlanes = 1, $iBitsPerPel = 1, $pBits = 0)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "hwnd", "CreateBitmap", "int", $iWidth, "int", $iHeight, "int", $iPlanes, "int", $iBitsPerPel, "ptr", $pBits)
	_WinAPI_Check("_WinAPI_CreateBitmap", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CreateBitmap
Func _WinAPI_CreateCompatibleBitmap($hDC, $iWidth, $iHeight)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "hwnd", "CreateCompatibleBitmap", "hwnd", $hDC, "int", $iWidth, "int", $iHeight)
	_WinAPI_Check("_WinAPI_CreateCompatibleBitmap", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CreateCompatibleBitmap
Func _WinAPI_CreateCompatibleDC($hDC)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "hwnd", "CreateCompatibleDC", "hwnd", $hDC)
	_WinAPI_Check("_WinAPI_CreateCompatibleDC", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CreateCompatibleDC
Func _WinAPI_CreateEvent($pAttributes = 0, $fManualReset = True, $fInitialState = True, $sName = "")
	Local $aResult
	If $sName = "" Then $sName = 0
	$aResult = DllCall("Kernel32.dll", "int", "CreateEvent", "ptr", $pAttributes, "int", $fManualReset, "int", $fInitialState, "str", $sName)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CreateEvent
Func _WinAPI_CreateFile($sFileName, $iCreation, $iAccess = 4, $iShare = 0, $iAttributes = 0, $pSecurity = 0)
	Local $iDA = 0, $iSM = 0, $iCD = 0, $iFA = 0, $aResult
	If BitAND($iAccess, 1) <> 0 Then $iDA = BitOR($iDA, $__WINAPCONSTANT_GENERIC_EXECUTE)
	If BitAND($iAccess, 2) <> 0 Then $iDA = BitOR($iDA, $__WINAPCONSTANT_GENERIC_READ)
	If BitAND($iAccess, 4) <> 0 Then $iDA = BitOR($iDA, $__WINAPCONSTANT_GENERIC_WRITE)
	If BitAND($iShare, 1) <> 0 Then $iSM = BitOR($iSM, $__WINAPCONSTANT_FILE_SHARE_DELETE)
	If BitAND($iShare, 2) <> 0 Then $iSM = BitOR($iSM, $__WINAPCONSTANT_FILE_SHARE_READ)
	If BitAND($iShare, 4) <> 0 Then $iSM = BitOR($iSM, $__WINAPCONSTANT_FILE_SHARE_WRITE)
	Switch $iCreation
		Case 0
			$iCD = $__WINAPCONSTANT_CREATE_NEW
		Case 1
			$iCD = $__WINAPCONSTANT_CREATE_ALWAYS
		Case 2
			$iCD = $__WINAPCONSTANT_OPEN_EXISTING
		Case 3
			$iCD = $__WINAPCONSTANT_OPEN_ALWAYS
		Case 4
			$iCD = $__WINAPCONSTANT_TRUNCATE_EXISTING
	EndSwitch
	If BitAND($iAttributes, 1) <> 0 Then $iFA = BitOR($iFA, $__WINAPCONSTANT_FILE_ATTRIBUTE_ARCHIVE)
	If BitAND($iAttributes, 2) <> 0 Then $iFA = BitOR($iFA, $__WINAPCONSTANT_FILE_ATTRIBUTE_HIDDEN)
	If BitAND($iAttributes, 4) <> 0 Then $iFA = BitOR($iFA, $__WINAPCONSTANT_FILE_ATTRIBUTE_READONLY)
	If BitAND($iAttributes, 8) <> 0 Then $iFA = BitOR($iFA, $__WINAPCONSTANT_FILE_ATTRIBUTE_SYSTEM)
	$aResult = DllCall("Kernel32.dll", "hwnd", "CreateFile", "str", $sFileName, "int", $iDA, "int", $iSM, "ptr", $pSecurity, "int", $iCD, "int", $iFA, "int", 0)
	If @error Then Return SetError(@error, 0, 0)
	If $aResult[0] = 0xFFFFFFFF Then Return 0
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CreateFile
Func _WinAPI_CreateFont($nHeight, $nWidth, $nEscape = 0, $nOrientn = 0, $fnWeight = $__WINAPCONSTANT_FW_NORMAL, $bItalic = False, $bUnderline = False, $bStrikeout = False, $nCharset = $__WINAPCONSTANT_DEFAULT_CHARSET, $nOutputPrec = $__WINAPCONSTANT_OUT_DEFAULT_PRECIS, $nClipPrec = $__WINAPCONSTANT_CLIP_DEFAULT_PRECIS, $nQuality = $__WINAPCONSTANT_DEFAULT_QUALITY, $nPitch = 0, $szFace = 'Arial')
	Local $tBuffer = DllStructCreate("char FontName[" & StringLen($szFace) + 1 & "]")
	Local $pBuffer = DllStructGetPtr($tBuffer)
	Local $aFont
	DllStructSetData($tBuffer, "FontName", $szFace)
	$aFont = DllCall('gdi32.dll', 'hwnd', 'CreateFont', 'int', $nHeight, 'int', $nWidth, 'int', $nEscape, 'int', $nOrientn, _
			'int', $fnWeight, 'long', $bItalic, 'long', $bUnderline, 'long', $bStrikeout, 'long', $nCharset, 'long', $nOutputPrec, _
			'long', $nClipPrec, 'long', $nQuality, 'long', $nPitch, 'ptr', $pBuffer)
	If @error Then Return SetError(@error, 0, 0)
	Return $aFont[0]
EndFunc   ;==>_WinAPI_CreateFont
Func _WinAPI_CreateFontIndirect($tLogFont)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "hwnd", "CreateFontIndirect", "ptr", DllStructGetPtr($tLogFont))
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CreateFontIndirect
Func _WinAPI_CreatePen($iPenStyle, $iWidth, $nColor)
	Local $hPen = DllCall("gdi32.dll", "hwnd", "CreatePen", "int", $iPenStyle, "int", $iWidth, "int", $nColor)
	If @error Then Return SetError(@error, 0, 0)
	Return $hPen[0]
EndFunc   ;==>_WinAPI_CreatePen
Func _WinAPI_CreateProcess($sAppName, $sCommand, $pSecurity, $pThread, $fInherit, $iFlags, $pEnviron, $sDir, $pStartupInfo, $pProcess)
	Local $pAppName, $tAppName, $pCommand, $tCommand, $pDir, $tDir, $aResult
	If $sAppName <> "" Then
		$tAppName = DllStructCreate("char Text[" & StringLen($sAppName) + 1 & "]")
		$pAppName = DllStructGetPtr($tAppName)
		DllStructSetData($tAppName, "Text", $sAppName)
	EndIf
	If $sCommand <> "" Then
		$tCommand = DllStructCreate("char Text[" & StringLen($sCommand) + 1 & "]")
		$pCommand = DllStructGetPtr($tCommand)
		DllStructSetData($tCommand, "Text", $sCommand)
	EndIf
	If $sDir <> "" Then
		$tDir = DllStructCreate("char Text[" & StringLen($sDir) + 1 & "]")
		$pDir = DllStructGetPtr($tDir)
		DllStructSetData($tDir, "Text", $sDir)
	EndIf
	$aResult = DllCall("Kernel32.dll", "int", "CreateProcess", "ptr", $pAppName, "ptr", $pCommand, "ptr", $pSecurity, "ptr", $pThread, _
			"int", $fInherit, "int", $iFlags, "ptr", $pEnviron, "ptr", $pDir, "ptr", $pStartupInfo, "ptr", $pProcess)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_CreateProcess
Func _WinAPI_CreateRectRgn($iLeftRect, $iTopRect, $iRightRect, $iBottomRect)
	Local $hRgn = DllCall("gdi32.dll", "hwnd", "CreateRectRgn", "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect)
	If @error Then Return SetError(@error, 0, 0)
	Return $hRgn[0]
EndFunc   ;==>_WinAPI_CreateRectRgn
Func _WinAPI_CreateRoundRectRgn($iLeftRect, $iTopRect, $iRightRect, $iBottomRect, $iWidthEllipse, $iHeightEllipse)
	Local $hRgn = DllCall("gdi32.dll", "hwnd", "CreateRoundRectRgn", "int", $iLeftRect, "int", $iTopRect, "int", $iRightRect, "int", $iBottomRect, _
			"int", $iWidthEllipse, "int", $iHeightEllipse)
	If @error Then Return SetError(@error, 0, 0)
	Return $hRgn[0]
EndFunc   ;==>_WinAPI_CreateRoundRectRgn
Func _WinAPI_CreateSolidBitmap($hWnd, $iColor, $iWidth, $iHeight)
	Local $iI, $iSize, $tBits, $tBMI, $hDC, $hBmp
	$iSize = $iWidth * $iHeight
	$tBits = DllStructCreate("int[" & $iSize & "]")
	For $iI = 1 To $iSize
		DllStructSetData($tBits, 1, $iColor, $iI)
	Next
	$tBMI = DllStructCreate($tagBITMAPINFO)
	DllStructSetData($tBMI, "Size", DllStructGetSize($tBMI) - 4)
	DllStructSetData($tBMI, "Planes", 1)
	DllStructSetData($tBMI, "BitCount", 32)
	DllStructSetData($tBMI, "Width", $iWidth)
	DllStructSetData($tBMI, "Height", $iHeight)
	$hDC = _WinAPI_GetDC($hWnd)
	$hBmp = _WinAPI_CreateCompatibleBitmap($hDC, $iWidth, $iHeight)
	_WinAPI_SetDIBits(0, $hBmp, 0, $iHeight, DllStructGetPtr($tBits), DllStructGetPtr($tBMI))
	_WinAPI_ReleaseDC($hWnd, $hDC)
	Return $hBmp
EndFunc   ;==>_WinAPI_CreateSolidBitmap
Func _WinAPI_CreateSolidBrush($nColor)
	Local $hBrush = DllCall('gdi32.dll', 'hwnd', 'CreateSolidBrush', 'int', $nColor)
	If @error Then Return SetError(@error, 0, 0)
	Return $hBrush[0]
EndFunc   ;==>_WinAPI_CreateSolidBrush
Func _WinAPI_CreateWindowEx($iExStyle, $sClass, $sName, $iStyle, $iX, $iY, $iWidth, $iHeight, $hParent, $hMenu = 0, $hInstance = 0, $pParam = 0)
	Local $aResult
	If $hInstance = 0 Then $hInstance = _WinAPI_GetModuleHandle("")
	$aResult = DllCall("User32.dll", "hwnd", "CreateWindowEx", "int", $iExStyle, "str", $sClass, "str", $sName, "int", $iStyle, "int", $iX, _
			"int", $iY, "int", $iWidth, "int", $iHeight, "hwnd", $hParent, "hwnd", $hMenu, "hwnd", $hInstance, "ptr", $pParam)
	_WinAPI_Check("_WinAPI_CreateWindowEx", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_CreateWindowEx
Func _WinAPI_DefWindowProc($hWnd, $iMsg, $iwParam, $ilParam)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "DefWindowProc", "hwnd", $hWnd, "int", $iMsg, "int", $iwParam, "int", $ilParam)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_DefWindowProc
Func _WinAPI_DeleteDC($hDC)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "DeleteDC", "hwnd", $hDC)
	_WinAPI_Check("_WinAPI_DeleteDC", ($aResult[0] = 0), 0, True)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_DeleteDC
Func _WinAPI_DeleteObject($hObject)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "DeleteObject", "int", $hObject)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_DeleteObject
Func _WinAPI_DestroyIcon($hIcon)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "DestroyIcon", "hwnd", $hIcon)
	_WinAPI_Check("_WinAPI_DestroyIcon", ($aResult[0] = 0), 0, True)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_DestroyIcon
Func _WinAPI_DestroyWindow($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "DestroyWindow", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_DestroyWindow
Func _WinAPI_DrawEdge($hDC, $ptrRect, $nEdgeType, $grfFlags)
	Local $bResult = DllCall('user32.dll', 'int', 'DrawEdge', 'hwnd', $hDC, 'ptr', $ptrRect, 'int', $nEdgeType, 'int', $grfFlags)
	If @error Then Return SetError(@error, 0, False)
	Return $bResult[0] <> 0
EndFunc   ;==>_WinAPI_DrawEdge
Func _WinAPI_DrawFrameControl($hDC, $ptrRect, $nType, $nState)
	Local $bResult = DllCall('user32.dll', 'int', 'DrawFrameControl', 'hwnd', $hDC, 'ptr', $ptrRect, 'int', $nType, 'int', $nState)
	If @error Then Return SetError(@error, 0, False)
	Return $bResult[0] <> 0
EndFunc   ;==>_WinAPI_DrawFrameControl
Func _WinAPI_DrawIcon($hDC, $iX, $iY, $hIcon)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "DrawIcon", "hwnd", $hDC, "int", $iX, "int", $iY, "hwnd", $hIcon)
	_WinAPI_Check("_WinAPI_DrawIcon", ($aResult[0] = 0), 0, True)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_DrawIcon
Func _WinAPI_DrawIconEx($hDC, $iX, $iY, $hIcon, $iWidth = 0, $iHeight = 0, $iStep = 0, $hBrush = 0, $iFlags = 3)
	Local $iOptions, $aResult
	Switch $iFlags
		Case 1
			$iOptions = $__WINAPCONSTANT_DI_MASK
		Case 2
			$iOptions = $__WINAPCONSTANT_DI_IMAGE
		Case 3
			$iOptions = $__WINAPCONSTANT_DI_NORMAL
		Case 4
			$iOptions = $__WINAPCONSTANT_DI_COMPAT
		Case 5
			$iOptions = $__WINAPCONSTANT_DI_DEFAULTSIZE
		Case Else
			$iOptions = $__WINAPCONSTANT_DI_NOMIRROR
	EndSwitch
	$aResult = DllCall("User32.dll", "int", "DrawIconEx", "hwnd", $hDC, "int", $iX, "int", $iY, "hwnd", $hIcon, "int", $iWidth, _
			"int", $iHeight, "uint", $iStep, "hwnd", $hBrush, "uint", $iOptions)
	_WinAPI_Check("_WinAPI_DrawIconEx", ($aResult[0] = 0), 0, True)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_DrawIconEx
Func _WinAPI_DrawLine($hDC, $iX1, $iY1, $iX2, $iY2)
	_WinAPI_MoveTo($hDC, $iX1, $iY1)
	If @error Then Return SetError(@error, 0, False)
	_WinAPI_LineTo($hDC, $iX2, $iY2)
	If @error Then Return SetError(@error, 0, False)
	Return True
EndFunc   ;==>_WinAPI_DrawLine
Func _WinAPI_DrawText($hDC, $sText, ByRef $tRect, $iFlags)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "DrawText", "hwnd", $hDC, "str", $sText, "int", -1, "ptr", DllStructGetPtr($tRect), "int", $iFlags)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_DrawText
Func _WinAPI_EnableWindow($hWnd, $fEnable = True)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "EnableWindow", "hwnd", $hWnd, "int", $fEnable)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_EnableWindow
Func _WinAPI_EnumDisplayDevices($sDevice, $iDevNum)
	Local $pName, $tName, $iDevice, $pDevice, $tDevice, $iN, $iFlags, $aResult, $aDevice[5]
	If $sDevice <> "" Then
		$tName = DllStructCreate("char Text[128]")
		$pName = DllStructGetPtr($tName)
		DllStructSetData($tName, "Text", $sDevice)
	EndIf
	$tDevice = DllStructCreate($tagDISPLAY_DEVICE)
	$pDevice = DllStructGetPtr($tDevice)
	$iDevice = DllStructGetSize($tDevice)
	DllStructSetData($tDevice, "Size", $iDevice)
	$aResult = DllCall("User32.dll", "int", "EnumDisplayDevices", "ptr", $pName, "int", $iDevNum, "ptr", $pDevice, "int", 1)
	If @error Then Return SetError(@error, 0, $aDevice)
	$iN = DllStructGetData($tDevice, "Flags")
	If BitAND($iN, $__WINAPCONSTANT_DISPLAY_DEVICE_ATTACHED_TO_DESKTOP) <> 0 Then $iFlags = BitOR($iFlags, 1)
	If BitAND($iN, $__WINAPCONSTANT_DISPLAY_DEVICE_PRIMARY_DEVICE) <> 0 Then $iFlags = BitOR($iFlags, 2)
	If BitAND($iN, $__WINAPCONSTANT_DISPLAY_DEVICE_MIRRORING_DRIVER) <> 0 Then $iFlags = BitOR($iFlags, 4)
	If BitAND($iN, $__WINAPCONSTANT_DISPLAY_DEVICE_VGA_COMPATIBLE) <> 0 Then $iFlags = BitOR($iFlags, 8)
	If BitAND($iN, $__WINAPCONSTANT_DISPLAY_DEVICE_REMOVABLE) <> 0 Then $iFlags = BitOR($iFlags, 16)
	If BitAND($iN, $__WINAPCONSTANT_DISPLAY_DEVICE_MODESPRUNED) <> 0 Then $iFlags = BitOR($iFlags, 32)
	$aDevice[0] = $aResult[0] <> 0
	$aDevice[1] = DllStructGetData($tDevice, "Name")
	$aDevice[2] = DllStructGetData($tDevice, "String")
	$aDevice[3] = $iFlags
	$aDevice[4] = DllStructGetData($tDevice, "ID")
	Return $aDevice
EndFunc   ;==>_WinAPI_EnumDisplayDevices
Func _WinAPI_EnumWindows($fVisible = True)
	_WinAPI_EnumWindowsInit()
	_WinAPI_EnumWindowsChild(_WinAPI_GetDesktopWindow(), $fVisible)
	Return $winapi_gaWinList
EndFunc   ;==>_WinAPI_EnumWindows
Func _WinAPI_EnumWindowsAdd($hWnd, $sClass = "")
	Local $iCount
	If $sClass = "" Then $sClass = _WinAPI_GetClassName($hWnd)
	$winapi_gaWinList[0][0] += 1
	$iCount = $winapi_gaWinList[0][0]
	If $iCount >= $winapi_gaWinList[0][1] Then
		ReDim $winapi_gaWinList[$iCount + 64][2]
		$winapi_gaWinList[0][1] += 64
	EndIf
	$winapi_gaWinList[$iCount][0] = $hWnd
	$winapi_gaWinList[$iCount][1] = $sClass
EndFunc   ;==>_WinAPI_EnumWindowsAdd
Func _WinAPI_EnumWindowsChild($hWnd, $fVisible = True)
	$hWnd = _WinAPI_GetWindow($hWnd, $__WINAPCONSTANT_GW_CHILD)
	While $hWnd <> 0
		If (Not $fVisible) Or _WinAPI_IsWindowVisible($hWnd) Then
			_WinAPI_EnumWindowsChild($hWnd, $fVisible)
			_WinAPI_EnumWindowsAdd($hWnd)
		EndIf
		$hWnd = _WinAPI_GetWindow($hWnd, $__WINAPCONSTANT_GW_HWNDNEXT)
	WEnd
EndFunc   ;==>_WinAPI_EnumWindowsChild
Func _WinAPI_EnumWindowsInit()
	ReDim $winapi_gaWinList[64][2]
	$winapi_gaWinList[0][0] = 0
	$winapi_gaWinList[0][1] = 64
EndFunc   ;==>_WinAPI_EnumWindowsInit
Func _WinAPI_EnumWindowsPopup()
	Local $hWnd, $sClass
	_WinAPI_EnumWindowsInit()
	$hWnd = _WinAPI_GetWindow(_WinAPI_GetDesktopWindow(), $__WINAPCONSTANT_GW_CHILD)
	While $hWnd <> 0
		If _WinAPI_IsWindowVisible($hWnd) Then
			$sClass = _WinAPI_GetClassName($hWnd)
			If $sClass = "#32768" Then
				_WinAPI_EnumWindowsAdd($hWnd)
			ElseIf $sClass = "ToolbarWindow32" Then
				_WinAPI_EnumWindowsAdd($hWnd)
			ElseIf $sClass = "ToolTips_Class32" Then
				_WinAPI_EnumWindowsAdd($hWnd)
			ElseIf $sClass = "BaseBar" Then
				_WinAPI_EnumWindowsChild($hWnd)
			EndIf
		EndIf
		$hWnd = _WinAPI_GetWindow($hWnd, $__WINAPCONSTANT_GW_HWNDNEXT)
	WEnd
	Return $winapi_gaWinList
EndFunc   ;==>_WinAPI_EnumWindowsPopup
Func _WinAPI_EnumWindowsTop()
	Local $hWnd
	_WinAPI_EnumWindowsInit()
	$hWnd = _WinAPI_GetWindow(_WinAPI_GetDesktopWindow(), $__WINAPCONSTANT_GW_CHILD)
	While $hWnd <> 0
		If _WinAPI_IsWindowVisible($hWnd) Then _WinAPI_EnumWindowsAdd($hWnd)
		$hWnd = _WinAPI_GetWindow($hWnd, $__WINAPCONSTANT_GW_HWNDNEXT)
	WEnd
	Return $winapi_gaWinList
EndFunc   ;==>_WinAPI_EnumWindowsTop
Func _WinAPI_ExpandEnvironmentStrings($sString)
	Local $tText, $aResult
	$tText = DllStructCreate("char Text[4096]")
	$aResult = DllCall("Kernel32.dll", "int", "ExpandEnvironmentStringsA", "str", $sString, "ptr", DllStructGetPtr($tText), "int", 4096)
	_WinAPI_Check("_WinAPI_ExpandEnvironmentStrings", ($aResult[0] = 0), 0, True)
	Return DllStructGetData($tText, "Text")
EndFunc   ;==>_WinAPI_ExpandEnvironmentStrings
Func _WinAPI_ExtractIconEx($sFile, $iIndex, $pLarge, $pSmall, $iIcons)
	Local $aResult
	$aResult = DllCall("Shell32.dll", "int", "ExtractIconEx", "str", $sFile, "int", $iIndex, "ptr", $pLarge, "ptr", $pSmall, "int", $iIcons)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_ExtractIconEx
Func _WinAPI_FatalAppExit($sMessage)
	DllCall("Kernel32.dll", "none", "FatalAppExit", "uint", 0, "str", $sMessage)
EndFunc   ;==>_WinAPI_FatalAppExit
Func _WinAPI_FillRect($hDC, $ptrRect, $hBrush)
	Local $bResult
	If IsHWnd($hBrush) Then
		$bResult = DllCall('user32.dll', 'int', 'FillRect', 'hwnd', $hDC, 'ptr', $ptrRect, 'hwnd', $hBrush)
	Else
		$bResult = DllCall('user32.dll', 'int', 'FillRect', 'hwnd', $hDC, 'ptr', $ptrRect, 'int', $hBrush)
	EndIf
	If @error Then Return SetError(@error, 0, False)
	Return $bResult[0] <> 0
EndFunc   ;==>_WinAPI_FillRect
Func _WinAPI_FindExecutable($sFileName, $sDirectory = "")
	Local $tText
	$tText = DllStructCreate("char Text[4096]")
	DllCall("Shell32.dll", "hwnd", "FindExecutable", "str", $sFileName, "str", $sDirectory, "ptr", DllStructGetPtr($tText))
	If @error Then Return SetError(@error, 0, 0)
	Return DllStructGetData($tText, "Text")
EndFunc   ;==>_WinAPI_FindExecutable
Func _WinAPI_FindWindow($sClassName, $sWindowName)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "FindWindow", "str", $sClassName, "str", $sWindowName)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_FindWindow
Func _WinAPI_FlashWindow($hWnd, $fInvert = True)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "FlashWindow", "hwnd", $hWnd, "int", $fInvert)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_FlashWindow
Func _WinAPI_FlashWindowEx($hWnd, $iFlags = 3, $iCount = 3, $iTimeout = 0)
	Local $iMode = 0, $iFlash, $pFlash, $tFlash, $aResult
	$tFlash = DllStructCreate($tagFLASHWINDOW)
	$pFlash = DllStructGetPtr($tFlash)
	$iFlash = DllStructGetSize($tFlash)
	If BitAND($iFlags, 1) <> 0 Then $iMode = BitOR($iMode, $__WINAPCONSTANT_FLASHW_CAPTION)
	If BitAND($iFlags, 2) <> 0 Then $iMode = BitOR($iMode, $__WINAPCONSTANT_FLASHW_TRAY)
	If BitAND($iFlags, 4) <> 0 Then $iMode = BitOR($iMode, $__WINAPCONSTANT_FLASHW_TIMER)
	If BitAND($iFlags, 8) <> 0 Then $iMode = BitOR($iMode, $__WINAPCONSTANT_FLASHW_TIMERNOFG)
	DllStructSetData($tFlash, "Size", $iFlash)
	DllStructSetData($tFlash, "hWnd", $hWnd)
	DllStructSetData($tFlash, "Flags", $iMode)
	DllStructSetData($tFlash, "Count", $iCount)
	DllStructSetData($tFlash, "Timeout", $iTimeout)
	$aResult = DllCall("User32.dll", "int", "FlashWindowEx", "ptr", $pFlash)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_FlashWindowEx
Func _WinAPI_FloatToInt($nFloat)
	Local $tFloat, $tInt
	$tFloat = DllStructCreate("float")
	$tInt = DllStructCreate("int", DllStructGetPtr($tFloat))
	DllStructSetData($tFloat, 1, $nFloat)
	Return DllStructGetData($tInt, 1)
EndFunc   ;==>_WinAPI_FloatToInt
Func _WinAPI_FlushFileBuffers($hFile)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "FlushFileBuffers", "hwnd", $hFile)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_FlushFileBuffers
Func _WinAPI_FormatMessage($iFlags, $pSource, $iMessageID, $iLanguageID, $pBuffer, $iSize, $vArguments)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "FormatMessageA", "int", $iFlags, "hwnd", $pSource, "int", $iMessageID, "int", $iLanguageID, _
			"ptr", $pBuffer, "int", $iSize, "ptr", $vArguments)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_FormatMessage
Func _WinAPI_FrameRect($hDC, $ptrRect, $hBrush)
	Local $bResult = DllCall('user32.dll', 'int', 'FrameRect', 'hwnd', $hDC, 'ptr', $ptrRect, 'hwnd', $hBrush)
	If @error Then Return SetError(@error, 0, False)
	Return $bResult[0] <> 0
EndFunc   ;==>_WinAPI_FrameRect
Func _WinAPI_FreeLibrary($hModule)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "hwnd", "FreeLibrary", "hwnd", $hModule)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_FreeLibrary
Func _WinAPI_GetAncestor($hWnd, $iFlags = 1)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetAncestor", "hwnd", $hWnd, "uint", $iFlags)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetAncestor
Func _WinAPI_GetAsyncKeyState($iKey)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "GetAsyncKeyState", "int", $iKey)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetAsyncKeyState
Func _WinAPI_GetBkMode($hDC)
	Local $aResult = DllCall("gdi32.dll", "int", "GetBkMode", "ptr", $hDC)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetBkMode
Func _WinAPI_GetClassName($hWnd)
	Local $aResult
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	$aResult = DllCall("User32.dll", "int", "GetClassName", "hwnd", $hWnd, "str", "", "int", 4096)
	If @error Then Return SetError(@error, 0, "")
	Return $aResult[2]
EndFunc   ;==>_WinAPI_GetClassName
Func _WinAPI_GetClientHeight($hWnd)
	Local $tRect
	$tRect = _WinAPI_GetClientRect($hWnd)
	Return DllStructGetData($tRect, "Bottom") - DllStructGetData($tRect, "Top")
EndFunc   ;==>_WinAPI_GetClientHeight
Func _WinAPI_GetClientWidth($hWnd)
	Local $tRect
	$tRect = _WinAPI_GetClientRect($hWnd)
	Return DllStructGetData($tRect, "Right") - DllStructGetData($tRect, "Left")
EndFunc   ;==>_WinAPI_GetClientWidth
Func _WinAPI_GetClientRect($hWnd)
	Local $tRect, $aResult
	$tRect = DllStructCreate($tagRECT)
	$aResult = DllCall("User32.dll", "int", "GetClientRect", "hwnd", $hWnd, "ptr", DllStructGetPtr($tRect))
	_WinAPI_Check("_WinAPI_GetClientRect", ($aResult[0] = 0), 0, True)
	Return $tRect
EndFunc   ;==>_WinAPI_GetClientRect
Func _WinAPI_GetCurrentProcess()
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "hwnd", "GetCurrentProcess")
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetCurrentProcess
Func _WinAPI_GetCurrentProcessID()
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GetCurrentProcessId")
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetCurrentProcessID
Func _WinAPI_GetCurrentThread()
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GetCurrentThread")
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetCurrentThread
Func _WinAPI_GetCurrentThreadId()
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GetCurrentThreadId")
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetCurrentThreadId
Func _WinAPI_GetCursorInfo()
	Local $iCursor, $tCursor, $aResult, $aCursor[5]
	$tCursor = DllStructCreate($tagCURSORINFO)
	$iCursor = DllStructGetSize($tCursor)
	DllStructSetData($tCursor, "Size", $iCursor)
	$aResult = DllCall("User32.dll", "int", "GetCursorInfo", "ptr", DllStructGetPtr($tCursor))
	_WinAPI_Check("_WinAPI_GetCursorInfo", ($aResult[0] = 0), 0, True)
	$aCursor[0] = $aResult[0] <> 0
	$aCursor[1] = DllStructGetData($tCursor, "Flags") <> 0
	$aCursor[2] = DllStructGetData($tCursor, "hCursor")
	$aCursor[3] = DllStructGetData($tCursor, "X")
	$aCursor[4] = DllStructGetData($tCursor, "Y")
	Return $aCursor
EndFunc   ;==>_WinAPI_GetCursorInfo
Func _WinAPI_GetDC($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetDC", "hwnd", $hWnd)
	_WinAPI_Check("_WinAPI_GetDC", ($aResult[0] = 0), -1)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetDC
Func _WinAPI_GetDesktopWindow()
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetDesktopWindow")
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetDesktopWindow
Func _WinAPI_GetDeviceCaps($hDC, $iIndex)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "GetDeviceCaps", "hwnd", $hDC, "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetDeviceCaps
Func _WinAPI_GetDIBits($hDC, $hBmp, $iStartScan, $iScanLines, $pBits, $pBI, $iUsage)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "GetDIBits", "hwnd", $hDC, "hwnd", $hBmp, "int", $iStartScan, "int", $iScanLines, _
			"ptr", $pBits, "ptr", $pBI, "int", $iUsage)
	_WinAPI_Check("_WinAPI_GetDIBits", ($aResult[0] = 0), 0, True)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_GetDIBits
Func _WinAPI_GetDlgCtrlID($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetDlgCtrlID", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetDlgCtrlID
Func _WinAPI_GetDlgItem($hWnd, $iItemID)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetDlgItem", "hwnd", $hWnd, "int", $iItemID)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetDlgItem
Func _WinAPI_GetFocus()
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetFocus")
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetFocus
Func _WinAPI_GetForegroundWindow()
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetForegroundWindow")
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetForegroundWindow
Func _WinAPI_GetIconInfo($hIcon)
	Local $tInfo, $aResult, $aIcon[6]
	$tInfo = DllStructCreate($tagICONINFO)
	$aResult = DllCall("User32.dll", "int", "GetIconInfo", "hwnd", $hIcon, "ptr", DllStructGetPtr($tInfo))
	_WinAPI_Check("_WinAPI_GetIconInfo", ($aResult[0] = 0), 0, True)
	$aIcon[0] = $aResult[0] <> 0
	$aIcon[1] = DllStructGetData($tInfo, "Icon") <> 0
	$aIcon[2] = DllStructGetData($tInfo, "XHotSpot")
	$aIcon[3] = DllStructGetData($tInfo, "YHotSpot")
	$aIcon[4] = DllStructGetData($tInfo, "hMask")
	$aIcon[5] = DllStructGetData($tInfo, "hColor")
	Return $aIcon
EndFunc   ;==>_WinAPI_GetIconInfo
Func _WinAPI_GetFileSizeEx($hFile)
	Local $tSize
	$tSize = DllStructCreate("int64 Size")
	DllCall("Kernel32.dll", "int", "GetFileSizeEx", "hwnd", $hFile, "ptr", DllStructGetPtr($tSize))
	Return SetError(_WinAPI_GetLastError(), 0, DllStructGetData($tSize, "Size"))
EndFunc   ;==>_WinAPI_GetFileSizeEx
Func _WinAPI_GetLastError()
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GetLastError")
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetLastError
Func _WinAPI_GetLastErrorMessage()
	Local $tText
	$tText = DllStructCreate("char Text[4096]")
	_WinAPI_FormatMessage($__WINAPCONSTANT_FORMAT_MESSAGE_FROM_SYSTEM, 0, _WinAPI_GetLastError(), 0, DllStructGetPtr($tText), 4096, 0)
	Return DllStructGetData($tText, "Text")
EndFunc   ;==>_WinAPI_GetLastErrorMessage
Func _WinAPI_GetModuleHandle($sModuleName)
	Local $tText, $aResult
	If $sModuleName <> "" Then
		$tText = DllStructCreate("char Text[4096]")
		DllStructSetData($tText, "Text", $sModuleName)
		$aResult = DllCall("Kernel32.dll", "hwnd", "GetModuleHandle", "ptr", DllStructGetPtr($tText))
	Else
		$aResult = DllCall("Kernel32.dll", "hwnd", "GetModuleHandle", "ptr", 0)
	EndIf
	_WinAPI_Check("_WinAPI_GetModuleHandle", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetModuleHandle
Func _WinAPI_GetMousePos($fToClient = False, $hWnd = 0)
	Local $iMode, $aPos, $tPoint
	$iMode = Opt("MouseCoordMode", 1)
	$aPos = MouseGetPos()
	Opt("MouseCoordMode", $iMode)
	$tPoint = DllStructCreate($tagPOINT)
	DllStructSetData($tPoint, "X", $aPos[0])
	DllStructSetData($tPoint, "Y", $aPos[1])
	If $fToClient Then _WinAPI_ScreenToClient($hWnd, $tPoint)
	Return $tPoint
EndFunc   ;==>_WinAPI_GetMousePos
Func _WinAPI_GetMousePosX($fToClient = False, $hWnd = 0)
	Local $tPoint
	$tPoint = _WinAPI_GetMousePos($fToClient, $hWnd)
	Return DllStructGetData($tPoint, "X")
EndFunc   ;==>_WinAPI_GetMousePosX
Func _WinAPI_GetMousePosY($fToClient = False, $hWnd = 0)
	Local $tPoint
	$tPoint = _WinAPI_GetMousePos($fToClient, $hWnd)
	Return DllStructGetData($tPoint, "Y")
EndFunc   ;==>_WinAPI_GetMousePosY
Func _WinAPI_GetObject($hObject, $iSize, $pObject)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "GetObject", "int", $hObject, "int", $iSize, "ptr", $pObject)
	_WinAPI_Check("_WinAPI_GetObject", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetObject
Func _WinAPI_GetOpenFileName($sTitle = "", $sFilter = "All files (*.*)", $sInitalDir = ".", $sDefaultFile = "", $sDefaultExt = "", $iFilterIndex = 1, $iFlags = 0, $iFlagsEx = 0, $hwndOwner = 0)
	Local $iPathLen = 4096 ; Max chars in returned string
	Local $iNulls = 0
	Local $tOFN = DllStructCreate($tagOPENFILENAME)
	Local $aFiles[1]
	Local $iFlag = $iFlags
	; Filter string to array conversion
	Local $asFLines = StringSplit($sFilter, "|")
	Local $asFilter[$asFLines[0] * 2 + 1]
	Local $i, $iStart, $iFinal, $stFilter
	$asFilter[0] = $asFLines[0] * 2
	For $i = 1 To $asFLines[0]
		$iStart = StringInStr($asFLines[$i], "(", 0, 1)
		$iFinal = StringInStr($asFLines[$i], ")", 0, -1)
		$asFilter[$i * 2 - 1] = StringStripWS(StringLeft($asFLines[$i], $iStart - 1), 3)
		$asFilter[$i * 2] = StringStripWS(StringTrimRight(StringTrimLeft($asFLines[$i], $iStart), StringLen($asFLines[$i]) - $iFinal + 1), 3)
		$stFilter &= "char[" & StringLen($asFilter[$i * 2 - 1]) + 1 & "];char[" & StringLen($asFilter[$i * 2]) + 1 & "];"
	Next
	Local $tTitle = DllStructCreate("char Title[" & StringLen($sTitle) + 1 & "]")
	Local $tInitialDir = DllStructCreate("char InitDir[" & StringLen($sInitalDir) + 1 & "]")
	Local $tFilter = DllStructCreate($stFilter & "char")
	Local $tPath = DllStructCreate("char Path[" & $iPathLen & "]")
	Local $tExtn = DllStructCreate("char Extension[" & StringLen($sDefaultExt) + 1 & "]")
	For $i = 1 To $asFilter[0]
		DllStructSetData($tFilter, $i, $asFilter[$i])
	Next
	Local $iResult
	; Set Data of API structures
	DllStructSetData($tTitle, "Title", $sTitle)
	DllStructSetData($tInitialDir, "InitDir", $sInitalDir)
	DllStructSetData($tPath, "Path", $sDefaultFile)
	DllStructSetData($tExtn, "Extension", $sDefaultExt)
	DllStructSetData($tOFN, "StructSize", DllStructGetSize($tOFN))
	DllStructSetData($tOFN, "hwndOwner", $hwndOwner)
	DllStructSetData($tOFN, "lpstrFilter", DllStructGetPtr($tFilter))
	DllStructSetData($tOFN, "nFilterIndex", $iFilterIndex)
	DllStructSetData($tOFN, "lpstrFile", DllStructGetPtr($tPath))
	DllStructSetData($tOFN, "nMaxFile", $iPathLen)
	DllStructSetData($tOFN, "lpstrInitialDir", DllStructGetPtr($tInitialDir))
	DllStructSetData($tOFN, "lpstrTitle", DllStructGetPtr($tTitle))
	DllStructSetData($tOFN, "Flags", $iFlag)
	DllStructSetData($tOFN, "lpstrDefExt", DllStructGetPtr($tExtn))
	DllStructSetData($tOFN, "FlagsEx", $iFlagsEx)
	$iResult = DllCall("comdlg32.dll", "int", "GetOpenFileName", "ptr", DllStructGetPtr($tOFN))
	If @error Or $iResult[0] = 0 Then Return SetError(@error, @extended, $aFiles)
	If BitAND($iFlags, $OFN_ALLOWMULTISELECT) = $OFN_ALLOWMULTISELECT And BitAND($iFlags, $OFN_EXPLORER) = $OFN_EXPLORER Then
		For $x = 1 To $iPathLen
			If DllStructGetData($tPath, "Path", $x) = Chr(0) Then
				DllStructSetData($tPath, "Path", "|", $x)
				$iNulls += 1
			Else
				$iNulls = 0
			EndIf
			If $iNulls = 2 Then ExitLoop
		Next
		DllStructSetData($tPath, "Path", Chr(0), $x - 1)
		$aFiles = StringSplit(DllStructGetData($tPath, "Path"), "|")
		If $aFiles[0] = 1 Then Return _WinAPI_ParseFileDialogPath(DllStructGetData($tPath, "Path"))
		Return StringSplit(DllStructGetData($tPath, "Path"), "|")
	ElseIf BitAND($iFlags, $OFN_ALLOWMULTISELECT) = $OFN_ALLOWMULTISELECT Then
		$aFiles = StringSplit(DllStructGetData($tPath, "Path"), " ")
		If $aFiles[0] = 1 Then Return _WinAPI_ParseFileDialogPath(DllStructGetData($tPath, "Path"))
		Return StringSplit(StringReplace(DllStructGetData($tPath, "Path"), " ", "|"), "|")
	Else
		Return _WinAPI_ParseFileDialogPath(DllStructGetData($tPath, "Path"))
	EndIf
EndFunc   ;==>_WinAPI_GetOpenFileName
Func _WinAPI_GetOverlappedResult($hFile, $pOverlapped, ByRef $iBytes, $fWait = False)
	Local $pRead, $tRead, $aResult
	$tRead = DllStructCreate("int Read")
	$pRead = DllStructGetPtr($tRead)
	$aResult = DllCall("Kernel32.dll", "int", "GetOverlappedResult", "int", $hFile, "ptr", $pOverlapped, "ptr", $pRead, "int", $fWait)
	$iBytes = DllStructGetData($tRead, "Read")
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_GetOverlappedResult
Func _WinAPI_GetParent($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetParent", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetParent
Func _WinAPI_GetProcessAffinityMask($hProcess)
	Local $pProcess, $tProcess, $pSystem, $tSystem, $aResult, $aMask[3]
	$tProcess = DllStructCreate("int Data")
	$pProcess = DllStructGetPtr($tProcess)
	$tSystem = DllStructCreate("int Data")
	$pSystem = DllStructGetPtr($tSystem)
	$aResult = DllCall("Kernel32.dll", "int", "GetProcessAffinityMask", "hwnd", $hProcess, "ptr", $pProcess, "ptr", $pSystem)
	If @error Then Return SetError(@error, 0, $aMask)
	$aMask[0] = $aResult[0] <> 0
	$aMask[1] = DllStructGetData($tProcess, "Data")
	$aMask[2] = DllStructGetData($tSystem, "Data")
	Return $aMask
EndFunc   ;==>_WinAPI_GetProcessAffinityMask
Func _WinAPI_GetSaveFileName($sTitle = "", $sFilter = "All files (*.*)", $sInitalDir = ".", $sDefaultFile = "", $sDefaultExt = "", $iFilterIndex = 1, $iFlags = 0, $iFlagsEx = 0, $hwndOwner = 0)
	Local $iPathLen = 4096 ; Max chars in returned string
	Local $tOFN = DllStructCreate($tagOPENFILENAME)
	Local $aFiles[1]
	Local $iFlag = $iFlags
	; Filter string to array conversion
	Local $asFLines = StringSplit($sFilter, "|")
	Local $asFilter[$asFLines[0] * 2 + 1]
	Local $i, $iStart, $iFinal, $stFilter
	$asFilter[0] = $asFLines[0] * 2
	For $i = 1 To $asFLines[0]
		$iStart = StringInStr($asFLines[$i], "(", 0, 1)
		$iFinal = StringInStr($asFLines[$i], ")", 0, -1)
		$asFilter[$i * 2 - 1] = StringStripWS(StringLeft($asFLines[$i], $iStart - 1), 3)
		$asFilter[$i * 2] = StringStripWS(StringTrimRight(StringTrimLeft($asFLines[$i], $iStart), StringLen($asFLines[$i]) - $iFinal + 1), 3)
		$stFilter &= "char[" & StringLen($asFilter[$i * 2 - 1]) + 1 & "];char[" & StringLen($asFilter[$i * 2]) + 1 & "];"
	Next
	Local $tTitle = DllStructCreate("char Title[" & StringLen($sTitle) + 1 & "]")
	Local $tInitialDir = DllStructCreate("char InitDir[" & StringLen($sInitalDir) + 1 & "]")
	Local $tFilter = DllStructCreate($stFilter & "char")
	Local $tPath = DllStructCreate("char Path[" & $iPathLen & "]")
	Local $tExtn = DllStructCreate("char Extension[" & StringLen($sDefaultExt) + 1 & "]")
	For $i = 1 To $asFilter[0]
		DllStructSetData($tFilter, $i, $asFilter[$i])
	Next
	Local $iResult
	; Set Data of API structures
	DllStructSetData($tTitle, "Title", $sTitle)
	DllStructSetData($tInitialDir, "InitDir", $sInitalDir)
	DllStructSetData($tPath, "Path", $sDefaultFile)
	DllStructSetData($tExtn, "Extension", $sDefaultExt)
	DllStructSetData($tOFN, "StructSize", DllStructGetSize($tOFN))
	DllStructSetData($tOFN, "hwndOwner", $hwndOwner)
	DllStructSetData($tOFN, "lpstrFilter", DllStructGetPtr($tFilter))
	DllStructSetData($tOFN, "nFilterIndex", $iFilterIndex)
	DllStructSetData($tOFN, "lpstrFile", DllStructGetPtr($tPath))
	DllStructSetData($tOFN, "nMaxFile", $iPathLen)
	DllStructSetData($tOFN, "lpstrInitialDir", DllStructGetPtr($tInitialDir))
	DllStructSetData($tOFN, "lpstrTitle", DllStructGetPtr($tTitle))
	DllStructSetData($tOFN, "Flags", $iFlag)
	DllStructSetData($tOFN, "lpstrDefExt", DllStructGetPtr($tExtn))
	DllStructSetData($tOFN, "FlagsEx", $iFlagsEx)
	$iResult = DllCall("comdlg32.dll", "int", "GetSaveFileName", "ptr", DllStructGetPtr($tOFN))
	If @error Or $iResult[0] = 0 Then Return SetError(@error, @extended, $aFiles)
	Return _WinAPI_ParseFileDialogPath(DllStructGetData($tPath, "Path"))
EndFunc   ;==>_WinAPI_GetSaveFileName
Func _WinAPI_GetStockObject($iObject)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "hwnd", "GetStockObject", "int", $iObject)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetStockObject
Func _WinAPI_GetStdHandle($iStdHandle)
	Local $aHandle[3] = [-10, -11, -12], $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GetStdHandle", "int", $aHandle[$iStdHandle])
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0])
EndFunc   ;==>_WinAPI_GetStdHandle
Func _WinAPI_GetSysColor($iIndex)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "GetSysColor", "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetSysColor
Func _WinAPI_GetSysColorBrush($iIndex)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "GetSysColorBrush", "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetSysColorBrush
Func _WinAPI_GetSystemMetrics($iIndex)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "GetSystemMetrics", "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetSystemMetrics
Func _WinAPI_GetTextExtentPoint32($hDC, $sText)
	Local $tSize, $iSize, $aResult
	$tSize = DllStructCreate($tagSIZE)
	$iSize = StringLen($sText)
	$aResult = DllCall("GDI32.dll", "int", "GetTextExtentPoint32", "hwnd", $hDC, "str", $sText, "int", $iSize, "ptr", DllStructGetPtr($tSize))
	_WinAPI_Check("_WinAPI_GetTextExtentPoint32", ($aResult[0] = 0), 0, True)
	Return $tSize
EndFunc   ;==>_WinAPI_GetTextExtentPoint32
Func _WinAPI_GetWindow($hWnd, $iCmd)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetWindow", "hwnd", $hWnd, "int", $iCmd)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetWindow
Func _WinAPI_GetWindowDC($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "GetWindowDC", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetWindowDC
Func _WinAPI_GetWindowHeight($hWnd)
	Local $tRect
	$tRect = _WinAPI_GetWindowRect($hWnd)
	Return DllStructGetData($tRect, "Bottom") - DllStructGetData($tRect, "Top")
EndFunc   ;==>_WinAPI_GetWindowHeight
Func _WinAPI_GetWindowLong($hWnd, $iIndex)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "GetWindowLong", "hwnd", $hWnd, "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetWindowLong
Func _WinAPI_GetWindowPlacement($hWnd)
	; Create struct to receive data
	Local $tWindowPlacement = DllStructCreate($tagWINDOWPLACEMENT)
	DllStructSetData($tWindowPlacement, "length", DllStructGetSize($tWindowPlacement))
	; Get pointer to struct
	Local $pWindowPlacement = DllStructGetPtr($tWindowPlacement)
	; Make DLL call
	Local $avRET = DllCall("user32.dll", "int", "GetWindowPlacement", "hwnd", $hWnd, "ptr", $pWindowPlacement)
	If @error Then Return SetError(@error, 0, 0)
	; Return results
	If $avRET[0] Then
		Return $tWindowPlacement
	Else
		Return SetError(1, _WinAPI_GetLastError(), 0)
	EndIf
EndFunc   ;==>_WinAPI_GetWindowPlacement
Func _WinAPI_GetWindowRect($hWnd)
	Local $tRect
	$tRect = DllStructCreate($tagRECT)
	DllCall("User32.dll", "int", "GetWindowRect", "hwnd", $hWnd, "ptr", DllStructGetPtr($tRect))
	If @error Then Return SetError(@error, 0, $tRect)
	Return $tRect
EndFunc   ;==>_WinAPI_GetWindowRect
Func _WinAPI_GetWindowRgn($hWnd, $hRgn)
	Local $aResult = DllCall("user32.dll", "int", "GetWindowRgn", "hwnd", $hWnd, "hwnd", $hRgn)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetWindowRgn
Func _WinAPI_GetWindowText($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "GetWindowText", "hwnd", $hWnd, "str", "", "int", 4096)
	If @error Then Return SetError(@error, 0, "")
	Return $aResult[2]
EndFunc   ;==>_WinAPI_GetWindowText
Func _WinAPI_GetWindowThreadProcessId($hWnd, ByRef $iPID)
	Local $pPID, $tPID, $aResult
	$tPID = DllStructCreate("int ID")
	$pPID = DllStructGetPtr($tPID)
	$aResult = DllCall("User32.dll", "int", "GetWindowThreadProcessId", "hwnd", $hWnd, "ptr", $pPID)
	If @error Then Return SetError(@error, 0, 0)
	$iPID = DllStructGetData($tPID, "ID")
	Return $aResult[0]
EndFunc   ;==>_WinAPI_GetWindowThreadProcessId
Func _WinAPI_GetWindowWidth($hWnd)
	Local $tRect
	$tRect = _WinAPI_GetWindowRect($hWnd)
	Return DllStructGetData($tRect, "Right") - DllStructGetData($tRect, "Left")
EndFunc   ;==>_WinAPI_GetWindowWidth
Func _WinAPI_GetXYFromPoint(ByRef $tPoint, ByRef $iX, ByRef $iY)
	$iX = DllStructGetData($tPoint, "X")
	$iY = DllStructGetData($tPoint, "Y")
EndFunc   ;==>_WinAPI_GetXYFromPoint
Func _WinAPI_GlobalMemStatus()
	Local $iMem, $pMem, $tMem, $aMem[7]
	$tMem = DllStructCreate("int;int;int;int;int;int;int;int;int")
	$pMem = DllStructGetPtr($tMem)
	$iMem = DllStructGetSize($tMem)
	DllStructSetData($tMem, 1, $iMem)
	DllCall("Kernel32.dll", "none", "GlobalMemStatus", "ptr", $pMem)
	If @error Then Return SetError(@error, 0, $aMem)
	$aMem[0] = DllStructGetData($tMem, 2)
	$aMem[1] = DllStructGetData($tMem, 3)
	$aMem[2] = DllStructGetData($tMem, 4)
	$aMem[3] = DllStructGetData($tMem, 5)
	$aMem[4] = DllStructGetData($tMem, 6)
	$aMem[5] = DllStructGetData($tMem, 7)
	$aMem[6] = DllStructGetData($tMem, 8)
	Return $aMem
EndFunc   ;==>_WinAPI_GlobalMemStatus
Func _WinAPI_GUIDFromString($sGUID)
	Local $tGUID
	$tGUID = DllStructCreate($tagGUID)
	_WinAPI_GUIDFromStringEx($sGUID, DllStructGetPtr($tGUID))
	Return SetError(@error, 0, $tGUID)
EndFunc   ;==>_WinAPI_GUIDFromString
Func _WinAPI_GUIDFromStringEx($sGUID, $pGUID)
	Local $tData, $aResult
	$tData = _WinAPI_MultiByteToWideChar($sGUID)
	$aResult = DllCall("Ole32.dll", "int", "CLSIDFromString", "ptr", DllStructGetPtr($tData), "ptr", $pGUID)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_GUIDFromStringEx
Func _WinAPI_HiWord($iLong)
	Return BitShift($iLong, 16)
EndFunc   ;==>_WinAPI_HiWord
Func _WinAPI_InProcess($hWnd, ByRef $hLastWnd)
	Local $iI, $iCount, $iProcessID
	If $hWnd = $hLastWnd Then Return True
	For $iI = $winapi_gaInProcess[0][0] To 1 Step -1
		If $hWnd = $winapi_gaInProcess[$iI][0] Then
			If $winapi_gaInProcess[$iI][1] Then
				$hLastWnd = $hWnd
				Return True
			Else
				Return False
			EndIf
		EndIf
	Next
	_WinAPI_GetWindowThreadProcessId($hWnd, $iProcessID)
	$iCount = $winapi_gaInProcess[0][0] + 1
	If $iCount >= 64 Then $iCount = 1
	$winapi_gaInProcess[0][0] = $iCount
	$winapi_gaInProcess[$iCount][0] = $hWnd
	$winapi_gaInProcess[$iCount][1] = ($iProcessID = @AutoItPID)
	Return $winapi_gaInProcess[$iCount][1]
EndFunc   ;==>_WinAPI_InProcess
Func _WinAPI_IntToFloat($iInt)
	Local $tFloat, $tInt
	$tInt = DllStructCreate("int")
	$tFloat = DllStructCreate("float", DllStructGetPtr($tInt))
	DllStructSetData($tInt, 1, $iInt)
	Return DllStructGetData($tFloat, 1)
EndFunc   ;==>_WinAPI_IntToFloat
Func _WinAPI_IsClassName($hWnd, $sClassName)
	Local $sSeperator, $aClassName, $sClassCheck
	$sSeperator = Opt("GUIDataSeparatorChar")
	$aClassName = StringSplit($sClassName, $sSeperator)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	$sClassCheck = _WinAPI_GetClassName($hWnd) ; ClassName from Handle
	; check array of ClassNames against ClassName Returned
	For $x = 1 To UBound($aClassName) - 1
		If StringUpper(StringMid($sClassCheck, 1, StringLen($aClassName[$x]))) = StringUpper($aClassName[$x]) Then
			Return True
		EndIf
	Next
	Return False
EndFunc   ;==>_WinAPI_IsClassName
Func _WinAPI_IsWindow($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "IsWindow", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_IsWindow
Func _WinAPI_IsWindowVisible($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "IsWindowVisible", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_IsWindowVisible
Func _WinAPI_InvalidateRect($hWnd, $tRect = 0, $fErase = True)
	Local $pRect, $aResult
	If $tRect <> 0 Then $pRect = DllStructGetPtr($tRect)
	$aResult = DllCall("User32.dll", "int", "InvalidateRect", "hwnd", $hWnd, "ptr", $pRect, "int", $fErase)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_InvalidateRect
Func _WinAPI_LineTo($hDC, $iX, $iY)
	Local $aResult = DllCall("gdi32.dll", "int", "LineTo", "int", $hDC, "int", $iX, "int", $iY)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_LineTo
Func _WinAPI_LoadBitmap($hInstance, $sBitmap)
	Local $aResult, $sType = "int"
	If IsString($sBitmap) Then $sType = "str"
	$aResult = DllCall("User32.dll", "hwnd", "LoadBitmap", "hwnd", $hInstance, $sType, $sBitmap)
	_WinAPI_Check("_WinAPI_LoadBitmap", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_LoadBitmap
Func _WinAPI_LoadImage($hInstance, $sImage, $iType, $iXDesired, $iYDesired, $iLoad)
	Local $aResult, $sType = "int"
	If IsString($sImage) Then $sType = "str"
	$aResult = DllCall("User32.dll", "hwnd", "LoadImage", "hwnd", $hInstance, $sType, $sImage, "int", $iType, "int", $iXDesired, _
			"int", $iYDesired, "int", $iLoad)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_LoadImage
Func _WinAPI_LoadLibrary($sFileName)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "hwnd", "LoadLibraryA", "str", $sFileName)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_LoadLibrary
Func _WinAPI_LoadLibraryEx($sFileName, $iFlags = 0)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "hwnd", "LoadLibraryExA", "str", $sFileName, "hwnd", 0, "int", $iFlags)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_LoadLibraryEx
Func _WinAPI_LoadShell32Icon($iIconID)
	Local $iIcons, $tIcons, $pIcons
	$tIcons = DllStructCreate("int Data")
	$pIcons = DllStructGetPtr($tIcons)
	$iIcons = _WinAPI_ExtractIconEx("Shell32.dll", $iIconID, 0, $pIcons, 1)
	_WinAPI_Check("_Lib_GetShell32Icon", ($iIcons = 0), -1)
	Return DllStructGetData($tIcons, "Data")
EndFunc   ;==>_WinAPI_LoadShell32Icon
Func _WinAPI_LoadString($hInstance, $iStringId)
	Local $iResult, $iBufferMax = 4096
	$iResult = DllCall("user32.dll", "int", "LoadString", "hwnd", $hInstance, "uint", $iStringId, "str", "", "int", $iBufferMax)
	If @error Or Not IsArray($iResult) Or $iResult[0] = 0 Then Return SetError(-1, -1, "")
	Return SetError(0, $iResult[0], $iResult[3])
EndFunc   ;==>_WinAPI_LoadString
Func _WinAPI_LocalFree($hMem)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "hwnd", "LocalFree", "hwnd", $hMem)
	_WinAPI_Check("_WinAPI_LocalFree", ($aResult[0] <> 0), 0, True)
	Return $aResult[0] = 0
EndFunc   ;==>_WinAPI_LocalFree
Func _WinAPI_LoWord($iLong)
	Return BitAND($iLong, 0xFFFF)
EndFunc   ;==>_WinAPI_LoWord
Func _WinAPI_MakeDWord($HiWord, $LoWord)
	Return BitOR($LoWord * 0x10000, BitAND($HiWord, 0xFFFF))
EndFunc   ;==>_WinAPI_MakeDWord
Func _WinAPI_MAKELANGID($lgidPrimary, $lgidSub)
	Return BitOR(BitShift($lgidSub, -10), $lgidPrimary)
EndFunc   ;==>_WinAPI_MAKELANGID
Func _WinAPI_MAKELCID($lgid, $srtid)
	Return BitOR(BitShift($srtid, -16), $lgid)
EndFunc   ;==>_WinAPI_MAKELCID
Func _WinAPI_MakeLong($iLo, $iHi)
	Return BitOR(BitShift($iHi, -16), BitAND($iLo, 0xFFFF))
EndFunc   ;==>_WinAPI_MakeLong
Func _WinAPI_MessageBeep($iType = 1)
	Local $iSound, $aResult
	Switch $iType
		Case 1
			$iSound = 0
		Case 2
			$iSound = 16
		Case 3
			$iSound = 32
		Case 4
			$iSound = 48
		Case 5
			$iSound = 64
		Case Else
			$iSound = -1
	EndSwitch
	$aResult = DllCall("User32.dll", "int", "MessageBeep", "uint", $iSound)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_MessageBeep
Func _WinAPI_MsgBox($iFlags, $sTitle, $sText)
	BlockInput(0)
	MsgBox($iFlags, $sTitle, $sText & "      ")
EndFunc   ;==>_WinAPI_MsgBox
Func _WinAPI_Mouse_Event($iFlags, $iX = 0, $iY = 0, $iData = 0, $iExtraInfo = 0)
	DllCall("User32.dll", "none", "mouse_event", "int", $iFlags, "int", $iX, "int", $iY, "int", $iData, "int", $iExtraInfo)
EndFunc   ;==>_WinAPI_Mouse_Event
Func _WinAPI_MoveTo($hDC, $iX, $iY)
	Local $aResult = DllCall("gdi32.dll", "int", "MoveToEx", "int", $hDC, "int", $iX, "int", $iY, "ptr", 0)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_MoveTo
Func _WinAPI_MoveWindow($hWnd, $iX, $iY, $iWidth, $iHeight, $fRepaint = True)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "MoveWindow", "hwnd", $hWnd, "int", $iX, "int", $iY, "int", $iWidth, "int", $iHeight, "int", $fRepaint)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_MoveWindow
Func _WinAPI_MulDiv($iNumber, $iNumerator, $iDenominator)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "MulDiv", "int", $iNumber, "int", $iNumerator, "int", $iDenominator)
	_WinAPI_Check("_MultDiv", ($aResult[0] = -1), -1)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_MulDiv
Func _WinAPI_MultiByteToWideChar($sText, $iCodePage = 0, $iFlags = 0)
	Local $iText, $pText, $tText
	$iText = StringLen($sText) + 1
	$tText = DllStructCreate("byte[" & $iText * 2 & "]")
	$pText = DllStructGetPtr($tText)
	DllCall("Kernel32.dll", "int", "MultiByteToWideChar", "int", $iCodePage, "int", $iFlags, "str", $sText, "int", $iText, _
			"ptr", $pText, "int", $iText * 2)
	If @error Then Return SetError(@error, 0, $tText)
	Return $tText
EndFunc   ;==>_WinAPI_MultiByteToWideChar
Func _WinAPI_MultiByteToWideCharEx($sText, $pText, $iCodePage = 0, $iFlags = 0)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "MultiByteToWideChar", "int", $iCodePage, "int", $iFlags, "str", $sText, "int", -1, _
			"ptr", $pText, "int", (StringLen($sText) + 1) * 2)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_MultiByteToWideCharEx
Func _WinAPI_OpenProcess($iAccess, $fInherit, $iProcessID, $fDebugPriv = False)
	Local $hToken, $aResult
	; Attempt to open process with standard security priviliges
	$aResult = DllCall("Kernel32.dll", "int", "OpenProcess", "int", $iAccess, "int", $fInherit, "int", $iProcessID)
	If Not $fDebugPriv Or ($aResult[0] <> 0) Then
		_WinAPI_Check("_WinAPI_OpenProcess:Standard", ($aResult[0] = 0), 0, True)
		Return $aResult[0]
	EndIf
	; Enable debug privileged mode
	$hToken = _Security__OpenThreadTokenEx(BitOR($__WINAPCONSTANT_TOKEN_ADJUST_PRIVILEGES, $__WINAPCONSTANT_TOKEN_QUERY))
	_WinAPI_Check("_WinAPI_OpenProcess:OpenThreadTokenEx", @error, @extended)
	_Security__SetPrivilege($hToken, "SeDebugPrivilege", True)
	_WinAPI_Check("_WinAPI_OpenProcess:SetPrivilege:Enable", @error, @extended)
	; Attempt to open process with debug priviliges
	$aResult = DllCall("Kernel32.dll", "int", "OpenProcess", "int", $iAccess, "int", $fInherit, "int", $iProcessID)
	_WinAPI_Check("_WinAPI_OpenProcess:Priviliged", ($aResult[0] = 0), 0, True)
	; Disable debug privileged mode
	_Security__SetPrivilege($hToken, "SeDebugPrivilege", False)
	_WinAPI_Check("_WinAPI_OpenProcess:SetPrivilege:Disable", @error, @extended)
	_WinAPI_CloseHandle($hToken)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_OpenProcess
Func _WinAPI_ParseFileDialogPath($sPath)
	Local $aFiles[3], $stemp
	$aFiles[0] = 2
	$stemp = StringMid($sPath, 1, StringInStr($sPath, "\", 0, -1) - 1)
	$aFiles[1] = $stemp
	$aFiles[2] = StringMid($sPath, StringInStr($sPath, "\", 0, -1) + 1)
	Return $aFiles
EndFunc   ;==>_WinAPI_ParseFileDialogPath
Func _WinAPI_PointFromRect(ByRef $tRect, $fCenter = True)
	Local $iX1, $iY1, $iX2, $iY2, $tPoint
	$iX1 = DllStructGetData($tRect, "Left")
	$iY1 = DllStructGetData($tRect, "Top")
	$iX2 = DllStructGetData($tRect, "Right")
	$iY2 = DllStructGetData($tRect, "Bottom")
	If $fCenter Then
		$iX1 = $iX1 + (($iX2 - $iX1) / 2)
		$iY1 = $iY1 + (($iY2 - $iY1) / 2)
	EndIf
	$tPoint = DllStructCreate($tagPOINT)
	DllStructSetData($tPoint, "X", $iX1)
	DllStructSetData($tPoint, "Y", $iY1)
	Return $tPoint
EndFunc   ;==>_WinAPI_PointFromRect
Func _WinAPI_PostMessage($hWnd, $iMsg, $iwParam, $ilParam)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "PostMessageA", "hwnd", $hWnd, "int", $iMsg, "int", $iwParam, "int", $ilParam)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_PostMessage
Func _WinAPI_PrimaryLangId($lgid)
	Return BitAND($lgid, 0x3FF)
EndFunc   ;==>_WinAPI_PrimaryLangId
Func _WinAPI_PtInRect(ByRef $tRect, ByRef $tPoint)
	Local $iX, $iY, $aResult
	$iX = DllStructGetData($tPoint, "X")
	$iY = DllStructGetData($tPoint, "Y")
	$aResult = DllCall("User32.dll", "int", "PtInRect", "ptr", DllStructGetPtr($tRect), "int", $iX, "int", $iY)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_PtInRect
Func _WinAPI_ReadFile($hFile, $pBuffer, $iToRead, ByRef $iRead, $pOverlapped = 0)
	Local $aResult, $pRead, $tRead
	$tRead = DllStructCreate("int Read")
	$pRead = DllStructGetPtr($tRead)
	$aResult = DllCall("Kernel32.dll", "int", "ReadFile", "hwnd", $hFile, "ptr", $pBuffer, "int", $iToRead, "ptr", $pRead, "ptr", $pOverlapped)
	$iRead = DllStructGetData($tRead, "Read")
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_ReadFile
Func _WinAPI_ReadProcessMemory($hProcess, $pBaseAddress, $pBuffer, $iSize, ByRef $iRead)
	Local $pRead, $tRead, $aResult
	$tRead = DllStructCreate("int Read")
	$pRead = DllStructGetPtr($tRead)
	$aResult = DllCall("Kernel32.dll", "int", "ReadProcessMemory", "int", $hProcess, "int", $pBaseAddress, "ptr", $pBuffer, "int", $iSize, "ptr", $pRead)
	_WinAPI_Check("_WinAPI_ReadProcessMemory", ($aResult[0] = 0), 0, True)
	$iRead = DllStructGetData($tRead, "Read")
	Return $aResult[0]
EndFunc   ;==>_WinAPI_ReadProcessMemory
Func _WinAPI_RectIsEmpty(ByRef $tRect)
	Return (DllStructGetData($tRect, "Left") = 0) And (DllStructGetData($tRect, "Top") = 0) And _
			(DllStructGetData($tRect, "Right") = 0) And (DllStructGetData($tRect, "Bottom") = 0)
EndFunc   ;==>_WinAPI_RectIsEmpty
Func _WinAPI_RedrawWindow($hWnd, $tRect = 0, $hRegion = 0, $iFlags = 5)
	Local $pRect, $aResult
	If $tRect <> 0 Then $pRect = DllStructGetPtr($tRect)
	$aResult = DllCall("User32.dll", "int", "RedrawWindow", "hwnd", $hWnd, "ptr", $pRect, "int", $hRegion, "int", $iFlags)
	If @error Then Return SetError(@error, 0, False)
	Return ($aResult[0] <> 0)
EndFunc   ;==>_WinAPI_RedrawWindow
Func _WinAPI_RegisterWindowMessage($sMessage)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "RegisterWindowMessage", "str", $sMessage)
	_WinAPI_Check("_WinAPI_RegisterWindowMessage", ($aResult[0] = 0), 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_RegisterWindowMessage
Func _WinAPI_ReleaseCapture()
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "ReleaseCapture")
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_ReleaseCapture
Func _WinAPI_ReleaseDC($hWnd, $hDC)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "ReleaseDC", "hwnd", $hWnd, "hwnd", $hDC)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_ReleaseDC
Func _WinAPI_ScreenToClient($hWnd, ByRef $tPoint)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "ScreenToClient", "hwnd", $hWnd, "ptr", DllStructGetPtr($tPoint))
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_ScreenToClient
Func _WinAPI_SelectObject($hDC, $hGDIObj)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "hwnd", "SelectObject", "hwnd", $hDC, "hwnd", $hGDIObj)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SelectObject
Func _WinAPI_SetBkColor($hDC, $iColor)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "SetBkColor", "hwnd", $hDC, "int", $iColor)
	If @error Then Return SetError(@error, 0, 0xFFFF)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetBkColor
Func _WinAPI_SetBkMode($hDC, $iBkMode)
	Local $aResult = DllCall("gdi32.dll", "int", "SetBkMode", "ptr", $hDC, "int", $iBkMode)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetBkMode
Func _WinAPI_SetCapture($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "SetCapture", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetCapture
Func _WinAPI_SetCursor($hCursor)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "SetCursor", "hwnd", $hCursor)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetCursor
Func _WinAPI_SetDefaultPrinter($sPrinter)
	Local $aResult
	$aResult = DllCall("WinSpool.drv", "int", "SetDefaultPrinterA", "str", $sPrinter)
	If @error Then Return SetError(@error, 0, False)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_SetDefaultPrinter
Func _WinAPI_SetDIBits($hDC, $hBmp, $iStartScan, $iScanLines, $pBits, $pBMI, $iColorUse = 0)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "SetDIBits", "hwnd", $hDC, "hwnd", $hBmp, "uint", $iStartScan, "uint", $iScanLines, _
			"ptr", $pBits, "ptr", $pBMI, "uint", $iColorUse)
	If @error Then Return SetError(@error, 0, False)
	Return SetError($aResult[0] = 0, _WinAPI_GetLastError(), $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_SetDIBits
Func _WinAPI_SetEndOfFile($hFile)
	Local $aResult
	$aResult = DllCall("kernel32.dll", "int", "SetEndOfFile", "hwnd", $hFile)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_SetEndOfFile
Func _WinAPI_SetEvent($hEvent)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "SetEvent", "hwnd", $hEvent)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_SetEvent
Func _WinAPI_SetFilePointer($hFile, $iPos, $iMethod = 0)
	Local $aResult
	$aResult = DllCall("kernel32.dll", "long", "SetFilePointer", "hwnd", $hFile, "long", $iPos, "long_ptr", 0, "long", $iMethod)
	If @error Then Return SetError(1, 0, -1)
	If $aResult[0] = $__WINAPCONSTANT_INVALID_SET_FILE_POINTER Then Return SetError(2, 0, -1)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetFilePointer
Func _WinAPI_SetFocus($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "SetFocus", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetFocus
Func _WinAPI_SetFont($hWnd, $hFont, $fRedraw = True)
	_SendMessage($hWnd, $__WINAPCONSTANT_WM_SETFONT, $hFont, $fRedraw, 0, "hwnd")
EndFunc   ;==>_WinAPI_SetFont
Func _WinAPI_SetHandleInformation($hObject, $iMask, $iFlags)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "SetHandleInformation", "hwnd", $hObject, "uint", $iMask, "uint", $iFlags)
	_WinAPI_Check("_WinAPI_SetHandleInformation", $aResult[0] = 0, 0, True)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetHandleInformation
Func _WinAPI_SetLastError($iErrCode)
	DllCall("Kernel32.dll", "none", "SetLastError", "dword", $iErrCode)
EndFunc   ;==>_WinAPI_SetLastError
Func _WinAPI_SetParent($hWndChild, $hWndParent)
	Local $aResult
	$aResult = DllCall("User32.dll", "hwnd", "SetParent", "hwnd", $hWndChild, "hwnd", $hWndParent)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetParent
Func _WinAPI_SetProcessAffinityMask($hProcess, $iMask)
	Local $iResult
	$iResult = DllCall("Kernel32.dll", "int", "SetProcessAffinityMask", "hwnd", $hProcess, "int", $iMask)
	_WinAPI_Check("_WinAPI_SetProcessAffinityMask", ($iResult[0] = 0), 0, True)
	Return $iResult[0] <> 0
EndFunc   ;==>_WinAPI_SetProcessAffinityMask
Func _WinAPI_SetSysColors($vElements, $vColors)
	Local $isEArray = IsArray($vElements), $isCArray = IsArray($vColors)
	Local $iElementNum
	If Not $isCArray And Not $isEArray Then
		$iElementNum = 1
	ElseIf $isCArray Or $isEArray Then
		If Not $isCArray Or Not $isEArray Then Return SetError(-1, -1, False)
		If UBound($vElements) <> UBound($vColors) Then Return SetError(-1, -1, False)
		$iElementNum = UBound($vElements)
	EndIf
	Local $tElements = DllStructCreate("int Element[" & $iElementNum & "]")
	Local $tColors = DllStructCreate("int NewColor[" & $iElementNum & "]")
	Local $pElements = DllStructGetPtr($tElements)
	Local $pColors = DllStructGetPtr($tColors)
	If Not $isEArray Then
		DllStructSetData($tElements, "Element", $vElements, 1)
	Else
		For $x = 0 To $iElementNum - 1
			DllStructSetData($tElements, "Element", $vElements[$x], $x + 1)
		Next
	EndIf
	If Not $isCArray Then
		DllStructSetData($tColors, "NewColor", $vColors, 1)
	Else
		For $x = 0 To $iElementNum - 1
			DllStructSetData($tColors, "NewColor", $vColors[$x], $x + 1)
		Next
	EndIf
	Local $iResults = DllCall("user32.dll", "int", "SetSysColors", "int", $iElementNum, "ptr", $pElements, "ptr", $pColors)
	If @error Then Return SetError(-1, -1, False)
	Return $iResults[0] <> 0
EndFunc   ;==>_WinAPI_SetSysColors
Func _WinAPI_SetTextColor($hDC, $iColor)
	Local $aResult
	$aResult = DllCall("GDI32.dll", "int", "SetTextColor", "hwnd", $hDC, "int", $iColor)
	If @error Then Return SetError(@error, 0, 0xFFFF)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetTextColor
Func _WinAPI_SetWindowLong($hWnd, $iIndex, $iValue)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "SetWindowLong", "hwnd", $hWnd, "int", $iIndex, "int", $iValue)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetWindowLong
Func _WinAPI_SetWindowPlacement($hWnd, $pWindowPlacement)
	; Make DLL call
	Local $avRET = DllCall("user32.dll", "int", "SetWindowPlacement", "hwnd", $hWnd, "ptr", $pWindowPlacement)
	If @error Then Return SetError(@error, _WinAPI_GetLastError(), 0)
	; Return results
	If $avRET[0] Then
		Return $avRET[0]
	Else
		Return SetError(1, _WinAPI_GetLastError(), 0)
	EndIf
EndFunc   ;==>_WinAPI_SetWindowPlacement
Func _WinAPI_SetWindowPos($hWnd, $hAfter, $iX, $iY, $iCX, $iCY, $iFlags)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "SetWindowPos", "hwnd", $hWnd, "hwnd", $hAfter, "int", $iX, "int", $iY, "int", $iCX, _
			"int", $iCY, "int", $iFlags)
	_WinAPI_Check("_WinAPI_SetWindowPos", ($aResult[0] = 0), 0, True)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_SetWindowPos
Func _WinAPI_SetWindowRgn($hWnd, $hRgn, $bRedraw = True)
	Local $aResult = DllCall("user32.dll", "int", "SetWindowRgn", "hwnd", $hWnd, "hwnd", $hRgn, "int", $bRedraw)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_SetWindowRgn
Func _WinAPI_SetWindowsHookEx($idHook, $lpfn, $hmod, $dwThreadId = 0)
	Local $hwndHook = DllCall("user32.dll", "hwnd", "SetWindowsHookEx", "int", $idHook, "ptr", $lpfn, "hwnd", $hmod, "dword", $dwThreadId)
	If @error Then Return SetError(@error, @extended, 0)
	Return $hwndHook[0]
EndFunc   ;==>_WinAPI_SetWindowsHookEx
Func _WinAPI_SetWindowText($hWnd, $sText)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "SetWindowText", "hwnd", $hWnd, "str", $sText)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_SetWindowText
Func _WinAPI_ShowCursor($fShow)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "ShowCursor", "int", $fShow)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_ShowCursor
Func _WinAPI_ShowError($sText, $fExit = True)
	_WinAPI_MsgBox(266256, "Error", $sText)
	If $fExit Then Exit
EndFunc   ;==>_WinAPI_ShowError
Func _WinAPI_ShowMsg($sText)
	_WinAPI_MsgBox(64 + 4096, "Information", $sText)
EndFunc   ;==>_WinAPI_ShowMsg
Func _WinAPI_ShowWindow($hWnd, $iCmdShow = 5)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "ShowWindow", "hwnd", $hWnd, "int", $iCmdShow)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_ShowWindow
Func _WinAPI_StringFromGUID($pGUID)
	Local $aResult
	$aResult = DllCall("Ole32.dll", "int", "StringFromGUID2", "ptr", $pGUID, "wstr", "", "int", 40)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError($aResult[0] <> 0, 0, $aResult[2])
EndFunc   ;==>_WinAPI_StringFromGUID
Func _WinAPI_SubLangId($lgid)
	Return BitShift($lgid, 10)
EndFunc   ;==>_WinAPI_SubLangId
Func _WinAPI_SystemParametersInfo($iAction, $iParam = 0, $vParam = 0, $iWinIni = 0)
	Local $aResult
	$aResult = DllCall("user32.dll", "int", "SystemParametersInfo", "int", $iAction, "int", $iParam, "int", $vParam, "int", $iWinIni)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_SystemParametersInfo
Func _WinAPI_TwipsPerPixelX()
	Local $lngDC, $TwipsPerPixelX
	$lngDC = _WinAPI_GetDC(0)
	$TwipsPerPixelX = 1440 / _WinAPI_GetDeviceCaps($lngDC, $__WINAPCONSTANT_LOGPIXELSX)
	_WinAPI_ReleaseDC(0, $lngDC)
	Return $TwipsPerPixelX
EndFunc   ;==>_WinAPI_TwipsPerPixelX
Func _WinAPI_TwipsPerPixelY()
	Local $lngDC, $TwipsPerPixelY
	$lngDC = _WinAPI_GetDC(0)
	$TwipsPerPixelY = 1440 / _WinAPI_GetDeviceCaps($lngDC, $__WINAPCONSTANT_LOGPIXELSY)
	_WinAPI_ReleaseDC(0, $lngDC)
	Return $TwipsPerPixelY
EndFunc   ;==>_WinAPI_TwipsPerPixelY
Func _WinAPI_UnhookWindowsHookEx($hhk)
	Local $iResult = DllCall("user32.dll", "int", "UnhookWindowsHookEx", "hwnd", $hhk)
	If @error Then Return SetError(@error, @extended, 0)
	Return $iResult[0] <> 0
EndFunc   ;==>_WinAPI_UnhookWindowsHookEx
Func _WinAPI_UpdateLayeredWindow($hWnd, $hDCDest, $pPTDest, $pSize, $hDCSrce, $pPTSrce, $iRGB, $pBlend, $iFlags)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "UpdateLayeredWindow", "hwnd", $hWnd, "hwnd", $hDCDest, "ptr", $pPTDest, "ptr", $pSize, _
			"hwnd", $hDCSrce, "ptr", $pPTSrce, "int", $iRGB, "ptr", $pBlend, "int", $iFlags)
	If @error Then Return SetError(1, 0, False)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_UpdateLayeredWindow
Func _WinAPI_UpdateWindow($hWnd)
	Local $aResult
	$aResult = DllCall("User32.dll", "int", "UpdateWindow", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_UpdateWindow
Func _WinAPI_WaitForInputIdle($hProcess, $iTimeout = -1)
	Local $aResult
	$aResult = DllCall("User32.dll", "dword", "WaitForInputIdle", "hwnd", $hProcess, "dword", $iTimeout)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] = 0)
EndFunc   ;==>_WinAPI_WaitForInputIdle
Func _WinAPI_WaitForMultipleObjects($iCount, $pHandles, $fWaitAll = False, $iTimeout = -1)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "WaitForMultipleObjects", "int", $iCount, "ptr", $pHandles, "int", $fWaitAll, "int", $iTimeout)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0])
EndFunc   ;==>_WinAPI_WaitForMultipleObjects
Func _WinAPI_WaitForSingleObject($hHandle, $iTimeout = -1)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "WaitForSingleObject", "hwnd", $hHandle, "int", $iTimeout)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0])
EndFunc   ;==>_WinAPI_WaitForSingleObject
Func _WinAPI_WideCharToMultiByte($pUnicode, $iCodePage = 0)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "WideCharToMultiByte", "int", $iCodePage, "int", 0, "ptr", $pUnicode, "int", -1, _
			"str", "", "int", 0, "int", 0, "int", 0)
	If @error Then Return SetError(@error, 0, "")
	$aResult = DllCall("Kernel32.dll", "int", "WideCharToMultiByte", "int", $iCodePage, "int", 0, "ptr", $pUnicode, "int", -1, _
			"str", "", "int", $aResult[0], "int", 0, "int", 0)
	If @error Then Return SetError(@error, 0, "")
	Return $aResult[5]
EndFunc   ;==>_WinAPI_WideCharToMultiByte
Func _WinAPI_WindowFromPoint(ByRef $tPoint)
	Local $iX, $iY, $aResult
	$iX = DllStructGetData($tPoint, "X")
	$iY = DllStructGetData($tPoint, "Y")
	$aResult = DllCall("User32.dll", "hwnd", "WindowFromPoint", "int", $iX, "int", $iY)
	If @error Then Return SetError(@error, 0, 0)
	Return $aResult[0]
EndFunc   ;==>_WinAPI_WindowFromPoint
Func _WinAPI_WriteConsole($hConsole, $sText)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "WriteConsole", "int", $hConsole, "str", $sText, "int", StringLen($sText), "int*", 0, "int", 0)
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_WriteConsole
Func _WinAPI_WriteFile($hFile, $pBuffer, $iToWrite, ByRef $iWritten, $pOverlapped = 0)
	Local $pWritten, $tWritten, $aResult
	$tWritten = DllStructCreate("int Written")
	$pWritten = DllStructGetPtr($tWritten)
	$aResult = DllCall("Kernel32.dll", "int", "WriteFile", "hwnd", $hFile, "ptr", $pBuffer, "uint", $iToWrite, "ptr", $pWritten, "ptr", $pOverlapped)
	$iWritten = DllStructGetData($tWritten, "Written")
	Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_WriteFile
Func _WinAPI_WriteProcessMemory($hProcess, $pBaseAddress, $pBuffer, $iSize, ByRef $iWritten, $sBuffer = "ptr")
	Local $pWritten, $tWritten, $aResult
	$tWritten = DllStructCreate("int Written")
	$pWritten = DllStructGetPtr($tWritten)
	$aResult = DllCall("Kernel32.dll", "int", "WriteProcessMemory", "int", $hProcess, "int", $pBaseAddress, $sBuffer, $pBuffer, _
			"int", $iSize, "int", $pWritten)
	_WinAPI_Check("_WinAPI_WriteProcessMemory", ($aResult[0] = 0), 0, True)
	$iWritten = DllStructGetData($tWritten, "Written")
	Return $aResult[0]
EndFunc   ;==>_WinAPI_WriteProcessMemory
Func _WinAPI_ValidateClassName($hWnd, $sClassNames)
	Local $aClassNames, $sSeperator = Opt("GUIDataSeparatorChar"), $sText
	If Not _WinAPI_IsClassName($hWnd, $sClassNames) Then
		$aClassNames = StringSplit($sClassNames, $sSeperator)
		For $x = 1 To $aClassNames[0]
			$sText &= $aClassNames[$x] & ", "
		Next
		$sText = StringTrimRight($sText, 2)
		_WinAPI_ShowError("Invalid Class Type(s):" & @LF & @TAB & _
				"Expecting Type(s): " & $sText & @LF & @TAB & _
				"Received Type : " & _WinAPI_GetClassName($hWnd))
	EndIf
EndFunc   ;==>_WinAPI_ValidateClassName
Global Const $GDIP_DASHCAPFLAT = 0 ; A square cap that squares off both ends of each dash
Global Const $GDIP_DASHCAPROUND = 2 ; A circular cap that rounds off both ends of each dash
Global Const $GDIP_DASHCAPTRIANGLE = 3 ; A triangular cap that points both ends of each dash
Global Const $GDIP_DASHSTYLESOLID = 0 ; A solid line
Global Const $GDIP_DASHSTYLEDASH = 1 ; A dashed line
Global Const $GDIP_DASHSTYLEDOT = 2 ; A dotted line
Global Const $GDIP_DASHSTYLEDASHDOT = 3 ; An alternating dash-dot line
Global Const $GDIP_DASHSTYLEDASHDOTDOT = 4 ; An alternating dash-dot-dot line
Global Const $GDIP_DASHSTYLECUSTOM = 5 ; A a user-defined, custom dashed line
Global Const $GDIP_EPGCHROMINANCETABLE = '{F2E455DC-09B3-4316-8260-676ADA32481C}'
Global Const $GDIP_EPGCOLORDEPTH = '{66087055-AD66-4C7C-9A18-38A2310B8337}'
Global Const $GDIP_EPGCOMPRESSION = '{E09D739D-CCD4-44EE-8EBA-3FBF8BE4FC58}'
Global Const $GDIP_EPGLUMINANCETABLE = '{EDB33BCE-0266-4A77-B904-27216099E717}'
Global Const $GDIP_EPGQUALITY = '{1D5BE4B5-FA4A-452D-9CDD-5DB35105E7EB}'
Global Const $GDIP_EPGRENDERMETHOD = '{6D42C53A-229A-4825-8BB7-5C99E2B9A8B8}'
Global Const $GDIP_EPGSAVEFLAG = '{292266FC-AC40-47BF-8CFC-A85B89A655DE}'
Global Const $GDIP_EPGSCANMETHOD = '{3A4E2661-3109-4E56-8536-42C156E7DCFA}'
Global Const $GDIP_EPGTRANSFORMATION = '{8D0EB2D1-A58E-4EA8-AA14-108074B7B6F9}'
Global Const $GDIP_EPGVERSION = '{24D18C76-814A-41A4-BF53-1C219CCCF797}'
Global Const $GDIP_EPTBYTE = 1 ; 8 bit unsigned integer
Global Const $GDIP_EPTASCII = 2 ; Null terminated character string
Global Const $GDIP_EPTSHORT = 3 ; 16 bit unsigned integer
Global Const $GDIP_EPTLONG = 4 ; 32 bit unsigned integer
Global Const $GDIP_EPTRATIONAL = 5 ; Two longs (numerator, denomintor)
Global Const $GDIP_EPTLONGRANGE = 6 ; Two longs (low, high)
Global Const $GDIP_EPTUNDEFINED = 7 ; Array of bytes of any type
Global Const $GDIP_EPTRATIONALRANGE = 8 ; Two ratationals (low, high)
Global Const $GDIP_ERROK = 0 ; Method call was successful
Global Const $GDIP_ERRGENERICERROR = 1 ; Generic method call error
Global Const $GDIP_ERRINVALIDPARAMETER = 2 ; One of the arguments passed to the method was not valid
Global Const $GDIP_ERROUTOFMEMORY = 3 ; The operating system is out of memory
Global Const $GDIP_ERROBJECTBUSY = 4 ; One of the arguments in the call is already in use
Global Const $GDIP_ERRINSUFFICIENTBUFFER = 5 ; A buffer is not large enough
Global Const $GDIP_ERRNOTIMPLEMENTED = 6 ; The method is not implemented
Global Const $GDIP_ERRWIN32ERROR = 7 ; The method generated a Microsoft Win32 error
Global Const $GDIP_ERRWRONGSTATE = 8 ; The object is in an invalid state to satisfy the API call
Global Const $GDIP_ERRABORTED = 9 ; The method was aborted
Global Const $GDIP_ERRFILENOTFOUND = 10 ; The specified image file or metafile cannot be found
Global Const $GDIP_ERRVALUEOVERFLOW = 11 ; The method produced a numeric overflow
Global Const $GDIP_ERRACCESSDENIED = 12 ; A write operation is not allowed on the specified file
Global Const $GDIP_ERRUNKNOWNIMAGEFORMAT = 13 ; The specified image file format is not known
Global Const $GDIP_ERRFONTFAMILYNOTFOUND = 14 ; The specified font family cannot be found
Global Const $GDIP_ERRFONTSTYLENOTFOUND = 15 ; The specified style is not available for the specified font
Global Const $GDIP_ERRNOTTRUETYPEFONT = 16 ; The font retrieved is not a TrueType font
Global Const $GDIP_ERRUNSUPPORTEDGDIVERSION = 17 ; The installed GDI+ version is incompatible
Global Const $GDIP_ERRGDIPLUSNOTINITIALIZED = 18 ; The GDI+ API is not in an initialized state
Global Const $GDIP_ERRPROPERTYNOTFOUND = 19 ; The specified property does not exist in the image
Global Const $GDIP_ERRPROPERTYNOTSUPPORTED = 20 ; The specified property is not supported
Global Const $GDIP_EVTCOMPRESSIONLZW = 2 ; TIFF: LZW compression
Global Const $GDIP_EVTCOMPRESSIONCCITT3 = 3 ; TIFF: CCITT3 compression
Global Const $GDIP_EVTCOMPRESSIONCCITT4 = 4 ; TIFF: CCITT4 compression
Global Const $GDIP_EVTCOMPRESSIONRLE = 5 ; TIFF: RLE compression
Global Const $GDIP_EVTCOMPRESSIONNONE = 6 ; TIFF: No compression
Global Const $GDIP_EVTTRANSFORMROTATE90 = 13 ; JPEG: Lossless 90 degree clockwise rotation
Global Const $GDIP_EVTTRANSFORMROTATE180 = 14 ; JPEG: Lossless 180 degree clockwise rotation
Global Const $GDIP_EVTTRANSFORMROTATE270 = 15 ; JPEG: Lossless 270 degree clockwise rotation
Global Const $GDIP_EVTTRANSFORMFLIPHORIZONTAL = 16 ; JPEG: Lossless horizontal flip
Global Const $GDIP_EVTTRANSFORMFLIPVERTICAL = 17 ; JPEG: Lossless vertical flip
Global Const $GDIP_EVTMULTIFRAME = 18 ; Multiple frame encoding
Global Const $GDIP_EVTLASTFRAME = 19 ; Last frame of a multiple frame image
Global Const $GDIP_EVTFLUSH = 20 ; The encoder object is to be closed
Global Const $GDIP_EVTFRAMEDIMENSIONPAGE = 23 ; TIFF: Page frame dimension
Global Const $GDIP_ICFENCODER = 0x00000001 ; The codec supports encoding (saving)
Global Const $GDIP_ICFDECODER = 0x00000002 ; The codec supports decoding (reading)
Global Const $GDIP_ICFSUPPORTBITMAP = 0x00000004 ; The codec supports raster images (bitmaps)
Global Const $GDIP_ICFSUPPORTVECTOR = 0x00000008 ; The codec supports vector images (metafiles)
Global Const $GDIP_ICFSEEKABLEENCODE = 0x00000010 ; The encoder requires a seekable output stream
Global Const $GDIP_ICFBLOCKINGDECODE = 0x00000020 ; The decoder has blocking behavior during the decoding process
Global Const $GDIP_ICFBUILTIN = 0x00010000 ; The codec is built in to GDI+
Global Const $GDIP_ICFSYSTEM = 0x00020000 ; Not used in GDI+ version 1.0
Global Const $GDIP_ICFUSER = 0x00040000 ; Not used in GDI+ version 1.0
Global Const $GDIP_ILMREAD = 0x0001 ; A portion of the image is locked for reading
Global Const $GDIP_ILMWRITE = 0x0002 ; A portion of the image is locked for writing
Global Const $GDIP_ILMUSERINPUTBUF = 0x0004 ; The buffer is allocated by the user
Global Const $GDIP_LINECAPFLAT = 0x00 ; Specifies a flat cap
Global Const $GDIP_LINECAPSQUARE = 0x01 ; Specifies a square cap
Global Const $GDIP_LINECAPROUND = 0x02 ; Specifies a circular cap
Global Const $GDIP_LINECAPTRIANGLE = 0x03 ; Specifies a triangular cap
Global Const $GDIP_LINECAPNOANCHOR = 0x10 ; Specifies that the line ends are not anchored
Global Const $GDIP_LINECAPSQUAREANCHOR = 0x11 ; Specifies that the line ends are anchored with a square
Global Const $GDIP_LINECAPROUNDANCHOR = 0x12 ; Specifies that the line ends are anchored with a circle
Global Const $GDIP_LINECAPDIAMONDANCHOR = 0x13 ; Specifies that the line ends are anchored with a diamond
Global Const $GDIP_LINECAPARROWANCHOR = 0x14 ; Specifies that the line ends are anchored with arrowheads
Global Const $GDIP_LINECAPCUSTOM = 0xFF ; Specifies that the line ends are made from a CustomLineCap
Global Const $GDIP_PXF01INDEXED = 0x00030101 ; 1 bpp, indexed
Global Const $GDIP_PXF04INDEXED = 0x00030402 ; 4 bpp, indexed
Global Const $GDIP_PXF08INDEXED = 0x00030803 ; 8 bpp, indexed
Global Const $GDIP_PXF16GRAYSCALE = 0x00101004 ; 16 bpp, grayscale
Global Const $GDIP_PXF16RGB555 = 0x00021005 ; 16 bpp; 5 bits for each RGB
Global Const $GDIP_PXF16RGB565 = 0x00021006 ; 16 bpp; 5 bits red, 6 bits green, and 5 bits blue
Global Const $GDIP_PXF16ARGB1555 = 0x00061007 ; 16 bpp; 1 bit for alpha and 5 bits for each RGB component
Global Const $GDIP_PXF24RGB = 0x00021808 ; 24 bpp; 8 bits for each RGB
Global Const $GDIP_PXF32RGB = 0x00022009 ; 32 bpp; 8 bits for each RGB. No alpha.
Global Const $GDIP_PXF32ARGB = 0x0026200A ; 32 bpp; 8 bits for each RGB and alpha
Global Const $GDIP_PXF32PARGB = 0x000D200B ; 32 bpp; 8 bits for each RGB and alpha, pre-mulitiplied
Global Const $GDIP_PXF48RGB = 0x0010300C ; 48 bpp; 16 bits for each RGB
Global Const $GDIP_PXF64ARGB = 0x0034400D ; 64 bpp; 16 bits for each RGB and alpha
Global Const $GDIP_PXF64PARGB = 0x001C400E ; 64 bpp; 16 bits for each RGB and alpha, pre-multiplied
Global Const $GDIP_IMAGEFORMAT_UNDEFINED = "{B96B3CA9-0728-11D3-9D7B-0000F81EF32E}" ; Windows GDI+ is unable to determine the format.
Global Const $GDIP_IMAGEFORMAT_MEMORYBMP = "{B96B3CAA-0728-11D3-9D7B-0000F81EF32E}" ; Image was constructed from a memory bitmap.
Global Const $GDIP_IMAGEFORMAT_BMP = "{B96B3CAB-0728-11D3-9D7B-0000F81EF32E}" ; Microsoft Windows Bitmap (BMP) format.
Global Const $GDIP_IMAGEFORMAT_EMF = "{B96B3CAC-0728-11D3-9D7B-0000F81EF32E}" ; Enhanced Metafile (EMF) format.
Global Const $GDIP_IMAGEFORMAT_WMF = "{B96B3CAD-0728-11D3-9D7B-0000F81EF32E}" ; Windows Metafile Format (WMF) format.
Global Const $GDIP_IMAGEFORMAT_JPEG = "{B96B3CAE-0728-11D3-9D7B-0000F81EF32E}" ; Joint Photographic Experts Group (JPEG) format.
Global Const $GDIP_IMAGEFORMAT_PNG = "{B96B3CAF-0728-11D3-9D7B-0000F81EF32E}" ; Portable Network Graphics (PNG) format.
Global Const $GDIP_IMAGEFORMAT_GIF = "{B96B3CB0-0728-11D3-9D7B-0000F81EF32E}" ; Graphics Interchange Format (GIF) format.
Global Const $GDIP_IMAGEFORMAT_TIFF = "{B96B3CB1-0728-11D3-9D7B-0000F81EF32E}" ; Tagged Image File Format (TIFF) format.
Global Const $GDIP_IMAGEFORMAT_EXIF = "{B96B3CB2-0728-11D3-9D7B-0000F81EF32E}" ; Exchangeable Image File (EXIF) format.
Global Const $GDIP_IMAGEFORMAT_ICON = "{B96B3CB5-0728-11D3-9D7B-0000F81EF32E}" ; Microsoft Windows Icon Image (ICO)format.
Global Const $GDIP_IMAGETYPE_UNKNOWN = 0
Global Const $GDIP_IMAGETYPE_BITMAP = 1
Global Const $GDIP_IMAGETYPE_METAFILE = 2
Global Const $GDIP_IMAGEFLAGS_NONE = 0x0 ; no format information.
Global Const $GDIP_IMAGEFLAGS_SCALABLE = 0x0001 ; image can be scaled.
Global Const $GDIP_IMAGEFLAGS_HASALPHA = 0x0002 ; pixel data contains alpha values.
Global Const $GDIP_IMAGEFLAGS_HASTRANSLUCENT = 0x0004 ; pixel data has alpha values other than 0 (transparent) and 255 (opaque).
Global Const $GDIP_IMAGEFLAGS_PARTIALLYSCALABLE = 0x0008 ; pixel data is partially scalable with some limitations.
Global Const $GDIP_IMAGEFLAGS_COLORSPACE_RGB = 0x0010 ; image is stored using an RGB color space.
Global Const $GDIP_IMAGEFLAGS_COLORSPACE_CMYK = 0x0020 ; image is stored using a CMYK color space.
Global Const $GDIP_IMAGEFLAGS_COLORSPACE_GRAY = 0x0040 ; image is a grayscale image.
Global Const $GDIP_IMAGEFLAGS_COLORSPACE_YCBCR = 0x0080 ; image is stored using a YCBCR color space.
Global Const $GDIP_IMAGEFLAGS_COLORSPACE_YCCK = 0x0100 ; image is stored using a YCCK color space.
Global Const $GDIP_IMAGEFLAGS_HASREALDPI = 0x1000 ; dots per inch information is stored in the image.
Global Const $GDIP_IMAGEFLAGS_HASREALPIXELSIZE = 0x2000 ; pixel size is stored in the image.
Global Const $GDIP_IMAGEFLAGS_READONLY = 0x00010000 ; pixel data is read-only.
Global Const $GDIP_IMAGEFLAGS_CACHING = 0x00020000 ; pixel data can be cached for faster access.
Global $ghGDIPBrush = 0
Global $ghGDIPDll = 0
Global $ghGDIPPen = 0
Global $giGDIPRef = 0
Global $giGDIPToken = 0
Func _GDIPlus_ArrowCapCreate($nHeight, $nWidth, $fFilled = True)
	Local $iHeight, $iWidth, $aResult
	$iHeight = _WinAPI_FloatToInt($nHeight)
	$iWidth = _WinAPI_FloatToInt($nWidth)
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateAdjustableArrowCap", "int", $iHeight, "int", $iWidth, "int", $fFilled, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[4])
EndFunc   ;==>_GDIPlus_ArrowCapCreate
Func _GDIPlus_ArrowCapDispose($hCap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeleteCustomLineCap", "hwnd", $hCap)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_ArrowCapDispose
Func _GDIPlus_ArrowCapGetFillState($hArrowCap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetAdjustableArrowCapFillState", "hwnd", $hArrowCap, "int*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[2] <> 0)
EndFunc   ;==>_GDIPlus_ArrowCapGetFillState
Func _GDIPlus_ArrowCapGetHeight($hArrowCap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetAdjustableArrowCapHeight", "hwnd", $hArrowCap, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, _WinAPI_IntToFloat($aResult[2]))
EndFunc   ;==>_GDIPlus_ArrowCapGetHeight
Func _GDIPlus_ArrowCapGetMiddleInset($hArrowCap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetAdjustableArrowCapMiddleInset", "hwnd", $hArrowCap, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, _WinAPI_IntToFloat($aResult[2]))
EndFunc   ;==>_GDIPlus_ArrowCapGetMiddleInset
Func _GDIPlus_ArrowCapGetWidth($hArrowCap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetAdjustableArrowCapWidth", "hwnd", $hArrowCap, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, _WinAPI_IntToFloat($aResult[2]))
EndFunc   ;==>_GDIPlus_ArrowCapGetWidth
Func _GDIPlus_ArrowCapSetFillState($hArrowCap, $fFilled = True)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetAdjustableArrowCapFillState", "hwnd", $hArrowCap, "int", $fFilled)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_ArrowCapSetFillState
Func _GDIPlus_ArrowCapSetHeight($hArrowCap, $nHeight)
	Local $iHeight, $aResult
	$iHeight = _WinAPI_FloatToInt($nHeight)
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetAdjustableArrowCapHeight", "hwnd", $hArrowCap, "int", $iHeight)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_ArrowCapSetHeight
Func _GDIPlus_ArrowCapSetMiddleInset($hArrowCap, $nInset)
	Local $iInset, $aResult
	$iInset = _WinAPI_FloatToInt($nInset)
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetAdjustableArrowCapMiddleInset", "hwnd", $hArrowCap, "int", $iInset)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_ArrowCapSetMiddleInset
Func _GDIPlus_ArrowCapSetWidth($hArrowCap, $nWidth)
	Local $iWidth, $aResult
	$iWidth = _WinAPI_FloatToInt($nWidth)
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetAdjustableArrowCapWidth", "hwnd", $hArrowCap, "int", $iWidth)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_ArrowCapSetWidth
Func _GDIPlus_BitmapCloneArea($hBmp, $iLeft, $iTop, $iWidth, $iHeight, $iFormat = 0x00021808)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCloneBitmapAreaI", "int", $iLeft, "int", $iTop, "int", $iWidth, "int", $iHeight, _
			"int", $iFormat, "ptr", $hBmp, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[7])
EndFunc   ;==>_GDIPlus_BitmapCloneArea
Func _GDIPlus_BitmapCreateFromFile($sFileName)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromFile", "wstr", $sFileName, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_BitmapCreateFromFile
Func _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromGraphics", "int", $iWidth, "int", $iHeight, "hwnd", $hGraphics, _
			"int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[4])
EndFunc   ;==>_GDIPlus_BitmapCreateFromGraphics
Func _GDIPlus_BitmapCreateFromHBITMAP($hBmp, $hPal = 0)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromHBITMAP", "hwnd", $hBmp, "hwnd", $hPal, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_GDIPlus_BitmapCreateFromHBITMAP
Func _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap, $iARGB = 0xFF000000)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateHBITMAPFromBitmap", "hwnd", $hBitmap, "int*", 0, "int", $iARGB)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_BitmapCreateHBITMAPFromBitmap
Func _GDIPlus_BitmapDispose($hBitmap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDisposeImage", "hwnd", $hBitmap)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_BitmapDispose
Func _GDIPlus_BitmapLockBits($hBitmap, $iLeft, $iTop, $iRight, $iBottom, $iFlags = 1, $iFormat = 0x00022009)
	Local $pData, $tData, $pRect, $tRect, $aResult
	$tData = DllStructCreate($tagGDIPBITMAPDATA)
	$pData = DllStructGetPtr($tData)
	$tRect = DllStructCreate($tagRECT)
	$pRect = DllStructGetPtr($tRect)
	DllStructSetData($tRect, "Left", $iLeft)
	DllStructSetData($tRect, "Top", $iTop)
	DllStructSetData($tRect, "Right", $iRight)
	DllStructSetData($tRect, "Bottom", $iBottom)
	$aResult = DllCall($ghGDIPDll, "int", "GdipBitmapLockBits", "hwnd", $hBitmap, "ptr", $pRect, "uint", $iFlags, "uint", $iFormat, "ptr", $pData)
	If @error Then Return SetError(@error, @extended, $tRect)
	Return SetError($aResult[0], 0, $tData)
EndFunc   ;==>_GDIPlus_BitmapLockBits
Func _GDIPlus_BitmapUnlockBits($hBitmap, $tBitmapData)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipBitmapUnlockBits", "hwnd", $hBitmap, "int*", DllStructGetPtr($tBitmapData))
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_BitmapUnlockBits
Func _GDIPlus_BrushClone($hBrush)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCloneBrush", "hwnd", $hBrush, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_BrushClone
Func _GDIPlus_BrushCreateSolid($iARGB = 0xFF000000)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateSolidFill", "int", $iARGB, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_BrushCreateSolid
Func _GDIPlus_BrushDispose($hBrush)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeleteBrush", "hwnd", $hBrush)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_BrushDispose
Func _GDIPlus_BrushGetType($hBrush)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetBrushType", "hwnd", $hBrush, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_BrushGetType
Func _GDIPlus_CustomLineCapDispose($hCap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeleteCustomLineCap", "hwnd", $hCap)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_CustomLineCapDispose
Func _GDIPlus_Decoders()
	Local $iI, $iCount, $iSize, $pBuffer, $tBuffer, $tCodec, $aResult, $aInfo[1][14]
	$iCount = _GDIPlus_DecodersGetCount()
	$iSize = _GDIPlus_DecodersGetSize()
	$tBuffer = DllStructCreate("byte[" & $iSize & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageDecoders", "int", $iCount, "int", $iSize, "ptr", $pBuffer)
	If @error Then Return SetError(@error, @extended, $aInfo)
	If $aResult[0] <> 0 Then Return SetError($aResult[0], 0, $aInfo)
	Dim $aInfo[$iCount + 1][14]
	$aInfo[0][0] = $iCount
	For $iI = 1 To $iCount
		$tCodec = DllStructCreate($tagGDIPIMAGECODECINFO, $pBuffer)
		$aInfo[$iI][1] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "CLSID"))
		$aInfo[$iI][2] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "FormatID"))
		$aInfo[$iI][3] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "CodecName"))
		$aInfo[$iI][4] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "DllName"))
		$aInfo[$iI][5] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FormatDesc"))
		$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FileExt"))
		$aInfo[$iI][7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "MimeType"))
		$aInfo[$iI][8] = DllStructGetData($tCodec, "Flags")
		$aInfo[$iI][9] = DllStructGetData($tCodec, "Version")
		$aInfo[$iI][10] = DllStructGetData($tCodec, "SigCount")
		$aInfo[$iI][11] = DllStructGetData($tCodec, "SigSize")
		$aInfo[$iI][12] = DllStructGetData($tCodec, "SigPattern")
		$aInfo[$iI][13] = DllStructGetData($tCodec, "SigMask")
		$pBuffer += DllStructGetSize($tCodec)
	Next
	Return $aInfo
EndFunc   ;==>_GDIPlus_Decoders
Func _GDIPlus_DecodersGetCount()
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageDecodersSize", "int*", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[1])
EndFunc   ;==>_GDIPlus_DecodersGetCount
Func _GDIPlus_DecodersGetSize()
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageDecodersSize", "int*", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_DecodersGetSize
Func _GDIPlus_DrawImagePoints($hGraphic, $hImage, $nULX, $nULY, $nURX, $nURY, $nLLX, $nLLY, $count = 3)
	Local $tPoint, $pPoint, $aResult
	$tPoint = DllStructCreate("float X;float Y;float X2;float Y2;float X3;float Y3")
	DllStructSetData($tPoint, "X", $nULX)
	DllStructSetData($tPoint, "Y", $nULY)
	DllStructSetData($tPoint, "X2", $nURX)
	DllStructSetData($tPoint, "Y2", $nURY)
	DllStructSetData($tPoint, "X3", $nLLX)
	DllStructSetData($tPoint, "Y3", $nLLY)
	$pPoint = DllStructGetPtr($tPoint)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawImagePoints", _
			"hwnd", $hGraphic, _
			"hwnd", $hImage, _
			"ptr", $pPoint, _
			"int", $count)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_DrawImagePoints
Func _GDIPlus_Encoders()
	Local $iI, $iCount, $iSize, $pBuffer, $tBuffer, $tCodec, $aResult, $aInfo[1][14]
	$iCount = _GDIPlus_EncodersGetCount()
	$iSize = _GDIPlus_EncodersGetSize()
	$tBuffer = DllStructCreate("byte[" & $iSize & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncoders", "int", $iCount, "int", $iSize, "ptr", $pBuffer)
	If @error Then Return SetError(@error, @extended, $aInfo)
	If $aResult[0] <> 0 Then Return SetError($aResult[0], 0, $aInfo)
	Dim $aInfo[$iCount + 1][14]
	$aInfo[0][0] = $iCount
	For $iI = 1 To $iCount
		$tCodec = DllStructCreate($tagGDIPIMAGECODECINFO, $pBuffer)
		$aInfo[$iI][1] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "CLSID"))
		$aInfo[$iI][2] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "FormatID"))
		$aInfo[$iI][3] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "CodecName"))
		$aInfo[$iI][4] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "DllName"))
		$aInfo[$iI][5] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FormatDesc"))
		$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FileExt"))
		$aInfo[$iI][7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "MimeType"))
		$aInfo[$iI][8] = DllStructGetData($tCodec, "Flags")
		$aInfo[$iI][9] = DllStructGetData($tCodec, "Version")
		$aInfo[$iI][10] = DllStructGetData($tCodec, "SigCount")
		$aInfo[$iI][11] = DllStructGetData($tCodec, "SigSize")
		$aInfo[$iI][12] = DllStructGetData($tCodec, "SigPattern")
		$aInfo[$iI][13] = DllStructGetData($tCodec, "SigMask")
		$pBuffer += DllStructGetSize($tCodec)
	Next
	Return $aInfo
EndFunc   ;==>_GDIPlus_Encoders
Func _GDIPlus_EncodersGetCLSID($sFileExt)
	Local $iI, $aEncoders
	$aEncoders = _GDIPlus_Encoders()
	For $iI = 1 To $aEncoders[0][0]
		If StringInStr($aEncoders[$iI][6], "*." & $sFileExt) > 0 Then Return $aEncoders[$iI][1]
	Next
	Return SetError(-1, -1, "")
EndFunc   ;==>_GDIPlus_EncodersGetCLSID
Func _GDIPlus_EncodersGetCount()
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncodersSize", "int*", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[1])
EndFunc   ;==>_GDIPlus_EncodersGetCount
Func _GDIPlus_EncodersGetParamList($hImage, $sEncoder)
	Local $iSize, $pBuffer, $tBuffer, $pGUID, $tGUID, $aResult
	$iSize = _GDIPlus_EncodersGetParamListSize($hImage, $sEncoder)
	If @error Then Return SetError(-1, -1, 0)
	$tGUID = _WinAPI_GUIDFromString($sEncoder)
	$pGUID = DllStructGetPtr($tGUID)
	$tBuffer = DllStructCreate("dword Count;byte Params[" & $iSize - 4 & "]")
	$pBuffer = DllStructGetPtr($tBuffer)
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetEncoderParameterList", "hwnd", $hImage, "ptr", $pGUID, "int", $iSize, "ptr", $pBuffer)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $tBuffer)
EndFunc   ;==>_GDIPlus_EncodersGetParamList
Func _GDIPlus_EncodersGetParamListSize($hImage, $sEncoder)
	Local $pGUID, $tGUID, $aResult
	$tGUID = _WinAPI_GUIDFromString($sEncoder)
	$pGUID = DllStructGetPtr($tGUID)
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetEncoderParameterListSize", "hwnd", $hImage, "ptr", $pGUID, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_GDIPlus_EncodersGetParamListSize
Func _GDIPlus_EncodersGetSize()
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageEncodersSize", "int*", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_EncodersGetSize
Func _GDIPlus_FontCreate($hFamily, $nSize, $iStyle = 0, $iUnit = 3)
	Local $iSize, $aResult
	$iSize = _WinAPI_FloatToInt($nSize)
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateFont", "hwnd", $hFamily, "int", $iSize, "int", $iStyle, "int", $iUnit, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[5])
EndFunc   ;==>_GDIPlus_FontCreate
Func _GDIPlus_FontDispose($hFont)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeleteFont", "hwnd", $hFont)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_FontDispose
Func _GDIPlus_FontFamilyCreate($sFamily)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateFontFamilyFromName", "wstr", $sFamily, "ptr", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_GDIPlus_FontFamilyCreate
Func _GDIPlus_FontFamilyDispose($hFamily)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeleteFontFamily", "hwnd", $hFamily)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_FontFamilyDispose
Func _GDIPlus_GraphicsClear($hGraphics, $iARGB = 0xFF000000)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGraphicsClear", "hwnd", $hGraphics, "int", $iARGB)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsClear
Func _GDIPlus_GraphicsCreateFromHDC($hDC)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateFromHDC", "hwnd", $hDC, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsCreateFromHDC
Func _GDIPlus_GraphicsCreateFromHWND($hWnd)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateFromHWND", "hwnd", $hWnd, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsCreateFromHWND
Func _GDIPlus_GraphicsDispose($hGraphics)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeleteGraphics", "hwnd", $hGraphics)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDispose
Func _GDIPlus_GraphicsDrawArc($hGraphics, $iX, $iY, $iWidth, $iHeight, $nStartAngle, $nSweepAngle, $hPen = 0)
	Local $iStart, $iSweep, $aResult, $tmpError, $tmpExError
	_GDIPlus_PenDefCreate($hPen)
	$iStart = _WinAPI_FloatToInt($nStartAngle)
	$iSweep = _WinAPI_FloatToInt($nSweepAngle)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawArcI", "hwnd", $hGraphics, "hwnd", $hPen, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight, "int", $iStart, "int", $iSweep)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawArc
Func _GDIPlus_GraphicsDrawBezier($hGraphics, $iX1, $iY1, $iX2, $iY2, $iX3, $iY3, $iX4, $iY4, $hPen = 0)
	Local $aResult, $tmpError, $tmpExError
	_GDIPlus_PenDefCreate($hPen)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawBezierI", "hwnd", $hGraphics, "hwnd", $hPen, "int", $iX1, "int", $iY1, _
			"int", $iX2, "int", $iY2, "int", $iX3, "int", $iY3, "int", $iX4, "int", $iY4)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawBezier
Func _GDIPlus_GraphicsDrawClosedCurve($hGraphics, $aPoints, $hPen = 0)
	Local $iI, $iCount, $pPoints, $tPoints, $aResult, $tmpError, $tmpExError
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("int[" & $iCount * 2 & "]")
	$pPoints = DllStructGetPtr($tPoints)
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	_GDIPlus_PenDefCreate($hPen)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawClosedCurveI", "hwnd", $hGraphics, "hwnd", $hPen, "ptr", $pPoints, "int", $iCount)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawClosedCurve
Func _GDIPlus_GraphicsDrawCurve($hGraphics, $aPoints, $hPen = 0)
	Local $iI, $iCount, $pPoints, $tPoints, $aResult, $tmpError, $tmpExError
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("int[" & $iCount * 2 & "]")
	$pPoints = DllStructGetPtr($tPoints)
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	_GDIPlus_PenDefCreate($hPen)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawCurveI", "hwnd", $hGraphics, "hwnd", $hPen, "ptr", $pPoints, "int", $iCount)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawCurve
Func _GDIPlus_GraphicsDrawEllipse($hGraphics, $iX, $iY, $iWidth, $iHeight, $hPen = 0)
	Local $aResult, $tmpError, $tmpExError
	_GDIPlus_PenDefCreate($hPen)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawEllipseI", "hwnd", $hGraphics, "hwnd", $hPen, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawEllipse
Func _GDIPlus_GraphicsDrawImage($hGraphics, $hImage, $iX, $iY)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageI", "hwnd", $hGraphics, "hwnd", $hImage, "int", $iX, "int", $iY)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawImage
Func _GDIPlus_GraphicsDrawImageRect($hGraphics, $hImage, $iX, $iY, $iW, $iH)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRectI", "hwnd", $hGraphics, "hwnd", $hImage, "int", $iX, "int", $iY, "int", $iW, "int", $iH)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRect
Func _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth, $iSrcHeight, $iDstX, $iDstY, $iDstWidth, $iDstHeight, $iUnit = 2)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRectRectI", "hwnd", $hGraphics, "hwnd", $hImage, "int", $iDstX, "int", _
			$iDstY, "int", $iDstWidth, "int", $iDstHeight, "int", $iSrcX, "int", $iSrcY, "int", $iSrcWidth, "int", _
			$iSrcHeight, "int", $iUnit, "int", 0, "int", 0, "int", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRect
Func _GDIPlus_GraphicsDrawLine($hGraphics, $iX1, $iY1, $iX2, $iY2, $hPen = 0)
	Local $aResult, $tmpError, $tmpExError
	_GDIPlus_PenDefCreate($hPen)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawLineI", "hwnd", $hGraphics, "hwnd", $hPen, "int", $iX1, "int", $iY1, "int", $iX2, "int", $iY2)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawLine
Func _GDIPlus_GraphicsDrawPie($hGraphics, $iX, $iY, $iWidth, $iHeight, $nStartAngle, $nSweepAngle, $hPen = 0)
	Local $iStart, $iSweep, $aResult, $tmpError, $tmpExError
	_GDIPlus_PenDefCreate($hPen)
	$iStart = _WinAPI_FloatToInt($nStartAngle)
	$iSweep = _WinAPI_FloatToInt($nSweepAngle)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawPieI", "hwnd", $hGraphics, "hwnd", $hPen, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight, "int", $iStart, "int", $iSweep)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawPie
Func _GDIPlus_GraphicsDrawPolygon($hGraphics, $aPoints, $hPen = 0)
	Local $iI, $iCount, $pPoints, $tPoints, $aResult, $tmpError, $tmpExError
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("int[" & $iCount * 2 & "]")
	$pPoints = DllStructGetPtr($tPoints)
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	_GDIPlus_PenDefCreate($hPen)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawPolygonI", "hwnd", $hGraphics, "hwnd", $hPen, "ptr", $pPoints, "int", $iCount)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawPolygon
Func _GDIPlus_GraphicsDrawRect($hGraphics, $iX, $iY, $iWidth, $iHeight, $hPen = 0)
	Local $aResult, $tmpError, $tmpExError
	_GDIPlus_PenDefCreate($hPen)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawRectangleI", "hwnd", $hGraphics, "hwnd", $hPen, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_PenDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawRect
Func _GDIPlus_GraphicsDrawString($hGraphics, $sString, $nX, $nY, $sFont = "Arial", $nSize = 10, $iFormat = 0)
	Local $hBrush, $iError, $hFamily, $hFont, $hFormat, $aInfo, $tLayout, $bResult
	$hBrush = _GDIPlus_BrushCreateSolid()
	$hFormat = _GDIPlus_StringFormatCreate($iFormat)
	$hFamily = _GDIPlus_FontFamilyCreate($sFont)
	$hFont = _GDIPlus_FontCreate($hFamily, $nSize)
	$tLayout = _GDIPlus_RectFCreate($nX, $nY, 0, 0)
	$aInfo = _GDIPlus_GraphicsMeasureString($hGraphics, $sString, $hFont, $tLayout, $hFormat)
	$bResult = _GDIPlus_GraphicsDrawStringEx($hGraphics, $sString, $hFont, $aInfo[0], $hFormat, $hBrush)
	$iError = @error
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	Return SetError($iError, 0, $bResult)
EndFunc   ;==>_GDIPlus_GraphicsDrawString
Func _GDIPlus_GraphicsDrawStringEx($hGraphics, $sString, $hFont, $tLayout, $hFormat, $hBrush)
	Local $pLayout, $aResult
	$pLayout = DllStructGetPtr($tLayout)
	$aResult = DllCall($ghGDIPDll, "int", "GdipDrawString", "hwnd", $hGraphics, "wstr", $sString, "int", -1, "hwnd", $hFont, _
			"ptr", $pLayout, "hwnd", $hFormat, "hwnd", $hBrush)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsDrawStringEx
Func _GDIPlus_GraphicsFillClosedCurve($hGraphics, $aPoints, $hBrush = 0)
	Local $iI, $iCount, $pPoints, $tPoints, $aResult, $tmpError, $tmpExError
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("int[" & $iCount * 2 & "]")
	$pPoints = DllStructGetPtr($tPoints)
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	_GDIPlus_BrushDefCreate($hBrush)
	$aResult = DllCall($ghGDIPDll, "int", "GdipFillClosedCurveI", "hwnd", $hGraphics, "hwnd", $hBrush, "ptr", $pPoints, "int", $iCount)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsFillClosedCurve
Func _GDIPlus_GraphicsFillEllipse($hGraphics, $iX, $iY, $iWidth, $iHeight, $hBrush = 0)
	Local $aResult, $tmpError, $tmpExError
	_GDIPlus_BrushDefCreate($hBrush)
	$aResult = DllCall($ghGDIPDll, "int", "GdipFillEllipseI", "hwnd", $hGraphics, "hwnd", $hBrush, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsFillEllipse
Func _GDIPlus_GraphicsFillPie($hGraphics, $iX, $iY, $iWidth, $iHeight, $nStartAngle, $nSweepAngle, $hBrush = 0)
	Local $iStart, $iSweep, $aResult, $tmpError, $tmpExError
	_GDIPlus_BrushDefCreate($hBrush)
	$iStart = _WinAPI_FloatToInt($nStartAngle)
	$iSweep = _WinAPI_FloatToInt($nSweepAngle)
	$aResult = DllCall($ghGDIPDll, "int", "GdipFillPieI", "hwnd", $hGraphics, "hwnd", $hBrush, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight, "int", $iStart, "int", $iSweep)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsFillPie
Func _GDIPlus_GraphicsFillPolygon($hGraphics, $aPoints, $hBrush = 0)
	Local $iI, $iCount, $pPoints, $tPoints, $aResult, $tmpError, $tmpExError
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("int[" & $iCount * 2 & "]")
	$pPoints = DllStructGetPtr($tPoints)
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	_GDIPlus_BrushDefCreate($hBrush)
	$aResult = DllCall($ghGDIPDll, "int", "GdipFillPolygonI", "hWnd", $hGraphics, "hWnd", $hBrush, _
			"ptr", $pPoints, "int", $iCount, "int", "FillModeAlternate")
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsFillPolygon
Func _GDIPlus_GraphicsFillRect($hGraphics, $iX, $iY, $iWidth, $iHeight, $hBrush = 0)
	Local $aResult, $tmpError, $tmpExError
	_GDIPlus_BrushDefCreate($hBrush)
	$aResult = DllCall($ghGDIPDll, "int", "GdipFillRectangleI", "hwnd", $hGraphics, "hwnd", $hBrush, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	$tmpError = @error
	$tmpExError = @extended
	_GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExError, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsFillRect
Func _GDIPlus_GraphicsGetDC($hGraphics)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetDC", "hwnd", $hGraphics, "int*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsGetDC
Func _GDIPlus_GraphicsGetSmoothingMode($hGraphics)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetSmoothingMode", "hwnd", $hGraphics, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Switch $aResult[2]
		Case 3
			Return SetError($aResult[0], 0, 1)
		Case 7
			Return SetError($aResult[0], 0, 2)
		Case Else
			Return SetError($aResult[0], 0, 0)
	EndSwitch
EndFunc   ;==>_GDIPlus_GraphicsGetSmoothingMode
Func _GDIPlus_GraphicsMeasureString($hGraphics, $sString, $hFont, $tLayout, $hFormat)
	Local $pLayout, $pRectF, $tRectF, $aResult, $aInfo[3]
	$pLayout = DllStructGetPtr($tLayout)
	$tRectF = DllStructCreate($tagGDIPRECTF)
	$pRectF = DllStructGetPtr($tRectF)
	$aResult = DllCall($ghGDIPDll, "int", "GdipMeasureString", "hwnd", $hGraphics, "wstr", $sString, "int", -1, "hwnd", $hFont, _
			"ptr", $pLayout, "hwnd", $hFormat, "ptr", $pRectF, "int*", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, $aInfo)
	$aInfo[0] = $tRectF
	$aInfo[1] = $aResult[8]
	$aInfo[2] = $aResult[9]
	Return SetError($aResult[0], 0, $aInfo)
EndFunc   ;==>_GDIPlus_GraphicsMeasureString
Func _GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipReleaseDC", "hwnd", $hGraphics, "hwnd", $hDC)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsReleaseDC
Func _GDIPlus_GraphicsSetTransform($hGraphics, $hMatrix)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetWorldTransform", "hwnd", $hGraphics, "hwnd", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsSetTransform
Func _GDIPlus_GraphicsSetSmoothingMode($hGraphics, $iSmooth)
	Local $aResult
	If $iSmooth < 0 Or $iSmooth > 4 Then $iSmooth = 0
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetSmoothingMode", "hwnd", $hGraphics, "int", $iSmooth)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_GraphicsSetSmoothingMode
Func _GDIPlus_ImageDispose($hImage)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDisposeImage", "hwnd", $hImage)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_ImageDispose
Func _GDIPlus_ImageGetFlags($hImage)
	Local $aResult, $aFlag[2] = [0, ""], $iError = 0
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(4, 1, $aFlag)
	Local $aImageFlags[13][2] = _
			[["Pixel data Cacheable", $GDIP_IMAGEFLAGS_CACHING], _
			["Pixel data read-only", $GDIP_IMAGEFLAGS_READONLY], _
			["Pixel size in image", $GDIP_IMAGEFLAGS_HASREALPIXELSIZE], _
			["DPI info in image", $GDIP_IMAGEFLAGS_HASREALDPI], _
			["YCCK color space", $GDIP_IMAGEFLAGS_COLORSPACE_YCCK], _
			["YCBCR color space", $GDIP_IMAGEFLAGS_COLORSPACE_YCBCR], _
			["Grayscale image", $GDIP_IMAGEFLAGS_COLORSPACE_GRAY], _
			["CMYK color space", $GDIP_IMAGEFLAGS_COLORSPACE_CMYK], _
			["RGB color space", $GDIP_IMAGEFLAGS_COLORSPACE_RGB], _
			["Partially scalable", $GDIP_IMAGEFLAGS_PARTIALLYSCALABLE], _
			["Alpha values other than 0 (transparent) and 255 (opaque)", $GDIP_IMAGEFLAGS_HASTRANSLUCENT], _
			["Alpha values", $GDIP_IMAGEFLAGS_HASALPHA], _
			["Scalable", $GDIP_IMAGEFLAGS_SCALABLE]]
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageFlags", "hwnd", $hImage, "long*", 0)
	$iError = @error
	If @error Or IsArray($aResult) = 0 Then Return SetError($iError, 2, $aFlag)
	If $aResult[2] = $GDIP_IMAGEFLAGS_NONE Then
		$aFlag[1] = "No pixel data"
		Return SetError($aResult[0], 3, $aFlag)
	EndIf
	$aFlag[0] = $aResult[2]
	For $i = 0 To 12
		If BitAND($aResult[2], $aImageFlags[$i][1]) = $aImageFlags[$i][1] Then
			If StringLen($aFlag[1]) Then $aFlag[1] &= "|"
			$aResult[2] -= $aImageFlags[$i][1]
			$aFlag[1] &= $aImageFlags[$i][0]
		EndIf
	Next
	Return SetError($aResult[0], 0, $aFlag)
EndFunc   ;==>_GDIPlus_ImageGetFlags
Func _GDIPlus_ImageGetGraphicsContext($hImage)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageGraphicsContext", "hwnd", $hImage, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetGraphicsContext
Func _GDIPlus_ImageGetHeight($hImage)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageHeight", "hwnd", $hImage, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetHeight
Func _GDIPlus_ImageGetHorizontalResolution($hImage)
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(4, 0, 0)
	Local $aResult, $iError = 0
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageHorizontalResolution", _
			"hwnd", $hImage, "float*", 0)
	$iError = @error
	If @error Or IsArray($aResult) = 0 Then Return SetError($iError, 0, 0)
	Return SetError($aResult[0], 0, Round($aResult[2]))
EndFunc   ;==>_GDIPlus_ImageGetHorizontalResolution
Func _GDIPlus_ImageGetPixelFormat($hImage)
	Local $aResult, $aFormat[2] = [0, ""], $iError = 0
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(4, 1, $aFormat)
	Local $aPixelFormat[14][2] = _
			[["1 Bpp Indexed", $GDIP_PXF01INDEXED], _
			["4 Bpp Indexed", $GDIP_PXF04INDEXED], _
			["8 Bpp Indexed", $GDIP_PXF08INDEXED], _
			["16 Bpp Grayscale", $GDIP_PXF16GRAYSCALE], _
			["16 Bpp RGB 555", $GDIP_PXF16RGB555], _
			["16 Bpp RGB 565", $GDIP_PXF16RGB565], _
			["16 Bpp ARGB 1555", $GDIP_PXF16ARGB1555], _
			["24 Bpp RGB", $GDIP_PXF24RGB], _
			["32 Bpp RGB", $GDIP_PXF32RGB], _
			["32 Bpp ARGB", $GDIP_PXF32ARGB], _
			["32 Bpp PARGB", $GDIP_PXF32PARGB], _
			["48 Bpp RGB", $GDIP_PXF48RGB], _
			["64 Bpp ARGB", $GDIP_PXF64ARGB], _
			["64 Bpp PARGB", $GDIP_PXF64PARGB]]
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImagePixelFormat", "hwnd", $hImage, "int*", 0)
	$iError = @error
	If @error Or IsArray($aResult) = 0 Then Return SetError($iError, 2, $aFormat)
	For $i = 0 To 13
		If $aPixelFormat[$i][1] = $aResult[2] Then
			$aFormat[0] = $aPixelFormat[$i][1]
			$aFormat[1] = $aPixelFormat[$i][0]
			Return SetError($aResult[0], 0, $aFormat)
		EndIf
	Next
	Return SetError($aResult[0], 3, $aFormat)
EndFunc   ;==>_GDIPlus_ImageGetPixelFormat
Func _GDIPlus_ImageGetRawFormat($hImage)
	Local $aResult1, $aResult2, $tStruc, $aGuid[2], $iError = 0
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(4, 1, $aGuid)
	Local $aImageType[11][2] = _
			[["UNDEFINED", $GDIP_IMAGEFORMAT_UNDEFINED], _
			["MEMORYBMP", $GDIP_IMAGEFORMAT_MEMORYBMP], _
			["BMP", $GDIP_IMAGEFORMAT_BMP], _
			["EMF", $GDIP_IMAGEFORMAT_EMF], _
			["WMF", $GDIP_IMAGEFORMAT_WMF], _
			["JPEG", $GDIP_IMAGEFORMAT_JPEG], _
			["PNG", $GDIP_IMAGEFORMAT_PNG], _
			["GIF", $GDIP_IMAGEFORMAT_GIF], _
			["TIFF", $GDIP_IMAGEFORMAT_TIFF], _
			["EXIF", $GDIP_IMAGEFORMAT_EXIF], _
			["ICON", $GDIP_IMAGEFORMAT_ICON]]
	$tStruc = DllStructCreate("byte[16]")
	$iError = @error
	If @error Or (Not IsDllStruct($tStruc)) Then Return SetError($iError, 2, $aGuid)
	$aResult1 = DllCall($ghGDIPDll, "int", "GdipGetImageRawFormat", "hwnd", $hImage, _
			"ptr", DllStructGetPtr($tStruc))
	$iError = @error
	If @error Or (Not IsArray($aResult1)) Or (Not IsPtr($aResult1[2])) Or _
			(Not $aResult1[2]) Then Return SetError($iError, 3, $aGuid)
	$aResult2 = DllCall("Ole32.dll", "int", "StringFromGUID2", "ptr", $aResult1[2], "wstr", "", "int", 40)
	$iError = @error
	If @error Or (Not IsArray($aResult2)) Or (Not $aResult2[2]) Then Return SetError($iError, 4, $aGuid)
	For $i = 0 To 10
		If $aImageType[$i][1] == $aResult2[2] Then
			$aGuid[0] = $aImageType[$i][1]
			$aGuid[1] = $aImageType[$i][0]
			Return SetError($aResult1[0], 0, $aGuid)
		EndIf
	Next
	Return SetError($aResult2[0], 5, $aGuid)
EndFunc   ;==>_GDIPlus_ImageGetRawFormat
Func _GDIPlus_ImageGetType($hImage)
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(4, 0, -1)
	Local $aResult, $iError = 0
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageType", "hwnd", $hImage, "int*", 0)
	$iError = @error
	If @error Or IsArray($aResult) = 0 Then Return SetError($iError, 0, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetType
Func _GDIPlus_ImageGetVerticalResolution($hImage)
	If ($hImage = -1) Or (Not $hImage) Then Return SetError(4, 0, 0)
	Local $aResult, $iError = 0
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageVerticalResolution", _
			"hwnd", $hImage, "float*", 0)
	$iError = @error
	If @error Or IsArray($aResult) = 0 Then Return SetError($iError, 0, 0)
	Return SetError($aResult[0], 0, Round($aResult[2]))
EndFunc   ;==>_GDIPlus_ImageGetVerticalResolution
Func _GDIPlus_ImageGetWidth($hImage)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetImageWidth", "hwnd", $hImage, "int*", -1)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetWidth
Func _GDIPlus_ImageLoadFromFile($sFileName)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipLoadImageFromFile", "wstr", $sFileName, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_ImageLoadFromFile
Func _GDIPlus_ImageSaveToFile($hImage, $sFileName)
	Local $sCLSID, $sExt
	$sExt = _GDIPlus_ExtractFileExt($sFileName)
	$sCLSID = _GDIPlus_EncodersGetCLSID($sExt)
	If $sCLSID = "" Then Return SetError(-1, 0, False)
	Return _GDIPlus_ImageSaveToFileEx($hImage, $sFileName, $sCLSID, 0)
EndFunc   ;==>_GDIPlus_ImageSaveToFile
Func _GDIPlus_ImageSaveToFileEx($hImage, $sFileName, $sEncoder, $pParams = 0)
	Local $pGUID, $tGUID, $aResult
	$tGUID = _WinAPI_GUIDFromString($sEncoder)
	$pGUID = DllStructGetPtr($tGUID)
	$aResult = DllCall($ghGDIPDll, "int", "GdipSaveImageToFile", "hwnd", $hImage, "wstr", $sFileName, "ptr", $pGUID, "ptr", $pParams)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_ImageSaveToFileEx
Func _GDIPlus_MatrixCreate()
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateMatrix", "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[1])
EndFunc   ;==>_GDIPlus_MatrixCreate
Func _GDIPlus_MatrixDispose($hMatrix)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeleteMatrix", "hwnd", $hMatrix)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_MatrixDispose
Func _GDIPlus_MatrixRotate($hMatrix, $nAngle, $fAppend = False)
	Local $iAngle, $aResult
	$iAngle = _WinAPI_FloatToInt($nAngle)
	$aResult = DllCall($ghGDIPDll, "int", "GdipRotateMatrix", "hwnd", $hMatrix, "int", $iAngle, "int", $fAppend)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_MatrixRotate
Func _GDIPlus_MatrixScale($hMatrix, $nScaleX, $nScaleY, $fOrder = False)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipScaleMatrix", "ptr", $hMatrix, "float", $nScaleX, "float", $nScaleY, "int", $fOrder)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_MatrixScale
Func _GDIPlus_MatrixTranslate($hMatrix, $nOffsetX, $nOffsetY, $fAppend = False)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipTranslateMatrix", "ptr", $hMatrix, "float", $nOffsetX, "float", $nOffsetY, "int", $fAppend)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_MatrixTranslate
Func _GDIPlus_ParamAdd(ByRef $tParams, $sGUID, $iCount, $iType, $pValues)
	Local $tParam
	$tParam = DllStructCreate($tagGDIPENCODERPARAM, DllStructGetPtr($tParams, "Params") + (DllStructGetData($tParams, "Count") * 28))
	_WinAPI_GUIDFromStringEx($sGUID, DllStructGetPtr($tParam, "GUID"))
	DllStructSetData($tParam, "Type", $iType)
	DllStructSetData($tParam, "Count", $iCount)
	DllStructSetData($tParam, "Values", $pValues)
	DllStructSetData($tParams, "Count", DllStructGetData($tParams, "Count") + 1)
EndFunc   ;==>_GDIPlus_ParamAdd
Func _GDIPlus_ParamInit($iCount)
	If $iCount <= 0 Then Return SetError(-1, -1, 0)
	Return DllStructCreate("dword Count;byte Params[" & $iCount * 28 & "]")
EndFunc   ;==>_GDIPlus_ParamInit
Func _GDIPlus_PenCreate($iARGB = 0xFF000000, $nWidth = 1, $iUnit = 2)
	Local $iWidth, $aResult
	$iWidth = _WinAPI_FloatToInt($nWidth)
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreatePen1", "int", $iARGB, "int", $iWidth, "int", $iUnit, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[4])
EndFunc   ;==>_GDIPlus_PenCreate
Func _GDIPlus_PenDispose($hPen)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeletePen", "hwnd", $hPen)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PenDispose
Func _GDIPlus_PenGetAlignment($hPen)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetPenMode", "hwnd", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetAlignment
Func _GDIPlus_PenGetColor($hPen)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetPenColor", "hwnd", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetColor
Func _GDIPlus_PenGetCustomEndCap($hPen)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetPenCustomEndCap", "hwnd", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetCustomEndCap
Func _GDIPlus_PenGetDashCap($hPen)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetPenDashCap197819", "hwnd", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetDashCap
Func _GDIPlus_PenGetDashStyle($hPen)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetPenDashStyle", "hwnd", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetDashStyle
Func _GDIPlus_PenGetEndCap($hPen)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetPenEndCap", "hwnd", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_PenGetEndCap
Func _GDIPlus_PenGetWidth($hPen)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipGetPenWidth", "hwnd", $hPen, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetError($aResult[0], 0, _WinAPI_IntToFloat($aResult[2]))
EndFunc   ;==>_GDIPlus_PenGetWidth
Func _GDIPlus_PenSetAlignment($hPen, $iAlignment = 0)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetPenMode", "hwnd", $hPen, "int", $iAlignment)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PenSetAlignment
Func _GDIPlus_PenSetColor($hPen, $iARGB)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetPenColor", "hwnd", $hPen, "int", $iARGB)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PenSetColor
Func _GDIPlus_PenSetDashCap($hPen, $iDash = 0)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetPenDashCap197819", "hwnd", $hPen, "int", $iDash)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PenSetDashCap
Func _GDIPlus_PenSetCustomEndCap($hPen, $hEndCap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetPenCustomEndCap", "hwnd", $hPen, "hwnd", $hEndCap)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PenSetCustomEndCap
Func _GDIPlus_PenSetDashStyle($hPen, $iStyle = 0)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetPenDashStyle", "hwnd", $hPen, "int", $iStyle)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PenSetDashStyle
Func _GDIPlus_PenSetEndCap($hPen, $iEndCap)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetPenEndCap", "hwnd", $hPen, "int", $iEndCap)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PenSetEndCap
Func _GDIPlus_PenSetWidth($hPen, $nWidth)
	Local $iWidth, $aResult
	$iWidth = _WinAPI_FloatToInt($nWidth)
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetPenWidth", "hwnd", $hPen, "int", $iWidth)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PenSetWidth
Func _GDIPlus_RectFCreate($nX = 0, $nY = 0, $nWidth = 0, $nHeight = 0)
	Local $tRectF
	$tRectF = DllStructCreate($tagGDIPRECTF)
	DllStructSetData($tRectF, "X", $nX)
	DllStructSetData($tRectF, "Y", $nY)
	DllStructSetData($tRectF, "Width", $nWidth)
	DllStructSetData($tRectF, "Height", $nHeight)
	Return $tRectF
EndFunc   ;==>_GDIPlus_RectFCreate
Func _GDIPlus_Shutdown()
	If $ghGDIPDll = 0 Then Return SetError(-1, -1, False)
	$giGDIPRef -= 1
	If $giGDIPRef = 0 Then
		DllCall($ghGDIPDll, "none", "GdiplusShutdown", "ptr", $giGDIPToken)
		DllClose($ghGDIPDll)
		$ghGDIPDll = 0
	EndIf
	Return True
EndFunc   ;==>_GDIPlus_Shutdown
Func _GDIPlus_Startup()
	Local $pInput, $tInput, $pToken, $tToken, $aResult
	$giGDIPRef += 1
	If $giGDIPRef > 1 Then Return True
	$ghGDIPDll = DllOpen("GDIPlus.dll")
	_WinAPI_Check("_GDIPlus_Startup (GDIPlus.dll not found)", @error, False)
	$tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
	$pInput = DllStructGetPtr($tInput)
	$tToken = DllStructCreate("int Data")
	$pToken = DllStructGetPtr($tToken)
	DllStructSetData($tInput, "Version", 1)
	$aResult = DllCall($ghGDIPDll, "int", "GdiplusStartup", "ptr", $pToken, "ptr", $pInput, "ptr", 0)
	If @error Then Return SetError(@error, @extended, False)
	$giGDIPToken = DllStructGetData($tToken, "Data")
	Return $aResult[0] == 0
EndFunc   ;==>_GDIPlus_Startup
Func _GDIPlus_StringFormatCreate($iFormat = 0, $iLangID = 0)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipCreateStringFormat", "int", $iFormat, "short", $iLangID, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_GDIPlus_StringFormatCreate
Func _GDIPlus_StringFormatDispose($hFormat)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipDeleteStringFormat", "hwnd", $hFormat)
	If @error Then Return SetError(@error, @extended, False)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_StringFormatDispose
Func _GDIPlus_StringFormatSetAlign($hStringFormat, $iFlag)
	Local $aResult
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetStringFormatAlign", "ptr", $hStringFormat, "short", $iFlag)
	If @error Then Return SetError(@error, @extended, 0)
	If $aResult[0] = 0 Then Return SetError(0, 0, 1)
	Return SetError(1, 0, 0)
EndFunc   ;==>_GDIPlus_StringFormatSetAlign
Func _GDIPlus_BrushDefCreate(ByRef $hBrush)
	If $hBrush = 0 Then
		$ghGDIPBrush = _GDIPlus_BrushCreateSolid()
		$hBrush = $ghGDIPBrush
	EndIf
EndFunc   ;==>_GDIPlus_BrushDefCreate
Func _GDIPlus_BrushDefDispose()
	If $ghGDIPBrush <> 0 Then
		_GDIPlus_BrushDispose($ghGDIPBrush)
		$ghGDIPBrush = 0
	EndIf
EndFunc   ;==>_GDIPlus_BrushDefDispose
Func _GDIPlus_ExtractFileExt($sFileName, $fNoDot = True)
	Local $iIndex
	$iIndex = _GDIPlus_LastDelimiter(".\:", $sFileName)
	If ($iIndex > 0) And (StringMid($sFileName, $iIndex, 1) = '.') Then
		If $fNoDot Then
			Return StringMid($sFileName, $iIndex + 1)
		Else
			Return StringMid($sFileName, $iIndex)
		EndIf
	Else
		Return ""
	EndIf
EndFunc   ;==>_GDIPlus_ExtractFileExt
Func _GDIPlus_LastDelimiter($sDelimiters, $sString)
	Local $iI, $iN, $sDelimiter
	For $iI = 1 To StringLen($sDelimiters)
		$sDelimiter = StringMid($sDelimiters, $iI, 1)
		$iN = StringInStr($sString, $sDelimiter, 0, -1)
		If $iN > 0 Then Return $iN
	Next
EndFunc   ;==>_GDIPlus_LastDelimiter
Func _GDIPlus_PenDefCreate(ByRef $hPen)
	If $hPen = 0 Then
		$ghGDIPPen = _GDIPlus_PenCreate()
		$hPen = $ghGDIPPen
	EndIf
EndFunc   ;==>_GDIPlus_PenDefCreate
Func _GDIPlus_PenDefDispose()
	If $ghGDIPPen <> 0 Then
		_GDIPlus_PenDispose($ghGDIPPen)
		$ghGDIPPen = 0
	EndIf
EndFunc   ;==>_GDIPlus_PenDefDispose
Func _ArrayAdd(ByRef $avArray, $vValue)
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, -1)
	Local $iUBound = UBound($avArray)
	ReDim $avArray[$iUBound + 1]
	$avArray[$iUBound] = $vValue
	Return $iUBound
EndFunc   ;==>_ArrayAdd
Func _ArrayBinarySearch(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	If UBound($avArray, 0) <> 1 Then Return SetError(5, 0, -1)
	Local $iUBound = UBound($avArray) - 1
	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(4, 0, -1)
	Local $iMid = Int(($iEnd + $iStart) / 2)
	If $avArray[$iStart] > $vValue Or $avArray[$iEnd] < $vValue Then Return SetError(2, 0, -1)
	; Search
	While $iStart <= $iMid And $vValue <> $avArray[$iMid]
		If $vValue < $avArray[$iMid] Then
			$iEnd = $iMid - 1
		Else
			$iStart = $iMid + 1
		EndIf
		$iMid = Int(($iEnd + $iStart) / 2)
	WEnd
	If $iStart > $iEnd Then Return SetError(3, 0, -1) ; Entry not found
	Return $iMid
EndFunc   ;==>_ArrayBinarySearch
Func _ArrayCombinations(ByRef $avArray, $iSet, $sDelim = "")
	Local $i, $aIdx[1], $aResult[1], $iN = 0, $iR = 0, $iLeft = 0, $iTotal = 0, $iCount = 1
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, 0)
	$iN = UBound($avArray)
	$iR = $iSet
	Dim $aIdx[$iR]
	For $i = 0 To $iR - 1
		$aIdx[$i] = $i
	Next
	$iTotal = _Array_Combinations($iN, $iR)
	$iLeft = $iTotal
	ReDim $aResult[$iTotal + 1]
	$aResult[0] = $iTotal
	While $iLeft > 0
		_Array_GetNext($iN, $iR, $iLeft, $iTotal, $aIdx)
		For $i = 0 To $iSet - 1
			$aResult[$iCount] &= $avArray[$aIdx[$i]] & $sDelim
		Next
		If $sDelim <> "" Then $aResult[$iCount] = StringTrimRight($aResult[$iCount], 1)
		$iCount += 1
	WEnd
	Return $aResult
EndFunc   ;==>_ArrayCombinations
Func _ArrayConcatenate(ByRef $avArrayTarget, Const ByRef $avArraySource)
	If Not IsArray($avArrayTarget) Then Return SetError(1, 0, 0)
	If Not IsArray($avArraySource) Then Return SetError(2, 0, 0)
	If UBound($avArrayTarget, 0) <> 1 Then
		If UBound($avArraySource, 0) <> 1 Then Return SetError(5, 0, 0)
		Return SetError(3, 0, 0)
	EndIf
	If UBound($avArraySource, 0) <> 1 Then Return SetError(4, 0, 0)
	Local $iUBoundTarget = UBound($avArrayTarget), $iUBoundSource = UBound($avArraySource)
	ReDim $avArrayTarget[$iUBoundTarget + $iUBoundSource]
	For $i = 0 To $iUBoundSource - 1
		$avArrayTarget[$iUBoundTarget + $i] = $avArraySource[$i]
	Next
	Return $iUBoundTarget + $iUBoundSource
EndFunc   ;==>_ArrayConcatenate
Func _ArrayCreate($v_0, $v_1 = 0, $v_2 = 0, $v_3 = 0, $v_4 = 0, $v_5 = 0, $v_6 = 0, $v_7 = 0, $v_8 = 0, $v_9 = 0, $v_10 = 0, $v_11 = 0, $v_12 = 0, $v_13 = 0, $v_14 = 0, $v_15 = 0, $v_16 = 0, $v_17 = 0, $v_18 = 0, $v_19 = 0, $v_20 = 0)
	Local $av_Array[21] = [$v_0, $v_1, $v_2, $v_3, $v_4, $v_5, $v_6, $v_7, $v_8, $v_9, $v_10, $v_11, $v_12, $v_13, $v_14, $v_15, $v_16, $v_17, $v_18, $v_19, $v_20]
	ReDim $av_Array[@NumParams]
	Return $av_Array
EndFunc   ;==>_ArrayCreate
Func _ArrayDelete(ByRef $avArray, $iElement)
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	Local $iUBound = UBound($avArray, 1) - 1
	If Not $iUBound Then
		$avArray = ""
		Return 0
	EndIf
	; Bounds checking
	If $iElement < 0 Then $iElement = 0
	If $iElement > $iUBound Then $iElement = $iUBound
	; Move items after $iElement up by 1
	Switch UBound($avArray, 0)
		Case 1
			For $i = $iElement To $iUBound - 1
				$avArray[$i] = $avArray[$i + 1]
			Next
			ReDim $avArray[$iUBound]
		Case 2
			Local $iSubMax = UBound($avArray, 2) - 1
			For $i = $iElement To $iUBound - 1
				For $j = 0 To $iSubMax
					$avArray[$i][$j] = $avArray[$i + 1][$j]
				Next
			Next
			ReDim $avArray[$iUBound][$iSubMax + 1]
		Case Else
			Return SetError(3, 0, 0)
	EndSwitch
	Return $iUBound
EndFunc   ;==>_ArrayDelete
Func _ArrayDisplay(Const ByRef $avArray, $sTitle = "Array: ListView Display", $iItemLimit = -1, $iTranspose = 0, $sSeparator = "", $sReplace = "|")
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	; Dimension checking
	Local $iDimension = UBound($avArray, 0), $iUBound = UBound($avArray, 1) - 1, $iSubMax = UBound($avArray, 2) - 1
	If $iDimension > 2 Then Return SetError(2, 0, 0)
	; Separator handling
	If $sSeparator = "" Then $sSeparator = Chr(124)
	; Declare variables
	Local $i, $j, $vTmp, $aItem, $avArrayText, $sHeader = "Row", $iBuffer = 64
	Local $iColLimit = 250, $iLVIAddUDFThreshold = 4000, $iWidth = 640, $iHeight = 480
	Local $iOnEventMode = Opt("GUIOnEventMode", 0), $sDataSeparatorChar = Opt("GUIDataSeparatorChar", $sSeparator)
	; Swap dimensions if transposing
	If $iSubMax < 0 Then $iSubMax = 0
	If $iTranspose Then
		$vTmp = $iUBound
		$iUBound = $iSubMax
		$iSubMax = $vTmp
	EndIf
	; Set limits for dimensions
	If $iSubMax > $iColLimit Then $iSubMax = $iColLimit
	If $iItemLimit = 1 Then $iItemLimit = $iLVIAddUDFThreshold
	If $iItemLimit < 1 Then $iItemLimit = $iUBound
	If $iUBound > $iItemLimit Then $iUBound = $iItemLimit
	If $iLVIAddUDFThreshold > $iUBound Then $iLVIAddUDFThreshold = $iUBound
	; Set header up
	For $i = 0 To $iSubMax
		$sHeader &= $sSeparator & "Col " & $i
	Next
	; Convert array into text for listview
	Local $avArrayText[$iUBound + 1]
	For $i = 0 To $iUBound
		$avArrayText[$i] = "[" & $i & "]"
		For $j = 0 To $iSubMax
			; Get current item
			If $iDimension = 1 Then
				If $iTranspose Then
					$vTmp = $avArray[$j]
				Else
					$vTmp = $avArray[$i]
				EndIf
			Else
				If $iTranspose Then
					$vTmp = $avArray[$j][$i]
				Else
					$vTmp = $avArray[$i][$j]
				EndIf
			EndIf
			; Add to text array
			$vTmp = StringReplace($vTmp, $sSeparator, $sReplace, 0, 1)
			$avArrayText[$i] &= $sSeparator & $vTmp
			; Set max buffer size
			$vTmp = StringLen($vTmp)
			If $vTmp > $iBuffer Then $iBuffer = $vTmp
		Next
	Next
	$iBuffer += 1
	; GUI Constants
	Local Const $_ARRAYCONSTANT_GUI_DOCKBORDERS = 0x66
	Local Const $_ARRAYCONSTANT_GUI_DOCKBOTTOM = 0x40
	Local Const $_ARRAYCONSTANT_GUI_DOCKHEIGHT = 0x0200
	Local Const $_ARRAYCONSTANT_GUI_DOCKLEFT = 0x2
	Local Const $_ARRAYCONSTANT_GUI_DOCKRIGHT = 0x4
	Local Const $_ARRAYCONSTANT_GUI_EVENT_CLOSE = -3
	Local Const $_ARRAYCONSTANT_LVIF_PARAM = 0x4
	Local Const $_ARRAYCONSTANT_LVIF_TEXT = 0x1
	Local Const $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH = (0x1000 + 29)
	Local Const $_ARRAYCONSTANT_LVM_GETITEMCOUNT = (0x1000 + 4)
	Local Const $_ARRAYCONSTANT_LVM_GETITEMSTATE = (0x1000 + 44)
	Local Const $_ARRAYCONSTANT_LVM_INSERTITEMA = (0x1000 + 7)
	Local Const $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE = (0x1000 + 54)
	Local Const $_ARRAYCONSTANT_LVM_SETITEMA = (0x1000 + 6)
	Local Const $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT = 0x20
	Local Const $_ARRAYCONSTANT_LVS_EX_GRIDLINES = 0x1
	Local Const $_ARRAYCONSTANT_LVS_SHOWSELALWAYS = 0x8
	Local Const $_ARRAYCONSTANT_WS_EX_CLIENTEDGE = 0x0200
	Local Const $_ARRAYCONSTANT_WS_MAXIMIZEBOX = 0x00010000
	Local Const $_ARRAYCONSTANT_WS_MINIMIZEBOX = 0x00020000
	Local Const $_ARRAYCONSTANT_WS_SIZEBOX = 0x00040000
	Local Const $_ARRAYCONSTANT_tagLVITEM = "int Mask;int Item;int SubItem;int State;int StateMask;ptr Text;int TextMax;int Image;int Param;int Indent;int GroupID;int Columns;ptr pColumns"
	Local $iAddMask = BitOR($_ARRAYCONSTANT_LVIF_TEXT, $_ARRAYCONSTANT_LVIF_PARAM)
	Local $tBuffer = DllStructCreate("char Text[" & $iBuffer & "]"), $pBuffer = DllStructGetPtr($tBuffer)
	Local $tItem = DllStructCreate($_ARRAYCONSTANT_tagLVITEM), $pItem = DllStructGetPtr($tItem)
	DllStructSetData($tItem, "Param", 0)
	DllStructSetData($tItem, "Text", $pBuffer)
	DllStructSetData($tItem, "TextMax", $iBuffer)
	; Set interface up
	Local $hGUI = GUICreate($sTitle, $iWidth, $iHeight, Default, Default, BitOR($_ARRAYCONSTANT_WS_SIZEBOX, $_ARRAYCONSTANT_WS_MINIMIZEBOX, $_ARRAYCONSTANT_WS_MAXIMIZEBOX))
	Local $aiGUISize = WinGetClientSize($hGUI)
	Local $hListView = GUICtrlCreateListView($sHeader, 0, 0, $aiGUISize[0], $aiGUISize[1] - 26, $_ARRAYCONSTANT_LVS_SHOWSELALWAYS)
	Local $hCopy = GUICtrlCreateButton("Copy Selected", 3, $aiGUISize[1] - 23, $aiGUISize[0] - 6, 20)
	GUICtrlSetResizing($hListView, $_ARRAYCONSTANT_GUI_DOCKBORDERS)
	GUICtrlSetResizing($hCopy, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
	GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_GRIDLINES, $_ARRAYCONSTANT_LVS_EX_GRIDLINES)
	GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT)
	GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE)
	; Fill listview
	For $i = 0 To $iLVIAddUDFThreshold
		GUICtrlCreateListViewItem($avArrayText[$i], $hListView)
	Next
	For $i = ($iLVIAddUDFThreshold + 1) To $iUBound
		$aItem = StringSplit($avArrayText[$i], $sSeparator)
		DllStructSetData($tBuffer, "Text", $aItem[1])
		; Add listview item
		DllStructSetData($tItem, "Item", $i)
		DllStructSetData($tItem, "SubItem", 0)
		DllStructSetData($tItem, "Mask", $iAddMask)
		GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_INSERTITEMA, 0, $pItem)
		; Set listview subitem text
		DllStructSetData($tItem, "Mask", $_ARRAYCONSTANT_LVIF_TEXT)
		For $j = 2 To $aItem[0]
			DllStructSetData($tBuffer, "Text", $aItem[$j])
			DllStructSetData($tItem, "SubItem", $j - 1)
			GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_SETITEMA, 0, $pItem)
		Next
	Next
	; ajust window width
	$iWidth = 0
	For $i = 0 To $iSubMax + 1
		$iWidth += GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH, $i, 0)
	Next
	If $iWidth < 250 Then $iWidth = 230
	WinMove($hGUI, "", Default, Default, $iWidth + 20)
	; Show dialog
	GUISetState(@SW_SHOW, $hGUI)
	While 1
		Switch GUIGetMsg()
			Case $_ARRAYCONSTANT_GUI_EVENT_CLOSE
				ExitLoop
			Case $hCopy
				Local $sClip = ""
				; Get selected indices [ _GUICtrlListView_GetSelectedIndices($hListView, True) ]
				Local $aiCurItems[1] = [0]
				For $i = 0 To GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETITEMCOUNT, 0, 0)
					If GUICtrlSendMsg($hListView, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, 0x2) Then
						$aiCurItems[0] += 1
						ReDim $aiCurItems[$aiCurItems[0] + 1]
						$aiCurItems[$aiCurItems[0]] = $i
					EndIf
				Next
				; Generate clipboard text
				If Not $aiCurItems[0] Then
					For $sItem In $avArrayText
						$sClip &= $sItem & @CRLF
					Next
				Else
					For $i = 1 To UBound($aiCurItems) - 1
						$sClip &= $avArrayText[$aiCurItems[$i]] & @CRLF
					Next
				EndIf
				ClipPut($sClip)
		EndSwitch
	WEnd
	GUIDelete($hGUI)
	Opt("GUIOnEventMode", $iOnEventMode)
	Opt("GUIDataSeparatorChar", $sDataSeparatorChar)
	Return 1
EndFunc   ;==>_ArrayDisplay
Func _ArrayFindAll(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iPartial = 0, $iSubItem = 0)
	$iStart = _ArraySearch($avArray, $vValue, $iStart, $iEnd, $iCase, $iPartial, 1, $iSubItem)
	If @error Then Return SetError(@error, 0, -1)
	Local $iIndex = 0, $avResult[UBound($avArray)]
	Do
		$avResult[$iIndex] = $iStart
		$iIndex += 1
		$iStart = _ArraySearch($avArray, $vValue, $iStart + 1, $iEnd, $iCase, $iPartial, 1, $iSubItem)
	Until @error
	ReDim $avResult[$iIndex]
	Return $avResult
EndFunc   ;==>_ArrayFindAll
Func _ArrayInsert(ByRef $avArray, $iElement, $vValue = "")
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, 0)
	; Add 1 to the array
	Local $iUBound = UBound($avArray) + 1
	ReDim $avArray[$iUBound]
	; Move all entries over til the specified element
	For $i = $iUBound - 1 To $iElement + 1 Step -1
		$avArray[$i] = $avArray[$i - 1]
	Next
	; Add the value in the specified element
	$avArray[$iElement] = $vValue
	Return $iUBound
EndFunc   ;==>_ArrayInsert
Func _ArrayMax(Const ByRef $avArray, $iCompNumeric = 0, $iStart = 0, $iEnd = 0)
	Local $iResult = _ArrayMaxIndex($avArray, $iCompNumeric, $iStart, $iEnd)
	If @error Then Return SetError(@error, 0, "")
	Return $avArray[$iResult]
EndFunc   ;==>_ArrayMax
Func _ArrayMaxIndex(Const ByRef $avArray, $iCompNumeric = 0, $iStart = 0, $iEnd = 0)
	If Not IsArray($avArray) Or UBound($avArray, 0) <> 1 Then Return SetError(1, 0, -1)
	If UBound($avArray, 0) <> 1 Then Return SetError(3, 0, -1)
	Local $iUBound = UBound($avArray) - 1
	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, -1)
	Local $iMaxIndex = $iStart
	; Search
	If $iCompNumeric Then
		For $i = $iStart To $iEnd
			If Number($avArray[$iMaxIndex]) < Number($avArray[$i]) Then $iMaxIndex = $i
		Next
	Else
		For $i = $iStart To $iEnd
			If $avArray[$iMaxIndex] < $avArray[$i] Then $iMaxIndex = $i
		Next
	EndIf
	Return $iMaxIndex
EndFunc   ;==>_ArrayMaxIndex
Func _ArrayMin(Const ByRef $avArray, $iCompNumeric = 0, $iStart = 0, $iEnd = 0)
	Local $iResult = _ArrayMinIndex($avArray, $iCompNumeric, $iStart, $iEnd)
	If @error Then Return SetError(@error, 0, "")
	Return $avArray[$iResult]
EndFunc   ;==>_ArrayMin
Func _ArrayMinIndex(Const ByRef $avArray, $iCompNumeric = 0, $iStart = 0, $iEnd = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	If UBound($avArray, 0) <> 1 Then Return SetError(3, 0, -1)
	Local $iUBound = UBound($avArray) - 1
	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, -1)
	Local $iMinIndex = $iStart
	; Search
	If $iCompNumeric Then
		For $i = $iStart To $iEnd
			If Number($avArray[$iMinIndex]) > Number($avArray[$i]) Then $iMinIndex = $i
		Next
	Else
		For $i = $iStart To $iEnd
			If $avArray[$iMinIndex] > $avArray[$i] Then $iMinIndex = $i
		Next
	EndIf
	Return $iMinIndex
EndFunc   ;==>_ArrayMinIndex
Func _ArrayPermute(ByRef $avArray, $sDelim = "")
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, 0)
	Local $i, $iSize = UBound($avArray), $iFactorial = 1, $aIdx[$iSize], $aResult[1], $iCount = 1
	For $i = 0 To $iSize - 1
		$aIdx[$i] = $i
	Next
	For $i = $iSize To 1 Step -1
		$iFactorial *= $i
	Next
	ReDim $aResult[$iFactorial + 1]
	$aResult[0] = $iFactorial
	_Array_ExeterInternal($avArray, 0, $iSize, $sDelim, $aIdx, $aResult, $iCount)
	Return $aResult
EndFunc   ;==>_ArrayPermute
Func _ArrayPop(ByRef $avArray)
	If (Not IsArray($avArray)) Then Return SetError(1, 0, "")
	If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, "")
	Local $iUBound = UBound($avArray) - 1, $sLastVal = $avArray[$iUBound]
	; Remove last item
	If Not $iUBound Then
		$avArray = ""
	Else
		ReDim $avArray[$iUBound]
	EndIf
	; Return last item
	Return $sLastVal
EndFunc   ;==>_ArrayPop
Func _ArrayPush(ByRef $avArray, $vValue, $iDirection = 0)
	If (Not IsArray($avArray)) Then Return SetError(1, 0, 0)
	If UBound($avArray, 0) <> 1 Then Return SetError(3, 0, 0)
	Local $iUBound = UBound($avArray) - 1
	If IsArray($vValue) Then ; $vValue is an array
		Local $iUBoundS = UBound($vValue)
		If ($iUBoundS - 1) > $iUBound Then Return SetError(2, 0, 0)
		; $vValue is an array smaller than $avArray
		If $iDirection Then ; slide right, add to front
			For $i = $iUBound To $iUBoundS Step -1
				$avArray[$i] = $avArray[$i - $iUBoundS]
			Next
			For $i = 0 To $iUBoundS - 1
				$avArray[$i] = $vValue[$i]
			Next
		Else ; slide left, add to end
			For $i = 0 To $iUBound - $iUBoundS
				$avArray[$i] = $avArray[$i + $iUBoundS]
			Next
			For $i = 0 To $iUBoundS - 1
				$avArray[$i + $iUBound - $iUBoundS + 1] = $vValue[$i]
			Next
		EndIf
	Else
		If $iDirection Then ; slide right, add to front
			For $i = $iUBound To 1 Step -1
				$avArray[$i] = $avArray[$i - 1]
			Next
			$avArray[0] = $vValue
		Else ; slide left, add to end
			For $i = 0 To $iUBound - 1
				$avArray[$i] = $avArray[$i + 1]
			Next
			$avArray[$iUBound] = $vValue
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_ArrayPush
Func _ArrayReverse(ByRef $avArray, $iStart = 0, $iEnd = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, 0) <> 1 Then Return SetError(3, 0, 0)
	Local $vTmp, $iUBound = UBound($avArray) - 1
	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, 0)
	; Reverse
	For $i = $iStart To Int(($iStart + $iEnd - 1) / 2)
		$vTmp = $avArray[$i]
		$avArray[$i] = $avArray[$iEnd]
		$avArray[$iEnd] = $vTmp
		$iEnd -= 1
	Next
	Return 1
EndFunc   ;==>_ArrayReverse
Func _ArraySearch(Const ByRef $avArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iPartial = 0, $iForward = 1, $iSubItem = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, -1)
	If UBound($avArray, 0) > 2 Or UBound($avArray, 0) < 1 Then Return SetError(2, 0, 0)
	Local $iUBound = UBound($avArray) - 1
	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(4, 0, -1)
	; Direction (flip if $iForward = 0)
	Local $iStep = 1
	If Not $iForward Then
		Local $iTmp = $iStart
		$iStart = $iEnd
		$iEnd = $iTmp
		$iStep = -1
	EndIf
	; Search
	Switch UBound($avArray, 0)
		Case 1 ; 1D array search
			If Not $iPartial Then
				If Not $iCase Then
					For $i = $iStart To $iEnd Step $iStep
						If $avArray[$i] = $vValue Then Return $i
					Next
				Else
					For $i = $iStart To $iEnd Step $iStep
						If $avArray[$i] == $vValue Then Return $i
					Next
				EndIf
			Else
				For $i = $iStart To $iEnd Step $iStep
					If StringInStr($avArray[$i], $vValue, $iCase) > 0 Then Return $i
				Next
			EndIf
		Case 2 ; 2D array search
			Local $iUBoundSub = UBound($avArray, 2) - 1
			If $iSubItem < 0 Then $iSubItem = 0
			If $iSubItem > $iUBoundSub Then $iSubItem = $iUBoundSub
			If Not $iPartial Then
				If Not $iCase Then
					For $i = $iStart To $iEnd Step $iStep
						If $avArray[$i][$iSubItem] = $vValue Then Return $i
					Next
				Else
					For $i = $iStart To $iEnd Step $iStep
						If $avArray[$i][$iSubItem] == $vValue Then Return $i
					Next
				EndIf
			Else
				For $i = $iStart To $iEnd Step $iStep
					If StringInStr($avArray[$i][$iSubItem], $vValue, $iCase) > 0 Then Return $i
				Next
			EndIf
		Case Else
			Return SetError(7, 0, -1)
	EndSwitch
	Return SetError(6, 0, -1)
EndFunc   ;==>_ArraySearch
Func _ArraySort(ByRef $avArray, $iDescending = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	Local $iUBound = UBound($avArray) - 1
	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, 0)
	; Sort
	Switch UBound($avArray, 0)
		Case 1
			__ArrayQuickSort1D($avArray, $iStart, $iEnd)
			If $iDescending Then _ArrayReverse($avArray, $iStart, $iEnd)
		Case 2
			Local $iSubMax = UBound($avArray, 2) - 1
			If $iSubItem > $iSubMax Then Return SetError(3, 0, 0)
			If $iDescending Then
				$iDescending = -1
			Else
				$iDescending = 1
			EndIf
			__ArrayQuickSort2D($avArray, $iDescending, $iStart, $iEnd, $iSubItem, $iSubMax)
		Case Else
			Return SetError(4, 0, 0)
	EndSwitch
	Return 1
EndFunc   ;==>_ArraySort
Func __ArrayQuickSort1D(ByRef $avArray, ByRef $iStart, ByRef $iEnd)
	If $iEnd <= $iStart Then Return
	Local $vTmp
	; InsertionSort (faster for smaller segments)
	If ($iEnd - $iStart) < 15 Then
		Local $i, $j, $vCur
		For $i = $iStart + 1 To $iEnd
			$vTmp = $avArray[$i]
			If IsNumber($vTmp) Then
				For $j = $i - 1 To $iStart Step -1
					$vCur = $avArray[$j]
					; If $vTmp >= $vCur Then ExitLoop
					If ($vTmp >= $vCur And IsNumber($vCur)) Or (Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
					$avArray[$j + 1] = $vCur
				Next
			Else
				For $j = $i - 1 To $iStart Step -1
					If (StringCompare($vTmp, $avArray[$j]) >= 0) Then ExitLoop
					$avArray[$j + 1] = $avArray[$j]
				Next
			EndIf
			$avArray[$j + 1] = $vTmp
		Next
		Return
	EndIf
	; QuickSort
	Local $L = $iStart, $R = $iEnd, $vPivot = $avArray[Int(($iStart + $iEnd) / 2)], $fNum = IsNumber($vPivot)
	Do
		If $fNum Then
			; While $avArray[$L] < $vPivot
			While ($avArray[$L] < $vPivot And IsNumber($avArray[$L])) Or (Not IsNumber($avArray[$L]) And StringCompare($avArray[$L], $vPivot) < 0)
				$L += 1
			WEnd
			; While $avArray[$R] > $vPivot
			While ($avArray[$R] > $vPivot And IsNumber($avArray[$R])) Or (Not IsNumber($avArray[$R]) And StringCompare($avArray[$R], $vPivot) > 0)
				$R -= 1
			WEnd
		Else
			While (StringCompare($avArray[$L], $vPivot) < 0)
				$L += 1
			WEnd
			While (StringCompare($avArray[$R], $vPivot) > 0)
				$R -= 1
			WEnd
		EndIf
		; Swap
		If $L <= $R Then
			$vTmp = $avArray[$L]
			$avArray[$L] = $avArray[$R]
			$avArray[$R] = $vTmp
			$L += 1
			$R -= 1
		EndIf
	Until $L > $R
	__ArrayQuickSort1D($avArray, $iStart, $R)
	__ArrayQuickSort1D($avArray, $L, $iEnd)
EndFunc   ;==>__ArrayQuickSort1D
Func __ArrayQuickSort2D(ByRef $avArray, ByRef $iStep, ByRef $iStart, ByRef $iEnd, ByRef $iSubItem, ByRef $iSubMax)
	If $iEnd <= $iStart Then Return
	; QuickSort
	Local $i, $vTmp, $L = $iStart, $R = $iEnd, $vPivot = $avArray[Int(($iStart + $iEnd) / 2)][$iSubItem], $fNum = IsNumber($vPivot)
	Do
		If $fNum Then
			; While $avArray[$L][$iSubItem] < $vPivot
			While ($iStep * ($avArray[$L][$iSubItem] - $vPivot) < 0 And IsNumber($avArray[$L][$iSubItem])) Or (Not IsNumber($avArray[$L][$iSubItem]) And $iStep * StringCompare($avArray[$L][$iSubItem], $vPivot) < 0)
				$L += 1
			WEnd
			; While $avArray[$R][$iSubItem] > $vPivot
			While ($iStep * ($avArray[$R][$iSubItem] - $vPivot) > 0 And IsNumber($avArray[$R][$iSubItem])) Or (Not IsNumber($avArray[$R][$iSubItem]) And $iStep * StringCompare($avArray[$R][$iSubItem], $vPivot) > 0)
				$R -= 1
			WEnd
		Else
			While ($iStep * StringCompare($avArray[$L][$iSubItem], $vPivot) < 0)
				$L += 1
			WEnd
			While ($iStep * StringCompare($avArray[$R][$iSubItem], $vPivot) > 0)
				$R -= 1
			WEnd
		EndIf
		; Swap
		If $L <= $R Then
			For $i = 0 To $iSubMax
				$vTmp = $avArray[$L][$i]
				$avArray[$L][$i] = $avArray[$R][$i]
				$avArray[$R][$i] = $vTmp
			Next
			$L += 1
			$R -= 1
		EndIf
	Until $L > $R
	__ArrayQuickSort2D($avArray, $iStep, $iStart, $R, $iSubItem, $iSubMax)
	__ArrayQuickSort2D($avArray, $iStep, $L, $iEnd, $iSubItem, $iSubMax)
EndFunc   ;==>__ArrayQuickSort2D
Func _ArraySwap(ByRef $vItem1, ByRef $vItem2)
	Local $vTmp = $vItem1
	$vItem1 = $vItem2
	$vItem2 = $vTmp
EndFunc   ;==>_ArraySwap
Func _ArrayToClip(Const ByRef $avArray, $iStart = 0, $iEnd = 0)
	Local $sResult = _ArrayToString($avArray, @CR, $iStart, $iEnd)
	If @error Then Return SetError(@error, 0, 0)
	Return ClipPut($sResult)
EndFunc   ;==>_ArrayToClip
Func _ArrayToString(Const ByRef $avArray, $sDelim = "|", $iStart = 0, $iEnd = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, "")
	If UBound($avArray, 0) <> 1 Then Return SetError(3, 0, "")
	Local $sResult, $iUBound = UBound($avArray) - 1
	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, "")
	; Combine
	For $i = $iStart To $iEnd
		$sResult &= $avArray[$i] & $sDelim
	Next
	Return StringTrimRight($sResult, StringLen($sDelim))
EndFunc   ;==>_ArrayToString
Func _ArrayTrim(ByRef $avArray, $iTrimNum, $iDirection = 0, $iStart = 0, $iEnd = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, 0)
	Local $iUBound = UBound($avArray) - 1
	; Bounds checking
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(5, 0, 0)
	; Trim
	If $iDirection Then
		For $i = $iStart To $iEnd
			$avArray[$i] = StringTrimRight($avArray[$i], $iTrimNum)
		Next
	Else
		For $i = $iStart To $iEnd
			$avArray[$i] = StringTrimLeft($avArray[$i], $iTrimNum)
		Next
	EndIf
	Return 1
EndFunc   ;==>_ArrayTrim
Func _ArrayUnique($aArray, $iDimension = 1, $iBase = 0, $iCase = 0, $vDelim = "|")
	Local $iUboundDim
	;$aArray used to be ByRef, but litlmike altered it to allow for the choosing of 1 Array Dimension, without altering the original array
	If $vDelim = "|" Then $vDelim = Chr(01) ; by SmOke_N, modified by litlmike
	If Not IsArray($aArray) Then Return SetError(1, 0, 0) ;Check to see if it is valid array
	;Checks that the given Dimension is Valid
	If Not $iDimension > 0 Then
		Return SetError(3, 0, 0) ;Check to see if it is valid array dimension, Should be greater than 0
	Else
		;If Dimension Exists, then get the number of "Rows"
		$iUboundDim = UBound($aArray, 1) ;Get Number of "Rows"
		If @error Then Return SetError(3, 0, 0) ;2 = Array dimension is invalid.
		;If $iDimension Exists, And the number of "Rows" is Valid:
		If $iDimension > 1 Then ;Makes sure the Array dimension desired is more than 1-dimensional
			Local $aArrayTmp[1] ;Declare blank array, which will hold the dimension declared by user
			For $i = 0 To $iUboundDim - 1 ;Loop through "Rows"
				_ArrayAdd($aArrayTmp, $aArray[$i][$iDimension - 1]) ;$iDimension-1 to match Dimension
			Next
			_ArrayDelete($aArrayTmp, 0) ;Get rid of 1st-element which is blank
		Else ;Makes sure the Array dimension desired is 1-dimensional
			;If Dimension Exists, And the number of "Rows" is Valid, and the Dimension desired is not > 1, then:
			;For the Case that the array is 1-Dimensional
			If UBound($aArray, 0) = 1 Then ;Makes sure the Array is only 1-Dimensional
				Dim $aArrayTmp[1] ;Declare blank array, which will hold the dimension declared by user
				For $i = 0 To $iUboundDim - 1
					_ArrayAdd($aArrayTmp, $aArray[$i])
				Next
				_ArrayDelete($aArrayTmp, 0) ;Get rid of 1st-element which is blank
			Else ;For the Case that the array is 2-Dimensional
				Dim $aArrayTmp[1] ;Declare blank array, which will hold the dimension declared by user
				For $i = 0 To $iUboundDim - 1
					_ArrayAdd($aArrayTmp, $aArray[$i][$iDimension - 1]) ;$iDimension-1 to match Dimension
				Next
				_ArrayDelete($aArrayTmp, 0) ;Get rid of 1st-element which is blank
			EndIf
		EndIf
	EndIf
	Local $sHold ;String that holds the Unique array info
	For $iCC = $iBase To UBound($aArrayTmp) - 1 ;Loop Through array
		;If Not the case that the element is already in $sHold, then add it
		If Not StringInStr($vDelim & $sHold, $vDelim & $aArrayTmp[$iCC] & $vDelim, $iCase) Then _
				$sHold &= $aArrayTmp[$iCC] & $vDelim
	Next
	If $sHold Then
		$aArrayTmp = StringSplit(StringTrimRight($sHold, StringLen($vDelim)), $vDelim, 1) ;Split the string into an array
		Return $aArrayTmp ;SmOke_N's version used to Return SetError(0, 0, 0)
	EndIf
	Return SetError(2, 0, 0) ;If the script gets this far, it has failed
EndFunc   ;==>_ArrayUnique
Func _Array_ExeterInternal(ByRef $avArray, $iStart, $iSize, $sDelim, ByRef $aIdx, ByRef $aResult, ByRef $iCount)
	Local $i, $iTemp
	If $iStart == $iSize - 1 Then
		For $i = 0 To $iSize - 1
			$aResult[$iCount] &= $avArray[$aIdx[$i]] & $sDelim
		Next
		If $sDelim <> "" Then $aResult[$iCount] = StringTrimRight($aResult[$iCount], 1)
		$iCount += 1
	Else
		For $i = $iStart To $iSize - 1
			$iTemp = $aIdx[$i]
			$aIdx[$i] = $aIdx[$iStart]
			$aIdx[$iStart] = $iTemp
			_Array_ExeterInternal($avArray, $iStart + 1, $iSize, $sDelim, $aIdx, $aResult, $iCount)
			$aIdx[$iStart] = $aIdx[$i]
			$aIdx[$i] = $iTemp
		Next
	EndIf
EndFunc   ;==>_Array_ExeterInternal
Func _Array_Combinations($iN, $iR)
	Local $i, $iNFact = 1, $iRFact = 1, $iNRFact = 1
	For $i = $iN To 2 Step -1
		$iNFact *= $i
	Next
	For $i = $iR To 2 Step -1
		$iRFact *= $i
	Next
	For $i = $iN - $iR To 2 Step -1
		$iNRFact *= $i
	Next
	Return $iNFact / ($iRFact * $iNRFact)
EndFunc   ;==>_Array_Combinations
Func _Array_GetNext($iN, $iR, ByRef $iLeft, $iTotal, ByRef $aIdx)
	Local $i, $j
	If $iLeft == $iTotal Then
		$iLeft -= 1
		Return
	EndIf
	$i = $iR - 1
	While $aIdx[$i] == $iN - $iR + $i
		$i -= 1
	WEnd
	$aIdx[$i] += 1
	For $j = $i + 1 To $iR - 1
		$aIdx[$j] = $aIdx[$i] + $j - $i
	Next
	$iLeft -= 1
EndFunc   ;==>_Array_GetNext
Global Const $GMEM_FIXED = 0x0000
Global Const $GMEM_MOVEABLE = 0x0002
Global Const $GMEM_NOCOMPACT = 0x0010
Global Const $GMEM_NODISCARD = 0x0020
Global Const $GMEM_ZEROINIT = 0x0040
Global Const $GMEM_MODIFY = 0x0080
Global Const $GMEM_DISCARDABLE = 0x0100
Global Const $GMEM_NOT_BANKED = 0x1000
Global Const $GMEM_SHARE = 0x2000
Global Const $GMEM_DDESHARE = 0x2000
Global Const $GMEM_NOTIFY = 0x4000
Global Const $GMEM_LOWER = 0x1000
Global Const $GMEM_VALID_FLAGS = 0x7F72
Global Const $GMEM_INVALID_HANDLE = 0x8000
Global Const $GPTR = 0x0040
Global Const $GHND = 0x0042
Global Const $MEM_COMMIT = 0x00001000
Global Const $MEM_RESERVE = 0x00002000
Global Const $MEM_TOP_DOWN = 0x00100000
Global Const $MEM_SHARED = 0x08000000
Global Const $PAGE_NOACCESS = 0x00000001
Global Const $PAGE_READONLY = 0x00000002
Global Const $PAGE_READWRITE = 0x00000004
Global Const $PAGE_EXECUTE = 0x00000010
Global Const $PAGE_EXECUTE_READ = 0x00000020
Global Const $PAGE_EXECUTE_READWRITE = 0x00000040
Global Const $PAGE_GUARD = 0x00000100
Global Const $PAGE_NOCACHE = 0x00000200
Global Const $MEM_DECOMMIT = 0x00004000
Global Const $MEM_RELEASE = 0x00008000
Global Const $__MEMORYCONSTANT_PROCESS_VM_OPERATION = 0x00000008
Global Const $__MEMORYCONSTANT_PROCESS_VM_READ = 0x00000010
Global Const $__MEMORYCONSTANT_PROCESS_VM_WRITE = 0x00000020
Func _MemFree(ByRef $tMemMap)
	Local $hProcess, $pMemory, $bResult
	$pMemory = DllStructGetData($tMemMap, "Mem")
	$hProcess = DllStructGetData($tMemMap, "hProc")
	; Thanks to jpm for his tip on using @OSType instead of @OSVersion
	If @OSTYPE = "WIN32_WINDOWS"  Then
		$bResult = _MemVirtualFree($pMemory, 0, $MEM_RELEASE)
	Else
		$bResult = _MemVirtualFreeEx($hProcess, $pMemory, 0, $MEM_RELEASE)
	EndIf
	_WinAPI_CloseHandle($hProcess)
	Return $bResult
EndFunc   ;==>_MemFree
Func _MemGlobalAlloc($iBytes, $iFlags = 0)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "hwnd", "GlobalAlloc", "int", $iFlags, "int", $iBytes)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalAlloc
Func _MemGlobalFree($hMem)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GlobalFree", "hwnd", $hMem)
	Return $aResult[0] = 0
EndFunc   ;==>_MemGlobalFree
Func _MemGlobalLock($hMem)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "ptr", "GlobalLock", "hwnd", $hMem)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalLock
Func _MemGlobalSize($hMem)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GlobalSize", "hwnd", $hMem)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalSize
Func _MemGlobalUnlock($hMem)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GlobalUnlock", "hwnd", $hMem)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalUnlock
Func _MemInit($hWnd, $iSize, ByRef $tMemMap)
	Local $iAccess, $iAlloc, $pMemory, $hProcess, $iProcessID
	_WinAPI_GetWindowThreadProcessId($hWnd, $iProcessID)
	If $iProcessID = 0 Then _MemShowError("_MemInit: Invalid window handle [0x" & Hex($hWnd) & "]")
	$iAccess = BitOR($__MEMORYCONSTANT_PROCESS_VM_OPERATION, $__MEMORYCONSTANT_PROCESS_VM_READ, $__MEMORYCONSTANT_PROCESS_VM_WRITE)
	$hProcess = _WinAPI_OpenProcess($iAccess, False, $iProcessID, True)
	; Thanks to jpm for his tip on using @OSType instead of @OSVersion
	If @OSTYPE = "WIN32_WINDOWS"  Then
		$iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT, $MEM_SHARED)
		$pMemory = _MemVirtualAlloc(0, $iSize, $iAlloc, $PAGE_READWRITE)
	Else
		$iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT)
		$pMemory = _MemVirtualAllocEx($hProcess, 0, $iSize, $iAlloc, $PAGE_READWRITE)
	EndIf
	If $pMemory = 0 Then _MemShowError("_MemInit: Unable to allocate memory")
	$tMemMap = DllStructCreate($tagMEMMAP)
	DllStructSetData($tMemMap, "hProc", $hProcess)
	DllStructSetData($tMemMap, "Size", $iSize)
	DllStructSetData($tMemMap, "Mem", $pMemory)
	Return $pMemory
EndFunc   ;==>_MemInit
Func _MemMsgBox($iFlags, $sTitle, $sText)
	BlockInput(0)
	MsgBox($iFlags, $sTitle, $sText & "      ")
EndFunc   ;==>_MemMsgBox
Func _MemMoveMemory($pSource, $pDest, $iLength)
	DllCall("Kernel32.dll", "none", "RtlMoveMemory", "ptr", $pDest, "ptr", $pSource, "dword", $iLength)
EndFunc   ;==>_MemMoveMemory
Func _MemRead(ByRef $tMemMap, $pSrce, $pDest, $iSize)
	Local $iRead
	Return _WinAPI_ReadProcessMemory(DllStructGetData($tMemMap, "hProc"), $pSrce, $pDest, $iSize, $iRead)
EndFunc   ;==>_MemRead
Func _MemShowError($sText, $fExit = True)
	_MemMsgBox(16 + 4096, "Error", $sText)
	If $fExit Then Exit
EndFunc   ;==>_MemShowError
Func _MemWrite(ByRef $tMemMap, $pSrce, $pDest = 0, $iSize = 0, $sSrce = "ptr")
	Local $iWritten
	If $pDest = 0 Then $pDest = DllStructGetData($tMemMap, "Mem")
	If $iSize = 0 Then $iSize = DllStructGetData($tMemMap, "Size")
	Return _WinAPI_WriteProcessMemory(DllStructGetData($tMemMap, "hProc"), $pDest, $pSrce, $iSize, $iWritten, $sSrce)
EndFunc   ;==>_MemWrite
Func _MemVirtualAlloc($pAddress, $iSize, $iAllocation, $iProtect)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "ptr", "VirtualAlloc", "ptr", $pAddress, "int", $iSize, "int", $iAllocation, "int", $iProtect)
	Return SetError($aResult[0] = 0, 0, $aResult[0])
EndFunc   ;==>_MemVirtualAlloc
Func _MemVirtualAllocEx($hProcess, $pAddress, $iSize, $iAllocation, $iProtect)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "ptr", "VirtualAllocEx", "int", $hProcess, "ptr", $pAddress, "int", $iSize, "int", $iAllocation, "int", $iProtect)
	Return SetError($aResult[0] = 0, 0, $aResult[0])
EndFunc   ;==>_MemVirtualAllocEx
Func _MemVirtualFree($pAddress, $iSize, $iFreeType)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "ptr", "VirtualFree", "ptr", $pAddress, "int", $iSize, "int", $iFreeType)
	Return $aResult[0]
EndFunc   ;==>_MemVirtualFree
Func _MemVirtualFreeEx($hProcess, $pAddress, $iSize, $iFreeType)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "ptr", "VirtualFreeEx", "hwnd", $hProcess, "ptr", $pAddress, "int", $iSize, "int", $iFreeType)
	Return $aResult[0]
EndFunc   ;==>_MemVirtualFreeEx
Global Const $__DATECONSTANT_TOKEN_ADJUST_PRIVILEGES = 0x00000020
Global Const $__DATECONSTANT_TOKEN_QUERY = 0x00000008
Func _DateAdd($sType, $iValToAdd, $sDate)
	Local $asTimePart[4]
	Local $asDatePart[4]
	Local $iJulianDate
	Local $iTimeVal
	Local $iNumDays
	Local $Day2Add
	; Verify that $sType is Valid
	$sType = StringLeft($sType, 1)
	If StringInStr("D,M,Y,w,h,n,s", $sType) = 0 Or $sType = "" Then
		SetError(1)
		Return (0)
	EndIf
	; Verify that Value to Add  is Valid
	If Not StringIsInt($iValToAdd) Then
		SetError(2)
		Return (0)
	EndIf
	; Verify If InputDate is valid
	If Not _DateIsValid($sDate) Then
		SetError(3)
		Return (0)
	EndIf
	; split the date and time into arrays
	_DateTimeSplit($sDate, $asDatePart, $asTimePart)
	; ====================================================
	; adding days then get the julian date
	; add the number of day
	; and convert back to Gregorian
	If $sType = "d" Or $sType = "w" Then
		If $sType = "w" Then $iValToAdd = $iValToAdd * 7
		$iJulianDate = _DateToDayValue($asDatePart[1], $asDatePart[2], $asDatePart[3]) + $iValToAdd
		_DayValueToDate($iJulianDate, $asDatePart[1], $asDatePart[2], $asDatePart[3])
	EndIf
	; ====================================================
	; adding Months
	If $sType = "m" Then
		$asDatePart[2] = $asDatePart[2] + $iValToAdd
		; pos number of months
		While $asDatePart[2] > 12
			$asDatePart[2] = $asDatePart[2] - 12
			$asDatePart[1] = $asDatePart[1] + 1
		WEnd
		; Neg number of months
		While $asDatePart[2] < 1
			$asDatePart[2] = $asDatePart[2] + 12
			$asDatePart[1] = $asDatePart[1] - 1
		WEnd
	EndIf
	; ====================================================
	; adding Years
	If $sType = "y" Then
		$asDatePart[1] = $asDatePart[1] + $iValToAdd
	EndIf
	; ====================================================
	; adding Time value
	If $sType = "h" Or $sType = "n" Or $sType = "s" Then
		$iTimeVal = _TimeToTicks($asTimePart[1], $asTimePart[2], $asTimePart[3]) / 1000
		If $sType = "h" Then $iTimeVal = $iTimeVal + $iValToAdd * 3600
		If $sType = "n" Then $iTimeVal = $iTimeVal + $iValToAdd * 60
		If $sType = "s" Then $iTimeVal = $iTimeVal + $iValToAdd
		; calculated days to add
		$Day2Add = Int($iTimeVal / (24 * 60 * 60))
		$iTimeVal = $iTimeVal - $Day2Add * 24 * 60 * 60
		If $iTimeVal < 0 Then
			$Day2Add = $Day2Add - 1
			$iTimeVal = $iTimeVal + 24 * 60 * 60
		EndIf
		$iJulianDate = _DateToDayValue($asDatePart[1], $asDatePart[2], $asDatePart[3]) + $Day2Add
		; calculate the julian back to date
		_DayValueToDate($iJulianDate, $asDatePart[1], $asDatePart[2], $asDatePart[3])
		; caluculate the new time
		_TicksToTime($iTimeVal * 1000, $asTimePart[1], $asTimePart[2], $asTimePart[3])
	EndIf
	; ====================================================
	; check if the Input day is Greater then the new month last day.
	; if so then change it to the last possible day in the month
	$iNumDays = StringSplit('31,28,31,30,31,30,31,31,30,31,30,31', ',')
	If _DateIsLeapYear($asDatePart[1]) Then $iNumDays[2] = 29
	;
	If $iNumDays[$asDatePart[2]] < $asDatePart[3] Then $asDatePart[3] = $iNumDays[$asDatePart[2]]
	; ========================
	; Format the return date
	; ========================
	; Format the return date
	$sDate = $asDatePart[1] & '/' & StringRight("0" & $asDatePart[2], 2) & '/' & StringRight("0" & $asDatePart[3], 2)
	; add the time when specified in the input
	If $asTimePart[0] > 0 Then
		If $asTimePart[0] > 2 Then
			$sDate = $sDate & " " & StringRight("0" & $asTimePart[1], 2) & ':' & StringRight("0" & $asTimePart[2], 2) & ':' & StringRight("0" & $asTimePart[3], 2)
		Else
			$sDate = $sDate & " " & StringRight("0" & $asTimePart[1], 2) & ':' & StringRight("0" & $asTimePart[2], 2)
		EndIf
	EndIf
	;
	Return ($sDate)
EndFunc   ;==>_DateAdd
Func _DateDayOfWeek($iDayNum, $iShort = 0)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $aDayOfWeek[8]
	$aDayOfWeek[1] = "Sunday"
	$aDayOfWeek[2] = "Monday"
	$aDayOfWeek[3] = "Tuesday"
	$aDayOfWeek[4] = "Wednesday"
	$aDayOfWeek[5] = "Thursday"
	$aDayOfWeek[6] = "Friday"
	$aDayOfWeek[7] = "Saturday"
	Select
		Case Not StringIsInt($iDayNum) Or Not StringIsInt($iShort)
			SetError(1)
			Return ""
		Case $iDayNum < 1 Or $iDayNum > 7
			SetError(1)
			Return ""
		Case Else
			Select
				Case $iShort = 0
					Return $aDayOfWeek[$iDayNum]
				Case $iShort = 1
					Return StringLeft($aDayOfWeek[$iDayNum], 3)
				Case Else
					SetError(1)
					Return ""
			EndSelect
	EndSelect
EndFunc   ;==>_DateDayOfWeek
Func _DateDaysInMonth($iYear, $iMonthNum)
	Local $aiNumDays
	$aiNumDays = "31,28,31,30,31,30,31,31,30,31,30,31"
	$aiNumDays = StringSplit($aiNumDays, ",")
	If _DateIsMonth($iMonthNum) And _DateIsYear($iYear) Then
		If _DateIsLeapYear($iYear) Then $aiNumDays[2] = $aiNumDays[2] + 1
		SetError(0)
		Return $aiNumDays[$iMonthNum]
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_DateDaysInMonth
Func _DateDiff($sType, $sStartDate, $sEndDate)
	Local $asStartDatePart[4]
	Local $asStartTimePart[4]
	Local $asEndDatePart[4]
	Local $asEndTimePart[4]
	Local $iTimeDiff
	Local $iYearDiff
	Local $iMonthDiff
	Local $iStartTimeInSecs
	Local $iEndTimeInSecs
	Local $aDaysDiff
	;
	; Verify that $sType is Valid
	$sType = StringLeft($sType, 1)
	If StringInStr("d,m,y,w,h,n,s", $sType) = 0 Or $sType = "" Then
		SetError(1)
		Return (0)
	EndIf
	; Verify If StartDate is valid
	If Not _DateIsValid($sStartDate) Then
		SetError(2)
		Return (0)
	EndIf
	; Verify If EndDate is valid
	If Not _DateIsValid($sEndDate) Then
		SetError(3)
		Return (0)
	EndIf
	; split the StartDate and Time into arrays
	_DateTimeSplit($sStartDate, $asStartDatePart, $asStartTimePart)
	; split the End  Date and time into arrays
	_DateTimeSplit($sEndDate, $asEndDatePart, $asEndTimePart)
	; ====================================================
	; Get the differens in days between the 2 dates
	$aDaysDiff = _DateToDayValue($asEndDatePart[1], $asEndDatePart[2], $asEndDatePart[3]) - _DateToDayValue($asStartDatePart[1], $asStartDatePart[2], $asStartDatePart[3])
	; ====================================================
	; Get the differens in Seconds between the 2 times when specified
	If $asStartTimePart[0] > 1 And $asEndTimePart[0] > 1 Then
		$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
		$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
		$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
		If $iTimeDiff < 0 Then
			$aDaysDiff = $aDaysDiff - 1
			$iTimeDiff = $iTimeDiff + 24 * 60 * 60
		EndIf
	Else
		$iTimeDiff = 0
	EndIf
	Select
		Case $sType = "d"
			Return ($aDaysDiff)
		Case $sType = "m"
			$iYearDiff = $asEndDatePart[1] - $asStartDatePart[1]
			$iMonthDiff = $asEndDatePart[2] - $asStartDatePart[2] + $iYearDiff * 12
			If $asEndDatePart[3] < $asStartDatePart[3] Then $iMonthDiff = $iMonthDiff - 1
			$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
			$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
			$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
			If $asEndDatePart[3] = $asStartDatePart[3] And $iTimeDiff < 0 Then $iMonthDiff = $iMonthDiff - 1
			Return ($iMonthDiff)
		Case $sType = "y"
			$iYearDiff = $asEndDatePart[1] - $asStartDatePart[1]
			If $asEndDatePart[2] < $asStartDatePart[2] Then $iYearDiff = $iYearDiff - 1
			If $asEndDatePart[2] = $asStartDatePart[2] And $asEndDatePart[3] < $asStartDatePart[3] Then $iYearDiff = $iYearDiff - 1
			$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
			$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
			$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
			If $asEndDatePart[2] = $asStartDatePart[2] And $asEndDatePart[3] = $asStartDatePart[3] And $iTimeDiff < 0 Then $iYearDiff = $iYearDiff - 1
			Return ($iYearDiff)
		Case $sType = "w"
			Return (Int($aDaysDiff / 7))
		Case $sType = "h"
			Return ($aDaysDiff * 24 + Int($iTimeDiff / 3600))
		Case $sType = "n"
			Return ($aDaysDiff * 24 * 60 + Int($iTimeDiff / 60))
		Case $sType = "s"
			Return ($aDaysDiff * 24 * 60 * 60 + $iTimeDiff)
	EndSelect
EndFunc   ;==>_DateDiff
Func _DateIsLeapYear($iYear)
	If StringIsInt($iYear) Then
		Select
			Case Mod($iYear, 4) = 0 And Mod($iYear, 100) <> 0
				Return 1
			Case Mod($iYear, 400) = 0
				Return 1
			Case Else
				Return 0
		EndSelect
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_DateIsLeapYear
Func _DateIsMonth($iNumber)
	If StringIsInt($iNumber) Then
		If $iNumber >= 1 And $iNumber <= 12 Then
			Return 1
		Else
			Return 0
		EndIf
	Else
		Return 0
	EndIf
EndFunc   ;==>_DateIsMonth
Func _DateIsValid($sDate)
	Local $asDatePart[4]
	Local $asTimePart[4]
	Local $iNumDays
	Local $sDateTime
	$iNumDays = "31,28,31,30,31,30,31,31,30,31,30,31"
	$iNumDays = StringSplit($iNumDays, ",")
	; split the Date and Time portion
	$sDateTime = StringSplit($sDate, " T")
	; split the date portion
	If $sDateTime[0] > 0 Then $asDatePart = StringSplit($sDateTime[1], "/-.")
	; Ensure the date contains 3 sections YYYY MM DD
	If UBound($asDatePart) <> 4 Then Return (0)
	If $asDatePart[0] <> 3 Then Return (0)
	; verify valid input date values
	; Make sure the Date parts contains numeric
	If Not StringIsInt($asDatePart[1]) Then Return (0)
	If Not StringIsInt($asDatePart[2]) Then Return (0)
	If Not StringIsInt($asDatePart[3]) Then Return (0)
	$asDatePart[1] = Number($asDatePart[1])
	$asDatePart[2] = Number($asDatePart[2])
	$asDatePart[3] = Number($asDatePart[3])
	; check if all contain valid values
	If _DateIsLeapYear($asDatePart[1]) Then $iNumDays[2] = 29
	If $asDatePart[1] < 1000 Or $asDatePart[1] > 2999 Then Return (0)
	If $asDatePart[2] < 1 Or $asDatePart[2] > 12 Then Return (0)
	If $asDatePart[3] < 1 Or $asDatePart[3] > $iNumDays[$asDatePart[2]] Then Return (0)
	; split the Time portion
	If $sDateTime[0] > 1 Then
		$asTimePart = StringSplit($sDateTime[2], ":")
		If UBound($asTimePart) < 4 Then ReDim $asTimePart[4]
	Else
		Dim $asTimePart[4]
	EndIf
	; check Time portion
	If $asTimePart[0] < 1 Then Return (1) ; No time specified so date must be correct
	If $asTimePart[0] < 2 Then Return (0) ; need at least HH:MM when something is specified
	If $asTimePart[0] = 2 Then $asTimePart[3] = "00" ; init SS when only HH:MM is specified
	; Make sure the Time parts contains numeric
	If Not StringIsInt($asTimePart[1]) Then Return (0)
	If Not StringIsInt($asTimePart[2]) Then Return (0)
	If Not StringIsInt($asTimePart[3]) Then Return (0)
	; check if all contain valid values
	$asTimePart[1] = Number($asTimePart[1])
	$asTimePart[2] = Number($asTimePart[2])
	$asTimePart[3] = Number($asTimePart[3])
	If $asTimePart[1] < 0 Or $asTimePart[1] > 23 Then Return (0)
	If $asTimePart[2] < 0 Or $asTimePart[2] > 59 Then Return (0)
	If $asTimePart[3] < 0 Or $asTimePart[3] > 59 Then Return (0)
	; we got here so date/time must be good
	Return (1)
EndFunc   ;==>_DateIsValid
Func _DateIsYear($iNumber)
	If StringIsInt($iNumber) Then
		If StringLen($iNumber) = 4 Then
			Return 1
		Else
			Return 0
		EndIf
	Else
		Return 0
	EndIf
EndFunc   ;==>_DateIsYear
Func _DateLastWeekdayNum($iWeekdayNum)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iLastWeekdayNum
	Select
		Case Not StringIsInt($iWeekdayNum)
			SetError(1)
			Return 0
		Case $iWeekdayNum < 1 Or $iWeekdayNum > 7
			SetError(1)
			Return 0
		Case Else
			If $iWeekdayNum = 1 Then
				$iLastWeekdayNum = 7
			Else
				$iLastWeekdayNum = $iWeekdayNum - 1
			EndIf
			Return $iLastWeekdayNum
	EndSelect
EndFunc   ;==>_DateLastWeekdayNum
Func _DateLastMonthNum($iMonthNum)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iLastMonthNum
	Select
		Case Not StringIsInt($iMonthNum)
			SetError(1)
			Return 0
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return 0
		Case Else
			If $iMonthNum = 1 Then
				$iLastMonthNum = 12
			Else
				$iLastMonthNum = $iMonthNum - 1
			EndIf
			$iLastMonthNum = StringFormat("%02d", $iLastMonthNum)
			Return $iLastMonthNum
	EndSelect
EndFunc   ;==>_DateLastMonthNum
Func _DateLastMonthYear($iMonthNum, $iYear)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iLastYear
	Select
		Case Not StringIsInt($iMonthNum) Or Not StringIsInt($iYear)
			SetError(1)
			Return 0
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return 0
		Case Else
			If $iMonthNum = 1 Then
				$iLastYear = $iYear - 1
			Else
				$iLastYear = $iYear
			EndIf
			$iLastYear = StringFormat("%04d", $iLastYear)
			Return $iLastYear
	EndSelect
EndFunc   ;==>_DateLastMonthYear
Func _DateMonthOfYear($iMonthNum, $iShort)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $aMonthOfYear[13]
	$aMonthOfYear[1] = "January"
	$aMonthOfYear[2] = "February"
	$aMonthOfYear[3] = "March"
	$aMonthOfYear[4] = "April"
	$aMonthOfYear[5] = "May"
	$aMonthOfYear[6] = "June"
	$aMonthOfYear[7] = "July"
	$aMonthOfYear[8] = "August"
	$aMonthOfYear[9] = "September"
	$aMonthOfYear[10] = "October"
	$aMonthOfYear[11] = "November"
	$aMonthOfYear[12] = "December"
	Select
		Case Not StringIsInt($iMonthNum) Or Not StringIsInt($iShort)
			SetError(1)
			Return ""
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return ""
		Case Else
			Select
				Case $iShort = 0
					Return $aMonthOfYear[$iMonthNum]
				Case $iShort = 1
					Return StringLeft($aMonthOfYear[$iMonthNum], 3)
				Case Else
					SetError(1)
					Return ""
			EndSelect
	EndSelect
EndFunc   ;==>_DateMonthOfYear
Func _DateNextWeekdayNum($iWeekdayNum)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iNextWeekdayNum
	Select
		Case Not StringIsInt($iWeekdayNum)
			SetError(1)
			Return 0
		Case $iWeekdayNum < 1 Or $iWeekdayNum > 7
			SetError(1)
			Return 0
		Case Else
			If $iWeekdayNum = 7 Then
				$iNextWeekdayNum = 1
			Else
				$iNextWeekdayNum = $iWeekdayNum + 1
			EndIf
			Return $iNextWeekdayNum
	EndSelect
EndFunc   ;==>_DateNextWeekdayNum
Func _DateNextMonthNum($iMonthNum)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iNextMonthNum
	Select
		Case Not StringIsInt($iMonthNum)
			SetError(1)
			Return 0
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return 0
		Case Else
			If $iMonthNum = 12 Then
				$iNextMonthNum = 1
			Else
				$iNextMonthNum = $iMonthNum + 1
			EndIf
			$iNextMonthNum = StringFormat("%02d", $iNextMonthNum)
			Return $iNextMonthNum
	EndSelect
EndFunc   ;==>_DateNextMonthNum
Func _DateNextMonthYear($iMonthNum, $iYear)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iNextYear
	Select
		Case Not StringIsInt($iMonthNum) Or Not StringIsInt($iYear)
			SetError(1)
			Return 0
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return 0
		Case Else
			If $iMonthNum = 12 Then
				$iNextYear = $iYear + 1
			Else
				$iNextYear = $iYear
			EndIf
			$iNextYear = StringFormat("%04d", $iNextYear)
			Return $iNextYear
	EndSelect
EndFunc   ;==>_DateNextMonthYear
Func _DateTimeFormat($sDate, $sType)
	Local $asDatePart[4]
	Local $asTimePart[4]
	Local $sTempDate = ""
	Local $sTempTime = ""
	Local $sAM
	Local $sPM
	Local $iWday
	Local $lngX
	; Verify If InputDate is valid
	If Not _DateIsValid($sDate) Then
		SetError(1)
		Return ("")
	EndIf
	; input validation
	If $sType < 0 Or $sType > 5 Or Not IsInt($sType) Then
		SetError(2)
		Return ("")
	EndIf
	; split the date and time into arrays
	_DateTimeSplit($sDate, $asDatePart, $asTimePart)
	;
	; 	Const $LOCALE_USER_DEFAULT = 0x400
	;   Const $LOCALE_SDATE = 0x1D            ;  date separator
	;   Const $LOCALE_STIME = 0x1E            ;  time separator
	;   Const $LOCALE_S1159 = 0x28            ;  AM designator
	;   Const $LOCALE_S2359 = 0x29            ;  PM designator
	; 	Const $LOCALE_SSHORTDATE = 0x1F       ;  short date format string
	; 	Const $LOCALE_SLONGDATE = 0x20        ;  long date format string
	; 	Const $LOCALE_STIMEFORMAT = 0x1003    ;  time format string
	Switch $sType
		Case 0
			; Get ShortDate format
			$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1F, "str", "", "long", 255)
			If Not @error And $lngX[0] <> 0 Then
				$sTempDate = $lngX[3]
			Else
				$sTempDate = "M/d/yyyy"
			EndIf
			;
			; Get Time format
			If $asTimePart[0] > 1 Then
				$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1003, "str", "", "long", 255)
				If Not @error And $lngX[0] <> 0 Then
					$sTempTime = $lngX[3]
				Else
					$sTempTime = "h:mm:ss tt"
				EndIf
			EndIf
		Case 1
			; Get LongDate format
			$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x20, "str", "", "long", 255)
			If Not @error And $lngX[0] <> 0 Then
				$sTempDate = $lngX[3]
			Else
				$sTempDate = "dddd, MMMM dd, yyyy"
			EndIf
		Case 2
			; Get ShortDate format
			$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1F, "str", "", "long", 255)
			If Not @error And $lngX[0] <> 0 Then
				$sTempDate = $lngX[3]
			Else
				$sTempDate = "M/d/yyyy"
			EndIf
		Case 3
			;
			; Get Time format
			If $asTimePart[0] > 1 Then
				$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1003, "str", "", "long", 255)
				If Not @error And $lngX[0] <> 0 Then
					$sTempTime = $lngX[3]
				Else
					$sTempTime = "h:mm:ss tt"
				EndIf
			EndIf
		Case 4
			If $asTimePart[0] > 1 Then
				$sTempTime = "hh:mm"
			EndIf
		Case 5
			If $asTimePart[0] > 1 Then
				$sTempTime = "hh:mm:ss"
			EndIf
	EndSwitch
	; Format DATE
	If $sTempDate <> "" Then
		;   Const $LOCALE_SDATE = 0x1D            ;  date separator
		$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1D, "str", "", "long", 255)
		If Not @error And $lngX[0] <> 0 Then
			$sTempDate = StringReplace($sTempDate, "/", $lngX[3])
		EndIf
		$iWday = _DateToDayOfWeek($asDatePart[1], $asDatePart[2], $asDatePart[3])
		$asDatePart[3] = StringRight("0" & $asDatePart[3], 2) ; make sure the length is 2
		$asDatePart[2] = StringRight("0" & $asDatePart[2], 2) ; make sure the length is 2
		$sTempDate = StringReplace($sTempDate, "d", "@")
		$sTempDate = StringReplace($sTempDate, "m", "#")
		$sTempDate = StringReplace($sTempDate, "y", "&")
		$sTempDate = StringReplace($sTempDate, "@@@@", _DateDayOfWeek($iWday, 0))
		$sTempDate = StringReplace($sTempDate, "@@@", _DateDayOfWeek($iWday, 1))
		$sTempDate = StringReplace($sTempDate, "@@", $asDatePart[3])
		$sTempDate = StringReplace($sTempDate, "@", StringReplace(StringLeft($asDatePart[3], 1), "0", "") & StringRight($asDatePart[3], 1))
		$sTempDate = StringReplace($sTempDate, "####", _DateMonthOfYear($asDatePart[2], 0))
		$sTempDate = StringReplace($sTempDate, "###", _DateMonthOfYear($asDatePart[2], 1))
		$sTempDate = StringReplace($sTempDate, "##", $asDatePart[2])
		$sTempDate = StringReplace($sTempDate, "#", StringReplace(StringLeft($asDatePart[2], 1), "0", "") & StringRight($asDatePart[2], 1))
		$sTempDate = StringReplace($sTempDate, "&&&&", $asDatePart[1])
		$sTempDate = StringReplace($sTempDate, "&&", StringRight($asDatePart[1], 2))
	EndIf
	; Format TIME
	If $sTempTime <> "" Then
		$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x28, "str", "", "long", 255)
		If Not @error And $lngX[0] <> 0 Then
			$sAM = $lngX[3]
		Else
			$sAM = "AM"
		EndIf
		$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x29, "str", "", "long", 255)
		If Not @error And $lngX[0] <> 0 Then
			$sPM = $lngX[3]
		Else
			$sPM = "PM"
		EndIf
		;   Const $LOCALE_STIME = 0x1E            ;  time separator
		$lngX = DllCall("kernel32.dll", "long", "GetLocaleInfo", "long", 0x400, "long", 0x1E, "str", "", "long", 255)
		If Not @error And $lngX[0] <> 0 Then
			$sTempTime = StringReplace($sTempTime, ":", $lngX[3])
		EndIf
		If StringInStr($sTempTime, "tt") Then
			If $asTimePart[1] < 12 Then
				$sTempTime = StringReplace($sTempTime, "tt", $sAM)
				If $asTimePart[1] = 0 Then $asTimePart[1] = 12
			Else
				$sTempTime = StringReplace($sTempTime, "tt", $sPM)
				If $asTimePart[1] > 12 Then $asTimePart[1] = $asTimePart[1] - 12
			EndIf
		EndIf
		$asTimePart[1] = StringRight("0" & $asTimePart[1], 2) ; make sure the length is 2
		$asTimePart[2] = StringRight("0" & $asTimePart[2], 2) ; make sure the length is 2
		$asTimePart[3] = StringRight("0" & $asTimePart[3], 2) ; make sure the length is 2
		$sTempTime = StringReplace($sTempTime, "hh", StringFormat("%02d", $asTimePart[1]))
		$sTempTime = StringReplace($sTempTime, "h", StringReplace(StringLeft($asTimePart[1], 1), "0", "") & StringRight($asTimePart[1], 1))
		$sTempTime = StringReplace($sTempTime, "mm", StringFormat("%02d", $asTimePart[2]))
		$sTempTime = StringReplace($sTempTime, "ss", StringFormat("%02d", $asTimePart[3]))
		$sTempDate = StringStripWS($sTempDate & " " & $sTempTime, 3)
	EndIf
	Return ($sTempDate)
EndFunc   ;==>_DateTimeFormat
Func _DateTimeSplit($sDate, ByRef $asDatePart, ByRef $iTimePart)
	Local $sDateTime
	Local $x
	; split the Date and Time portion
	$sDateTime = StringSplit($sDate, " T")
	; split the date portion
	If $sDateTime[0] > 0 Then $asDatePart = StringSplit($sDateTime[1], "/-.")
	; split the Time portion
	If $sDateTime[0] > 1 Then
		$iTimePart = StringSplit($sDateTime[2], ":")
		If UBound($iTimePart) < 4 Then ReDim $iTimePart[4]
	Else
		Dim $iTimePart[4]
	EndIf
	; Ensure the arrays contain 4 values
	If UBound($asDatePart) < 4 Then ReDim $asDatePart[4]
	; update the array to contain numbers not strings
	For $x = 1 To 3
		If StringIsInt($asDatePart[$x]) Then
			$asDatePart[$x] = Number($asDatePart[$x])
		Else
			$asDatePart[$x] = -1
		EndIf
		If StringIsInt($iTimePart[$x]) Then
			$iTimePart[$x] = Number($iTimePart[$x])
		Else
			$iTimePart[$x] = 0
		EndIf
	Next
	Return (1)
EndFunc   ;==>_DateTimeSplit
Func _DateToDayOfWeek($iYear, $iMonth, $iDay)
	Local $i_aFactor
	Local $i_yFactor
	Local $i_mFactor
	Local $i_dFactor
	; Verify If InputDate is valid
	If Not _DateIsValid($iYear & "/" & $iMonth & "/" & $iDay) Then
		SetError(1)
		Return ("")
	EndIf
	$i_aFactor = Int((14 - $iMonth) / 12)
	$i_yFactor = $iYear - $i_aFactor
	$i_mFactor = $iMonth + (12 * $i_aFactor) - 2
	$i_dFactor = Mod($iDay + $i_yFactor + Int($i_yFactor / 4) - Int($i_yFactor / 100) + Int($i_yFactor / 400) + Int((31 * $i_mFactor) / 12), 7)
	Return ($i_dFactor + 1)
EndFunc   ;==>_DateToDayOfWeek
Func _DateToDayOfWeekISO($iYear, $iMonth, $iDay)
	Local $idow = _DateToDayOfWeek($iYear, $iMonth, $iDay)
	If @error Then
		SetError(1)
		Return ""
	EndIf
	If $idow >= 2 Then Return $idow - 2
	Return 6
EndFunc   ;==>_DateToDayOfWeekISO
Func _DateToDayValue($iYear, $iMonth, $iDay)
	Local $i_aFactor
	Local $i_bFactor
	Local $i_cFactor
	Local $i_eFactor
	Local $i_fFactor
	Local $iJulianDate
	; Verify If InputDate is valid
	If Not _DateIsValid(StringFormat("%04d/%02d/%02d", $iYear, $iMonth, $iDay)) Then
		SetError(1)
		Return ("")
	EndIf
	If $iMonth < 3 Then
		$iMonth = $iMonth + 12
		$iYear = $iYear - 1
	EndIf
	$i_aFactor = Int($iYear / 100)
	$i_bFactor = Int($i_aFactor / 4)
	$i_cFactor = 2 - $i_aFactor + $i_bFactor
	$i_eFactor = Int(1461 * ($iYear + 4716) / 4)
	$i_fFactor = Int(153 * ($iMonth + 1) / 5)
	$iJulianDate = $i_cFactor + $iDay + $i_eFactor + $i_fFactor - 1524.5
	Return ($iJulianDate)
EndFunc   ;==>_DateToDayValue
Func _DateToMonth($iMonthNum, $iShort = 0)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $aMonthNumber[13] = ["", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	Local $aMonthNumberAbbrev[13] = ["", "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
	Select
		Case Not StringIsInt($iMonthNum)
			SetError(1)
			Return ""
		Case $iMonthNum < 1 Or $iMonthNum > 12
			SetError(1)
			Return ""
		Case Else
			Select
				Case $iShort = 0
					Return $aMonthNumber[$iMonthNum]
				Case $iShort = 1
					Return $aMonthNumberAbbrev[$iMonthNum]
				Case Else
					SetError(1)
					Return ""
			EndSelect
	EndSelect
EndFunc   ;==>_DateToMonth
Func _DayValueToDate($iJulianDate, ByRef $iYear, ByRef $iMonth, ByRef $iDay)
	Local $i_zFactor
	Local $i_wFactor
	Local $i_aFactor
	Local $i_bFactor
	Local $i_xFactor
	Local $i_cFactor
	Local $i_dFactor
	Local $i_eFactor
	Local $i_fFactor
	; check for valid input date
	If $iJulianDate < 0 Or Not IsNumber($iJulianDate) Then
		SetError(1)
		Return 0
	EndIf
	; calculte the date
	$i_zFactor = Int($iJulianDate + 0.5)
	$i_wFactor = Int(($i_zFactor - 1867216.25) / 36524.25)
	$i_xFactor = Int($i_wFactor / 4)
	$i_aFactor = $i_zFactor + 1 + $i_wFactor - $i_xFactor
	$i_bFactor = $i_aFactor + 1524
	$i_cFactor = Int(($i_bFactor - 122.1) / 365.25)
	$i_dFactor = Int(365.25 * $i_cFactor)
	$i_eFactor = Int(($i_bFactor - $i_dFactor) / 30.6001)
	$i_fFactor = Int(30.6001 * $i_eFactor)
	$iDay = $i_bFactor - $i_dFactor - $i_fFactor
	; (must get number less than or equal to 12)
	If $i_eFactor - 1 < 13 Then
		$iMonth = $i_eFactor - 1
	Else
		$iMonth = $i_eFactor - 13
	EndIf
	If $iMonth < 3 Then
		$iYear = $i_cFactor - 4715 ; (if Month is January or February)
	Else
		$iYear = $i_cFactor - 4716 ;(otherwise)
	EndIf
	$iYear = StringFormat("%04d", $iYear)
	$iMonth = StringFormat("%02d", $iMonth)
	$iDay = StringFormat("%02d", $iDay)
	Return $iYear & "/" & $iMonth & "/" & $iDay
EndFunc   ;==>_DayValueToDate
Func _Date_JulianDayNo($iYear, $iMonth, $iDay)
	Local $sFullDate
	Local $aiDaysInMonth
	Local $iJDay
	Local $iCntr
	; Verify If InputDate is valid
	$sFullDate = StringFormat("%04d/%02d/%02d", $iYear, $iMonth, $iDay)
	If Not _DateIsValid($sFullDate) Then
		SetError(1)
		Return ""
	EndIf
	; Build JDay value
	$iJDay = 0
	$aiDaysInMonth = __DaysInMonth($iYear)
	For $iCntr = 1 To $iMonth - 1
		$iJDay = $iJDay + $aiDaysInMonth[$iCntr]
	Next
	$iJDay = ($iYear * 1000) + ($iJDay + $iDay)
	Return $iJDay
EndFunc   ;==>_Date_JulianDayNo
Func _JulianToDate($iJDay, $sSep = "/")
	Local $aiDaysInMonth
	Local $iYear
	Local $iMonth
	Local $iDay
	Local $iDays
	Local $iMaxDays
	; Verify If InputDate is valid
	$iYear = Int($iJDay / 1000)
	$iDays = Mod($iJDay, 1000)
	$iMaxDays = 365
	If _DateIsLeapYear($iYear) Then $iMaxDays = 366
	If $iDays > $iMaxDays Then
		SetError(1)
		Return ""
	EndIf
	; Convert to regular date
	$aiDaysInMonth = __DaysInMonth($iYear)
	$iMonth = 1
	While $iDays > $aiDaysInMonth[$iMonth]
		$iDays = $iDays - $aiDaysInMonth[$iMonth]
		$iMonth = $iMonth + 1
	WEnd
	$iDay = $iDays
	Return StringFormat("%04d%s%02d%s%02d", $iYear, $sSep, $iMonth, $sSep, $iDay)
EndFunc   ;==>_JulianToDate
Func _Now()
	Return (_DateTimeFormat(@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC, 0))
EndFunc   ;==>_Now
Func _NowCalc()
	Return (@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC)
EndFunc   ;==>_NowCalc
Func _NowCalcDate()
	Return (@YEAR & "/" & @MON & "/" & @MDAY)
EndFunc   ;==>_NowCalcDate
Func _NowDate()
	Return (_DateTimeFormat(@YEAR & "/" & @MON & "/" & @MDAY, 0))
EndFunc   ;==>_NowDate
Func _NowTime($sType = 3)
	If $sType < 3 Or $sType > 5 Then $sType = 3
	Return (_DateTimeFormat(@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC, $sType))
EndFunc   ;==>_NowTime
Func _SetDate($iDay, $iMonth = 0, $iYear = 0)
	Local $iRetval, $SYSTEMTIME, $lpSystemTime
	;============================================================================
	;== Some error checking
	;============================================================================
	If $iYear = 0 Then $iYear = @YEAR
	If $iMonth = 0 Then $iMonth = @MON
	If Not _DateIsValid($iYear & "/" & $iMonth & "/" & $iDay) Then Return 1
	$SYSTEMTIME = DllStructCreate("ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort")
	$lpSystemTime = DllStructGetPtr($SYSTEMTIME)
	;============================================================================
	;== Get the local system time to fill up the SYSTEMTIME structure
	;============================================================================
	$iRetval = DllCall("kernel32.dll", "long", "GetLocalTime", "ptr", $lpSystemTime)
	;============================================================================
	;== Change the necessary values
	;============================================================================
	DllStructSetData($SYSTEMTIME, 4, $iDay)
	If $iMonth > 0 Then DllStructSetData($SYSTEMTIME, 2, $iMonth)
	If $iYear > 0 Then DllStructSetData($SYSTEMTIME, 1, $iYear)
	;============================================================================
	;== Set the new date
	;============================================================================
	$iRetval = DllCall("kernel32.dll", "long", "SetLocalTime", "ptr", $lpSystemTime)
	; a second call is needed to take care of daylight saving see MSDN
	$iRetval = DllCall("kernel32.dll", "long", "SetLocalTime", "ptr", $lpSystemTime)
	;============================================================================
	;== If DllCall was successfull, check for an error of the API Call
	;============================================================================
	If @error = 0 Then
		If $iRetval[0] = 0 Then
			Local $lastError = DllCall("kernel32.dll", "int", "GetLastError")
			SetExtended($lastError[0])
			SetError(1)
			Return 0
		Else
			Return 1
		EndIf
		;============================================================================
		;== If DllCall was UNsuccessfull, return an error
		;============================================================================
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_SetDate
Func _SetTime($iHour, $iMinute, $iSecond = 0)
	Local $iRetval, $SYSTEMTIME, $lpSystemTime
	;============================================================================
	;== Some error checking
	;============================================================================
	If $iHour < 0 Or $iHour > 23 Then Return 1
	If $iMinute < 0 Or $iMinute > 59 Then Return 1
	If $iSecond < 0 Or $iSecond > 59 Then Return 1
	$SYSTEMTIME = DllStructCreate("ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort")
	$lpSystemTime = DllStructGetPtr($SYSTEMTIME)
	;============================================================================
	;== Get the local system time to fill up the SYSTEMTIME structure
	;============================================================================
	$iRetval = DllCall("kernel32.dll", "long", "GetLocalTime", "ptr", $lpSystemTime)
	;============================================================================
	;== Change the necessary values
	;============================================================================
	DllStructSetData($SYSTEMTIME, 5, $iHour)
	DllStructSetData($SYSTEMTIME, 6, $iMinute)
	If $iSecond > 0 Then DllStructSetData($SYSTEMTIME, 7, $iSecond)
	;============================================================================
	;== Set the new time
	;============================================================================
	$iRetval = DllCall("kernel32.dll", "long", "SetLocalTime", "ptr", $lpSystemTime)
	; a second call is needed to take care of daylight saving see MSDN
	$iRetval = DllCall("kernel32.dll", "long", "SetLocalTime", "ptr", $lpSystemTime)
	;============================================================================
	;== If DllCall was successfull, check for an error of the API Call
	;============================================================================
	If @error = 0 Then
		If $iRetval[0] = 0 Then
			Local $lastError = DllCall("kernel32.dll", "int", "GetLastError")
			SetExtended($lastError[0])
			SetError(1)
			Return 0
		Else
			Return 1
		EndIf
		;============================================================================
		;== If DllCall was UNsuccessfull, return an error
		;============================================================================
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_SetTime
Func _TicksToTime($iTicks, ByRef $iHours, ByRef $iMins, ByRef $iSecs)
	If Number($iTicks) > 0 Then
		$iTicks = Round($iTicks / 1000)
		$iHours = Int($iTicks / 3600)
		$iTicks = Mod($iTicks, 3600)
		$iMins = Int($iTicks / 60)
		$iSecs = Round(Mod($iTicks, 60))
		; If $iHours = 0 then $iHours = 24
		Return 1
	ElseIf Number($iTicks) = 0 Then
		$iHours = 0
		$iTicks = 0
		$iMins = 0
		$iSecs = 0
		Return 1
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_TicksToTime
Func _TimeToTicks($iHours = @HOUR, $iMins = @MIN, $iSecs = @SEC)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $iTicks
	If StringIsInt($iHours) And StringIsInt($iMins) And StringIsInt($iSecs) Then
		$iTicks = 1000 * ((3600 * $iHours) + (60 * $iMins) + $iSecs)
		Return $iTicks
	Else
		SetError(1)
		Return 0
	EndIf
EndFunc   ;==>_TimeToTicks
Func _WeekNumberISO($iYear = @YEAR, $iMonth = @MON, $iDay = @MDAY)
	Local $idow, $iDow0101
	; Check for erroneous input in $Day, $Month & $Year
	If $iDay > 31 Or $iDay < 1 Then
		SetError(1)
		Return -1
	ElseIf $iMonth > 12 Or $iMonth < 1 Then
		SetError(1)
		Return -1
	ElseIf $iYear < 1 Or $iYear > 2999 Then
		SetError(1)
		Return -1
	EndIf
	$idow = _DateToDayOfWeekISO($iYear, $iMonth, $iDay);
	$iDow0101 = _DateToDayOfWeekISO($iYear, 1, 1);
	If ($iMonth = 1 And 3 < $iDow0101 And $iDow0101 < 7 - ($iDay - 1)) Then
		;days before week 1 of the current year have the same week number as
		;the last day of the last week of the previous year
		$idow = $iDow0101 - 1;
		$iDow0101 = _DateToDayOfWeekISO($iYear - 1, 1, 1);
		$iMonth = 12
		$iDay = 31
		$iYear = $iYear - 1
	ElseIf ($iMonth = 12 And 30 - ($iDay - 1) < _DateToDayOfWeekISO($iYear + 1, 1, 1) And _DateToDayOfWeekISO($iYear + 1, 1, 1) < 4) Then
		; days after the last week of the current year have the same week number as
		; the first day of the next year, (i.e. 1)
		Return 1;
	EndIf
	Return Int((_DateToDayOfWeekISO($iYear, 1, 1) < 4) + 4 * ($iMonth - 1) + (2 * ($iMonth - 1) + ($iDay - 1) + $iDow0101 - $idow + 6) * 36 / 256)
EndFunc   ;==>_WeekNumberISO
Func _WeekNumber($iYear = @YEAR, $iMonth = @MON, $iDay = @MDAY, $iWeekStart = 1)
	Local $iDow0101, $iDow0101ny
	Local $iDate, $iStartWeek1, $iEndWeek1, $iEndWeek1Date, $iStartWeek1ny, $iStartWeek1Dateny
	Local $iCurrDateDiff, $iCurrDateDiffny
	; Check for erroneous input in $Day, $Month & $Year
	If $iDay > 31 Or $iDay < 1 Then
		SetError(1)
		Return -1
	ElseIf $iMonth > 12 Or $iMonth < 1 Then
		SetError(1)
		Return -1
	ElseIf $iYear < 1 Or $iYear > 2999 Then
		SetError(1)
		Return -1
	ElseIf $iWeekStart < 1 Or $iWeekStart > 2 Then
		SetError(2)
		Return -1
	EndIf
	;
	;$idow = _DateToDayOfWeekISO($iYear, $iMonth, $iDay);
	$iDow0101 = _DateToDayOfWeekISO($iYear, 1, 1);
	$iDate = $iYear & '/' & $iMonth & '/' & $iDay
	;Calculate the Start and End date of Week 1 this year
	If $iWeekStart = 1 Then
		If $iDow0101 = 6 Then
			$iStartWeek1 = 0
		Else
			$iStartWeek1 = -1 * $iDow0101 - 1
		EndIf
		$iEndWeek1 = $iStartWeek1 + 6
	Else
		$iStartWeek1 = $iDow0101 * - 1
		$iEndWeek1 = $iStartWeek1 + 6
	EndIf
	;$iStartWeek1Date = _DateAdd('d',$iStartWeek1,$iYear & '/01/01')
	$iEndWeek1Date = _DateAdd('d', $iEndWeek1, $iYear & '/01/01')
	;Calculate the Start and End date of Week 1 this Next year
	$iDow0101ny = _DateToDayOfWeekISO($iYear + 1, 1, 1);
	;  1 = start on Sunday / 2 = start on Monday
	If $iWeekStart = 1 Then
		If $iDow0101ny = 6 Then
			$iStartWeek1ny = 0
		Else
			$iStartWeek1ny = -1 * $iDow0101ny - 1
		EndIf
		;$IEndWeek1ny = $iStartWeek1ny + 6
	Else
		$iStartWeek1ny = $iDow0101ny * - 1
		;$IEndWeek1ny = $iStartWeek1ny + 6
	EndIf
	$iStartWeek1Dateny = _DateAdd('d', $iStartWeek1ny, $iYear + 1 & '/01/01')
	;$iEndWeek1Dateny = _DateAdd('d',$IEndWeek1ny,$iYear+1 & '/01/01')
	;number of days after end week 1
	$iCurrDateDiff = _DateDiff('d', $iEndWeek1Date, $iDate) - 1
	;number of days before next week 1 start
	$iCurrDateDiffny = _DateDiff('d', $iStartWeek1Dateny, $iDate)
	;
	; Check for end of year
	If $iCurrDateDiff >= 0 And $iCurrDateDiffny < 0 Then Return 2 + Int($iCurrDateDiff / 7)
	; > week 1
	If $iCurrDateDiff < 0 Or $iCurrDateDiffny >= 0 Then Return 1
EndFunc   ;==>_WeekNumber
Func __DaysInMonth($iYear)
	Local $aiDays
	$aiDays = StringSplit("31,28,31,30,31,30,31,31,30,31,30,31", ",")
	If _DateIsLeapYear($iYear) Then $aiDays[2] = 29
	Return $aiDays
EndFunc   ;==>__DaysInMonth
Func _Date_Time_CloneSystemTime($pSystemTime)
	Local $tSystemTime1, $tSystemTime2
	$tSystemTime1 = DllStructCreate($tagSYSTEMTIME, $pSystemTime)
	$tSystemTime2 = DllStructCreate($tagSYSTEMTIME)
	DllStructSetData($tSystemTime2, "Month", DllStructGetData($tSystemTime1, "Month"))
	DllStructSetData($tSystemTime2, "Day", DllStructGetData($tSystemTime1, "Day"))
	DllStructSetData($tSystemTime2, "Year", DllStructGetData($tSystemTime1, "Year"))
	DllStructSetData($tSystemTime2, "Hour", DllStructGetData($tSystemTime1, "Hour"))
	DllStructSetData($tSystemTime2, "Minute", DllStructGetData($tSystemTime1, "Minute"))
	DllStructSetData($tSystemTime2, "Second", DllStructGetData($tSystemTime1, "Second"))
	DllStructSetData($tSystemTime2, "MSeconds", DllStructGetData($tSystemTime1, "MSeconds"))
	DllStructSetData($tSystemTime2, "DOW", DllStructGetData($tSystemTime1, "DOW"))
	Return $tSystemTime2
EndFunc   ;==>_Date_Time_CloneSystemTime
Func _Date_Time_CompareFileTime($pFileTime1, $pFileTime2)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "CompareFileTime", "ptr", $pFileTime1, "ptr", $pFileTime2)
	Return SetError(0, 0, $aResult[0])
EndFunc   ;==>_Date_Time_CompareFileTime
Func _Date_Time_DOSDateTimeToFileTime($iFatDate, $iFatTime)
	Local $pTime, $tTime, $aResult
	$tTime = DllStructCreate($tagFILETIME)
	$pTime = DllStructGetPtr($tTime)
	$aResult = DllCall("Kernel32.dll", "int", "DosDateTimeToFileTime", "ushort", $iFatDate, "ushort", $iFatTime, "ptr", $pTime)
	Return SetError($aResult[0] = 0, 0, $tTime)
EndFunc   ;==>_Date_Time_DOSDateTimeToFileTime
Func _Date_Time_DOSDateToArray($iDosDate)
	Local $aDate[3]
	$aDate[0] = BitAND($iDosDate, 0x1F)
	$aDate[1] = BitAND(BitShift($iDosDate, 5), 0x0F)
	$aDate[2] = BitAND(BitShift($iDosDate, 9), 0x3F) + 1980
	Return $aDate
EndFunc   ;==>_Date_Time_DOSDateToArray
Func _Date_Time_DOSDateTimeToArray($iDosDate, $iDosTime)
	Local $aDate[6]
	$aDate[0] = BitAND($iDosDate, 0x1F)
	$aDate[1] = BitAND(BitShift($iDosDate, 5), 0x0F)
	$aDate[2] = BitAND(BitShift($iDosDate, 9), 0x3F) + 1980
	$aDate[5] = BitAND($iDosTime, 0x1F) * 2
	$aDate[4] = BitAND(BitShift($iDosTime, 5), 0x3F)
	$aDate[3] = BitAND(BitShift($iDosTime, 11), 0x1F)
	Return $aDate
EndFunc   ;==>_Date_Time_DOSDateTimeToArray
Func _Date_Time_DOSDateTimeToStr($iDosDate, $iDosTime)
	Local $aDate
	$aDate = _Date_Time_DOSDateTimeToArray($iDosDate, $iDosTime)
	Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $aDate[0], $aDate[1], $aDate[2], $aDate[3], $aDate[4], $aDate[5])
EndFunc   ;==>_Date_Time_DOSDateTimeToStr
Func _Date_Time_DOSDateToStr($iDosDate)
	Local $aDate
	$aDate = _Date_Time_DOSDateToArray($iDosDate)
	Return StringFormat("%02d/%02d/%04d", $aDate[0], $aDate[1], $aDate[2])
EndFunc   ;==>_Date_Time_DOSDateToStr
Func _Date_Time_DOSTimeToArray($iDosTime)
	Local $aTime[3]
	$aTime[2] = BitAND($iDosTime, 0x1F) * 2
	$aTime[1] = BitAND(BitShift($iDosTime, 5), 0x3F)
	$aTime[0] = BitAND(BitShift($iDosTime, 11), 0x1F)
	Return $aTime
EndFunc   ;==>_Date_Time_DOSTimeToArray
Func _Date_Time_DOSTimeToStr($iDosTime)
	Local $aTime
	$aTime = _Date_Time_DOSTimeToArray($iDosTime)
	Return StringFormat("%02d:%02d:%02d", $aTime[0], $aTime[1], $aTime[2])
EndFunc   ;==>_Date_Time_DOSTimeToStr
Func _Date_Time_EncodeFileTime($iMonth, $iDay, $iYear, $iHour = 0, $iMinute = 0, $iSecond = 0, $iMSeconds = 0)
	Local $tSystemTime
	$tSystemTime = _Date_Time_EncodeSystemTime($iMonth, $iDay, $iYear, $iHour, $iMinute, $iSecond, $iMSeconds)
	Return _Date_Time_SystemTimeToFileTime(DllStructGetPtr($tSystemTime))
EndFunc   ;==>_Date_Time_EncodeFileTime
Func _Date_Time_EncodeSystemTime($iMonth, $iDay, $iYear, $iHour = 0, $iMinute = 0, $iSecond = 0, $iMSeconds = 0)
	Local $tSystemTime
	$tSystemTime = DllStructCreate($tagSYSTEMTIME)
	DllStructSetData($tSystemTime, "Month", $iMonth)
	DllStructSetData($tSystemTime, "Day", $iDay)
	DllStructSetData($tSystemTime, "Year", $iYear)
	DllStructSetData($tSystemTime, "Hour", $iHour)
	DllStructSetData($tSystemTime, "Minute", $iMinute)
	DllStructSetData($tSystemTime, "Second", $iSecond)
	DllStructSetData($tSystemTime, "MSeconds", $iMSeconds)
	Return $tSystemTime
EndFunc   ;==>_Date_Time_EncodeSystemTime
Func _Date_Time_FileTimeToArray(ByRef $tFileTime)
	Local $tSystemTime
	$tSystemTime = _Date_Time_FileTimeToSystemTime(DllStructGetPtr($tFileTime))
	Return _Date_Time_SystemTimeToArray($tSystemTime)
EndFunc   ;==>_Date_Time_FileTimeToArray
Func _Date_Time_FileTimeToStr(ByRef $tFileTime)
	Local $aDate
	$aDate = _Date_Time_FileTimeToArray($tFileTime)
	Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $aDate[0], $aDate[1], $aDate[2], $aDate[3], $aDate[4], $aDate[5])
EndFunc   ;==>_Date_Time_FileTimeToStr
Func _Date_Time_FileTimeToDOSDateTime($pFileTime)
	Local $aDate[2], $aResult
	$aResult = DllCall("Kernel32.dll", "int", "FileTimeToDosDateTime", "ptr", $pFileTime, "int*", 0, "int*", 0)
	$aDate[0] = $aResult[2]
	$aDate[1] = $aResult[3]
	Return SetError($aResult[0] = 0, 0, $aDate)
EndFunc   ;==>_Date_Time_FileTimeToDOSDateTime
Func _Date_Time_FileTimeToLocalFileTime($pFileTime)
	Local $tLocal, $aResult
	$tLocal = DllStructCreate($tagFILETIME)
	$aResult = DllCall("Kernel32.dll", "int", "FileTimeToLocalFileTime", "ptr", $pFileTime, "ptr", DllStructGetPtr($tLocal))
	Return SetError($aResult[0] = 0, 0, $tLocal)
EndFunc   ;==>_Date_Time_FileTimeToLocalFileTime
Func _Date_Time_FileTimeToSystemTime($pFileTime)
	Local $tSystTime, $aResult
	$tSystTime = DllStructCreate($tagSYSTEMTIME)
	$aResult = DllCall("Kernel32.dll", "int", "FileTimeToSystemTime", "ptr", $pFileTime, "ptr", DllStructGetPtr($tSystTime))
	Return SetError($aResult[0] = 0, 0, $tSystTime)
EndFunc   ;==>_Date_Time_FileTimeToSystemTime
Func _Date_Time_GetFileTime($hFile)
	Local $pCT, $pLA, $pLM, $aDate[3], $aResult
	$aDate[0] = DllStructCreate($tagFILETIME)
	$aDate[1] = DllStructCreate($tagFILETIME)
	$aDate[2] = DllStructCreate($tagFILETIME)
	$pCT = DllStructGetPtr($aDate[0])
	$pLA = DllStructGetPtr($aDate[1])
	$pLM = DllStructGetPtr($aDate[2])
	$aResult = DllCall("Kernel32.dll", "int", "GetFileTime", "hwnd", $hFile, "ptr", $pCT, "ptr", $pLA, "ptr", $pLM)
	Return SetError($aResult[0] = 0, 0, $aDate)
EndFunc   ;==>_Date_Time_GetFileTime
Func _Date_Time_GetLocalTime()
	Local $tSystTime
	$tSystTime = DllStructCreate($tagSYSTEMTIME)
	DllCall("Kernel32.dll", "none", "GetLocalTime", "ptr", DllStructGetPtr($tSystTime))
	Return $tSystTime
EndFunc   ;==>_Date_Time_GetLocalTime
Func _Date_Time_GetSystemTime()
	Local $tSystTime
	$tSystTime = DllStructCreate($tagSYSTEMTIME)
	DllCall("Kernel32.dll", "none", "GetSystemTime", "ptr", DllStructGetPtr($tSystTime))
	Return $tSystTime
EndFunc   ;==>_Date_Time_GetSystemTime
Func _Date_Time_GetSystemTimeAdjustment()
	Local $aInfo[3], $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GetSystemTimeAdjustment", "int*", 0, "int*", 0, "int*", 0)
	$aInfo[0] = $aResult[1]
	$aInfo[1] = $aResult[2]
	$aInfo[2] = $aResult[3] <> 0
	Return SetError($aResult[0] = 0, 0, $aInfo)
EndFunc   ;==>_Date_Time_GetSystemTimeAdjustment
Func _Date_Time_GetSystemTimeAsFileTime()
	Local $tFileTime
	$tFileTime = DllStructCreate($tagFILETIME)
	DllCall("Kernel32.dll", "none", "GetSystemTimeAsFileTime", "ptr", DllStructGetPtr($tFileTime))
	Return $tFileTime
EndFunc   ;==>_Date_Time_GetSystemTimeAsFileTime
Func _Date_Time_GetSystemTimes()
	Local $pIdle, $pKernel, $pUser, $aInfo[3], $aResult
	$aInfo[0] = DllStructCreate($tagFILETIME)
	$aInfo[1] = DllStructCreate($tagFILETIME)
	$aInfo[2] = DllStructCreate($tagFILETIME)
	$pIdle = DllStructGetPtr($aInfo[0])
	$pKernel = DllStructGetPtr($aInfo[1])
	$pUser = DllStructGetPtr($aInfo[2])
	$aResult = DllCall("Kernel32.dll", "int", "GetSystemTimes", "ptr", $pIdle, "ptr", $pKernel, "ptr", $pUser)
	Return SetError($aResult[0] = 0, 0, $aInfo)
EndFunc   ;==>_Date_Time_GetSystemTimes
Func _Date_Time_GetTickCount()
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "GetTickCount")
	Return $aResult[0]
EndFunc   ;==>_Date_Time_GetTickCount
Func _Date_Time_GetTimeZoneInformation()
	Local $tTimeZone, $aInfo[8], $aResult
	$tTimeZone = DllStructCreate($tagTIME_ZONE_INFORMATION)
	$aResult = DllCall("Kernel32.dll", "int", "GetTimeZoneInformation", "ptr", DllStructGetPtr($tTimeZone))
	$aInfo[0] = $aResult[0]
	$aInfo[1] = DllStructGetData($tTimeZone, "Bias")
	$aInfo[2] = _WinAPI_WideCharToMultiByte(DllStructGetPtr($tTimeZone, "StdName"))
	$aInfo[3] = _Date_Time_CloneSystemTime(DllStructGetPtr($tTimeZone, "StdDate"))
	$aInfo[4] = DllStructGetData($tTimeZone, "StdBias")
	$aInfo[5] = _WinAPI_WideCharToMultiByte(DllStructGetPtr($tTimeZone, "DayName"))
	$aInfo[6] = _Date_Time_CloneSystemTime(DllStructGetPtr($tTimeZone, "DayDate"))
	$aInfo[7] = DllStructGetData($tTimeZone, "DayBias")
	Return $aInfo
EndFunc   ;==>_Date_Time_GetTimeZoneInformation
Func _Date_Time_LocalFileTimeToFileTime($pLocalTime)
	Local $tFileTime, $aResult
	$tFileTime = DllStructCreate($tagFILETIME)
	$aResult = DllCall("Kernel32.dll", "int", "LocalFileTimeToFileTime", "ptr", $pLocalTime, "ptr", DllStructGetPtr($tFileTime))
	Return SetError($aResult[0] = 0, 0, $tFileTime)
EndFunc   ;==>_Date_Time_LocalFileTimeToFileTime
Func _Date_Time_SetFileTime($hFile, $pCreateTime, $pLastAccess, $pLastWrite)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "SetFileTime", "hwnd", $hFile, "ptr", $pCreateTime, "ptr", $pLastAccess, "ptr", $pLastWrite)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetFileTime
Func _Date_Time_SetLocalTime($pSystemTime)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "SetLocalTime", "ptr", $pSystemTime)
	If $aResult[0] = 0 Then Return SetError(True, 0, False)
	; The system uses UTC internally.  When you call SetLocalTime, the system uses the current time zone information to perform the
	; conversion, incuding the daylight saving time setting.  The system uses the daylight saving time setting of the current time,
	; not the new time you are setting.  This is a "feature" according to Microsoft.  In order to get around this, we have to  call
	; the function twice. The first call sets the internal time zone and the second call sets the actual time.
	$aResult = DllCall("Kernel32.dll", "int", "SetLocalTime", "ptr", $pSystemTime)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetLocalTime
Func _Date_Time_SetSystemTime($pSystemTime)
	Local $aResult
	$aResult = DllCall("Kernel32.dll", "int", "SetSystemTime", "ptr", $pSystemTime)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetSystemTime
Func _Date_Time_SetSystemTimeAdjustment($iAdjustment, $fDisabled)
	Local $hToken, $aResult
	; Enable system time privileged mode
	$hToken = _Security__OpenThreadTokenEx(BitOR($__DATECONSTANT_TOKEN_ADJUST_PRIVILEGES, $__DATECONSTANT_TOKEN_QUERY))
	_WinAPI_Check("_Date_Time_SetSystemTimeAjustment:OpenThreadTokenEx", @error, @extended)
	_Security__SetPrivilege($hToken, "SeSystemtimePrivilege", True)
	_WinAPI_Check("_Date_Time_SetSystemTimeAjustment:SetPrivilege:Enable", @error, @extended)
	; Set system time
	$aResult = DllCall("Kernel32.dll", "int", "SetSystemTimeAdjustment", "dword", $iAdjustment, "int", $fDisabled)
	; Disable system time privileged mode
	_Security__SetPrivilege($hToken, "SeSystemtimePrivilege", False)
	_WinAPI_Check("_Date_Time_SetSystemTimeAdjustment:SetPrivilege:Disable", @error, @extended)
	_WinAPI_CloseHandle($hToken)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetSystemTimeAdjustment
Func _Date_Time_SetTimeZoneInformation($iBias, $sStdName, $tStdDate, $iStdBias, $sDayName, $tDayDate, $iDayBias)
	Local $hToken, $tStdName, $tDayName, $tZoneInfo, $aResult
	$tStdName = _WinAPI_MultiByteToWideChar($sStdName)
	$tDayName = _WinAPI_MultiByteToWideChar($sDayName)
	$tZoneInfo = DllStructCreate($tagTIME_ZONE_INFORMATION)
	DllStructSetData($tZoneInfo, "Bias", $iBias)
	DllStructSetData($tZoneInfo, "StdName", DllStructGetData($tStdName, 1))
	_MemMoveMemory(DllStructGetPtr($tStdDate), DllStructGetPtr($tZoneInfo, "StdDate"), DllStructGetSize($tStdDate))
	DllStructSetData($tZoneInfo, "StdBias", $iStdBias)
	DllStructSetData($tZoneInfo, "DayName", DllStructGetData($tDayName, 1))
	_MemMoveMemory(DllStructGetPtr($tDayDate), DllStructGetPtr($tZoneInfo, "DayDate"), DllStructGetSize($tDayDate))
	DllStructSetData($tZoneInfo, "DayBias", $iDayBias)
	; Enable system time privileged mode
	$hToken = _Security__OpenThreadTokenEx(BitOR($__DATECONSTANT_TOKEN_ADJUST_PRIVILEGES, $__DATECONSTANT_TOKEN_QUERY))
	_WinAPI_Check("_Date_Time_SetSystemTimeAjustment:OpenThreadTokenEx", @error, @extended)
	_Security__SetPrivilege($hToken, "SeSystemtimePrivilege", True)
	_WinAPI_Check("_Date_Time_SetSystemTimeAjustment:SetPrivilege:Enable", @error, @extended)
	; Set time zone information
	$aResult = DllCall("Kernel32.dll", "int", "SetTimeZoneInformation", "ptr", DllStructGetPtr($tZoneInfo))
	; Disable system time privileged mode
	_Security__SetPrivilege($hToken, "SeSystemtimePrivilege", False)
	_WinAPI_Check("_Date_Time_SetSystemTimeAdjustment:SetPrivilege:Disable", @error, @extended)
	_WinAPI_CloseHandle($hToken)
	Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Date_Time_SetTimeZoneInformation
Func _Date_Time_SystemTimeToArray(ByRef $tSystemTime)
	Local $aInfo[8]
	$aInfo[0] = DllStructGetData($tSystemTime, "Month")
	$aInfo[1] = DllStructGetData($tSystemTime, "Day")
	$aInfo[2] = DllStructGetData($tSystemTime, "Year")
	$aInfo[3] = DllStructGetData($tSystemTime, "Hour")
	$aInfo[4] = DllStructGetData($tSystemTime, "Minute")
	$aInfo[5] = DllStructGetData($tSystemTime, "Second")
	$aInfo[6] = DllStructGetData($tSystemTime, "MSeconds")
	$aInfo[7] = DllStructGetData($tSystemTime, "DOW")
	Return $aInfo
EndFunc   ;==>_Date_Time_SystemTimeToArray
Func _Date_Time_SystemTimeToDateStr(ByRef $tSystemTime)
	Local $aInfo
	$aInfo = _Date_Time_SystemTimeToArray($tSystemTime)
	Return StringFormat("%02d/%02d/%04d", $aInfo[0], $aInfo[1], $aInfo[2])
EndFunc   ;==>_Date_Time_SystemTimeToDateStr
Func _Date_Time_SystemTimeToDateTimeStr(ByRef $tSystemTime)
	Local $aInfo
	$aInfo = _Date_Time_SystemTimeToArray($tSystemTime)
	Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $aInfo[0], $aInfo[1], $aInfo[2], $aInfo[3], $aInfo[4], $aInfo[5])
EndFunc   ;==>_Date_Time_SystemTimeToDateTimeStr
Func _Date_Time_SystemTimeToFileTime($pSystemTime)
	Local $tFileTime, $aResult
	$tFileTime = DllStructCreate($tagFILETIME)
	$aResult = DllCall("Kernel32.dll", "int", "SystemTimeToFileTime", "ptr", $pSystemTime, "ptr", DllStructGetPtr($tFileTime))
	Return SetError($aResult[0] = 0, 0, $tFileTime)
EndFunc   ;==>_Date_Time_SystemTimeToFileTime
Func _Date_Time_SystemTimeToTimeStr(ByRef $tSystemTime)
	Local $aInfo
	$aInfo = _Date_Time_SystemTimeToArray($tSystemTime)
	Return StringFormat("%02d:%02d:%02d", $aInfo[3], $aInfo[4], $aInfo[5])
EndFunc   ;==>_Date_Time_SystemTimeToTimeStr
Func _Date_Time_SystemTimeToTzSpecificLocalTime($pUTC, $pTimeZone = 0)
	Local $tLocalTime, $aResult
	$tLocalTime = DllStructCreate($tagSYSTEMTIME)
	$aResult = DllCall("Kernel32.dll", "int", "SystemTimeToTzSpecificLocalTime", "ptr", $pTimeZone, "ptr", $pUTC, "ptr", DllStructGetPtr($tLocalTime))
	Return SetError($aResult[0] = 0, 0, $tLocalTime)
EndFunc   ;==>_Date_Time_SystemTimeToTzSpecificLocalTime
Func _Date_Time_TzSpecificLocalTimeToSystemTime($pLocalTime, $pTimeZone = 0)
	Local $tUTC, $aResult
	$tUTC = DllStructCreate($tagSYSTEMTIME)
	$aResult = DllCall("Kernel32.dll", "int", "TzSpecificLocalTimeToSystemTime", "ptr", $pTimeZone, "ptr", $pLocalTime, "ptr", DllStructGetPtr($tUTC))
	Return SetError($aResult[0] = 0, 0, $tUTC)
EndFunc   ;==>_Date_Time_TzSpecificLocalTimeToSystemTime
Func _ATan2(Const $nY, Const $nX)
	Const $nPi = 3.14159265358979323846264338328
	Local $nResult
	; Check if given numeric arguments
	If IsNumber($nY) = 0 Then
		SetError(1)
		Return 0
	ElseIf IsNumber($nX) = 0 Then
		SetError(1)
		Return 0
	EndIf
	If $nX = 0 Then
		If $nY > 0 Then
			$nResult = $nPi / 2.0
		ElseIf $nY < 0 Then
			$nResult = 3.0 * $nPi / 2.0
		Else
			SetError(2) 	; no direction can be determined.
			Return 0
		EndIf
	ElseIf $nX < 0 Then
		$nResult = ATan($nY / $nX) + $nPi
	Else
		$nResult = ATan($nY / $nX)
	EndIf
	While $nResult < 0
		$nResult += 2.0 * $nPi
	WEnd
	Return $nResult
EndFunc   ;==>_ATan2
Func _Degree($nRadians)
	If Not IsNumber($nRadians) Then
		SetError(1)
		Return ""
	EndIf
	Return $nRadians * 57.2957795130823
EndFunc   ;==>_Degree
Func _MathCheckDiv($i_NumA, $i_NumB = 2)
	If Number($i_NumA) = 0 Or Number($i_NumB) = 0 Or Int($i_NumA) <> $i_NumA Or Int($i_NumB) <> $i_NumB Then
		Return -1
		SetError(1)
	ElseIf Int($i_NumA / $i_NumB) <> $i_NumA / $i_NumB Then
		Return 1
	Else
		Return 2
	EndIf
EndFunc   ;==>_MathCheckDiv
Func _Max($nNum1, $nNum2)
	; Check to see if the parameters are indeed numbers of some sort.
	If (Not IsNumber($nNum1)) Then
		SetError(1)
		Return (0)
	EndIf
	If (Not IsNumber($nNum2)) Then
		SetError(2)
		Return (0)
	EndIf
	If $nNum1 > $nNum2 Then
		Return $nNum1
	Else
		Return $nNum2
	EndIf
EndFunc   ;==>_Max
Func _Min($nNum1, $nNum2)
	; Check to see if the parameters are indeed numbers of some sort.
	If (Not IsNumber($nNum1)) Then
		SetError(1)
		Return (0)
	EndIf
	If (Not IsNumber($nNum2)) Then
		SetError(2)
		Return (0)
	EndIf
	If $nNum1 > $nNum2 Then
		Return $nNum2
	Else
		Return $nNum1
	EndIf
EndFunc   ;==>_Min
Func _Radian($nDegrees)
	If Not Number($nDegrees) Then
		SetError(1)
		Return ""
	EndIf
	Return $nDegrees / 57.2957795130823
EndFunc   ;==>_Radian
Global Const $WS_TILED = 0
Global Const $WS_OVERLAPPED = 0
Global Const $WS_MAXIMIZEBOX = 0x00010000
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_TABSTOP = 0x00010000
Global Const $WS_GROUP = 0x00020000
Global Const $WS_SIZEBOX = 0x00040000
Global Const $WS_THICKFRAME = 0x00040000
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_HSCROLL = 0x00100000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_DLGFRAME = 0x00400000
Global Const $WS_BORDER = 0x00800000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_OVERLAPPEDWINDOW = 0x00CF0000
Global Const $WS_TILEDWINDOW = 0x00CF0000
Global Const $WS_MAXIMIZE = 0x01000000
Global Const $WS_CLIPCHILDREN = 0x02000000
Global Const $WS_CLIPSIBLINGS = 0x04000000
Global Const $WS_DISABLED = 0x08000000
Global Const $WS_VISIBLE = 0x10000000
Global Const $WS_MINIMIZE = 0x20000000
Global Const $WS_CHILD = 0x40000000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_POPUPWINDOW = 0x80880000
Global Const $DS_MODALFRAME = 0x80
Global Const $DS_SETFOREGROUND = 0x00000200
Global Const $DS_CONTEXTHELP = 0x00002000
Global Const $WS_EX_ACCEPTFILES = 0x00000010
Global Const $WS_EX_MDICHILD = 0x00000040
Global Const $WS_EX_APPWINDOW = 0x00040000
Global Const $WS_EX_CLIENTEDGE = 0x00000200
Global Const $WS_EX_CONTEXTHELP = 0x00000400
Global Const $WS_EX_DLGMODALFRAME = 0x00000001
Global Const $WS_EX_LEFTSCROLLBAR = 0x00004000
Global Const $WS_EX_OVERLAPPEDWINDOW = 0x00000300
Global Const $WS_EX_RIGHT = 0x00001000
Global Const $WS_EX_STATICEDGE = 0x00020000
Global Const $WS_EX_TOOLWINDOW = 0x00000080
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $WS_EX_TRANSPARENT = 0x00000020
Global Const $WS_EX_WINDOWEDGE = 0x00000100
Global Const $WS_EX_LAYERED = 0x00080000
Global Const $WS_EX_CONTROLPARENT = 0x10000
Global Const $WS_EX_LAYOUTRTL = 0x400000
Global Const $WS_EX_RTLREADING = 0x2000
Global Const $WM_GETTEXTLENGTH = 0x000E
Global Const $WM_GETTEXT = 0x000D
Global Const $WM_SIZE = 0x05
Global Const $WM_SIZING = 0x0214
Global Const $WM_USER = 0X400
Global Const $WM_CREATE = 0x0001
Global Const $WM_DESTROY = 0x0002
Global Const $WM_MOVE = 0x0003
Global Const $WM_ACTIVATE = 0x0006
Global Const $WM_SETFOCUS = 0x0007
Global Const $WM_KILLFOCUS = 0x0008
Global Const $WM_ENABLE = 0x000A
Global Const $WM_SETREDRAW = 0x000B
Global Const $WM_SETTEXT = 0x000C
Global Const $WM_PAINT = 0x000F
Global Const $WM_CLOSE = 0x0010
Global Const $WM_QUIT = 0x0012
Global Const $WM_ERASEBKGND = 0x0014
Global Const $WM_SYSCOLORCHANGE = 0x0015
Global Const $WM_SHOWWINDOW = 0x0018
Global Const $WM_WININICHANGE = 0x001A
Global Const $WM_DEVMODECHANGE = 0x001B
Global Const $WM_ACTIVATEAPP = 0x001C
Global Const $WM_FONTCHANGE = 0x001D
Global Const $WM_TIMECHANGE = 0x001E
Global Const $WM_CANCELMODE = 0x001F
Global Const $WM_SETCURSOR = 0x0020
Global Const $WM_MOUSEACTIVATE = 0x0021
Global Const $WM_CHILDACTIVATE = 0x0022
Global Const $WM_QUEUESYNC = 0x0023
Global Const $WM_GETMINMAXINFO = 0x0024
Global Const $WM_PAINTICON = 0x0026
Global Const $WM_ICONERASEBKGND = 0x0027
Global Const $WM_NEXTDLGCTL = 0x0028
Global Const $WM_SPOOLERSTATUS = 0x002A
Global Const $WM_DRAWITEM = 0x002B
Global Const $WM_MEASUREITEM = 0x002C
Global Const $WM_DELETEITEM = 0x002D
Global Const $WM_VKEYTOITEM = 0x002E
Global Const $WM_CHARTOITEM = 0x002F
Global Const $WM_SETFONT = 0x0030
Global Const $WM_GETFONT = 0x0031
Global Const $WM_SETHOTKEY = 0x0032
Global Const $WM_GETHOTKEY = 0x0033
Global Const $WM_QUERYDRAGICON = 0x0037
Global Const $WM_COMPAREITEM = 0x0039
Global Const $WM_GETOBJECT = 0x003D
Global Const $WM_COMPACTING = 0x0041
Global Const $WM_COMMNOTIFY = 0x0044
Global Const $WM_WINDOWPOSCHANGING = 0x0046
Global Const $WM_WINDOWPOSCHANGED = 0x0047
Global Const $WM_POWER = 0x0048
Global Const $WM_NOTIFY = 0x004E
Global Const $WM_COPYDATA = 0x004A
Global Const $WM_CANCELJOURNAL = 0x004B
Global Const $WM_INPUTLANGCHANGEREQUEST = 0x0050
Global Const $WM_INPUTLANGCHANGE = 0x0051
Global Const $WM_TCARD = 0x0052
Global Const $WM_HELP = 0x0053
Global Const $WM_USERCHANGED = 0x0054
Global Const $WM_NOTIFYFORMAT = 0x0055
Global Const $WM_CUT = 0x00000300
Global Const $WM_COPY = 0x00000301
Global Const $WM_PASTE = 0x00000302
Global Const $WM_CLEAR = 0x00000303
Global Const $WM_UNDO = 0x304
Global Const $WM_CONTEXTMENU = 0x007B
Global Const $WM_STYLECHANGING = 0x007C
Global Const $WM_STYLECHANGED = 0x007D
Global Const $WM_DISPLAYCHANGE = 0x007E
Global Const $WM_GETICON = 0x007F
Global Const $WM_SETICON = 0x0080
Global Const $WM_NCCREATE = 0x0081
Global Const $WM_NCDESTROY = 0x0082
Global Const $WM_NCCALCSIZE = 0x0083
Global Const $WM_NCHITTEST = 0x0084
Global Const $WM_NCPAINT = 0x0085
Global Const $WM_NCACTIVATE = 0x0086
Global Const $WM_GETDLGCODE = 0x0087
Global Const $WM_SYNCPAINT = 0x0088
Global Const $WM_NCMOUSEMOVE = 0x00A0
Global Const $WM_NCLBUTTONDOWN = 0x00A1
Global Const $WM_NCLBUTTONUP = 0x00A2
Global Const $WM_NCLBUTTONDBLCLK = 0x00A3
Global Const $WM_NCRBUTTONDOWN = 0x00A4
Global Const $WM_NCRBUTTONUP = 0x00A5
Global Const $WM_NCRBUTTONDBLCLK = 0x00A6
Global Const $WM_NCMBUTTONDOWN = 0x00A7
Global Const $WM_NCMBUTTONUP = 0x00A8
Global Const $WM_NCMBUTTONDBLCLK = 0x00A9
Global Const $WM_KEYDOWN = 0x0100
Global Const $WM_KEYUP = 0x0101
Global Const $WM_CHAR = 0x0102
Global Const $WM_DEADCHAR = 0x0103
Global Const $WM_SYSKEYDOWN = 0x0104
Global Const $WM_SYSKEYUP = 0x0105
Global Const $WM_SYSCHAR = 0x0106
Global Const $WM_SYSDEADCHAR = 0x0107
Global Const $WM_INITDIALOG = 0x0110
Global Const $WM_COMMAND = 0x0111
Global Const $WM_SYSCOMMAND = 0x0112
Global Const $WM_TIMER = 0x0113
Global Const $WM_HSCROLL = 0x0114
Global Const $WM_VSCROLL = 0x0115
Global Const $WM_INITMENU = 0x0116
Global Const $WM_INITMENUPOPUP = 0x0117
Global Const $WM_MENUSELECT = 0x011F
Global Const $WM_MENUCHAR = 0x0120
Global Const $WM_ENTERIDLE = 0x0121
Global Const $WM_MENURBUTTONUP = 0x0122
Global Const $WM_MENUDRAG = 0x0123
Global Const $WM_MENUGETOBJECT = 0x0124
Global Const $WM_UNINITMENUPOPUP = 0x0125
Global Const $WM_MENUCOMMAND = 0x0126
Global Const $WM_CHANGEUISTATE = 0x0127
Global Const $WM_UPDATEUISTATE = 0x0128
Global Const $WM_QUERYUISTATE = 0x0129
Global Const $WM_CTLCOLORMSGBOX = 0x0132
Global Const $WM_CTLCOLOREDIT = 0x0133
Global Const $WM_CTLCOLORLISTBOX = 0x0134
Global Const $WM_CTLCOLORBTN = 0x0135
Global Const $WM_CTLCOLORDLG = 0x0136
Global Const $WM_CTLCOLORSCROLLBAR = 0x0137
Global Const $WM_CTLCOLORSTATIC = 0x0138
Global Const $WM_CTLCOLOR = 0x19
Global Const $MN_GETHMENU = 0x01E1
Global Const $NM_FIRST = 0
Global Const $NM_OUTOFMEMORY = $NM_FIRST - 1
Global Const $NM_CLICK = $NM_FIRST - 2
Global Const $NM_DBLCLK = $NM_FIRST - 3
Global Const $NM_RETURN = $NM_FIRST - 4
Global Const $NM_RCLICK = $NM_FIRST - 5
Global Const $NM_RDBLCLK = $NM_FIRST - 6
Global Const $NM_SETFOCUS = $NM_FIRST - 7
Global Const $NM_KILLFOCUS = $NM_FIRST - 8
Global Const $NM_CUSTOMDRAW = $NM_FIRST - 12
Global Const $NM_HOVER = $NM_FIRST - 13
Global Const $NM_NCHITTEST = $NM_FIRST - 14
Global Const $NM_KEYDOWN = $NM_FIRST - 15
Global Const $NM_RELEASEDCAPTURE = $NM_FIRST - 16
Global Const $NM_SETCURSOR = $NM_FIRST - 17
Global Const $NM_CHAR = $NM_FIRST - 18
Global Const $NM_TOOLTIPSCREATED = $NM_FIRST - 19
Global Const $NM_LDOWN = $NM_FIRST - 20
Global Const $NM_RDOWN = $NM_FIRST - 21
Global Const $NM_THEMECHANGED = $NM_FIRST - 22
Global Const $WM_LBUTTONUP = 0x202
Global Const $WM_MOUSEMOVE = 0x200
Global Const $PS_SOLID = 0
Global Const $PS_DASH = 1
Global Const $PS_DOT = 2
Global Const $PS_DASHDOT = 3
Global Const $PS_DASHDOTDOT = 4
Global Const $PS_NULL = 5
Global Const $PS_INSIDEFRAME = 6
Global Const $RGN_AND = 1
Global Const $RGN_OR = 2
Global Const $RGN_XOR = 3
Global Const $RGN_DIFF = 4
Global Const $RGN_COPY = 5
Global Const $ERROR = 0
Global Const $NULLREGION = 1
Global Const $SIMPLEREGION = 2
Global Const $COMPLEXREGION = 3
Global Const $TRANSPARENT = 1
Global Const $OPAQUE = 2
Global Const $CCM_FIRST = 0x2000
Global Const $CCM_GETUNICODEFORMAT = ($CCM_FIRST + 6)
Global Const $CCM_SETUNICODEFORMAT = ($CCM_FIRST + 5)
Global Const $CCM_SETBKCOLOR = $CCM_FIRST + 1
Global Const $CCM_SETCOLORSCHEME = $CCM_FIRST + 2
Global Const $CCM_GETCOLORSCHEME = $CCM_FIRST + 3
Global Const $CCM_GETDROPTARGET = $CCM_FIRST + 4
Global Const $CCM_SETWINDOWTHEME = $CCM_FIRST + 11
Global Const $GA_PARENT = 1
Global Const $GA_ROOT = 2
Global Const $GA_ROOTOWNER = 3
Global Const $SM_CXSCREEN = 0
Global Const $SM_CYSCREEN = 1
Global Const $SM_CXVSCROLL = 2
Global Const $SM_CYHSCROLL = 3
Global Const $SM_CYCAPTION = 4
Global Const $SM_CXBORDER = 5
Global Const $SM_CYBORDER = 6
Global Const $SM_CXDLGFRAME = 7
Global Const $SM_CYDLGFRAME = 8
Global Const $SM_CYVTHUMB = 9
Global Const $SM_CXHTHUMB = 10
Global Const $SM_CXICON = 11
Global Const $SM_CYICON = 12
Global Const $SM_CXCURSOR = 13
Global Const $SM_CYCURSOR = 14
Global Const $SM_CYMENU = 15
Global Const $SM_CXFULLSCREEN = 16
Global Const $SM_CYFULLSCREEN = 17
Global Const $SM_CYKANJIWINDOW = 18
Global Const $SM_MOUSEPRESENT = 19
Global Const $SM_CYVSCROLL = 20
Global Const $SM_CXHSCROLL = 21
Global Const $SM_DEBUG = 22
Global Const $SM_SWAPBUTTON = 23
Global Const $SM_RESERVED1 = 24
Global Const $SM_RESERVED2 = 25
Global Const $SM_RESERVED3 = 26
Global Const $SM_RESERVED4 = 27
Global Const $SM_CXMIN = 28
Global Const $SM_CYMIN = 29
Global Const $SM_CXSIZE = 30
Global Const $SM_CYSIZE = 31
Global Const $SM_CXFRAME = 32
Global Const $SM_CYFRAME = 33
Global Const $SM_CXMINTRACK = 34
Global Const $SM_CYMINTRACK = 35
Global Const $SM_CXDOUBLECLK = 36
Global Const $SM_CYDOUBLECLK = 37
Global Const $SM_CXICONSPACING = 38
Global Const $SM_CYICONSPACING = 39
Global Const $SM_MENUDROPALIGNMENT = 40
Global Const $SM_PENWINDOWS = 41
Global Const $SM_DBCSENABLED = 42
Global Const $SM_CMOUSEBUTTONS = 43
Global Const $SM_SECURE = 44
Global Const $SM_CXEDGE = 45
Global Const $SM_CYEDGE = 46
Global Const $SM_CXMINSPACING = 47
Global Const $SM_CYMINSPACING = 48
Global Const $SM_CXSMICON = 49
Global Const $SM_CYSMICON = 50
Global Const $SM_CYSMCAPTION = 51
Global Const $SM_CXSMSIZE = 52
Global Const $SM_CYSMSIZE = 53
Global Const $SM_CXMENUSIZE = 54
Global Const $SM_CYMENUSIZE = 55
Global Const $SM_ARRANGE = 56
Global Const $SM_CXMINIMIZED = 57
Global Const $SM_CYMINIMIZED = 58
Global Const $SM_CXMAXTRACK = 59
Global Const $SM_CYMAXTRACK = 60
Global Const $SM_CXMAXIMIZED = 61
Global Const $SM_CYMAXIMIZED = 62
Global Const $SM_NETWORK = 63
Global Const $SM_CLEANBOOT = 67
Global Const $SM_CXDRAG = 68
Global Const $SM_CYDRAG = 69
Global Const $SM_SHOWSOUNDS = 70
Global Const $SM_CXMENUCHECK = 71
Global Const $SM_CYMENUCHECK = 72
Global Const $SM_SLOWMACHINE = 73
Global Const $SM_MIDEASTENABLED = 74
Global Const $SM_MOUSEWHEELPRESENT = 75
Global Const $SM_XVIRTUALSCREEN = 76
Global Const $SM_YVIRTUALSCREEN = 77
Global Const $SM_CXVIRTUALSCREEN = 78
Global Const $SM_CYVIRTUALSCREEN = 79
Global Const $SM_CMONITORS = 80
Global Const $SM_SAMEDISPLAYFORMAT = 81
Global Const $SM_IMMENABLED = 82
Global Const $SM_CXFOCUSBORDER = 83
Global Const $SM_CYFOCUSBORDER = 84
Global Const $SM_TABLETPC = 86
Global Const $SM_MEDIACENTER = 87
Global Const $SM_STARTER = 88
Global Const $SM_SERVERR2 = 89
Global Const $SM_CMETRICS = 90
Global Const $SM_REMOTESESSION = 0x1000
Global Const $SM_SHUTTINGDOWN = 0x2000
Global Const $SM_REMOTECONTROL = 0x2001
Global Const $SM_CARETBLINKINGENABLED = 0x2002
Global Const $BLACKNESS = 0x00000042 ; Fills the destination rectangle using the color associated with index 0 in the physical palette
Global Const $CAPTUREBLT = 0X40000000 ; Includes any window that are layered on top of your window in the resulting image
Global Const $DSTINVERT = 0x00550009 ; Inverts the destination rectangle
Global Const $MERGECOPY = 0x00C000CA ; Copies the inverted source rectangle to the destination
Global Const $MERGEPAINT = 0x00BB0226 ; Merges the color of the inverted source rectangle with the colors of the destination rectangle by using the OR operator
Global Const $NOMIRRORBITMAP = 0X80000000 ; Prevents the bitmap from being mirrored
Global Const $NOTSRCCOPY = 0x00330008 ; Copies the inverted source rectangle to the destination
Global Const $NOTSRCERASE = 0x001100A6 ; Combines the colors of the source and destination rectangles by using the Boolean OR operator and then inverts the resultant color
Global Const $PATCOPY = 0x00F00021 ; Copies the brush selected in hdcDest, into the destination bitmap
Global Const $PATINVERT = 0x005A0049 ; Combines the colors of the brush currently selected  in  hDest,  with  the  colors  of  the destination rectangle by using the XOR operator
Global Const $PATPAINT = 0x00FB0A09 ; Combines the colors of the brush currently selected  in  hDest,  with  the  colors  of  the inverted source rectangle by using the OR operator
Global Const $SRCAND = 0x008800C6 ; Combines the colors of the source and destination rectangles by using the Boolean AND operator
Global Const $SRCCOPY = 0x00CC0020 ; Copies the source rectangle directly to the destination rectangle
Global Const $SRCERASE = 0x00440328 ; Combines the inverted colors of the destination rectangle with the colors of the source rectangle by using the Boolean AND operator
Global Const $SRCINVERT = 0x00660046 ; Combines the colors of the source and destination rectangles by using the Boolean XOR operator
Global Const $SRCPAINT = 0x00EE0086 ; Combines the colors of the source and destination rectangles by using the Boolean OR operator
Global Const $WHITENESS = 0x00FF0062 ; Fills the destination rectangle using the color associated with index 1 in the physical palette
Global Const $DT_BOTTOM = 0x8
Global Const $DT_CALCRECT = 0x400
Global Const $DT_CENTER = 0x1
Global Const $DT_EDITCONTROL = 0x2000
Global Const $DT_END_ELLIPSIS = 0x8000
Global Const $DT_EXPANDTABS = 0x40
Global Const $DT_EXTERNALLEADING = 0x200
Global Const $DT_HIDEPREFIX = 0x100000
Global Const $DT_INTERNAL = 0x1000
Global Const $DT_LEFT = 0x0
Global Const $DT_MODIFYSTRING = 0x10000
Global Const $DT_NOCLIP = 0x100
Global Const $DT_NOFULLWIDTHCHARBREAK = 0x80000
Global Const $DT_NOPREFIX = 0x800
Global Const $DT_PATH_ELLIPSIS = 0x4000
Global Const $DT_PREFIXONLY = 0x200000
Global Const $DT_RIGHT = 0x2
Global Const $DT_RTLREADING = 0x20000
Global Const $DT_SINGLELINE = 0x20
Global Const $DT_TABSTOP = 0x80
Global Const $DT_TOP = 0x0
Global Const $DT_VCENTER = 0x4
Global Const $DT_WORDBREAK = 0x10
Global Const $DT_WORD_ELLIPSIS = 0x40000
Global Const $RDW_ERASE = 0x0004 ; Causes the window to receive a WM_ERASEBKGND message when the window is repainted
Global Const $RDW_FRAME = 0x0400 ; Causes any part of the nonclient area of the window that intersects the update region to receive a WM_NCPAINT message
Global Const $RDW_INTERNALPAINT = 0x0002 ; Causes a WM_PAINT message to be posted to the window regardless of whether any portion of the window is invalid
Global Const $RDW_INVALIDATE = 0x0001 ; Invalidates DllStructGetData($tRect or $hRegion, "") If both are 0, the entire window is invalidated
Global Const $RDW_NOERASE = 0x0020 ; Suppresses any pending WM_ERASEBKGND messages
Global Const $RDW_NOFRAME = 0x0800 ; Suppresses any pending WM_NCPAINT messages
Global Const $RDW_NOINTERNALPAINT = 0x0010 ; Suppresses any pending internal WM_PAINT messages
Global Const $RDW_VALIDATE = 0x0008 ; Validates Rect or hRegion
Global Const $RDW_ERASENOW = 0x0200 ; Causes the affected windows to receive WM_NCPAINT and WM_ERASEBKGND messages
Global Const $RDW_UPDATENOW = 0x0100 ; Causes the affected windows to receive WM_NCPAINT, WM_ERASEBKGND, and WM_PAINT messages
Global Const $RDW_ALLCHILDREN = 0x0080 ; Includes child windows in the repainting operation
Global Const $RDW_NOCHILDREN = 0x0040 ; Excludes child windows from the repainting operation
Global Const $WM_RENDERFORMAT = 0x00000305 ; Sent if the owner has delayed rendering a specific clipboard format
Global Const $WM_RENDERALLFORMATS = 0x00000306 ; Sent if the owner has delayed rendering clipboard formats
Global Const $WM_DESTROYCLIPBOARD = 0x00000307 ; Sent when a call to EmptyClipboard empties the clipboard
Global Const $WM_DRAWCLIPBOARD = 0x00000308 ; Sent when the content of the clipboard changes
Global Const $WM_PAINTCLIPBOARD = 0x00000309 ; Sent when the clipboard viewer's client area needs repainting
Global Const $WM_VSCROLLCLIPBOARD = 0x0000030A ; Sent when an event occurs in the viewer's vertical scroll bar
Global Const $WM_SIZECLIPBOARD = 0x0000030B ; Sent when the clipboard viewer's client area has changed size
Global Const $WM_ASKCBFORMATNAME = 0x0000030C ; Sent to request the name of a $CF_OWNERDISPLAY clipboard format
Global Const $WM_CHANGECBCHAIN = 0x0000030D ; Sent when a window is being removed from the chain
Global Const $WM_HSCROLLCLIPBOARD = 0x0000030E ; Sent when an event occurs in the viewer's horizontal scroll bar
Global Const $HTERROR = -2
Global Const $HTTRANSPARENT = -1
Global Const $HTNOWHERE = 0
Global Const $HTCLIENT = 1
Global Const $HTCAPTION = 2
Global Const $HTSYSMENU = 3
Global Const $HTGROWBOX = 4
Global Const $HTSIZE = $HTGROWBOX
Global Const $HTMENU = 5
Global Const $HTHSCROLL = 6
Global Const $HTVSCROLL = 7
Global Const $HTMINBUTTON = 8
Global Const $HTMAXBUTTON = 9
Global Const $HTLEFT = 10
Global Const $HTRIGHT = 11
Global Const $HTTOP = 12
Global Const $HTTOPLEFT = 13
Global Const $HTTOPRIGHT = 14
Global Const $HTBOTTOM = 15
Global Const $HTBOTTOMLEFT = 16
Global Const $HTBOTTOMRIGHT = 17
Global Const $HTBORDER = 18
Global Const $HTREDUCE = $HTMINBUTTON
Global Const $HTZOOM = $HTMAXBUTTON
Global Const $HTSIZEFIRST = $HTLEFT
Global Const $HTSIZELAST = $HTBOTTOMRIGHT
Global Const $HTOBJECT = 19
Global Const $HTCLOSE = 20
Global Const $HTHELP = 21
Global Const $COLOR_SCROLLBAR = 0
Global Const $COLOR_BACKGROUND = 1
Global Const $COLOR_ACTIVECAPTION = 2
Global Const $COLOR_INACTIVECAPTION = 3
Global Const $COLOR_MENU = 4
Global Const $COLOR_WINDOW = 5
Global Const $COLOR_WINDOWFRAME = 6
Global Const $COLOR_MENUTEXT = 7
Global Const $COLOR_WINDOWTEXT = 8
Global Const $COLOR_CAPTIONTEXT = 9
Global Const $COLOR_ACTIVEBORDER = 10
Global Const $COLOR_INACTIVEBORDER = 11
Global Const $COLOR_APPWORKSPACE = 12
Global Const $COLOR_HIGHLIGHT = 13
Global Const $COLOR_HIGHLIGHTTEXT = 14
Global Const $COLOR_BTNFACE = 15
Global Const $COLOR_BTNSHADOW = 16
Global Const $COLOR_GRAYTEXT = 17
Global Const $COLOR_BTNTEXT = 18
Global Const $COLOR_INACTIVECAPTIONTEXT = 19
Global Const $COLOR_BTNHIGHLIGHT = 20
Global Const $COLOR_3DDKSHADOW = 21
Global Const $COLOR_3DLIGHT = 22
Global Const $COLOR_INFOTEXT = 23
Global Const $COLOR_INFOBK = 24
Global Const $COLOR_HOTLIGHT = 26
Global Const $COLOR_GRADIENTACTIVECAPTION = 27
Global Const $COLOR_GRADIENTINACTIVECAPTION = 28
Global Const $COLOR_MENUHILIGHT = 29
Global Const $COLOR_MENUBAR = 30
Global Const $COLOR_DESKTOP = 1
Global Const $COLOR_3DFACE = 15
Global Const $COLOR_3DSHADOW = 16
Global Const $COLOR_3DHIGHLIGHT = 20
Global Const $COLOR_3DHILIGHT = 20
Global Const $COLOR_BTNHILIGHT = 20
Global Const $HINST_COMMCTRL = -1
Global Const $IDB_STD_SMALL_COLOR = 0
Global Const $IDB_STD_LARGE_COLOR = 1
Global Const $IDB_VIEW_SMALL_COLOR = 4
Global Const $IDB_VIEW_LARGE_COLOR = 5
Global Const $IDB_HIST_SMALL_COLOR = 8
Global Const $IDB_HIST_LARGE_COLOR = 9
Global Const $STARTF_FORCEOFFFEEDBACK = 0x80
Global Const $STARTF_FORCEONFEEDBACK = 0x40
Global Const $STARTF_RUNFULLSCREEN = 0x20
Global Const $STARTF_USECOUNTCHARS = 0x8
Global Const $STARTF_USEFILLATTRIBUTE = 0x10
Global Const $STARTF_USEHOTKEY = 0x200
Global Const $STARTF_USEPOSITION = 0x4
Global Const $STARTF_USESHOWWINDOW = 0x1
Global Const $STARTF_USESIZE = 0x2
Global Const $STARTF_USESTDHANDLES = 0x100
Global Const $CDDS_PREPAINT = 0x00000001
Global Const $CDDS_POSTPAINT = 0x00000002
Global Const $CDDS_PREERASE = 0x00000003
Global Const $CDDS_POSTERASE = 0x00000004
Global Const $CDDS_ITEM = 0x00010000
Global Const $CDDS_ITEMPREPAINT = 0x00010001
Global Const $CDDS_ITEMPOSTPAINT = 0x00010002
Global Const $CDDS_ITEMPREERASE = 0x00010003
Global Const $CDDS_ITEMPOSTERASE = 0x00010004
Global Const $CDDS_SUBITEM = 0x00020000
Global Const $CDIS_SELECTED = 0x00000001
Global Const $CDIS_GRAYED = 0x00000002
Global Const $CDIS_DISABLED = 0x00000004
Global Const $CDIS_CHECKED = 0x00000008
Global Const $CDIS_FOCUS = 0x00000010
Global Const $CDIS_DEFAULT = 0x00000020
Global Const $CDIS_HOT = 0x00000040
Global Const $CDIS_MARKED = 0x00000080
Global Const $CDIS_INDETERMINATE = 0x00000100
Global Const $CDIS_SHOWKEYBOARDCUES = 0x00000200
Global Const $CDIS_NEARHOT = 0x0400
Global Const $CDIS_OTHERSIDEHOT = 0x0800
Global Const $CDIS_DROPHILITED = 0x1000
Global Const $CDRF_DODEFAULT = 0x00000000
Global Const $CDRF_NEWFONT = 0x00000002
Global Const $CDRF_SKIPDEFAULT = 0x00000004
Global Const $CDRF_NOTIFYPOSTPAINT = 0x00000010
Global Const $CDRF_NOTIFYITEMDRAW = 0x00000020
Global Const $CDRF_NOTIFYSUBITEMDRAW = 0x00000020
Global Const $CDRF_NOTIFYPOSTERASE = 0x00000040
Global Const $CDRF_DOERASE = 0x00000008
Global Const $CDRF_SKIPPOSTPAINT = 0x00000100
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
Global Const $VERSION_NUMER = "2.8.11 beta"
Global Const $COPYRIGHT_DATE = "2009"
Global $ERROR_DECODE_HANDLING = ""
Global Const $EmptySizedArray = emptySizedArray()
Global Const $LENGTH_SIZED_ARRAY_INDEX = 0
If @Compiled Then
	Opt('TrayIconHide', 1)
Else
	Opt('TrayIconDebug', 1)
EndIf
Func size(ByRef $SizedArray)
	Return $SizedArray[0]
EndFunc   ;==>size
Func emptyQueue()
	Return _ArrayCreate(0)
EndFunc   ;==>emptyQueue
Func emptySizedArray()
	Return _ArrayCreate(0)
EndFunc   ;==>emptySizedArray
Func pop(ByRef $queue)
	$tmp = $queue[1]
	_ArrayDelete($queue, 1)
	$queue[0] -= 1
	Return $tmp
EndFunc   ;==>pop
Func push(ByRef $queue, $element)
	_ArrayAdd($queue, $element)
	$queue[0] += 1
EndFunc   ;==>push
Func insert(ByRef $queue, $element, $index)
	insertAfter($queue, $element, $index - 1)
EndFunc   ;==>insert
Func insertAfter(ByRef $queue, $element, $index)
	;Logging("inserting "&formulaItemToString($element)&" into a queue")
	If $index + 1 > size($queue) Then
		push($queue, $element)
	Else
		_ArrayInsert($queue, $index + 1, $element)
		$queue[0] += 1
	EndIf
EndFunc   ;==>insertAfter
Func insertSortedObj(ByRef $queue, $obj, $increasing = True)
	; Linear insertion... not that bad.
	For $i = 1 To size($queue)
		$el = $queue[$i]
		If $el[0] > $obj[0] And $increasing Then
			insert($queue, $obj, $i)
			Return
		EndIf
		If $el[0] < $obj[0] And Not $increasing Then
			insert($queue, $obj, $i)
			Return
		EndIf
	Next
	push($queue, $obj)
EndFunc   ;==>insertSortedObj
Func deleteAt(ByRef $queue, $index)
	If $index > $queue[0] Or $index < 1 Then
		Return
	Else
		_ArrayDelete($queue, $index)
		$queue[0] -= 1
	EndIf
EndFunc   ;==>deleteAt
Func indexOf(ByRef $queue, $element)
	For $i = 1 To $queue[0]
		If $queue[$i] == $element Then Return $i
	Next
	Return 0
EndFunc   ;==>indexOf
Func deleteElement(ByRef $queue, $element)
	deleteAt($queue, indexOf($queue, $element))
EndFunc   ;==>deleteElement
Func isEmpty(ByRef $queue)
	Return $queue[0] == 0
EndFunc   ;==>isEmpty
Func isNotEmpty(ByRef $queue)
	Return $queue[0] <> 0
EndFunc   ;==>isNotEmpty
Func toBasicArray(ByRef $queue)
	_ArrayDelete($queue, 0)
EndFunc   ;==>toBasicArray
Func arrayDiff($t1, $t2)
	Local $result[UBound($t1)]
	For $i = 0 To UBound($t1) - 1
		$result[$i] = $t1[$i] - $t2[$i]
	Next
	Return $result
EndFunc   ;==>arrayDiff
Func leftTopWithHeight_to_leftTopRightBottom($pos)
	$pos[2] = $pos[2] + $pos[0]
	$pos[3] = $pos[3] + $pos[1]
	Return $pos
EndFunc   ;==>leftTopWithHeight_to_leftTopRightBottom
Func leftTopRightBottom_to_leftTopWithHeight($pos)
	$pos[2] = $pos[2] - $pos[0]
	$pos[3] = $pos[3] - $pos[1]
	Return $pos
EndFunc   ;==>leftTopRightBottom_to_leftTopWithHeight
Func toString($element)
	Local $res = ""
	If IsArray($element) Then
		Local $first = True
		$res = "["
		For $el In $element
			If $first Then
				$res &= toString($el)
				$first = False
			Else
				$res &= ", " & toString($el)
			EndIf
		Next
		$res &= "]"
	ElseIf IsString($element) Then
		$res = """" & $element & """"
	Else
		$res = String($element)
	EndIf
	If Not IsArray($element) And StringLen($res) > 1000 Then
		$res = StringLeft($res, 1000) & "..."
	EndIf
	Return $res
EndFunc   ;==>toString
Func concatenate(ByRef $array, $array2)
	For $element In $array2
		_ArrayAdd($array, $element)
	Next
EndFunc   ;==>concatenate
Func makeFileName($str)
	$badchars = StringSplit('*?\/""|<>:', '')
	_ArrayDelete($badchars, 0)
	For $char In $badchars
		$str = StringReplace($str, $char, '')
	Next
	Return $str
EndFunc   ;==>makeFileName
Func reflexFileNameFromComment($formula_comment, $formula_filename, $reflex_extension)
	$comment = makeFileName($formula_comment)
	$pos = StringInStr($formula_filename, '\', 0, -1)
	While True
		If $pos == 0 Then ExitLoop
		$basefilename = StringMid($formula_filename, 1, $pos)
		$pos1 = StringInStr($reflex_extension, '.')
		If $pos1 == 0 Then ExitLoop
		$extension = StringMid($reflex_extension, $pos1, 4)
		Return $basefilename & $comment & $extension
	WEnd
	Return IniReadSaveBox('reflexFile', '')
EndFunc   ;==>reflexFileNameFromComment
Func FileBaseName($longFileName)
	Return StringRegExpReplace($longFileName, ".*\\", "")
EndFunc   ;==>FileBaseName
Func FileFolder($longFileName)
	Return StringLeft($longFileName, StringLen($longFileName) - StringLen(FileBaseName($longFileName)))
EndFunc   ;==>FileFolder
Func FileReplaceContent($file_name, $file_name_after, $to_search, $to_replace)
	$fi = FileOpen($file_name, 0)
	$fo = FileOpen($file_name_after & "_tmp", 2)
	While True
		$l = FileReadLine($fi)
		If @error <> 0 Then ExitLoop
		FileWriteLine($fo, StringReplace($l, $to_search, $to_replace))
	WEnd
	FileClose($fi)
	FileClose($fo)
	FileMove($file_name_after & "_tmp", $file_name_after, 1)
EndFunc   ;==>FileReplaceContent
Func ImageConvert($previous_image, $after_image)
	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($previous_image)
	_GDIPlus_ImageSaveToFile($hImage, $after_image)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
EndFunc   ;==>ImageConvert
Func Logging($str, $line = @ScriptLineNumber)
	If Not @Compiled Then
		ConsoleWrite("Line:" & $line & ": " & _NowCalc() & " : " & $str & @CRLF)
	EndIf
EndFunc   ;==>Logging
Func isChecked($ctrl)
	$state = GUICtrlRead($ctrl)
	Return BitAND($state, $GUI_CHECKED)
EndFunc   ;==>isChecked
Func check($ctrl, $checked)
  GUICtrlSetState($ctrl, _Iif($checked, $GUI_CHECKED, $GUI_UNCHECKED))
EndFunc   ;==>isChecked
Func SetFocus($hCtrl)
	GUICtrlSetState($hCtrl, $GUI_FOCUS)
EndFunc   ;==>SetFocus
Func ErrorDecodeAdd($string)
	logging("Adding '" & $string & "' to error string")
	$ERROR_DECODE_HANDLING &= @CRLF & $string
EndFunc   ;==>ErrorDecodeAdd
Func ErrorDecodeDisplay()
	ConsoleWriteError($ERROR_DECODE_HANDLING & @CRLF)
	logging("Error: " & $ERROR_DECODE_HANDLING)
	Return False
EndFunc   ;==>ErrorDecodeDisplay
Func createFlag($flag, $value)
	If $value <> "" Or Not IsString($value) Then
		If StringLeft($value, 1) == "-" Then
			Return StringFormat(' --%s " %s"', $flag, $value)
		Else
			Return StringFormat(' --%s "%s"', $flag, $value)
		EndIf
	Else
		Return StringFormat(' --%s', $flag)
	EndIf
EndFunc   ;==>createFlag
Func addFlag(ByRef $flags, $new_flag, $new_value = "")
	$flags = $flags & createFlag($new_flag, $new_value)
EndFunc   ;==>addFlag
Func isFormulaLine($line)
	Return StringCompare(StringLeft($line, 8), "formula:") == 0
EndFunc   ;==>isFormulaLine
Func extractFormulaLine($line)
	Return StringMid($line, 9)
EndFunc   ;==>extractFormulaLine
Func simplifyParenthesis($complex_number)
	While StringLeft($complex_number, 1) == '(' And StringRight($complex_number, 1) == ')'
		$complex_number = StringMid($complex_number, 2, StringLen($complex_number) - 2)
	WEnd
	Return $complex_number
EndFunc   ;==>simplifyParenthesis
Global $RenderReflexExe
Func runReflexWithArguments($args)
	$cmd = StringFormat("%s %s", $RenderReflexExe, $args)
	logging("Running " & $cmd)
	Local $pid = Run($cmd, '', @SW_HIDE, 2 + 4)
	Return $pid
EndFunc   ;==>runReflexWithArguments
Func complex_calculate($expr)
	;logging("Calculating "&$expr)
	Dim $flags = ""
	addFlag($flags, "simplify")
	addFlag($flags, "formula", $expr)
	;$flags = $formula_flag&$seed_flag
	$p = runReflexWithArguments($flags)
	$found = False
	$result = 0
	$text = ""
	While True ; Read everything
		$text = $text & StdoutRead($p)
		If @error Then ExitLoop
	WEnd
	$lines = StringSplit($text, @CRLF, 1)
	For $i = 1 To $lines[0]
		$current_line = $lines[$i]
		;Logging("Line to compare: "&$current_line)
		If isFormulaLine($current_line) Then
			;Logging("Formula!")
			$result = extractFormulaLine($current_line)
			$found = True
			ExitLoop
		EndIf
	Next
	ProcessClose($p)
	;logging("rr output={"&$text&"}")
	If Not $found Then
		logging(StringFormat("%s has not been simplified, retrying.", $expr))
		Return complex_calculate($expr)
	EndIf
	$result = simplifyParenthesis($result)
	Return $result
EndFunc   ;==>complex_calculate
Func getNumberOfProcessors()
	$test = 0
	While RegRead("HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\" & $test, "~MHz") <> ""
		$test += 1
	WEnd
	Return $test
EndFunc   ;==>getNumberOfProcessors
Func StringStartsWith($str, $start)
	Return StringCompare(StringLeft($str, StringLen($start)), $start) == 0
EndFunc   ;==>StringStartsWith
Func StringEndsWith($str, $end)
	Return StringCompare(StringRight($str, StringLen($end)), $end) == 0
EndFunc   ;==>StringEndsWith
Func StringContains($str, $char_str)
	For $i = 1 To StringLen($str)
		If StringInStr($char_str, StringMid($str, $i, 1)) Then Return True
	Next
	Return False
EndFunc   ;==>StringContains
Func replaceVariableString($string, $varname, $varvalue)
	$varname = StringReplace(StringStripWS($varname, 3), "$", "\$")
	If StringContains($varvalue, "+*-/()") Then $varvalue = "(" & $varvalue & ")"
	$string = StringRegExpReplace($string, $varname & "([^[:alnum:]]|\z)", $varvalue & "\1")
	Return $string
EndFunc   ;==>replaceVariableString
Func StringSizeMin($str, $length, $add_char = " ")
	While StringLen($str) < $length
		$str = $str & $add_char
	WEnd
	Return $str
EndFunc   ;==>StringSizeMin
Func UpdateMyDocuments($str)
	Return StringReplace($str, "%MY_DOCUMENTS%", @MyDocumentsDir)
EndFunc   ;==>UpdateMyDocuments
Func removeComments($string, $introductor = ";")
	$comments_replaced = $string
	Do
		$string = $comments_replaced
		$comments_replaced = StringRegExpReplace($string, "(\r?\n|\A)" & $introductor & "(?m).*(?:\r?\n|\z)", "\1")
	Until $comments_replaced == $string
	Return $comments_replaced
EndFunc   ;==>removeComments
Func _FileSaveDialog($sTitle, $sInitDir, $sFilter = 'All (*.*)', $iOpt = 0, $sDefFile = '', $iDefFilter = 1, $hWnd = 0)
	Local $iFileLen = 65536 ; Max chars in returned string
	; API flags prepare
	Local $iFlag = BitOR(BitShift(BitAND($iOpt, 2), -10), BitShift(BitAND($iOpt, 16), 3))
	; Filter string to array convertion
	If Not StringInStr($sFilter, '|') Then $sFilter &= '|*.*'
	$sFilter = StringRegExpReplace($sFilter, '|+', '|')
	Local $asFLines = StringSplit($sFilter, '|')
	Local $i, $suFilter = ''
	For $i = 1 To $asFLines[0] Step 2
		If $i < $asFLines[0] Then _
				$suFilter &= 'byte[' & StringLen($asFLines[$i]) + 1 & '];char[' & StringLen($asFLines[$i + 1]) + 1 & '];'
	Next
	; Create API structures
	Local $uOFN = DllStructCreate('dword;int;int;ptr;ptr;dword;dword;ptr;dword' & _
			';ptr;int;ptr;ptr;dword;short;short;ptr;ptr;ptr;ptr;ptr;dword;dword')
	Local $usTitle = DllStructCreate('char[' & StringLen($sTitle) + 1 & ']')
	Local $usInitDir = DllStructCreate('char[' & StringLen($sInitDir) + 1 & ']')
	Local $usFilter = DllStructCreate($suFilter & 'byte')
	Local $usFile = DllStructCreate('char[' & $iFileLen & ']')
	Local $usExtn = DllStructCreate('char[1]')
	For $i = 1 To $asFLines[0]
		DllStructSetData($usFilter, $i, $asFLines[$i])
	Next
	; Set Data of API structures
	DllStructSetData($usTitle, 1, $sTitle)
	DllStructSetData($usInitDir, 1, $sInitDir)
	DllStructSetData($usFile, 1, $sDefFile)
	DllStructSetData($usExtn, 1, "")
	DllStructSetData($uOFN, 1, DllStructGetSize($uOFN))
	DllStructSetData($uOFN, 2, $hWnd)
	DllStructSetData($uOFN, 4, DllStructGetPtr($usFilter))
	DllStructSetData($uOFN, 7, $iDefFilter)
	DllStructSetData($uOFN, 8, DllStructGetPtr($usFile))
	DllStructSetData($uOFN, 9, $iFileLen)
	DllStructSetData($uOFN, 12, DllStructGetPtr($usInitDir))
	DllStructSetData($uOFN, 13, DllStructGetPtr($usTitle))
	DllStructSetData($uOFN, 14, $iFlag)
	DllStructSetData($uOFN, 17, DllStructGetPtr($usExtn))
	DllStructSetData($uOFN, 23, BitShift(BitAND($iOpt, 32), 5))
	;Set Timer to check FileName Input for file extension
	Local $hCallBack = DllCallbackRegister("_Check_FSD_Input", "none", "hwnd;int;int;dword")
	Local $ahTimer = DllCall("user32.dll", "int", "SetTimer", "hwnd", 0, _
			"int", TimerInit(), "int", 100, "ptr", DllCallbackGetPtr($hCallBack))
	; Call API function
	Local $aRet = DllCall('comdlg32.dll', 'int', 'GetSaveFileName', 'ptr', DllStructGetPtr($uOFN))
	;Free CallBack and kill the timer
	DllCallbackFree($hCallBack)
	DllCall("user32.dll", "int", "KillTimer", "hwnd", 0, "int", $ahTimer)
	If Not IsArray($aRet) Or Not $aRet[0] Then Return SetError(1, 0, "")
	;Return Results
	Local $sRet = StringStripWS(DllStructGetData($usFile, 1), 3)
	Return SetExtended(DllStructGetData($uOFN, 7), $sRet) ;@extended is the 1-based index of selected filter
EndFunc   ;==>_FileSaveDialog
Func _Check_FSD_Input($hWndGUI, $MsgID, $WParam, $LParam)
	Local $sSaveAs_hWnd = _WinGetHandleEx(@AutoItPID, "#32770", "", "FolderView")
	If ControlGetFocus($sSaveAs_hWnd) = "Edit1" Then Return
	Local $sEdit_Data = ControlGetText($sSaveAs_hWnd, "", "Edit1")
	Local $sFilter_Ext = ControlCommand($sSaveAs_hWnd, "", "ComboBox3", "GetCurrentSelection")
	$sFilter_Ext = StringRegExpReplace($sFilter_Ext, ".*\(\*(.*?)\)$", "\1")
	If $sFilter_Ext = ".*" Then
		$sFilter_Ext = ""
	ElseIf Not StringInStr($sFilter_Ext, ".") Then
		Return
	EndIf
	Local $sEdit_Ext = StringRegExpReplace($sEdit_Data, "^.*\.", ".")
	If $sEdit_Ext <> $sFilter_Ext And ($sEdit_Ext <> $sEdit_Data Or $sFilter_Ext <> "") Then
		$sEdit_Data = StringRegExpReplace($sEdit_Data, "\.[^.]*$", "")
		ControlSetText($sSaveAs_hWnd, "", "Edit1", $sEdit_Data & $sFilter_Ext)
	EndIf
EndFunc   ;==>_Check_FSD_Input
Func _WinGetHandleEx($iPID, $sClassNN = "", $sPartTitle = "", $sText = "", $iVisibleOnly = 1)
	If IsString($iPID) Then $iPID = ProcessExists($iPID)
	Local $aWList = WinList("[CLASS:" & $sClassNN & ";REGEXPTITLE:(?i).*" & $sPartTitle & ".*]", $sText)
	If @error Then Return SetError(1, 0, "")
	For $i = 1 To $aWList[0][0]
		If WinGetProcess($aWList[$i][1]) = $iPID And (Not $iVisibleOnly Or _
				($iVisibleOnly And BitAND(WinGetState($aWList[$i][1]), 2))) Then Return $aWList[$i][1]
	Next
	Return SetError(2, 0, "")
EndFunc   ;==>_WinGetHandleEx
Func AnimateFadeIn($win)
	WinSetTrans($win, "", 0)
	GUISetState(@SW_SHOW, $win)
	Local $delay = 500
	Local $init = TimerInit()
	Do
		$d = TimerDiff($init)
		WinSetTrans($win, "", _Max($d * 255 / $delay, 255))
	Until $d > $delay
	WinSetTrans($win, "", 255)
EndFunc   ;==>AnimateFadeIn
Func AnimateFadeOut($win)
	For $i = 255 To 0 Step 5
		WinSetTrans($win, "", $i)
	Next
EndFunc   ;==>AnimateFadeOut
Func AnimateFromTopLeft($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 200, "long", 0x00040005);diag slide-in from Top-left
	GUISetState(@SW_SHOW, $win)
EndFunc   ;==>AnimateFromTopLeft
Func AnimateToTopRight($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 200, "long", 0x00050009);diag slide-out to Top-Right
EndFunc   ;==>AnimateToTopRight
Func AnimateToBottomRight($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 200, "long", 0x00050005);diag slide-out to Bottom-right
EndFunc   ;==>AnimateToBottomRight
Func AnimateFromTop($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 100, "long", 0x00040004);diag slide-in from Top
	GUISetState(@SW_SHOW, $win)
EndFunc   ;==>AnimateFromTop
Func AnimateToTop($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 100, "long", 0x00050008);slide-out to Top
EndFunc   ;==>AnimateToTop
Func AnimateFromLeft($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 100, "long", 0x00040001);slide in from left
EndFunc   ;==>AnimateFromLeft
Func AnimateToLeft($win)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $win, "int", 100, "long", 0x00050002);slide out to left
EndFunc   ;==>AnimateToLeft
Func move_ltrb(ByRef $pos_child_ltrb, ByRef $pos_before_ltrb, ByRef $pos_after_ltrb)
	Local $x_dep = 0, $y_dep = 0
	;If the window can be hit if the window moves left or right
	;logging(toString($pos_child_ltrb)&","&toString($pos_before_ltrb)&","&toString($pos_after_ltrb))
	If Not ($pos_child_ltrb[3] <= $pos_before_ltrb[1] Or $pos_child_ltrb[1] >= $pos_before_ltrb[3]) Then
		If $pos_child_ltrb[2] <= $pos_before_ltrb[0] Then $x_dep = $pos_after_ltrb[0] - $pos_before_ltrb[0]
		If $pos_child_ltrb[0] >= $pos_before_ltrb[2] Then $x_dep = $pos_after_ltrb[2] - $pos_before_ltrb[2]
	Else
		$x_dep = ($pos_after_ltrb[0] - $pos_before_ltrb[0] + $pos_after_ltrb[2] - $pos_before_ltrb[2]) / 2
	EndIf
	;If the window can be hit if the window moves top or bottom
	If Not ($pos_child_ltrb[2] <= $pos_before_ltrb[0] Or $pos_child_ltrb[0] >= $pos_before_ltrb[2]) Then
		If $pos_child_ltrb[3] <= $pos_before_ltrb[1] Then $y_dep = $pos_after_ltrb[1] - $pos_before_ltrb[1]
		If $pos_child_ltrb[1] >= $pos_before_ltrb[3] Then $y_dep = $pos_after_ltrb[3] - $pos_before_ltrb[3]
	Else
		$y_dep = ($pos_after_ltrb[1] - $pos_before_ltrb[1] + $pos_after_ltrb[3] - $pos_before_ltrb[3]) / 2
	EndIf
	$pos_child_ltrb[0] += $x_dep
	$pos_child_ltrb[2] += $x_dep
	$pos_child_ltrb[1] += $y_dep
	$pos_child_ltrb[3] += $y_dep
EndFunc   ;==>move_ltrb
Global Const $global_timer = TimerInit()
Global $global_timeout_functions = emptySizedArray()
Global Enum $N_Timeout_Timer, $N_Timeout_FunctionName, $N_Timeout_size
Func setTimeout_Timer(ByRef $obj, $value)
	$obj[$N_Timeout_Timer] = $value
EndFunc   ;==>setTimeout_Timer
Func getTimeout_Timer($obj)
	Return $obj[$N_Timeout_Timer]
EndFunc   ;==>getTimeout_Timer
Func setTimeout_FunctionName(ByRef $obj, $value)
	$obj[$N_Timeout_FunctionName] = $value
EndFunc   ;==>setTimeout_FunctionName
Func getTimeout_FunctionName($obj)
	Return $obj[$N_Timeout_FunctionName]
EndFunc   ;==>getTimeout_FunctionName
Func newTimeout($Timer, $FunctionName)
	Local $result[$N_Timeout_size]
	$result[$N_Timeout_Timer] = $Timer
	$result[$N_Timeout_FunctionName] = $FunctionName
	Return $result
EndFunc   ;==>newTimeout
Func setTimeout($function_name, $timeout)
	$now = TimerDiff($global_timer)
	insertSortedObj($global_timeout_functions, newTimeout($now + $timeout, $function_name))
EndFunc   ;==>setTimeout
Func setTimeout_external($command, $timeout)
	Local $arguments = ' timeout ' & $timeout & ' "' & $command & '"'
	If @Compiled Then
		Run(@ScriptFullPath & $arguments)
	Else
		Run('"' & @AutoItExe & '" "' & @ScriptFullPath & '"' & $arguments)
		logging('"' & @AutoItExe & '" "' & @ScriptFullPath & '"' & $arguments)
	EndIf
EndFunc   ;==>setTimeout_external
Func cancelAllTimeouts($function_name)
	For $i = size($global_timeout_functions) To 1 Step -1
		If StringCompare(getTimeout_FunctionName($global_timeout_functions[$i]), $function_name) == 0 Then
			deleteAt($global_timeout_functions, $i)
		EndIf
	Next
EndFunc   ;==>cancelAllTimeouts
Func cancelAllTimeoutsStartingWith($function_name)
	For $i = size($global_timeout_functions) To 1 Step -1
		If StringStartsWith(getTimeout_FunctionName($global_timeout_functions[$i]), $function_name) Then
			deleteAt($global_timeout_functions, $i)
		EndIf
	Next
EndFunc   ;==>cancelAllTimeoutsStartingWith
Func parseTimeOutFunctions()
	If size($global_timeout_functions) > 0 Then
		;Logging(TimerDiff($global_timer)&" should get bigger than "&getTimeout_Timer($global_timeout_functions[1]))
		If TimerDiff($global_timer) > getTimeout_Timer($global_timeout_functions[1]) Then
			Local $function = getTimeout_FunctionName($global_timeout_functions[1])
			deleteAt($global_timeout_functions, 1)
			Call($function)
			If @error = 0xDEAD And @extended = 0xBEEF Then
				logging("Error: Function '" & $function & " does not exist")
			EndIf
		EndIf
	EndIf
EndFunc   ;==>parseTimeOutFunctions
Func clear_tooltip_after_ms($ms)
	setTimeout("clear_tooltip", $ms)
EndFunc   ;==>clear_tooltip_after_ms
Func clear_tooltip()
	ToolTip("")
EndFunc   ;==>clear_tooltip
Func AssertEqual($a, $b, $e = "")
	If $a <> $b Then
		If $e <> "" Then $e = " : " & $e
		MsgBox(0, "Assertion error", StringFormat("%s != %s" & $e, $a, $b))
		Exit
	EndIf
EndFunc   ;==>AssertEqual
Global Const $LBS_NOTIFY = 0x00000001 ; Notifies whenever the user clicks or double clicks a string
Global Const $LBS_SORT = 0x00000002 ; Sorts strings in the list box alphabetically
Global Const $LBS_NOREDRAW = 0x00000004 ; Specifies that the appearance is not updated when changes are made
Global Const $LBS_MULTIPLESEL = 0x00000008 ; Turns string selection on or off each time the user clicks a string
Global Const $LBS_OWNERDRAWFIXED = 0x00000010 ; Specifies that the list box is owner drawn
Global Const $LBS_OWNERDRAWVARIABLE = 0x00000020 ; Specifies that the list box is owner drawn with variable height
Global Const $LBS_HASSTRINGS = 0x00000040 ; Specifies that a list box contains items consisting of strings
Global Const $LBS_USETABSTOPS = 0x00000080 ; Enables a list box to recognize and expand tab characters
Global Const $LBS_NOINTEGRALHEIGHT = 0x00000100 ; Specifies that the size is exactly the size set by the application
Global Const $LBS_MULTICOLUMN = 0x00000200 ; Specifies a multi columnn list box that is scrolled horizontally
Global Const $LBS_WANTKEYBOARDINPUT = 0x00000400 ; Specifies that the owner window receives WM_VKEYTOITEM messages
Global Const $LBS_EXTENDEDSEL = 0x00000800 ; Allows multiple items to be selected
Global Const $LBS_DISABLENOSCROLL = 0x00001000 ; Shows a disabled vertical scroll bar
Global Const $LBS_NODATA = 0x00002000 ; Specifies a no-data list box
Global Const $LBS_NOSEL = 0x00004000 ; Specifies that items that can be viewed but not selected
Global Const $LBS_COMBOBOX = 0x00008000 ; Notifies a list box that it is part of a combo box
Global Const $LBS_STANDARD = 0x00000003 ; Standard list box style
Global Const $LB_ERR = -1
Global Const $LB_ERRATTRIBUTE = -3
Global Const $LB_ERRREQUIRED = -4
Global Const $LB_ERRSPACE = -2
Global Const $LB_ADDSTRING = 0x0180
Global Const $LB_INSERTSTRING = 0x0181
Global Const $LB_DELETESTRING = 0x0182
Global Const $LB_SELITEMRANGEEX = 0x0183
Global Const $LB_RESETCONTENT = 0x0184
Global Const $LB_SETSEL = 0x0185
Global Const $LB_SETCURSEL = 0x0186
Global Const $LB_GETSEL = 0x0187
Global Const $LB_GETCURSEL = 0x0188
Global Const $LB_GETTEXT = 0x0189
Global Const $LB_GETTEXTLEN = 0x018A
Global Const $LB_GETCOUNT = 0x018B
Global Const $LB_SELECTSTRING = 0x018C
Global Const $LB_DIR = 0x018D
Global Const $LB_GETTOPINDEX = 0x018E
Global Const $LB_FINDSTRING = 0x018F
Global Const $LB_GETSELCOUNT = 0x0190
Global Const $LB_GETSELITEMS = 0x0191
Global Const $LB_SETTABSTOPS = 0x0192
Global Const $LB_GETHORIZONTALEXTENT = 0x0193
Global Const $LB_SETHORIZONTALEXTENT = 0x0194
Global Const $LB_SETCOLUMNWIDTH = 0x0195
Global Const $LB_ADDFILE = 0x0196
Global Const $LB_SETTOPINDEX = 0x0197
Global Const $LB_GETITEMRECT = 0x0198
Global Const $LB_GETITEMDATA = 0x0199
Global Const $LB_SETITEMDATA = 0x019A
Global Const $LB_SELITEMRANGE = 0x019B
Global Const $LB_SETANCHORINDEX = 0x019C
Global Const $LB_GETANCHORINDEX = 0x019D
Global Const $LB_SETCARETINDEX = 0x019E
Global Const $LB_GETCARETINDEX = 0x019F
Global Const $LB_SETITEMHEIGHT = 0x01A0
Global Const $LB_GETITEMHEIGHT = 0x01A1
Global Const $LB_FINDSTRINGEXACT = 0x01A2
Global Const $LB_SETLOCALE = 0x01A5
Global Const $LB_GETLOCALE = 0x01A6
Global Const $LB_SETCOUNT = 0x01A7
Global Const $LB_INITSTORAGE = 0x01A8
Global Const $LB_ITEMFROMPOINT = 0x01A9
Global Const $LB_MULTIPLEADDSTRING = 0x01B1
Global Const $LB_GETLISTBOXINFO = 0x01B2
Global Const $LBN_ERRSPACE = 0xFFFFFFFE ; Sent when a list box cannot allocate enough memory for a request
Global Const $LBN_SELCHANGE = 0x00000001 ; Sent when the selection in a list box is about to change
Global Const $LBN_DBLCLK = 0x00000002 ; Sent when the user double clicks a string in a list box
Global Const $LBN_SELCANCEL = 0x00000003 ; Sent when the user cancels the selection in a list box
Global Const $LBN_SETFOCUS = 0x00000004 ; Sent when a list box receives the keyboard focus
Global Const $LBN_KILLFOCUS = 0x00000005 ; Sent when a list box loses the keyboard focus
Global Const $__LISTBOXCONSTANT_WS_BORDER = 0x00800000
Global Const $__LISTBOXCONSTANT_WS_VSCROLL = 0x00200000
Global Const $GUI_SS_DEFAULT_LIST = BitOR($LBS_SORT, $__LISTBOXCONSTANT_WS_BORDER, $__LISTBOXCONSTANT_WS_VSCROLL, $LBS_NOTIFY)
Global Const $_UDF_GlobalIDs_OFFSET = 2
Global Const $_UDF_GlobalID_MAX_WIN = 16
Global Const $_UDF_STARTID = 10000
Global Const $_UDF_GlobalID_MAX_IDS = 55535
Global $_UDF_GlobalIDs_Used[$_UDF_GlobalID_MAX_WIN][$_UDF_GlobalID_MAX_IDS + $_UDF_GlobalIDs_OFFSET + 1] ; [index][0] = HWND, [index][1] = NEXT ID
Func _UDF_GetNextGlobalID($hWnd)
	Local $nCtrlID, $iUsedIndex = -1, $fAllUsed = True
	; check if window still exists
	If Not WinExists($hWnd) Then Return SetError(-1, -1, 0)
	; check that all slots still hold valid window handles
	For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
		If $_UDF_GlobalIDs_Used[$iIndex][0] <> 0 Then
			; window no longer exist, free up the slot and reset the control id counter
			If Not WinExists($_UDF_GlobalIDs_Used[$iIndex][0]) Then
				For $x = 0 To UBound($_UDF_GlobalIDs_Used, 2) - 1
					$_UDF_GlobalIDs_Used[$iIndex][$x] = 0
				Next
				$_UDF_GlobalIDs_Used[$iIndex][1] = $_UDF_STARTID
				$fAllUsed = False
			EndIf
		EndIf
	Next
	; check if window has been used before with this function
	For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
		If $_UDF_GlobalIDs_Used[$iIndex][0] = $hWnd Then
			$iUsedIndex = $iIndex
			ExitLoop ; $hWnd has been used before
		EndIf
	Next
	; window hasn't been used before, get 1st un-used index
	If $iUsedIndex = -1 Then
		For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
			If $_UDF_GlobalIDs_Used[$iIndex][0] = 0 Then
				$_UDF_GlobalIDs_Used[$iIndex][0] = $hWnd
				$_UDF_GlobalIDs_Used[$iIndex][1] = $_UDF_STARTID
				$fAllUsed = False
				$iUsedIndex = $iIndex
				ExitLoop
			EndIf
		Next
	EndIf
	If $iUsedIndex = -1 And $fAllUsed Then Return SetError(16, 0, 0) ; used up all 16 window slots
	; used all control ids
	If $_UDF_GlobalIDs_Used[$iUsedIndex][1] = $_UDF_STARTID + $_UDF_GlobalID_MAX_IDS Then
		; check if control has been deleted, if so use that index in array
		For $iIDIndex = $_UDF_GlobalIDs_OFFSET To UBound($_UDF_GlobalIDs_Used, 2) - 1
			If $_UDF_GlobalIDs_Used[$iUsedIndex][$iIDIndex] = 0 Then
				$nCtrlID = ($iIDIndex - $_UDF_GlobalIDs_OFFSET) + 10000
				$_UDF_GlobalIDs_Used[$iUsedIndex][$iIDIndex] = $nCtrlID
				Return $nCtrlID
			EndIf
		Next
		Return SetError(-1, $_UDF_GlobalID_MAX_IDS, 0) ; we have used up all available control ids
	EndIf
	; new control id
	$nCtrlID = $_UDF_GlobalIDs_Used[$iUsedIndex][1]
	$_UDF_GlobalIDs_Used[$iUsedIndex][1] += 1
	$_UDF_GlobalIDs_Used[$iUsedIndex][($nCtrlID - 10000) + $_UDF_GlobalIDs_OFFSET] = $nCtrlID
	Return $nCtrlID
EndFunc   ;==>_UDF_GetNextGlobalID
Func _UDF_FreeGlobalID($hWnd, $iGlobalID)
	; invalid udf global id passed in
	If $iGlobalID - $_UDF_STARTID < 0 Or $iGlobalID - $_UDF_STARTID > $_UDF_GlobalID_MAX_IDS Then Return SetError(-1, 0, False)
	For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
		If $_UDF_GlobalIDs_Used[$iIndex][0] = $hWnd Then
			For $x = $_UDF_GlobalIDs_OFFSET To UBound($_UDF_GlobalIDs_Used, 2) - 1
				If $_UDF_GlobalIDs_Used[$iIndex][$x] = $iGlobalID Then
					; free up control id
					$_UDF_GlobalIDs_Used[$iIndex][$x] = 0
					Return True
				EndIf
			Next
			; $iGlobalID wasn't found in the used list
			Return SetError(-3, 0, False)
		EndIf
	Next
	; $hWnd wasn't found in the used list
	Return SetError(-2, 0, False)
EndFunc   ;==>_UDF_FreeGlobalID
Global $_lb_ghLastWnd
Global $Debug_LB = False
Global Const $__LISTBOXCONSTANT_ClassName = "ListBox"
Global Const $__LISTBOXCONSTANT_WS_VISIBLE = 0x10000000
Global Const $__LISTBOXCONSTANT_WS_TABSTOP = 0x00010000
Global Const $__LISTBOXCONSTANT_WS_CHILD = 0x40000000
Global Const $__LISTBOXCONSTANT_DEFAULT_GUI_FONT = 17
Global Const $__LISTBOXCONSTANT_DDL_DRIVES = 0x4000
Global Const $__LISTBOXCONSTANT_WM_SETREDRAW = 0x000B
Global Const $__LISTBOXCONSTANT_WM_GETFONT = 0x0031
Func _GUICtrlListBox_AddFile($hWnd, $sFile)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_ADDFILE, 0, $sFile, 0, "wparam", "str")
	Else
		Return GUICtrlSendMsg($hWnd, $LB_ADDFILE, 0, $sFile)
	EndIf
EndFunc   ;==>_GUICtrlListBox_AddFile
Func _GUICtrlListBox_AddString($hWnd, $sText)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_ADDSTRING, 0, $sText, 0, "wparam", "str")
	Else
		Return GUICtrlSendMsg($hWnd, $LB_ADDSTRING, 0, $sText)
	EndIf
EndFunc   ;==>_GUICtrlListBox_AddString
Func _GUICtrlListBox_BeginUpdate($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $__LISTBOXCONSTANT_WM_SETREDRAW) = 0
EndFunc   ;==>_GUICtrlListBox_BeginUpdate
Func _GUICtrlListBox_ClickItem($hWnd, $iIndex, $sButton = "left", $fMove = False, $iClicks = 1, $iSpeed = 0)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Local $iX, $iY, $tPoint, $tRect, $iMode, $aPos
	$tRect = _GUICtrlListBox_GetItemRectEx($hWnd, $iIndex)
	$tPoint = _WinAPI_PointFromRect($tRect)
	$tPoint = _WinAPI_ClientToScreen($hWnd, $tPoint)
	_WinAPI_GetXYFromPoint($tPoint, $iX, $iY)
	$iMode = Opt("MouseCoordMode", 1)
	If Not $fMove Then
		$aPos = MouseGetPos()
		_WinAPI_ShowCursor(False)
		MouseClick($sButton, $iX, $iY, $iClicks, $iSpeed)
		MouseMove($aPos[0], $aPos[1], 0)
		_WinAPI_ShowCursor(True)
	Else
		MouseClick($sButton, $iX, $iY, $iClicks, $iSpeed)
	EndIf
	Opt("MouseCoordMode", $iMode)
EndFunc   ;==>_GUICtrlListBox_ClickItem
Func _GUICtrlListBox_Create($hWnd, $sText, $iX, $iY, $iWidth = 100, $iHeight = 200, $iStyle = 0x00B00002, $iExStyle = 0x00000200)
	If Not IsHWnd($hWnd) Then _WinAPI_ShowError("Invalid Window handle for _GUICtrlListBox_Create 1st parameter")
	If Not IsString($sText) Then _WinAPI_ShowError("2nd parameter not a string for _GUICtrlListBox_Create")
	Local $hList, $nCtrlID
	If $iWidth = -1 Then $iWidth = 100
	If $iHeight = -1 Then $iHeight = 200
	If $iStyle = -1 Then $iStyle = 0x00B00002
	If $iExStyle = -1 Then $iExStyle = 0x00000200
	$iStyle = BitOR($iStyle, $__LISTBOXCONSTANT_WS_VISIBLE, $__LISTBOXCONSTANT_WS_TABSTOP, $__LISTBOXCONSTANT_WS_CHILD, $LBS_NOTIFY)
	$nCtrlID = _UDF_GetNextGlobalID($hWnd)
	If @error Then Return SetError(@error, @extended, 0)
	$hList = _WinAPI_CreateWindowEx($iExStyle, $__LISTBOXCONSTANT_ClassName, "", $iStyle, $iX, $iY, $iWidth, $iHeight, $hWnd, $nCtrlID)
	_WinAPI_SetFont($hList, _WinAPI_GetStockObject($__LISTBOXCONSTANT_DEFAULT_GUI_FONT))
	If StringLen($sText) Then _GUICtrlListBox_AddString($hList, $sText)
	Return $hList
EndFunc   ;==>_GUICtrlListBox_Create
Func _GUICtrlListBox_DebugPrint($sText, $iLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @LF & _
			"+======================================================" & @LF & _
			"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @LF & _
			"+======================================================" & @LF)
EndFunc   ;==>_GUICtrlListBox_DebugPrint
Func _GUICtrlListBox_DeleteString($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_DELETESTRING, $iIndex)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_DELETESTRING, $iIndex, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_DeleteString
Func _GUICtrlListBox_Destroy(ByRef $hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $Destroyed, $iResult
	If IsHWnd($hWnd) Then
		If _WinAPI_InProcess($hWnd, $_lb_ghLastWnd) Then
			Local $nCtrlID = _WinAPI_GetDlgCtrlID($hWnd)
			Local $hParent = _WinAPI_GetParent($hWnd)
			$Destroyed = _WinAPI_DestroyWindow($hWnd)
			$iResult = _UDF_FreeGlobalID($hParent, $nCtrlID)
			If Not $iResult Then
				; can check for errors here if needed, for debug
			EndIf
		Else
			_WinAPI_ShowMsg("Not Allowed to Destroy Other Applications ListView(s)")
			Return SetError(1, 1, False)
		EndIf
	Else
		$Destroyed = GUICtrlDelete($hWnd)
	EndIf
	If $Destroyed Then $hWnd = 0
	Return $Destroyed <> 0
EndFunc   ;==>_GUICtrlListBox_Destroy
Func _GUICtrlListBox_Dir($hWnd, $sFile, $iAttributes = 0, $fBrackets = True)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If BitAND($iAttributes, $__LISTBOXCONSTANT_DDL_DRIVES) = $__LISTBOXCONSTANT_DDL_DRIVES And Not $fBrackets Then
		Local $sText, $v_ret
		Local $gui_no_brackets = GUICreate("no brackets")
		Local $list_no_brackets = GUICtrlCreateList("", 240, 40, 120, 120)
		$v_ret = GUICtrlSendMsg($list_no_brackets, $LB_DIR, $iAttributes, $sFile)
		For $i = 0 To _GUICtrlListBox_GetCount($list_no_brackets) - 1
			$sText = _GUICtrlListBox_GetText($list_no_brackets, $i)
			$sText = StringReplace(StringReplace(StringReplace($sText, "[", ""), "]", ":"), "-", "")
			_GUICtrlListBox_InsertString($hWnd, $sText)
		Next
		GUIDelete($gui_no_brackets)
		Return $v_ret
	Else
		If IsHWnd($hWnd) Then
			Return _SendMessage($hWnd, $LB_DIR, $iAttributes, $sFile, 0, "wparam", "str")
		Else
			Return GUICtrlSendMsg($hWnd, $LB_DIR, $iAttributes, $sFile)
		EndIf
	EndIf
EndFunc   ;==>_GUICtrlListBox_Dir
Func _GUICtrlListBox_EndUpdate($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $__LISTBOXCONSTANT_WM_SETREDRAW, 1, 0) = 0
EndFunc   ;==>_GUICtrlListBox_EndUpdate
Func _GUICtrlListBox_FindString($hWnd, $sText, $fExact = False)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		If ($fExact) Then
			Return _SendMessage($hWnd, $LB_FINDSTRINGEXACT, -1, $sText, 0, "wparam", "str")
		Else
			Return _SendMessage($hWnd, $LB_FINDSTRING, -1, $sText, 0, "wparam", "str")
		EndIf
	Else
		If ($fExact) Then
			Return GUICtrlSendMsg($hWnd, $LB_FINDSTRINGEXACT, -1, $sText)
		Else
			Return GUICtrlSendMsg($hWnd, $LB_FINDSTRING, -1, $sText)
		EndIf
	EndIf
EndFunc   ;==>_GUICtrlListBox_FindString
Func _GUICtrlListBox_FindInText($hWnd, $sText, $iStart = -1, $fWrapOK = True)
	Local $iI, $iCount, $sList
	$iCount = _GUICtrlListBox_GetCount($hWnd)
	For $iI = $iStart + 1 To $iCount - 1
		$sList = _GUICtrlListBox_GetText($hWnd, $iI)
		If StringInStr($sList, $sText) Then Return $iI
	Next
	If ($iStart = -1) Or Not $fWrapOK Then Return -1
	For $iI = 0 To $iStart - 1
		$sList = _GUICtrlListBox_GetText($hWnd, $iI)
		If StringInStr($sList, $sText) Then Return $iI
	Next
	Return -1
EndFunc   ;==>_GUICtrlListBox_FindInText
Func _GUICtrlListBox_GetAnchorIndex($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETANCHORINDEX)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETANCHORINDEX, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetAnchorIndex
Func _GUICtrlListBox_GetCaretIndex($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETCARETINDEX)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETCARETINDEX, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetCaretIndex
Func _GUICtrlListBox_GetCount($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETCOUNT)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETCOUNT, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetCount
Func _GUICtrlListBox_GetCurSel($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETCURSEL)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETCURSEL, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetCurSel
Func _GUICtrlListBox_GetHorizontalExtent($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETHORIZONTALEXTENT)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETHORIZONTALEXTENT, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetHorizontalExtent
Func _GUICtrlListBox_GetItemData($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETITEMDATA, $iIndex)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETITEMDATA, $iIndex, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetItemData
Func _GUICtrlListBox_GetItemHeight($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETITEMHEIGHT)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETITEMHEIGHT, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetItemHeight
Func _GUICtrlListBox_GetItemRect($hWnd, $iIndex)
	Local $tRect, $aRect[4]
	$tRect = _GUICtrlListBox_GetItemRectEx($hWnd, $iIndex)
	$aRect[0] = DllStructGetData($tRect, "Left")
	$aRect[1] = DllStructGetData($tRect, "Top")
	$aRect[2] = DllStructGetData($tRect, "Right")
	$aRect[3] = DllStructGetData($tRect, "Bottom")
	Return $aRect
EndFunc   ;==>_GUICtrlListBox_GetItemRect
Func _GUICtrlListBox_GetItemRectEx($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $tRect
	$tRect = DllStructCreate($tagRECT)
	If IsHWnd($hWnd) Then
		_SendMessage($hWnd, $LB_GETITEMRECT, $iIndex, DllStructGetPtr($tRect), 0, "wparam", "ptr")
	Else
		GUICtrlSendMsg($hWnd, $LB_GETITEMRECT, $iIndex, DllStructGetPtr($tRect))
	EndIf
	Return $tRect
EndFunc   ;==>_GUICtrlListBox_GetItemRectEx
Func _GUICtrlListBox_GetListBoxInfo($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETLISTBOXINFO)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETLISTBOXINFO, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetListBoxInfo
Func _GUICtrlListBox_GetLocale($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETLOCALE)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETLOCALE, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetLocale
Func _GUICtrlListBox_GetLocaleCountry($hWnd)
	Return _WinAPI_HiWord(_GUICtrlListBox_GetLocale($hWnd))
EndFunc   ;==>_GUICtrlListBox_GetLocaleCountry
Func _GUICtrlListBox_GetLocaleLang($hWnd)
	Return _WinAPI_LoWord(_GUICtrlListBox_GetLocale($hWnd))
EndFunc   ;==>_GUICtrlListBox_GetLocaleLang
Func _GUICtrlListBox_GetLocalePrimLang($hWnd)
	Return _WinAPI_PrimaryLangId(_GUICtrlListBox_GetLocaleLang($hWnd))
EndFunc   ;==>_GUICtrlListBox_GetLocalePrimLang
Func _GUICtrlListBox_GetLocaleSubLang($hWnd)
	Return _WinAPI_SubLangId(_GUICtrlListBox_GetLocaleLang($hWnd))
EndFunc   ;==>_GUICtrlListBox_GetLocaleSubLang
Func _GUICtrlListBox_GetSel($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETSEL, $iIndex) <> 0
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETSEL, $iIndex, 0) <> 0
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetSel
Func _GUICtrlListBox_GetSelCount($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETSELCOUNT)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETSELCOUNT, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetSelCount
Func _GUICtrlListBox_GetSelItems($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $iI, $iCount, $tArray, $aArray[1] = [0]
	$iCount = _GUICtrlListBox_GetSelCount($hWnd)
	If $iCount > 0 Then
		ReDim $aArray[$iCount + 1]
		$tArray = DllStructCreate("int[" & $iCount & "]")
		If IsHWnd($hWnd) Then
			_SendMessage($hWnd, $LB_GETSELITEMS, $iCount, DllStructGetPtr($tArray), 0, "wparam", "ptr")
		Else
			GUICtrlSendMsg($hWnd, $LB_GETSELITEMS, $iCount, DllStructGetPtr($tArray))
		EndIf
		$aArray[0] = $iCount
		For $iI = 1 To $iCount
			$aArray[$iI] = DllStructGetData($tArray, 1, $iI)
		Next
	EndIf
	Return $aArray
EndFunc   ;==>_GUICtrlListBox_GetSelItems
Func _GUICtrlListBox_GetSelItemsText($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $aIndices, $aText[1] = [0], $iCount = _GUICtrlListBox_GetSelCount($hWnd)
	If $iCount > 0 Then
		$aIndices = _GUICtrlListBox_GetSelItems($hWnd)
		ReDim $aText[UBound($aIndices)]
		$aText[0] = $aIndices[0]
		For $i = 1 To $aIndices[0]
			$aText[$i] = _GUICtrlListBox_GetText($hWnd, $aIndices[$i])
		Next
	EndIf
	Return $aText
EndFunc   ;==>_GUICtrlListBox_GetSelItemsText
Func _GUICtrlListBox_GetText($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $struct = DllStructCreate("char Text[" & _GUICtrlListBox_GetTextLen($hWnd, $iIndex) + 1 & "]")
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	_SendMessageA($hWnd, $LB_GETTEXT, $iIndex, DllStructGetPtr($struct), 0, "wparam", "ptr")
	Return DllStructGetData($struct, "Text")
EndFunc   ;==>_GUICtrlListBox_GetText
Func _GUICtrlListBox_GetTextLen($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETTEXTLEN, $iIndex)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETTEXTLEN, $iIndex, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetTextLen
Func _GUICtrlListBox_GetTopIndex($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_GETTOPINDEX)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_GETTOPINDEX, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_GetTopIndex
Func _GUICtrlListBox_InitStorage($hWnd, $iItems, $iBytes)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_INITSTORAGE, $iItems, $iBytes)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_INITSTORAGE, $iItems, $iBytes)
	EndIf
EndFunc   ;==>_GUICtrlListBox_InitStorage
Func _GUICtrlListBox_InsertString($hWnd, $sText, $iIndex = -1)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Local $struct_String = DllStructCreate("char[" & StringLen($sText) + 1 & "]")
		Local $sBuffer_pointer = DllStructGetPtr($struct_String)
		DllStructSetData($struct_String, 1, $sText)
		Local $rMemMap
		_MemInit($hWnd, StringLen($sText) + 1, $rMemMap)
		_MemWrite($rMemMap, $sBuffer_pointer)
		Local $iResult = _SendMessage($hWnd, $LB_INSERTSTRING, $iIndex, $sBuffer_pointer, 0, "wparam", "ptr")
		_MemFree($rMemMap)
		Return $iResult
	Else
		Return GUICtrlSendMsg($hWnd, $LB_INSERTSTRING, $iIndex, $sText)
	EndIf
EndFunc   ;==>_GUICtrlListBox_InsertString
Func _GUICtrlListBox_ItemFromPoint($hWnd, $iX, $iY)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $iResult
	If IsHWnd($hWnd) Then
		$iResult = _SendMessage($hWnd, $LB_ITEMFROMPOINT, 0, _WinAPI_MakeLong($iX, $iY))
	Else
		$iResult = GUICtrlSendMsg($hWnd, $LB_ITEMFROMPOINT, 0, _WinAPI_MakeLong($iX, $iY))
	EndIf
	If _WinAPI_HiWord($iResult) <> 0 Then $iResult = -1
	Return $iResult
EndFunc   ;==>_GUICtrlListBox_ItemFromPoint
Func _GUICtrlListBox_ReplaceString($hWnd, $iIndex, $sText)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If (_GUICtrlListBox_DeleteString($hWnd, $iIndex) == $LB_ERR) Then Return SetError($LB_ERR, $LB_ERR, False)
	If (_GUICtrlListBox_InsertString($hWnd, $sText, $iIndex) == $LB_ERR) Then Return SetError($LB_ERR, $LB_ERR, False)
	Return True
EndFunc   ;==>_GUICtrlListBox_ReplaceString
Func _GUICtrlListBox_ResetContent($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		_SendMessage($hWnd, $LB_RESETCONTENT)
	Else
		GUICtrlSendMsg($hWnd, $LB_RESETCONTENT, 0, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_ResetContent
Func _GUICtrlListBox_SelectString($hWnd, $sText, $iIndex = -1)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SELECTSTRING, $iIndex, $sText, 0, "wparam", "str")
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SELECTSTRING, $iIndex, $sText)
	EndIf
EndFunc   ;==>_GUICtrlListBox_SelectString
Func _GUICtrlListBox_SelItemRange($hWnd, $iFirst, $iLast, $fSelect = True)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SELITEMRANGE, $fSelect, _WinAPI_MakeLong($iFirst, $iLast)) = 0
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SELITEMRANGE, $fSelect, _WinAPI_MakeLong($iFirst, $iLast)) = 0
	EndIf
EndFunc   ;==>_GUICtrlListBox_SelItemRange
Func _GUICtrlListBox_SelItemRangeEx($hWnd, $iFirst, $iLast)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SELITEMRANGEEX, $iFirst, $iLast) = 0
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SELITEMRANGEEX, $iFirst, $iLast) = 0
	EndIf
EndFunc   ;==>_GUICtrlListBox_SelItemRangeEx
Func _GUICtrlListBox_SetAnchorIndex($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SETANCHORINDEX, $iIndex) = 0
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SETANCHORINDEX, $iIndex, 0) = 0
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetAnchorIndex
Func _GUICtrlListBox_SetCaretIndex($hWnd, $iIndex, $fPartial = False)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SETCARETINDEX, $iIndex, $fPartial) = 0
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SETCARETINDEX, $iIndex, $fPartial) = 0
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetCaretIndex
Func _GUICtrlListBox_SetColumnWidth($hWnd, $iWidth)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		_SendMessage($hWnd, $LB_SETCOLUMNWIDTH, $iWidth)
	Else
		GUICtrlSendMsg($hWnd, $LB_SETCOLUMNWIDTH, $iWidth, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetColumnWidth
Func _GUICtrlListBox_SetCurSel($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SETCURSEL, $iIndex)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SETCURSEL, $iIndex, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetCurSel
Func _GUICtrlListBox_SetHorizontalExtent($hWnd, $iWidth)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		_SendMessage($hWnd, $LB_SETHORIZONTALEXTENT, $iWidth)
	Else
		GUICtrlSendMsg($hWnd, $LB_SETHORIZONTALEXTENT, $iWidth, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetHorizontalExtent
Func _GUICtrlListBox_SetItemData($hWnd, $iIndex, $iValue)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SETITEMDATA, $iIndex, $iValue) <> -1
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SETITEMDATA, $iIndex, $iValue) <> -1
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetItemData
Func _GUICtrlListBox_SetItemHeight($hWnd, $iHeight, $iIndex = 0)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $iResult
	If IsHWnd($hWnd) Then
		$iResult = _SendMessage($hWnd, $LB_SETITEMHEIGHT, $iIndex, $iHeight)
		_WinAPI_InvalidateRect($hWnd)
	Else
		$iResult = GUICtrlSendMsg($hWnd, $LB_SETITEMHEIGHT, $iIndex, $iHeight)
		_WinAPI_InvalidateRect(GUICtrlGetHandle($hWnd))
	EndIf
	Return $iResult <> -1
EndFunc   ;==>_GUICtrlListBox_SetItemHeight
Func _GUICtrlListBox_SetLocale($hWnd, $iLocal)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SETLOCALE, $iLocal)
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SETLOCALE, $iLocal, 0)
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetLocale
Func _GUICtrlListBox_SetSel($hWnd, $iIndex = -1, $fSelect = -1)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $i_ret = True
	If IsHWnd($hWnd) Then
		If $iIndex == -1 Then ; toggle all
			For $iIndex = 0 To _GUICtrlListBox_GetCount($hWnd) - 1
				$i_ret = _GUICtrlListBox_GetSel($hWnd, $iIndex)
				If ($i_ret == $LB_ERR) Then Return SetError($LB_ERR, $LB_ERR, False)
				If ($i_ret > 0) Then ;If Selected Then
					$i_ret = _SendMessage($hWnd, $LB_SETSEL, False, $iIndex) <> -1
				Else
					$i_ret = _SendMessage($hWnd, $LB_SETSEL, True, $iIndex) <> -1
				EndIf
				If ($i_ret == False) Then Return SetError($LB_ERR, $LB_ERR, False)
			Next
		ElseIf $fSelect == -1 Then ; toggle state of index
			If _GUICtrlListBox_GetSel($hWnd, $iIndex) Then ;If Selected Then
				Return _SendMessage($hWnd, $LB_SETSEL, False, $iIndex) <> -1
			Else
				Return _SendMessage($hWnd, $LB_SETSEL, True, $iIndex) <> -1
			EndIf
		Else ; set state according to flag
			Return _SendMessage($hWnd, $LB_SETSEL, $fSelect, $iIndex) <> -1
		EndIf
	Else
		If $iIndex == -1 Then ; toggle all
			For $iIndex = 0 To _GUICtrlListBox_GetCount($hWnd) - 1
				$i_ret = _GUICtrlListBox_GetSel($hWnd, $iIndex)
				If ($i_ret == $LB_ERR) Then Return SetError($LB_ERR, $LB_ERR, False)
				If ($i_ret > 0) Then ;If Selected Then
					$i_ret = GUICtrlSendMsg($hWnd, $LB_SETSEL, False, $iIndex) <> -1
				Else
					$i_ret = GUICtrlSendMsg($hWnd, $LB_SETSEL, True, $iIndex) <> -1
				EndIf
				If ($i_ret == False) Then Return SetError($LB_ERR, $LB_ERR, False)
			Next
		ElseIf $fSelect == -1 Then ; toggle state of index
			If _GUICtrlListBox_GetSel($hWnd, $iIndex) Then ;If Selected Then
				Return GUICtrlSendMsg($hWnd, $LB_SETSEL, False, $iIndex) <> -1
			Else
				Return GUICtrlSendMsg($hWnd, $LB_SETSEL, True, $iIndex) <> -1
			EndIf
		Else ; set state according to flag
			Return GUICtrlSendMsg($hWnd, $LB_SETSEL, $fSelect, $iIndex) <> -1
		EndIf
	EndIf
	Return $i_ret
EndFunc   ;==>_GUICtrlListBox_SetSel
Func _GUICtrlListBox_SetTabStops($hWnd, $aTabStops)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $iI, $iCount, $tTabStops
	$iCount = $aTabStops[0]
	$tTabStops = DllStructCreate("int[" & $iCount & "]")
	For $iI = 1 To $iCount
		DllStructSetData($tTabStops, 1, $aTabStops[$iI], $iI)
	Next
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SETTABSTOPS, $iCount, DllStructGetPtr($tTabStops), 0, "wparam", "ptr") = 0
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SETTABSTOPS, $iCount, DllStructGetPtr($tTabStops)) = 0
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetTabStops
Func _GUICtrlListBox_SetTopIndex($hWnd, $iIndex)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $LB_SETTOPINDEX, $iIndex) <> -1
	Else
		Return GUICtrlSendMsg($hWnd, $LB_SETTOPINDEX, $iIndex, 0) <> -1
	EndIf
EndFunc   ;==>_GUICtrlListBox_SetTopIndex
Func _GUICtrlListBox_Sort($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $bak = _GUICtrlListBox_GetText($hWnd, 0)
	If ($bak == -1) Then Return SetError($LB_ERR, $LB_ERR, False)
	If (_GUICtrlListBox_DeleteString($hWnd, 0) == -1) Then Return SetError($LB_ERR, $LB_ERR, False)
	Return _GUICtrlListBox_AddString($hWnd, $bak) <> -1
EndFunc   ;==>_GUICtrlListBox_Sort
Func _GUICtrlListBox_SwapString($hWnd, $iIndexA, $iIndexB)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $itemA, $itemB
	$itemA = _GUICtrlListBox_GetText($hWnd, $iIndexA)
	$itemB = _GUICtrlListBox_GetText($hWnd, $iIndexB)
	If (_GUICtrlListBox_DeleteString($hWnd, $iIndexA) == -1) Then Return SetError($LB_ERR, $LB_ERR, False)
	If (_GUICtrlListBox_InsertString($hWnd, $itemB, $iIndexA) == -1) Then Return SetError($LB_ERR, $LB_ERR, False)
	If (_GUICtrlListBox_DeleteString($hWnd, $iIndexB) == -1) Then Return SetError($LB_ERR, $LB_ERR, False)
	If (_GUICtrlListBox_InsertString($hWnd, $itemA, $iIndexB) == -1) Then Return SetError($LB_ERR, $LB_ERR, False)
	Return True
EndFunc   ;==>_GUICtrlListBox_SwapString
Func _GUICtrlListBox_UpdateHScroll($hWnd)
	If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
	Local $iI, $hDC, $hFont, $iMax, $tSize, $sText, $t_hwnd
	$iMax = 0
	If IsHWnd($hWnd) Then
		$hFont = _SendMessage($hWnd, $__LISTBOXCONSTANT_WM_GETFONT)
		$hDC = _WinAPI_GetDC($hWnd)
		_WinAPI_SelectObject($hDC, $hFont)
		For $iI = 0 To _GUICtrlListBox_GetCount($hWnd) - 1
			$sText = _GUICtrlListBox_GetText($hWnd, $iI)
			$tSize = _WinAPI_GetTextExtentPoint32($hDC, $sText & "W")
			If DllStructGetData($tSize, "X") > $iMax Then
				$iMax = DllStructGetData($tSize, "X")
			EndIf
		Next
		_GUICtrlListBox_SetHorizontalExtent($hWnd, $iMax)
		_WinAPI_SelectObject($hDC, $hFont)
		_WinAPI_ReleaseDC($hWnd, $hDC)
	Else
		$hFont = GUICtrlSendMsg($hWnd, $__LISTBOXCONSTANT_WM_GETFONT, 0, 0)
		$t_hwnd = GUICtrlGetHandle($hWnd)
		$hDC = _WinAPI_GetDC($t_hwnd)
		_WinAPI_SelectObject($hDC, $hFont)
		For $iI = 0 To _GUICtrlListBox_GetCount($hWnd) - 1
			$sText = _GUICtrlListBox_GetText($hWnd, $iI)
			$tSize = _WinAPI_GetTextExtentPoint32($hDC, $sText & "W")
			If DllStructGetData($tSize, "X") > $iMax Then
				$iMax = DllStructGetData($tSize, "X")
			EndIf
		Next
		_GUICtrlListBox_SetHorizontalExtent($hWnd, $iMax)
		_WinAPI_SelectObject($hDC, $hFont)
		_WinAPI_ReleaseDC($t_hwnd, $hDC)
	EndIf
EndFunc   ;==>_GUICtrlListBox_UpdateHScroll
Func _GUICtrlListBox_ValidateClassName($hWnd)
	_GUICtrlListBox_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
	_WinAPI_ValidateClassName($hWnd, $__LISTBOXCONSTANT_ClassName & "|TListBox")
EndFunc   ;==>_GUICtrlListBox_ValidateClassName
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
Global $__about_box__
Global $__version__
Global $__copyright__
Global $__ok_button__
Global $__formula_chooser__
Global $__choose_a_formula__
Global $__other_file__
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
add($affectations, "__about_box__", $gui_section, 'About', 'About')
add($affectations, "__version__", $gui_section, 'Version %s', 'Version %s')
add($affectations, "__copyright__", $gui_section, 'Copyright 2008', 'Copyright 2008')
add($affectations, "__ok_button__", $gui_section, '&OK', '&OK')
add($affectations, "__formula_chooser__", $gui_section, 'Formula Chooser', 'Formula Chooser')
add($affectations, "__choose_a_formula__", $gui_section, 'Choose a formula :', 'Choose a formula :')
add($affectations, "__other_file__", $gui_section, 'Other file', 'Other file')
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
Func ReadNChars(ByRef $string, $count)
  $chars = StringLeft($string, $count)
  $string = StringMid($string, 1+$count)
  Return $chars
EndFunc
Func ReadNBytes(ByRef $hex_string, $count)
  Return ReadNChars($hex_string, 2*$count)
EndFunc
Func ReadOneByte(ByRef $hex_string)
  Return ReadNChars($hex_string, 2)
EndFunc
Func ReadTwoBytes(ByRef $hex_string)
  Return ReadNChars($hex_string, 4)
EndFunc
Func ReadNumberOverBytes(ByRef $hex_string, $count, $intel = True)
  $number_string = ""
  While $count > 0
    If $intel Then
      $number_string = ReadOneByte($hex_string) & $number_string
    Else
      $number_string &= ReadOneByte($hex_string)
    EndIf
    $count -= 1
  WEnd
  Return Dec($number_string)
EndFunc
Func ReadAsciiStringOverBytes($hex_string, $count)
  $string = ""
  While $count > 0
    $string &= Chr(Dec(ReadOneByte($hex_string)))
    $count -= 1
  WEnd
  Return $string
EndFunc
Func ToByteArray($hex_string)
  Dim $count = StringLen($hex_string)/2
  Dim $array[$count], $i=0
  While $i < $count
    $n = Dec(StringMid($hex_string, $i*2 + 1, 2))
    $array[$i] = $n
    $i += 1
  WEnd
  Return $array
EndFunc
Func BitShiftSigned($number, $dir)
  Local $m = 0x80000000, $m2 = 0x40000000
  If $dir = 0 Then Return $number
  If Not BitAND($m, $number) Then
    Return BitShift($number, $dir)
  Else ; Negative number! Be careful.
    $number = BitXOR($number, $m)
    If $dir > 0 Then
      $number = BitOR(BitShift($number, $dir), BitShift($m2, $dir - 1)) ; Add the remaining 1.
    Else
      $number = BitShift($number, $dir)
    EndIf
    Return $number
  EndIf
EndFunc
Func TransformUnicodeDataToString($unicode_data)
  $result = ""
  While $unicode_data <> ""
    $code = ReadNumberOverBytes($unicode_data, 2)
    If $code == 0 Then ExitLoop
    $result &= ChrW($code)
  WEnd
  Return $result
EndFunc
Func TransformStringToUnicodeData($string)
  $result = ""
  While $string <> ""
    $char = ReadNChars($string, 1)
    $result &= NumberHexInverted(AscW($char), 2)
  WEnd
  $result &= "0000"
  Return $result
EndFunc
Func TransformStringToPngData($string)
  $result = ""
  $string = StringReplace($string, @CRLF, @LF)
  While $string <> ""
    $char = ReadNChars($string, 1)
    $result &= Hex(AscW($char), 2)
  WEnd  
  Return $result
EndFunc
Func NumberHexInverted($number, $n)
  $str = Hex($number, $n * 2)
  $str_inverted = ""
  For $i = 1 To $n
    $str_inverted = StringLeft($str, 2) & $str_inverted
    $str = StringMid($str, 3)
  Next
  Return $str_inverted
EndFunc
Func CopyNBytes($handleFileOriginal, $handleFileCopy, $n)
  ;MsgBox(0,"Bytescopy",$n)
  ;logging("Reading "&$n&" bytes...")
  If $n <> Default Then
    $content = Binary(FileRead($handleFileOriginal, $n))
    ;MsgBox(0,"test",$content)
    ;logging("Copying "&$n&" bytes...")
    if(FileWrite($handleFileCopy, $content)==0) Then
      Return ErrorDecodeAdd("Impossible to copy bytes")
    EndIf
  Else
    While True
      $non_binary_content = FileRead($handleFileOriginal, 1)
      If @error == -1 Then ExitLoop
      $content = Binary($non_binary_content)
      ;MsgBox(0,"test",$content)
      ;jpegDebug("Copying "&$n&" bytes...")
      if(FileWrite($handleFileCopy, $content)==0) Then
        Return ErrorDecodeAdd("Impossible to copy bytes in while loop")
      EndIf
    WEnd
  EndIf
  logging("Copied...")
  Return True
EndFunc
Func FileWriteHex($being_written, $string)
  FileWrite($being_written, Binary("0x"&$string))
EndFunc
Global Const $JPEG_DATA_BEGIN = "FFDA", $JPEG_STG_BEGIN = "FFDB", $JPEG_START = "FFD8", $JPEG_END = "FFD9", $JPEG_EXIF_TAG = "FFE1", $XP_COMMENT_START = "9C9C"
Func XpExifTags($filename)
  $ERROR_DECODE_HANDLING = ""
  Dim $informations = emptySizedArray()
  $reader = FileOpen($filename, 16)
  If $reader <> -1 Then
    If ReadXpExifTags($reader, $informations) Then
    Else
      ErrorDecodeDisplay()
    EndIf
  Else
    If FileExists($filename) Then
      logging("Error while opening file, even if it exists :"&$filename)
    Else
      logging("This file does not exists: "&$filename)
    EndIf
  EndIf
  FileClose($reader)
  Return $informations
EndFunc
Func ReadXpExifTags($reader, ByRef $informations)
  If Not FileReadOpenJpegTag($reader) Then Return False
  While True
    Dim $section
    If Not FileReadJpegSection($reader, $section) Then Return False
    ;logging("Section read : "&$section[0])
    If $section[0] == $JPEG_END or $section[0] == $JPEG_DATA_BEGIN or $section[0] == $JPEG_STG_BEGIN Then ExitLoop
    If $section[0] == $JPEG_EXIF_TAG Then
      If Not GetXPInformationsFromExifTag($section[1], $section[2], $informations) Then Return ErrorDecodeAdd("Nothing available (neither Title, Comment, nor Author)")
      Return True
    EndIf
  WEnd
  Return True
EndFunc
Func FileReadOpenJpegTag($reader)
  $head = FileRead($reader, 2)
  If @error <> 0                       Then Return ErrorDecodeAdd("Empty file : Error "&@error)
  If String($head) <> "0x"&$JPEG_START Then Return ErrorDecodeAdd("Invalid Jpeg file, begins with "&String($head))
  Return True
EndFunc
Func FileReadJpegSection($reader, ByRef $section)
  $section = _ArrayCreate(0, 0, "")
  $head = StringRight(FileRead($reader, 2), 4)
  If @error <> 0 Then Return ErrorDecodeAdd("End of file reached while reading section : Error "&@error)
  $section[0] = $head
  If $head == $JPEG_END Or $head == $JPEG_DATA_BEGIN Or $head == $JPEG_STG_BEGIN Then
    Return True
  EndIf
  $count_string = StringRight(FileRead($reader, 2), 4)
  $count = Dec($count_string)
  If $count <= 1 Then Return ErrorDecodeAdd("Empty section in jpeg file : "&$count_string)
  If $count == 2 Then Return True
  $section[1] = $count - 2
  $data = StringRight(FileRead($reader, $section[1]), $section[1]*2)
  If @error <> 0 Then Return ErrorDecodeAdd("Error while reading data in section : Error "&@error)
  $section[2] = $data
  Return True
EndFunc
Global Const $JPEG_TIFF_TAG = "49492A0008000000", $JPEG_EXIF_STRING = "457869660000"
Func GetXPInformationsFromExifTag($count, $exif_tag, ByRef $informations)
  If Not ReadInExifTag($exif_tag, $JPEG_EXIF_STRING) Then Return ErrorDecodeAdd("Exif tag does not begin with 'Exif'")
  If Not ReadInExifTag($exif_tag, $JPEG_TIFF_TAG) Then Return ErrorDecodeAdd("Exif tag does not have a correct TIFF tag")
  $offset = StringLen($JPEG_TIFF_TAG)/2
  $number_of_fields = ReadNumberOverBytes($exif_tag, 2)
  ;logging("Exif Tag before parsing tags: "&$exif_tag)
  ;logging($number_of_fields&" fields to parse")
  $offset += 2
  If $number_of_fields == 0 Then
    $informations = _ArrayCreate(0)
    Return True
  EndIf
  Dim $field[$number_of_fields]
  For $i = 0 To $number_of_fields - 1
    $current_field = _ArrayCreate("type", "size", "(offset and then )data")
    $type = ReadTwoBytes($exif_tag)
    $current_field[0] = $type
    $number_one = ReadNumberOverBytes($exif_tag, 2)
    If $number_one <> 1 Then Return ErrorDecodeAdd("Weird error: expected 1, got "&$number_one)
    $size = ReadNumberOverBytes($exif_tag, 4)
    $current_field[1] = $size
    If $size > 4 Then
      $offset_local = ReadNumberOverBytes($exif_tag, 4)
      $current_field[2] = $offset_local
    ElseIf $size == 4 Then
      ;The data is directly stored into the header
      $data = TransformUnicodeDataToString(ReadNBytes($exif_tag, 4))
      $current_field[2] = $data
      ;logging("Quick Field found: "&$current_field[0]&" => "&$current_field[1])
    Else
      Return ErrorDecodeAdd("Unexpected size "&$size&" less than 4")
    EndIf
    
    $field[$i] = $current_field
    $offset += 12
  Next
  If Not ReadInExifTag($exif_tag, "00000000") Then Return ErrorDecodeAdd("Zeros missing")
  $offset += 4
  ;logging("Exif Tag before parsing strings: "&$exif_tag)
  For $i = 0 To $number_of_fields - 1
    MaybeDecompressXPData($field[$i], $exif_tag, $offset)
    $current_field = $field[$i]
    ;logging("Field found: "&$current_field[0]&" => "&$current_field[1])
  Next
  $informations = $field
  _ArrayInsert($informations, 0, UBound($informations))
  ;"05 00";5 = number of fields over 2 bytes
  ;"9b 9c 01 00 0c 00 00 00 4a 00 00 00";Title
  ;"9c 9c 01 00 4c 00 00 00 56 00 00 00";Comment
  ;"9d 9c 01 00 0e 00 00 00 a2 00 00 00";Author
  ;"9e 9c 01 00 10 00 00 00 b0 00 00 00";Keywords
  ;"9f 9c 01 00 0c 00 00 00 c0 00 00 00";Subject
  ;TAG(2),1(2),Length(4),Position from the |4949 marker (4)
  ;"00 00 00 00";Start
  ;"74 00 69 00 74 00 72 00 65 00 00 00"
  ;"63 00 6f 00 6d 00 6d 00 65 00 6e 00 74 00 61 00 69 00 72 00 65 00 20 00 72 00 e9 00 63 00 75 00 70 00 e9 00 72 00 e9 00 21 00 0d 00 0a 00 44 00 65 00 75 00 78 00 69 00 e8 00 6d 00 65 00 20 00 6c 00 69 00 67 00 6e 00 65 00 00 00"
  ;"61 00 75 00 74 00 65 00 75 00 72 00 00 00"
  ;"6d 00 6f 00 74 00 63 00 6c 00 65 00 66 00 00 00"
  ;"6f 00 62 00 6a 00 65 00 74 00 00 00"
  ;Titre, commentaire, auteur, mot-clef, objet
  
  ;Si la chaîne peut être incluse dans l'entête (taille de 4 octets), alors elle sera directement incluse sans passer par une référence.
  ;9b 9c 01 00 04 00 00 00 4a 00 00 00 + 00 00 00 00 (contient la lettre directement dans l'entête)
  
  ;logging($exif_tag)
  Return True
EndFunc
Func MaybeDecompressXPData(ByRef $current_field, $exif_tag, $offset)
  $size = $current_field[1]
  If $size > 4 Then
    $offset_local = $current_field[2]
    ;logging("etag : "&$exif_tag)
    ;logging("Offset : "&$offset&", Offset_local : "&$offset_local&", Size : "&$size)
    $string_hex = StringMid($exif_tag, 2*($offset_local - $offset) + 1, $size*2)
    $string = TransformUnicodeDataToString($string_hex)
    $current_field[2] = $string
  EndIf
  $current_field[0] = PutNameOnXPCode($current_field[0])
  _ArrayDelete($current_field, 1)
EndFunc
Global $xpcode_name_map = _ArrayCreate( _
_ArrayCreate("9B9C", "title"), _
_ArrayCreate("9C9C", "comment"), _
_ArrayCreate("9D9C", "author"), _
_ArrayCreate("9E9C", "keywords"), _
_ArrayCreate("9F9C", "subject"))
Func PutNameOnXPCode($xpcode)
  For $mapping in $xpcode_name_map
    If $mapping[0] == $xpcode Then Return $mapping[1]
  Next
  Return "unknown xpcode"
EndFunc
Func PutXPCodeOnName($name)
  For $mapping in $xpcode_name_map
    If $mapping[1] == $name Then Return $mapping[0]
    Next
    logging("Unknown name : "&$name)
  Return "ABCD"
EndFunc
 
Func ReadInExifTag(ByRef $exif_tag, $str)
  If StringCompare(StringLeft($exif_tag, StringLen($str)), $str) <> 0 Then Return ErrorDecodeAdd("No exif_tag")
  $exif_tag = StringMid($exif_tag, StringLen($str) + 1)
  Return True
EndFunc
Func WriteXPSections($file, ByRef $sections)
  $file1 = $file
  $file2 = $file&"copy.jpg"
  $handleFileOriginal = FileOpen($file1, 0+16)
  $handleFileCopy = FileOpen($file2, 2+16)
  $no_errors = WriteXPSectionsBinary($handleFileOriginal, $handleFileCopy, $sections)
  FileClose($handleFileOriginal)
  FileClose($handleFileCopy)
  If $no_errors Then
    logging("No errors")
    FileMove($file2, $file1, 1)
  Else
    logging("Errors")
    ErrorDecodeDisplay()
    FileDelete($file2)
  EndIf
EndFunc
Func WriteXPSectionsBinary($being_read, $being_written, ByRef $sections)
  Dim $section
  Dim $exif_has_been_replaced = False, $success= True
  If Not FileReadOpenJpegTag($being_read) Then Return ErrorDecodeAdd("No opening Jpeg tag "&$JPEG_START)
  FileWriteHex($being_written, $JPEG_START)
  While True
    If Not FileReadJpegSection($being_read, $section) Then Return ErrorDecodeAdd("Unable to read section")
    ;logging("Section read : "&$section[0])
    If $section[0] == $JPEG_END or $section[0] == $JPEG_DATA_BEGIN or $section[0] == $JPEG_STG_BEGIN Then
      If not $exif_has_been_replaced Then
        $success = SetXpInformationsInExifTag($being_written, $sections)
        $exif_has_been_replaced = True
      EndIf
      FileWriteHex($being_written, $section[0])
      ExitLoop
    EndIf
    ;logging("Comparing "&$section[0]&" to "&$JPEG_EXIF_TAG)
    If $section[0] == $JPEG_EXIF_TAG Then
      Dim $informations = _ArrayCreate(0)
      ;logging("Retrieving informations...")
      If Not GetXPInformationsFromExifTag($section[1], $section[2], $informations) Then Return ErrorDecodeAdd("Impossible to get Xp tags")
      ;logging("Merging informations...")
      MergeInformationsSections($informations, $sections)
      $success = SetXpInformationsInExifTag($being_written, $sections)
      $exif_has_been_replaced = True
    Else
      JpegFileWriteSection($being_written, $section)
    EndIf
  WEnd
  CopyNBytes($being_read, $being_written, Default)
  Return $exif_has_been_replaced and $success
EndFunc
Func MergeInformationsSections(ByRef $informations, ByRef $sections)
  ;logging("Merging...")
  ;Priority of the informations in $section than in $informations.
  For $i = 1 To $informations[0]
    $current_information = $informations[$i]
    Dim $found = False
    For $j = 1 To $sections[0]
      $current_section = $sections[$j]
      If $current_information[0] == $current_section[0] Then
        $found = True
        ExitLoop
      EndIf
    Next
    If Not $found Then
      ;logging("Pushed "&$current_information[0]&" = "&$current_information[1]&" into queue")
      push($sections, $current_information)
    EndIf
  Next
EndFunc
Func SetXpInformationsInExifTag($being_written, $informations)
  $number_of_fields = $informations[0]
  If $number_of_fields == 0 Then Return True
  
  FileWriteHex($being_written, $JPEG_EXIF_TAG)
  
  ;Il mangue la taille, qui sera rajoutée à la fin.
  $string_to_write = $JPEG_EXIF_STRING & $JPEG_TIFF_TAG
  $offset = StringLen($JPEG_TIFF_TAG)/2
  
  $string_to_write &= NumberHexInverted($number_of_fields, 2)
  $offset += 2
  ;Put the offset to beginning of the strings
  $offset += $number_of_fields * 12 + 4
  
  ;Write XP tags
  For $i = 1 To $number_of_fields
    $field = $informations[$i]
    $code = PutXPCodeOnName($field[0])
    If $code == "ABCD" Then
      Return ErrorDecodeAdd("Field not recognized as a code : "&$field[0])
    EndIf
    ;Code of the Xp tag
    $string_to_write &= $code
    $data = TransformStringToUnicodeData($field[1])
    ;Size
    $string_to_write &= "0100"
    $string_to_write &= NumberHexInverted(StringLen($data)/2, 4)
    If(StringLen($data) == 8) Then
      $string_to_write &= $data
    Else
      $string_to_write &= NumberHexInverted($offset, 4)
      $offset += StringLen($data)/2
    EndIf
    $field[1] = $data
    $informations[$i] = $field
  Next
  ;The raw string contents
  $string_to_write &= "00000000"
  For $i = 1 To $number_of_fields
    $field = $informations[$i]
    $data = $field[1]
    If StringLen($data) > 8 Then
      $string_to_write &= $data
    EndIf
  Next
  ;+2 Because the size itself it counted for the length of the tag
  $string_to_write = Hex(StringLen($string_to_write)/2+2, 4) & $string_to_write
  FileWriteHex($being_written, $string_to_write)
  Return True
EndFunc
Func JpegFileWriteSection($being_written, $section)
  ;section[0] == Tag without 0x
  ;section[1] == Size
  ;Section[2] == Data
  FileWriteHex($being_written, $section[0])
  FileWriteHex($being_written, Hex($section[1]+2, 4))
  FileWriteHex($being_written, $section[2])
EndFunc
Global Const $PNG_START = "89504E470D0A1A0A", $PNG_TEXT_TAG = "tEXt", $PNG_END = "IEND"
Global Const $formula_keyword = "Comment", $software_keyword = "Software", $title_keyword = "Title"
Global $crc_table[256], $crc_table_computed = False
Func PngReflexTags($filename)
  $ERROR_DECODE_HANDLING = ""
  Dim $informations = emptySizedArray()
  $reader = FileOpen($filename, 16)
  If $reader <> -1 Then
    If ReadPngReflexTags($reader, $informations) Then
      ;logging("Rien !")
    Else
      ErrorDecodeDisplay()
    EndIf
    ;logging("Fini ! ")
  Else
    If FileExists($filename) Then
      logging("Error while opening file, even if it exists :"&$filename)
    Else
      logging("This file does not exists: "&$filename)
    EndIf
  EndIf
  FileClose($reader)
  Return $informations
EndFunc
Func ReadPngReflexTags($reader, ByRef $informations)
  If Not FileReadOpenPngTag($reader) Then Return False
  Dim $section = _ArrayCreate("NOTIEND")
  While $section[0] <> $PNG_END
    ;logging("section à lire")
    If Not FileReadPngSection($reader, $section) Then Return False
    ;logging("section lue sans encombre:" & $section[0])
    If $section[0] == $PNG_TEXT_TAG Then
      GetReflexInformationsFromPngTextChunk($section, $informations)
    EndIf
  WEnd
  Return True
EndFunc
Func FileReadOpenPngTag($reader)
  $head = FileRead($reader, StringLen($PNG_START)/2)
  If @error <> 0              Then Return ErrorDecodeAdd("Empty file : Error "&@error)
  If $head <> "0x"&$PNG_START Then Return ErrorDecodeAdd("Invalid Png file, begins with "&$head&" instead of "&$PNG_START)
  Return True
EndFunc
Func FileReadPngTagSize($reader, ByRef $size)
  $size_string = FileRead($reader, 4)
  If @error <> 0 Then Return ErrorDecodeAdd("End of file reached while reading section : Error " & @error)
  $size_string = StringMid($size_string, 3)
  $size = ReadNumberOverBytes($size_string, 4, False)
  Return True
EndFunc
Func FileReadPngTagHeader($reader, ByRef $header_hex_string)
  $header_hex_string = FileRead($reader, 4)
  If @error <> 0 Then Return ErrorDecodeAdd("End of file reached while reading section : Error " & @error)
  $header_hex_string = StringMid($header_hex_string, 3)
  Return True
EndFunc
Func FileReadPngSection($reader, ByRef $section, $external_size_max=1000)
  Local $size = 0, $header, $header_hex_string = ""
  $section = _ArrayCreate(0, 0, "", 0)
  If Not FileReadPngTagSize($reader, $size) Then Return False
  If Not FileReadPngTagHeader($reader, $header_hex_string) Then Return False
  $header = ReadAsciiStringOverBytes($header_hex_string, 4)
  ;logging($header)
  ;Read section and compute CRC at the same time.
  
  Local $verify_crc = ($size < $external_size_max Or StringCompare($header, $PNG_TEXT_TAG, 1) == 0)
  Local $data = "", $crc_string
  
  If $verify_crc Then
    Dim $crc_computing = 0xFFFFFFFF
    $crc_computing = update_crc($crc_computing, ToByteArray($header_hex_string))
    For $i = 1 To $size
      $c = StringMid(FileRead($reader, 1), 3)
      $data &= $c
      $crc_computing = update_crc($crc_computing, _ArrayCreate(Dec($c)))
    Next
    $self_crc = BitXOR($crc_computing, 0xFFFFFFFF)
    $crc_string_aux = StringMid(FileRead($reader, 4), 3)
    $crc_string = $crc_string_aux
    $crc_number = ReadNumberOverBytes($crc_string_aux, 4, False)
    If $self_crc <> $crc_number Then Return ErrorDecodeAdd("CRC is not valid for chunk "&$header&" on this file. Got "&Hex($crc_number)&" instead of calculated "&Hex($self_crc))
  Else
    $data = StringMid(FileRead($reader, $size), 3)
    $crc_string = StringMid(FileRead($reader, 4), 3)
  EndIf  
  $section[0]=$header
  $section[1]=$size
  $section[2]=$data
  $section[3]=$crc_string
  ;logging("Returning section "&toString($section))
  Return True
EndFunc
Func GetReflexInformationsFromPngTextChunk(ByRef $section, ByRef $results)
  Local $i, $text = $section[2], $n = StringLen($text) , $keyword, $content
  $i = 1
  For $i = 1 To $n *2-1 Step 2
    If StringMid($text, $i, 2) == "00" Then
      $keyword = ReadAsciiStringOverBytes($text, ($i - 1)/2)
      $content_bytes = StringMid($text, $i + 2)
      $content = ReadAsciiStringOverBytes($content_bytes, StringLen($content_bytes)/2)
      $content = StringAddCR($content)
      push($results, _ArrayCreate($keyword, $content))
      ;logging("One tEXt chunk!=>"&$keyword&":"&$content)
      Return True
    EndIf
  Next
  Return ErrorDecodeAdd("Corrupted tEXt chunk in PNG file: "&$section[0])
EndFunc
Func WritePngTextChunks($file, ByRef $sections)
  $file1 = $file
  $file2 = $file&"copy.png"
  $handleFileOriginal = FileOpen($file1, 0+16)
  $handleFileCopy = FileOpen($file2, 2+16)
  $no_errors = WritePngSectionsBinary($handleFileOriginal, $handleFileCopy, $sections)
  FileClose($handleFileOriginal)
  FileClose($handleFileCopy)
  If $no_errors Then
    ;logging("No errors")
    FileMove($file2, $file1, 1)
  Else
    ;logging("Errors")
    ErrorDecodeDisplay()
    FileDelete($file2)
  EndIf
EndFunc
Func WritePngSectionsBinary($being_read, $being_written, ByRef $sections_to_write)
  Dim $section
  If Not FileReadOpenPngTag($being_read) Then Return ErrorDecodeAdd("No open PNG tag in this file")
  FileWriteHex($being_written, $PNG_START)
  Dim $section = _ArrayCreate("NOTIEND")
  While $section[0] <> $PNG_END
    If Not FileReadPngSection($being_read, $section) Then Return ErrorDecodeAdd("Impossible to read chunk")
    If $section[0] == $PNG_END Then ExitLoop ; PNG_END to be written.
    If $section[0] == $PNG_TEXT_TAG Then
      Local $result = emptySizedArray(), $foundold = 0
      GetReflexInformationsFromPngTextChunk($section, $result)
      $result = $result[1]
      For $i = 1 To $sections_to_write[0]
        $t = $sections_to_write[$i]
        If StringCompare($t[0], $result[0]) == 0 Then
          $foundold = $i
          ExitLoop
        EndIf
      Next
      If $foundold >= 1 Then
        WriteTextSection($being_written, $sections_to_write[$i])
        deleteAt($sections_to_write, $i)
      Else
        WriteSection($being_written, $section) ; Copies the previous section.
      EndIf
    Else
      ;logging("Copying section : "&toString($section))
      WriteSection($being_written, $section) ; Copies the previous section.
    EndIf
  WEnd
  For $i = 1 To $sections_to_write[0]
    WriteTextSection($being_written, $sections_to_write[$i])
  Next
  WriteSection($being_written, $section) ; Contains $PNG_END
  Return True
EndFunc
Func WriteSection($being_written, $section)
  ;TODO: Size, header, content, CRC.
  $chunktype = TransformStringToPngData($section[0])
  $chunksize = $section[1]
  $chunkdata = $section[2]
  $chunkcrc  = $section[3]
  FileWriteHex($being_written, Hex($chunksize, 8))
  FileWriteHex($being_written, $chunktype)
  FileWriteHex($being_written, $chunkdata)
  FileWriteHex($being_written, $chunkcrc)
EndFunc
Func WriteTextSection($being_written, $section)
  Local $real_section = _ArrayCreate($PNG_TEXT_TAG, 0, "", 0)
  Local $keyword = $section[0]
  Local $content = $section[1]
  $hex_content = TransformStringToPngData($keyword)&"00"&TransformStringToPngData($content)
  ;logging("Computing CRC on "&TransformStringToPngData($PNG_TEXT_TAG)&$hex_content)
  $crc = Hex(crc(ToByteArray(TransformStringToPngData($PNG_TEXT_TAG)&$hex_content)), 8)
  $real_section[1] = StringLen($hex_content)/2
  $real_section[2] = $hex_content
  $real_section[3] = $crc
  WriteSection($being_written, $real_section)
EndFunc
make_crc_table()
Func make_crc_table()
  Local $c, $n, $k;
  For $n = 0 To 255
    $c = $n;
    For $k = 0 To 7
      if BitAND($c, 1) Then
        $c = BitXOR(0xedb88320, BitShiftSigned($c, 1))
      Else
        $c = BitShiftSigned($c, 1)
      EndIf
    Next
    $crc_table[$n] = $c
  Next
  $crc_table_computed = True;
EndFunc
Func update_crc($crc, $buf) ;buf = Array<Char>
  Dim $c = $crc, $n, $len = UBound($buf)
  If Not $crc_table_computed Then make_crc_table()
  For $n = 0 To $len - 1
    ;logging(Hex($c)&": "&Hex($buf[$n])&" => "&Hex(BitXOR($c, $buf[$n]))&" => "&Hex(BitAND(BitXOR($c, $buf[$n]), 0xff))&" => "&Hex($crc_table[BitAND(BitXOR($c, $buf[$n]), 0xff)])&" => "& _
    $c = BitXOR($crc_table[BitAND(BitXOR($c, $buf[$n]), 0xff)], BitShiftSigned($c, 8))
  Next
  return $c
EndFunc
Func crc($buf)
  Return BitXOR(update_crc(0xffffffff, $buf), 0xffffffff)
EndFunc
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
Func _FileCountLines($sFilePath)
	Local $hFile, $sFileContent, $aTmp
	$hFile = FileOpen($sFilePath, 0)
	If $hFile = -1 Then Return SetError(1, 0, 0)
	$sFileContent = StringStripWS(FileRead($hFile), 2)
	FileClose($hFile)
	If StringInStr($sFileContent, @LF) Then
		$aTmp = StringSplit(StringStripCR($sFileContent), @LF)
	ElseIf StringInStr($sFileContent, @CR) Then
		$aTmp = StringSplit($sFileContent, @CR)
	Else
		If StringLen($sFileContent) Then
			Return 1
		Else
			Return SetError(2, 0, 0)
		EndIf
	EndIf
	Return $aTmp[0]
EndFunc   ;==>_FileCountLines
Func _FileCreate($sFilePath)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $hOpenFile
	Local $hWriteFile
	$hOpenFile = FileOpen($sFilePath, 2)
	If $hOpenFile = -1 Then
		SetError(1)
		Return 0
	EndIf
	$hWriteFile = FileWrite($hOpenFile, "")
	If $hWriteFile = -1 Then
		SetError(2)
		Return 0
	EndIf
	FileClose($hOpenFile)
	Return 1
EndFunc   ;==>_FileCreate
Func _FileListToArray($sPath, $sFilter = "*", $iFlag = 0)
	Local $hSearch, $sFile, $asFileList[1]
	If Not FileExists($sPath) Then Return SetError(1, 1, "")
	If (StringInStr($sFilter, "\")) Or (StringInStr($sFilter, "/")) Or (StringInStr($sFilter, ":")) Or (StringInStr($sFilter, ">")) Or (StringInStr($sFilter, "<")) Or (StringInStr($sFilter, "|")) Or (StringStripWS($sFilter, 8) = "") Then Return SetError(2, 2, "")
	If Not ($iFlag = 0 Or $iFlag = 1 Or $iFlag = 2) Then Return SetError(3, 3, "")
	If (StringMid($sPath, StringLen($sPath), 1) = "\") Then $sPath = StringTrimRight($sPath, 1) ; needed for Win98 for x:\  root dir
	$hSearch = FileFindFirstFile($sPath & "\" & $sFilter)
	If $hSearch = -1 Then Return SetError(4, 4, "")
	While 1
		$sFile = FileFindNextFile($hSearch)
		If @error Then
			SetError(0)
			ExitLoop
		EndIf
		If $iFlag = 1 And StringInStr(FileGetAttrib($sPath & "\" & $sFile), "D") <> 0 Then ContinueLoop
		If $iFlag = 2 And StringInStr(FileGetAttrib($sPath & "\" & $sFile), "D") = 0 Then ContinueLoop
		$asFileList[0] += 1
		If UBound($asFileList) <= $asFileList[0] Then ReDim $asFileList[UBound($asFileList) * 2]
		$asFileList[$asFileList[0]] = $sFile
	WEnd
	FileClose($hSearch)
	ReDim $asFileList[$asFileList[0] + 1] ; Trim unused slots
	Return $asFileList
EndFunc   ;==>_FileListToArray
Func _FilePrint($s_File, $i_Show = @SW_HIDE)
	Local $a_Ret = DllCall("shell32.dll", "long", "ShellExecute", _
			"hwnd", 0, _
			"string", "print", _
			"string", $s_File, _
			"string", "", _
			"string", "", _
			"int", $i_Show)
	If $a_Ret[0] > 32 And Not @error Then
		Return 1
	Else
		SetError($a_Ret[0])
		Return 0
	EndIf
EndFunc   ;==>_FilePrint
Func _FileReadToArray($sFilePath, ByRef $aArray)
	Local $hFile, $aFile
	$hFile = FileOpen($sFilePath, 0)
	If $hFile = -1 Then Return SetError(1, 0, 0);; unable to open the file
	;; Read the file and remove any trailing white spaces
	$aFile = FileRead($hFile, FileGetSize($sFilePath))
	$aFile = StringStripWS($aFile, 2)
	FileClose($hFile)
	If StringInStr($aFile, @LF) Then
		$aArray = StringSplit(StringStripCR($aFile), @LF)
	ElseIf StringInStr($aFile, @CR) Then ;; @LF does not exist so split on the @CR
		$aArray = StringSplit($aFile, @CR)
	Else ;; unable to split the file
		If StringLen($aFile) Then
			Dim $aArray[2] = [1, $aFile]
		Else
			Return SetError(2, 0, 0)
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_FileReadToArray
Func _FileWriteFromArray($File, $a_Array, $i_Base = 0, $i_UBound = 0)
	; Check if we have a valid array as input
	If Not IsArray($a_Array) Then Return SetError(2, 0, 0)
	; determine last entry
	Local $last = UBound($a_Array) - 1
	If $i_UBound < 1 Or $i_UBound > $last Then $i_UBound = $last
	If $i_Base < 0 Or $i_Base > $last Then $i_Base = 0
	; Open output file for overwrite by default, or use input file handle if passed
	Local $hFile
	If IsString($File) Then
		$hFile = FileOpen($File, 2)
	Else
		$hFile = $File
	EndIf
	If $hFile = -1 Then Return SetError(1, 0, 0)
	; Write array data to file
	Local $ErrorSav = 0
	For $x = $i_Base To $i_UBound
		If FileWrite($hFile, $a_Array[$x] & @CRLF) = 0 Then
			$ErrorSav = 3
			ExitLoop
		EndIf
	Next
	; Close file only if specified by a string path
	If IsString($File) Then FileClose($hFile)
	; Return results
	If $ErrorSav Then
		Return SetError($ErrorSav, 0, 0)
	Else
		Return 1
	EndIf
EndFunc   ;==>_FileWriteFromArray
Func _FileWriteLog($sLogPath, $sLogMsg, $iFlag = -1)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $sDateNow, $sTimeNow, $sMsg, $iWriteFile, $hOpenFile, $iOpenMode = 1
	$sDateNow = @YEAR & "-" & @MON & "-" & @MDAY
	$sTimeNow = @HOUR & ":" & @MIN & ":" & @SEC
	$sMsg = $sDateNow & " " & $sTimeNow & " : " & $sLogMsg
	If $iFlag <> -1 Then
		$sMsg &= @CRLF & FileRead($sLogPath)
		$iOpenMode = 2
	EndIf
	$hOpenFile = FileOpen($sLogPath, $iOpenMode)
	If $hOpenFile = -1 Then Return SetError(1, 0, 0)
	$iWriteFile = FileWriteLine($hOpenFile, $sMsg)
	If $iWriteFile = -1 Then Return SetError(2, 0, 0)
	Return FileClose($hOpenFile)
EndFunc   ;==>_FileWriteLog
Func _FileWriteToLine($sFile, $iLine, $sText, $fOverWrite = 0)
	If $iLine <= 0 Then Return SetError(4, 0, 0)
	If Not IsString($sText) Then Return SetError(6, 0, 0)
	If $fOverWrite <> 0 And $fOverWrite <> 1 Then Return SetError(5, 0, 0)
	If Not FileExists($sFile) Then Return SetError(2, 0, 0)
	Local $filtxt = FileRead($sFile, FileGetSize($sFile))
	$filtxt = StringSplit($filtxt, @CRLF, 1)
	If UBound($filtxt, 1) < $iLine Then Return SetError(1, 0, 0)
	Local $fil = FileOpen($sFile, 2)
	If $fil = -1 Then Return SetError(3, 0, 0)
	For $i = 1 To UBound($filtxt) - 1
		If $i = $iLine Then
			If $fOverWrite = 1 Then
				If $sText <> '' Then
					FileWrite($fil, $sText & @CRLF)
				Else
					FileWrite($fil, $sText)
				EndIf
			EndIf
			If $fOverWrite = 0 Then
				FileWrite($fil, $sText & @CRLF)
				FileWrite($fil, $filtxt[$i] & @CRLF)
			EndIf
		ElseIf $i < UBound($filtxt, 1) - 1 Then
			FileWrite($fil, $filtxt[$i] & @CRLF)
		ElseIf $i = UBound($filtxt, 1) - 1 Then
			FileWrite($fil, $filtxt[$i])
		EndIf
	Next
	FileClose($fil)
	Return 1
EndFunc   ;==>_FileWriteToLine
Func _PathFull($sRelativePath, $sBasePath = @WorkingDir)
	If Not $sRelativePath Or $sRelativePath = "." Then Return $sBasePath
	; Normalize slash direction.
	Local $sFullPath = StringReplace($sRelativePath, "/", "\") ; Holds the full path (later, minus the root)
	Local Const $sFullPathConst = $sFullPath ; Holds a constant version of the full path.
	Local $sPath ; Holds the root drive/server
	Local $bRootOnly = StringLeft($sFullPath, 1) = "\" And StringMid($sFullPath, 2, 1) <> "\"
	; Check for UNC paths or local drives.  We run this twice at most.  The
	; first time, we check if the relative path is absolute.  If it's not, then
	; we use the base path which should be absolute.
	For $i = 1 To 2
		$sPath = StringLeft($sFullPath, 2)
		If $sPath = "\\" Then
			$sFullPath = StringTrimLeft($sFullPath, 2)
			$sPath &= StringLeft($sFullPath, StringInStr($sFullPath, "\") - 1)
			ExitLoop
		ElseIf StringRight($sPath, 1) = ":" Then
			$sFullPath = StringTrimLeft($sFullPath, 2)
			ExitLoop
		Else
			$sFullPath = $sBasePath & "\" & $sFullPath
		EndIf
	Next
	; If this happens, we've found a funky path and don't know what to do
	; except for get out as fast as possible.  We've also screwed up our
	; variables so we definitely need to quit.
	If $i = 3 Then Return ""
	; Build an array of the path parts we want to use.
	Local $aTemp = StringSplit($sFullPath, "\")
	Local $aPathParts[$aTemp[0]], $j = 0
	For $i = 2 To $aTemp[0]
		If $aTemp[$i] = ".." Then
			If $j Then $j -= 1
		ElseIf Not ($aTemp[$i] = "" And $i <> $aTemp[0]) And $aTemp[$i] <> "." Then
			$aPathParts[$j] = $aTemp[$i]
			$j += 1
		EndIf
	Next
	; Here we re-build the path from the parts above.  We skip the
	; loop if we are only returning the root.
	$sFullPath = $sPath
	If Not $bRootOnly Then
		For $i = 0 To $j - 1
			$sFullPath &= "\" & $aPathParts[$i]
		Next
	Else
		$sFullPath &= $sFullPathConst
		; If we detect more relative parts, remove them by calling ourself recursively.
		If StringInStr($sFullPath, "..") Then $sFullPath = _PathFull($sFullPath)
	EndIf
	; Clean up the path.
	While StringInStr($sFullPath, ".\")
		$sFullPath = StringReplace($sFullPath, ".\", "\")
	WEnd
	Return $sFullPath
EndFunc   ;==>_PathFull
Func _PathGetRelative($sFrom, $sTo)
	Local $asFrom, $asTo, $iDiff, $sRelPath, $i
	If StringRight($sFrom, 1) <> "\" Then $sFrom &= "\" ; add missing trailing \ to $sFrom path
	If StringRight($sTo, 1) <> "\" Then $sTo &= "\" ; add trailing \ to $sTo
	If $sFrom = $sTo Then Return SetError(1, 0, StringTrimRight($sTo, 1)) ; $sFrom equals $sTo
	$asFrom = StringSplit($sFrom, "\")
	$asTo = StringSplit($sTo, "\")
	If $asFrom[1] <> $asTo[1] Then Return SetError(2, 0, StringTrimRight($sTo, 1)) ; drives are different, rel path not possible
	; create rel path
	$i = 2
	$iDiff = 1
	While 1
		If $asFrom[$i] <> $asTo[$i] Then
			$iDiff = $i
			ExitLoop
		EndIf
		$i += 1
	WEnd
	$i = 1
	$sRelPath = ""
	For $j = 1 To $asTo[0]
		If $i >= $iDiff Then
			$sRelPath &= "\" & $asTo[$i]
		EndIf
		$i += 1
	Next
	$sRelPath = StringTrimLeft($sRelPath, 1)
	$i = 1
	For $j = 1 To $asFrom[0]
		If $i > $iDiff Then
			$sRelPath = "..\" & $sRelPath
		EndIf
		$i += 1
	Next
	If StringRight($sRelPath, 1) == "\" Then $sRelPath = StringTrimRight($sRelPath, 1) ; remove trailing \
	Return $sRelPath
EndFunc   ;==>_PathGetRelative
Func _PathMake($szDrive, $szDir, $szFName, $szExt)
	; Format $szDrive, if it's not a UNC server name, then just get the drive letter and add a colon
	Local $szFullPath
	;
	If StringLen($szDrive) Then
		If Not (StringLeft($szDrive, 2) = "\\") Then $szDrive = StringLeft($szDrive, 1) & ":"
	EndIf
	; Format the directory by adding any necessary slashes
	If StringLen($szDir) Then
		If Not (StringRight($szDir, 1) = "\") And Not (StringRight($szDir, 1) = "/") Then $szDir = $szDir & "\"
	EndIf
	; Nothing to be done for the filename
	; Add the period to the extension if necessary
	If StringLen($szExt) Then
		If Not (StringLeft($szExt, 1) = ".") Then $szExt = "." & $szExt
	EndIf
	$szFullPath = $szDrive & $szDir & $szFName & $szExt
	Return $szFullPath
EndFunc   ;==>_PathMake
Func _PathSplit($szPath, ByRef $szDrive, ByRef $szDir, ByRef $szFName, ByRef $szExt)
	; Set local strings to null (We use local strings in case one of the arguments is the same variable)
	Local $drive = ""
	Local $dir = ""
	Local $fname = ""
	Local $ext = ""
	Local $pos
	; Create an array which will be filled and returned later
	Local $array[5]
	$array[0] = $szPath; $szPath can get destroyed, so it needs set now
	; Get drive letter if present (Can be a UNC server)
	If StringMid($szPath, 2, 1) = ":" Then
		$drive = StringLeft($szPath, 2)
		$szPath = StringTrimLeft($szPath, 2)
	ElseIf StringLeft($szPath, 2) = "\\" Then
		$szPath = StringTrimLeft($szPath, 2) ; Trim the \\
		$pos = StringInStr($szPath, "\")
		If $pos = 0 Then $pos = StringInStr($szPath, "/")
		If $pos = 0 Then
			$drive = "\\" & $szPath; Prepend the \\ we stripped earlier
			$szPath = ""; Set to null because the whole path was just the UNC server name
		Else
			$drive = "\\" & StringLeft($szPath, $pos - 1) ; Prepend the \\ we stripped earlier
			$szPath = StringTrimLeft($szPath, $pos - 1)
		EndIf
	EndIf
	; Set the directory and file name if present
	Local $nPosForward = StringInStr($szPath, "/", 0, -1)
	Local $nPosBackward = StringInStr($szPath, "\", 0, -1)
	If $nPosForward >= $nPosBackward Then
		$pos = $nPosForward
	Else
		$pos = $nPosBackward
	EndIf
	$dir = StringLeft($szPath, $pos)
	$fname = StringRight($szPath, StringLen($szPath) - $pos)
	; If $szDir wasn't set, then the whole path must just be a file, so set the filename
	If StringLen($dir) = 0 Then $fname = $szPath
	$pos = StringInStr($fname, ".", 0, -1)
	If $pos Then
		$ext = StringRight($fname, StringLen($fname) - ($pos - 1))
		$fname = StringLeft($fname, $pos - 1)
	EndIf
	; Set the strings and array to what we found
	$szDrive = $drive
	$szDir = $dir
	$szFName = $fname
	$szExt = $ext
	$array[1] = $drive
	$array[2] = $dir
	$array[3] = $fname
	$array[4] = $ext
	Return $array
EndFunc   ;==>_PathSplit
Func _ReplaceStringInFile($szFileName, $szSearchString, $szReplaceString, $fCaseness = 0, $fOccurance = 1)
	Local $iRetVal = 0
	Local $hWriteHandle, $aFileLines, $nCount, $sEndsWith, $hFile
	; Check if file is readonly ..
	If StringInStr(FileGetAttrib($szFileName), "R") Then Return SetError(6, 0, -1)
	;===============================================================================
	;== Read the file into an array
	;===============================================================================
	$hFile = FileOpen($szFileName, 0)
	If $hFile = -1 Then Return SetError(1, 0, -1)
	Local $s_TotFile = FileRead($hFile, FileGetSize($szFileName))
	If StringRight($s_TotFile, 2) = @CRLF Then
		$sEndsWith = @CRLF
	ElseIf StringRight($s_TotFile, 1) = @CR Then
		$sEndsWith = @CR
	ElseIf StringRight($s_TotFile, 1) = @LF Then
		$sEndsWith = @LF
	Else
		$sEndsWith = ""
	EndIf
	$aFileLines = StringSplit(StringStripCR($s_TotFile), @LF)
	FileClose($hFile)
	;===============================================================================
	;== Open the output file in write mode
	;===============================================================================
	$hWriteHandle = FileOpen($szFileName, 2)
	If $hWriteHandle = -1 Then Return SetError(2, 0, -1)
	;===============================================================================
	;== Loop through the array and search for $szSearchString
	;===============================================================================
	For $nCount = 1 To $aFileLines[0]
		If StringInStr($aFileLines[$nCount], $szSearchString, $fCaseness) Then
			$aFileLines[$nCount] = StringReplace($aFileLines[$nCount], $szSearchString, $szReplaceString, 1 - $fOccurance, $fCaseness)
			$iRetVal = $iRetVal + 1
			;======================================================================
			;== If we want just the first string replaced, copy the rest of the lines
			;== and stop
			;======================================================================
			If $fOccurance = 0 Then
				$iRetVal = 1
				ExitLoop
			EndIf
		EndIf
	Next
	;===============================================================================
	;== Write the lines back to original file.
	;===============================================================================
	For $nCount = 1 To $aFileLines[0] - 1
		If FileWriteLine($hWriteHandle, $aFileLines[$nCount]) = 0 Then
			SetError(3)
			FileClose($hWriteHandle)
			Return -1
		EndIf
	Next
	; Write the last record and ensure it ends with the same as the input file
	If $aFileLines[$nCount] <> "" Then FileWrite($hWriteHandle, $aFileLines[$nCount] & $sEndsWith)
	FileClose($hWriteHandle)
	Return $iRetVal
EndFunc   ;==>_ReplaceStringInFile
Func _TempFile($s_DirectoryName = @TempDir, $s_FilePrefix = "~", $s_FileExtension = ".tmp", $i_RandomLength = 7)
	Local $s_TempName
	; Check parameters
	If Not FileExists($s_DirectoryName) Then $s_DirectoryName = @TempDir ; First reset to default temp dir
	If Not FileExists($s_DirectoryName) Then $s_DirectoryName = @ScriptDir ; Still wrong then set to Scriptdir
	; add trailing \ for directory name
	If StringRight($s_DirectoryName, 1) <> "\" Then $s_DirectoryName = $s_DirectoryName & "\"
	;
	Do
		$s_TempName = ""
		While StringLen($s_TempName) < $i_RandomLength
			$s_TempName = $s_TempName & Chr(Random(97, 122, 1))
		WEnd
		$s_TempName = $s_DirectoryName & $s_FilePrefix & $s_TempName & $s_FileExtension
	Until Not FileExists($s_TempName)
	Return ($s_TempName)
EndFunc   ;==>_TempFile
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
