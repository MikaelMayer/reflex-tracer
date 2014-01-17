//Mock version of stdafx.h
// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently

typedef unsigned int COLORREF;
#define RGB(r,g,b) (((b)<<16)+((g)<<8)+(r))
// typedef char TCHAR;
#define TEXT(a) (char *)a
#define TEXTC(a) a
#define TRUE true
#define FALSE false
#undef _UNICODE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tchar.h"

