/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Name: RenderReflex.cpp
 * Author: Mikaël Mayer
 * Work started: 20080614
 * Purpose:  Render a reflex given some arguments.
 * Format: Ini file.
formula="The(very+complicated*formula)which/will-give(some)*nice*reflex"
width=1600
height=1600
winmin=-4-4i
winmax=4+4i
output=c:\the\path\where\to\store\the\file.bmp
 * An AutoIt3 script calls the program with a nice interface
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#define _CRT_SECURE_NO_DEPRECATE
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <string.h>
#include <algorithm>
#include <math.h>
#include <stdio.h>
#include "argstream.h"
#include "png.h"
//#include "tbb/task_scheduler_init.h"
//#include "tbb/parallel_for.h"
#//include "tbb/blocked_range.h"
#include "stdafx.h"
#include "complex.h"
#include "functions.h"
#include "lexeur.h"

#ifdef _MSC_VER
#define SSCANF(inputstr,formatstr,...) \
    sscanf_s(inputstr,formatstr, __VA_ARGS__)
#else
#define SSCANF(inputstr,formatstr,...) \
    sscanf(inputstr,formatstr, __VA_ARGS__)
#define _strnicmp strncasecmp
#endif




#define MAX_FUNC_LENGTH 0xFFFF
//using namespace tbb;
using namespace std;
static const size_t N = 6;
const TCHAR* options_line_string = TEXT("@Options:");

/*class SubStringFinder {
  const string str;
  size_t *max_array;
  size_t *pos_array;
  public:
  void operator() ( const blocked_range<size_t>& r ) const {
    for ( size_t I = r.begin(); I != r.end(); ++I ) {
      size_t max_size = 0, max_pos = 0;
      for (size_t j = 0; j < str.size(); ++j)
        if (j != I) {
          size_t limit = str.size()-max(I,j);
          for (size_t k = 0; k < limit; ++k) {
            if (str[I + k] != str[j + k]) break;
            if (k > max_size) {
              max_size = k;
              max_pos = j;
            }
          }
        }
        max_array[I] = max_size;
        pos_array[I] = max_pos;
    }
  }
  SubStringFinder(string &s, size_t *m, size_t *p) : str(s), max_array(m), pos_array(p) { }
};*/

void putInvertedNumber(ofstream &file, int size, int number) {
  char a;
  while (size>0) {
    a = number&0xFF;
    file.write(&a, 1);
    number >>= 8;
    size--;
  }
}
// Goal: Maximize the number of numbers of modulus between 1 and 5
// with the coefficient closest to 1.
Function *autoscale_function(Function* f) {
  Function* function = f;
  double x = -3.963647, y = -3.997621;
  //double modules = 0;
  double num = 10;
  double modulearray[10];
  for(int i = 0; i < num; i++) {
    double m = function->eval(cplx(x, y)).module();
    //modules += log(m);
    x += 7.25314297;
    y += 2.257493158;
    if(x > 4) x -= 8;
    if(y > 4) y -= 8;
    modulearray[i] = m;
  }
  double modulemappedarray[10];
  double bestcoef = 1.0;
  int best = 0;
  for(int j = 0; j < num; j++) {
    double res = modulearray[j];
    if(res >= 1 && res <= 5) {
      best += 1;
    }
  }
  for(int i = 0; i < num; i++) {
    if(modulearray[i] != 0) {
      int ok = 0;
      for(int j = 0; j < num; j++) {
        double res = modulearray[j]/modulearray[i];
        if(res >= 1 && res <= 5) {
          ok += 1;
        }
      }
      if(ok > best) {
        bestcoef = 1/modulearray[i];
        best = ok;
      }
    }
  }
  
  //double average = exp(modules/num);
  if(bestcoef != 1.0) {
    function = new Multiplication(new Constante(cplx(bestcoef,0)), function, false);
  }
  return function;
}

// Takes a string in input, the name is for debug purpose only.
// final_string is an array of size MAX_FUNC_LENGTH where the formula will be stored,
// if there was any randomness.
Function* getFunction(const char* string, char* final_string, const char* name, bool force_output=false, STRING_TYPE formula_style=DEFAULT_TYPE, bool autoscale=false) {
  Parseur *parseur = new Parseur(string);
  Function *function = parseur->valeurFonction();
   
  if(!function) {
    cerr << name << " error : " << string << " <= ";
    if(parseur->errorCode() >= 0){
      cerr << Parseur::errorNum[parseur->errorCode()];
    } else {
      cerr << "Simplification error";
    }
    cerr << " at position " << parseur->getPosition() << endl;
    cerr << name << " error : ";
    for(int i = 0; i< parseur->getPosition(); i++) {
      cerr << string[i];
    }
    cerr << "^" << endl;
  } else {
    if(autoscale) {
      function = autoscale_function(function);
    }
    TCHAR funcstring[MAX_FUNC_LENGTH];
    *(function->toStringConst(funcstring, funcstring+MAX_FUNC_LENGTH, formula_style))=L'\0';
    if(final_string != NULL) {
       _tcscpy(final_string, funcstring);
    }
    if(parseur->hasBeenMacro() || force_output) {//On recopie la fonction...
      cout << "formula:" << funcstring << endl;
    }
  }
  delete parseur;
  return function;
}

//Returns a boolean indicating if the operation was a success.
//Puts the integer from the string into value.
//Displays a pretty error message containing the name of the variable.
bool getInt(const char* string, const char* name, int& value) {
  Function *function = getFunction(string, NULL, name);
  if(function==NULL)
    return false;
  bool return_value = true;
  if(!function->isConstant()) {
    cerr << name << " error : " << string << " is not constant";
    return_value = false;
  } else {
    value = static_cast<int>((dynamic_cast<Constante*>(function))->valeur.real());
  }
  function = function->kill();
  return return_value;
}

bool getHex(const char* string, const char* name, unsigned int& value) {
  unsigned int result = 0;
  while(*string) {
    unsigned int c = *string - '0';
    if(! (c >= 0 && c <= 9) ) {
      c = *string - 'A' + 10;
      if(! (c >= 10 && c <= 15) ) {
        cerr << name << " error : " << string << " is not in hex format (got "
             << *string << ")" << endl;;
        return false;
      }
    }
    result = result * 16 + c;
    string++;
  }
  value = result;
  return true;
}

bool getCplx(const char* string, const char* name, cplx& value) {
  Function *function = getFunction(string, NULL, name);
  if(function==NULL)
    return false;
  bool return_value = true;
  if(!function->isConstant()) {
    cerr << name << " error : " << string << " is not constant";
    return_value = false;
  } else {
    value = (dynamic_cast<Constante*>(function))->valeur;
  }
  function = function->kill();
  return return_value;
}

void getMinXYMaxXY(cplx winmin, cplx winmax,
                   int x, int y,
                   double &min_x, double &min_y,
                   double &max_x, double &max_y) {
  
  min_x = winmin.real();
  min_y = winmin.imag();
  max_x = winmax.real();
  max_y = winmax.imag();
  double dx = max_x - min_x;
  double dy = max_y - min_y;

  double cen_x = (min_x + max_x)/2.;
  double cen_y = (min_y + max_y)/2.;

  //  Cut the observing tree if needed.
  // max_y should not change if the ratio is close to zero (that is, dx/dy = x/y)
  double diffRatio = dx * y - dy * x;
  if (diffRatio != 0) {
    if (diffRatio < 0) {  // dx/dy < width/height // rendering is larger than the pre-display one.
      max_y = cen_y + (y * (max_x - cen_x)) / x;
      min_y = cen_y + (y * (min_x - cen_x)) / x;
    } else { // rendering is higher than the pre-display one.
      max_x = cen_x + (x * (max_y - cen_y)) / y;
      min_x = cen_x + (x * (min_y - cen_y)) / y;
    }
  }
}

int renderBmp(const char* formula_string, int width, int height,
              const char* winmin_string, const char* winmax_string, const char* output_string,
              int seed_init, unsigned int colornan, bool realmode,
              bool autoscale
              ) {
  bool fine = true;
  int errpos = 0;
  cplx winmin, winmax;

  srand(seed_init);
  TCHAR final_funcstring[MAX_FUNC_LENGTH];

  Function *f_formula = getFunction(formula_string, final_funcstring, "Formula", false, DEFAULT_TYPE, autoscale);

  fine = fine && f_formula;
  fine = fine && getCplx(winmin_string, "Winmin", winmin);
  fine = fine && getCplx(winmax_string, "Winmax", winmax);
  if(!fine) {
    if(f_formula)	f_formula = f_formula->kill();
    return -1;
  }
  cplx::color_NaN = colornan;

  ofstream output_file(output_string, ios::binary | ios::out);
  if(!output_file.is_open()) {
    if(f_formula)	f_formula = f_formula->kill();
    cerr << "Output file invalid : " << output_string << endl;
    return -1;
  }
  int x = width, y = height;
  int taille = 3*x*y;
  int offset = x % 4;
  putInvertedNumber(output_file, 1, 66);                      //  B
  putInvertedNumber(output_file, 1, 77);                      //  M
  putInvertedNumber(output_file, 8, (taille+(y*offset)+54));  //  Total size
  putInvertedNumber(output_file, 4, 54);                      //  Head total size.
  putInvertedNumber(output_file, 4, 40);                      //  Head size from here.
  putInvertedNumber(output_file, 4, x);                       //  width
  putInvertedNumber(output_file, 4, y);                       //  height
  putInvertedNumber(output_file, 2, 1);                       //  number of layers
  putInvertedNumber(output_file, 6, 24);                      //  number of colors
  putInvertedNumber(output_file, 20, (taille+y*offset));      //  bitmap size.
  
  double min_x, min_y, max_x, max_y;
  getMinXYMaxXY(winmin, winmax, x, y,
                min_x, min_y, max_x, max_y);

  double iMult = (max_x - min_x) / (x - 1);
  double iBase = min_x;
  double jMult = (max_y - min_y) / (y - 1);
  double jBase = min_y;
  
  if(realmode == 0) {
    for (int j = 0; j < y; j++) {
      cout << j << "/" << y << endl;
      for (int i = 0; i < x; i++) {
        cplx z(i*iMult+iBase, j*jMult+jBase);
        COLORREF color = f_formula->eval(z).couleur24();
        putInvertedNumber(output_file, 3, color);
      }
      putInvertedNumber(output_file, offset, 0);
    }
  } else {
    double d0 = 0;
    double d1 = 0;
    unsigned int color_base = 0, color = 0;
    double *valeurs = new double[x];
    double *valeursj = new double[x];
    double *coefdirs = new double[x - 1];
    for (int i = 0; i < x; i++) {
      cplx z(i*iMult+iBase, 0);
      valeurs[i] = f_formula->eval(z).real();
      valeursj[i] = (valeurs[i] - jBase)/jMult;
    }
    for (int i = 0; i < x-1; i++) {
      double tmp = (valeursj[i+1]-valeursj[i]);
      double tmp2 = 1.0+(tmp*tmp);
      coefdirs[i] = 1.0/sqrt(tmp2);
      coefdirs[i] *= tmp > 0 ? 1 : -1;
    }
    for (int j = 0; j < y; j++) {
      cout << j << "/" << y << endl;
      color_base = cplx(j * jMult + jBase, 0).couleur24();
      for (int i = 0; i < x; i++) {
        //Calcul de la distance du point à la courbe
        double dmin = 2.0;
        if((j > valeursj[i]+0.5 && (i == 0 || j > valeursj[i - 1] + 0.5)
                                && (i == x - 1 || j > valeursj[i + 1] + 0.5))
           || (j < valeursj[i]-0.5 && (i == 0 || j < valeursj[i - 1] - 0.5)
                                   && (i == x - 1 || j < valeursj[i + 1] - 0.5)))
        {
        } else {
          if (i > 0) {
            d0 = (valeursj[i] - j) * coefdirs[i-1];
          }
          if (i < x - 1) {
            d1 = (j - valeursj[i]) * coefdirs[i];
          } else {
            d1 = d0;
          }
          if (i == 0) d0 = d1;
          if(d0 <= 0 && d1 <= 0) {
            dmin = j > valeursj[i] ? j - valeursj[i] : valeursj[i] - j;
          } else if(d0 >= 0 && d1 >= 0) {
            if(d0 > d1) {
              dmin = d1;
            } else {
              dmin = d0;
            }
          } else {
            if(d0 > 0)
              dmin = d0;
            if(d1 > 0)
              dmin = d1;
          }
        }
        const double limup = 1.014;
        if(dmin <= 0.5) {          // Pile sur la ligne
          color = color_base;
        } else if(dmin >= limup) { // En dehors de la ligne
          color = 0xFFFFFF;
        } else {                   // Sur la limite de la ligne: dégradé
          double coef = (dmin - 0.5)/(limup - 0.5);
          unsigned int blu = ((color_base & 0xFF0000) >> 16);
          unsigned int gre = ((color_base & 0x00FF00) >> 8);
          unsigned int red =  (color_base & 0x0000FF);
          red = (int)(255.0 * coef + (1.0 - coef) * red);
          gre = (int)(255.0 * coef + (1.0 - coef) * gre);
          blu = (int)(255.0 * coef + (1.0 - coef) * blu);
          color = RGB(red, gre, blu);
        }
        putInvertedNumber(output_file, 3, color);
      }
      putInvertedNumber(output_file, offset, 0);
    }
    delete []valeurs;
    delete []valeursj;
    delete []coefdirs;
  }
  output_file.close();
  f_formula = f_formula->kill();
  cout << "Done." << endl;
  return 0;
}

void write_row_callback(png_structp png_ptr, png_uint_32 row_number, int pass);
void write_row_callback(png_structp png_ptr, png_uint_32 row_number, int pass)
{
    //if(png_ptr == NULL || row_number > PNG_UINT_31_MAX || pass > 7) return;
    //fprintf(stdout, "w");
}

int renderPng(const char* formula_string, const char* formulalatex_string, int width, int height,
              const char* winmin_string, const char* winmax_string, const char* output_string,
              int seed_init, unsigned int colornan, bool realmode, string comment_string,
              bool autoscale) {
  bool fine = true;
  //int errpos = 0;
  cplx winmin, winmax;

  TCHAR final_funcstring[MAX_FUNC_LENGTH];
  TCHAR final_funcstringlatex[MAX_FUNC_LENGTH];

  srand(seed_init);
  Function *f_formula = getFunction(formula_string, final_funcstring, "Formula", false, DEFAULT_TYPE, autoscale);
  Function *f_formulalatex = getFunction(formulalatex_string, final_funcstringlatex, "Formula", false, LATEX_TYPE, autoscale);

  fine = fine && f_formula;
  fine = fine && getCplx(winmin_string, "Winmin", winmin);
  fine = fine && getCplx(winmax_string, "Winmax", winmax);
  if(!fine) {
    if(f_formula)	f_formula = f_formula->kill();
    if(f_formulalatex) f_formulalatex = f_formulalatex->kill();
    return -1;
  }
  cplx::color_NaN = colornan;

  FILE *output_file = fopen(output_string, "wb");

  if(!output_file) {
    if(f_formula)	f_formula = f_formula->kill();
    if(f_formulalatex) f_formulalatex = f_formulalatex->kill();
    cerr << "Output file invalid : " << output_string << endl;
    return -1;
  }

  png_structp write_ptr;
  png_infop write_info_ptr;
  //png_infop write_end_info_ptr;

  write_ptr = png_create_write_struct
  (PNG_LIBPNG_VER_STRING, NULL/*png_voidp_NULL*/,
      /*png_error_ptr_NULL*/NULL, NULL/*png_error_ptr_NULL*/);
  if(!write_ptr)
     return -1;
  png_init_io(write_ptr, output_file);

  //png_debug(0, "Allocating read_info, write_info and end_info structures\n");
  write_info_ptr = png_create_info_struct(write_ptr);
  //write_end_info_ptr = png_create_info_struct(write_ptr);

  if (!write_info_ptr)
  {
     png_destroy_write_struct(&write_ptr,
       (png_infopp)NULL);
     return (-1);
  }

  png_set_write_status_fn(write_ptr, write_row_callback);

  png_set_IHDR(write_ptr, write_info_ptr, width, height,
    8, PNG_COLOR_TYPE_RGB,
    PNG_INTERLACE_NONE,
    PNG_COMPRESSION_TYPE_DEFAULT,
    PNG_FILTER_TYPE_DEFAULT);

  
  png_write_info(write_ptr, write_info_ptr);

  int x = width, y = height;
  
  double min_x, min_y, max_x, max_y;
  getMinXYMaxXY(winmin, winmax, x, y,
                min_x, min_y, max_x, max_y);

  double iMult = (max_x - min_x) / (x - 1);
  double iBase = min_x;
  double jMult = (max_y - min_y) / (y - 1);
  double jBase = min_y;

  unsigned char* row_pointer = new unsigned char[3*x];
  
  if(realmode == 0) {
    for (int j = y-1; j >= 0; j--) {
      cout << (y-1-j) << "/" << y << endl;
      for (int i = 0; i < x; i++) {
        cplx z(i*iMult+iBase, j*jMult+jBase);
        COLORREF color = f_formula->eval(z).couleur24();
        row_pointer[i*3+2] = (color>>0)  & 0xFF;
        row_pointer[i*3+1] = (color>>8)  & 0xFF;
        row_pointer[i*3+0] = (color>>16) & 0xFF;
      }
      png_write_row(write_ptr, row_pointer);
    }
  } else {
    double d0 = 0;
    double d1 = 0;
    unsigned int color_base = 0, color = 0;
    double *valeurs = new double[x];
    double *valeursj = new double[x];
    double *coefdirs = new double[x - 1];
    for (int i = 0; i < x; i++) {
      cplx z(i*iMult+iBase, 0);
      valeurs[i] = f_formula->eval(z).real();
      valeursj[i] = (valeurs[i] - jBase)/jMult;
    }
    for (int i = 0; i < x-1; i++) {
      double tmp = (valeursj[i+1]-valeursj[i]);
      coefdirs[i] = 1.0/sqrt(1.0+tmp*tmp);
      coefdirs[i] *= tmp > 0 ? 1 : -1;
    }
    for (int j = y-1; j >= 0; j--) {
      cout << (y-1-j) << "/" << y << endl;
      color_base = cplx(j * jMult + jBase, 0).couleur24();
      for (int i = 0; i < x; i++) {
        //Calcul de la distance du point à la courbe
        double dmin = 2.0;
        if((j > valeursj[i]+0.5 && (i == 0 || j > valeursj[i - 1] + 0.5)
                                && (i == x - 1 || j > valeursj[i + 1] + 0.5))
           || (j < valeursj[i]-0.5 && (i == 0 || j < valeursj[i - 1] - 0.5)
                                   && (i == x - 1 || j < valeursj[i + 1] - 0.5)))
        {
        } else {
          if (i > 0) {
            d0 = (valeursj[i] - j) * coefdirs[i-1];
          }
          if (i < x - 1) {
            d1 = (j - valeursj[i]) * coefdirs[i];
          } else {
            d1 = d0;
          }
          if (i == 0) d0 = d1;
          if(d0 <= 0 && d1 <= 0) {
            dmin = j > valeursj[i] ? j - valeursj[i] : valeursj[i] - j;
          } else if(d0 >= 0 && d1 >= 0) {
            if(d0 > d1) {
              dmin = d1;
            } else {
              dmin = d0;
            }
          } else {
            if(d0 > 0)
              dmin = d0;
            if(d1 > 0)
              dmin = d1;
          }
        }
        const double limup = 1.014;
        if(dmin <= 0.5) {          // Pile sur la ligne
          color = color_base;
        } else if(dmin >= limup) { // En dehors de la ligne
          color = 0xFFFFFF;
        } else {                   // Sur la limite de la ligne: dégradé
          double coef = (dmin - 0.5)/(limup - 0.5);
          unsigned int blu = ((color_base & 0xFF0000) >> 16);
          unsigned int gre = ((color_base & 0x00FF00) >> 8);
          unsigned int red =  (color_base & 0x0000FF);
          red = (int)(255.0 * coef + (1.0 - coef) * red);
          gre = (int)(255.0 * coef + (1.0 - coef) * gre);
          blu = (int)(255.0 * coef + (1.0 - coef) * blu);
          color = RGB(red, gre, blu);
        }
        row_pointer[i*3+0] = (color>>0)  & 0xFF;
        row_pointer[i*3+1] = (color>>8)  & 0xFF;
        row_pointer[i*3+2] = (color>>16) & 0xFF;
      }
      png_write_row(write_ptr, row_pointer);
    }
    delete []valeurs;
    delete []valeursj;
    delete []coefdirs;
  }
  delete []row_pointer;
  f_formula = f_formula->kill();
  f_formulalatex = f_formulalatex->kill();
  //Writes comments
  //Formula
  //@Options, etc.
  png_text text_title, text_comment, text_software, text_latex;
  text_title.compression    = -1; // "tEXt" No compression
  text_comment.compression  = -1;
  text_software.compression = -1;
  text_latex.compression = -1;

  text_title.key    = TEXT("Title");
  text_comment.key  = TEXT("Comment");
  text_software.key = TEXT("Software");
  text_latex.key = TEXT("LaTeX");

  text_title.text    = TEXT("Reflex");
  text_software.text = TEXT("Reflex Renderer");
  bool first_item_entered = false;
  string ss_string;
  ostringstream ss(stringstream::in | stringstream::out);
  ss << comment_string << endl;
  ss << final_funcstring << endl;
  ss << options_line_string <<" ";
  ss << "winmin=" << winmin_string<<"; ";
  ss << "winmax=" << winmax_string<<"; ";
  ss << "width=" << width << "; ";
  ss << "height=" << height << "; ";
  ss << "colornan=" << showbase << hex << colornan;
  ss_string = ss.str();
  text_comment.text = const_cast<char*>(ss_string.c_str());
  
  ostringstream ss2(stringstream::in | stringstream::out);
  ss2 << final_funcstringlatex;
  string ss2_string;
  ss2_string = ss2.str();
  text_latex.text = const_cast<char*>(ss2_string.c_str());
  
  //cout << "String got : " << ss.str() << endl;
  //cout << "Written in png : " << text_comment.text << endl;
  
  text_title.text_length    = strlen(text_title.text);
  text_comment.text_length  = strlen(text_comment.text);
  text_software.text_length = strlen(text_software.text);
  text_latex.text_length = strlen(text_latex.text);

  png_set_text(write_ptr, write_info_ptr, &text_title, 1);
  png_set_text(write_ptr, write_info_ptr, &text_comment, 1);
  png_set_text(write_ptr, write_info_ptr, &text_software, 1);
  png_set_text(write_ptr, write_info_ptr, &text_latex, 1);

  png_write_end(write_ptr, write_info_ptr);
  png_destroy_write_struct(&write_ptr, &write_info_ptr);
  cout << "Done." << endl;
  return 0;
}

int calculateNewWindow(int width, int height, const char* winmin_string,
                   const char* winmax_string, int deltax, int deltay) {
  bool fine = true;
  //int errpos = 0;
  cplx winmin, winmax;
  fine = fine && getCplx(winmin_string, "Winmin", winmin);
  fine = fine && getCplx(winmax_string, "Winmax", winmax);
  if(!fine) {
    return -1;
  }
  double min_x, min_y, max_x, max_y;

  getMinXYMaxXY(winmin, winmax, width, height,
                min_x, min_y, max_x, max_y);
  width -= 1;
  height -= 1;
  double move_real = (deltax * (max_x - min_x)) / width;
  double move_imag = (deltay * (max_y - min_y)) / height;
  cplx new_winmin(min_x + move_real, min_y + move_imag);
  cplx new_winmax(max_x + move_real, max_y + move_imag);
  char new_winmin_string[256];
  char new_winmax_string[256];
  new_winmin.toString(new_winmin_string);
  new_winmax.toString(new_winmax_string);
  cout << new_winmin_string << ";" << new_winmax_string << endl;
  return 0;
}

int simplify_formula(const char* formula_string, int seed_init, STRING_TYPE formula_style, bool autoscale) {
  bool fine = true;
  int errpos = 0;

  //TCHAR final_funcstring[MAX_FUNC_LENGTH];

  srand(seed_init);
  // We force the simplification of the formula
  Function *f_formula = getFunction(formula_string, NULL, "Formula", true, formula_style, autoscale);
  fine = fine && f_formula;
  if(f_formula)	f_formula = f_formula->kill();
  if(!fine) {
    return -1;
  }
  //cout << "formula:" << final_funcstring << endl;
  return 0;
  /*
    //TODO : Delete everything
  int size_func = MAX_FUNC_LENGTH;
  TCHAR* funcStringEnd = 0;
  TCHAR* funcString = 0;
  while(true) {
    funcString = new TCHAR[size_func + 1];
    TCHAR* funcStringMax = funcString+size_func;

    funcStringEnd = f_formula->toStringConst(funcString, funcStringMax, formula_style);
    if(funcStringEnd == funcStringMax) {
      delete funcString;
      size_func *= 2;
      continue;
    }
    break;
  }
  if(funcStringEnd) *(funcStringEnd)=L'\0';
  if(funcString) cout << "formula:" << funcString << endl;
  else           cout << "Error ! unable to convert formula to string" << endl;
  if(f_formula)  f_formula = f_formula->kill();
  if(funcString) delete funcString;
  return 0;*/
}

inline void set_if_tag(const char* arg, const char* TAG, const char * &var) {
  size_t t = _tcslen(TAG);
  if(_strnicmp(arg, TAG, t)==0)
    var = arg+t;
}
inline void set_if_null(const char* &value, const char* DEFAULT) {
  if(value == NULL) {
    value = DEFAULT;
  }
}


int main(int argc, char* argv[]) {
  
  argstream as(argc, argv);

  bool render_mode;
  bool new_window;
  bool simplify_mode;
  as >> option("render", render_mode,
    "Renders the reflex to a *.bmp or *.png file.\n"
    "Used options are --width, --height, --winmin, --winmax, --output, --colornan, --realmode, --seed");
  as >> option("new_window", new_window,
    "Returns new window coordinates if the original window is shifted.\n"
    "Used options are --width, --height, --winmin, --winmax, --delta_x, --delta_y.");
  as >> option("simplify", simplify_mode,
    "Simplifies an expression/function. Like a calculator.\n"
    "Used options are --formula, --seed");

  string formula_string= "0";
  string formulalatex_string= "";
  int width = 201;
  int height = 201;
  string winmin_string = "-4-4i";
  string winmax_string = "4+4i";
  string output_string = "tmp.png";
  string deltax_string = "0";  int delta_x=0;
  string deltay_string = "0";  int delta_y=0;
  string comment_string = "";
  int seed   = 1;
  string colornan_string = "0xFFFFFF";
  unsigned int colornan = 0xFFFFFF;
  bool realmode;
  bool openoffice_formula;
  bool latex_formula;
  bool autoscale;
  STRING_TYPE formula_style = DEFAULT_TYPE;

  as >> parameter('f', "formula", formula_string, "A formula like (1+2-x)/sin(z%i)", false)
     >> parameter('t', "formula4latex", formulalatex_string, "If the formula for LaTeX should be different", false)
     >> parameter('w', "width", width, "The rendering width in pixels", false)
     >> parameter('h', "height", height, "The rendering height in pixels", false)
     >> parameter('m', "winmin", winmin_string, "The lower left complex of the reflex", false)
     >> parameter('n', "winmax", winmax_string, "The upper right complex of the reflex", false)
     >> parameter('o', "output", output_string, "The file where to render", false)
     >> parameter('s', "seed", seed, "The seed used by the functions randh and randf", false)
     >> parameter('c', "colornan", colornan_string, "The default NaN color in hex", false)
     >> option('r', "realmode", realmode, "If it only renders the real part")
     >> option('p', "openoffice", openoffice_formula, "If it outputs the formule using OpenOffice style")
     >> option('l', "latex", latex_formula, "If it outputs the formule using LaTeX style")
     >> parameter('d', "delta_x", deltax_string, "The horizontal shift", false)
     >> parameter('e', "delta_y", deltay_string, "The vertical shift", false)
     >> parameter('x', "comment", comment_string, "The comment for the formula", false)
     >> option('s', "autoscale", autoscale, "If it finds a multiplicator to find it.")
     >> help();

  SSCANF(deltax_string.c_str(), "%d", &delta_x);
  SSCANF(deltay_string.c_str(), "%d", &delta_y);
  SSCANF(colornan_string.c_str(), "%x", &colornan);

  if(formulalatex_string == "") {
    formulalatex_string = formula_string;
  }
  
  if(output_string.size() < 4) {
    cout << "The output file name "<<output_string<< " is not valid. It should end with .png or .bmp" << endl;
    exit(0);
  }
  string format_string = output_string.substr(output_string.size()-3,3);
  if(format_string.compare("png") != 0 && format_string.compare("bmp") != 0) {
    cout << "Only bmp and png are supported, not " << format_string << endl;
    exit(0);
  }
  if (as.helpRequested()) {
    cout<<as.usage()<<endl;
    exit(0);
  }
  if(!as.isOk()) {
    as.defaultErrorHandling();
    exit(1);
  }

  if(openoffice_formula) formula_style = OPENOFFICE3_TYPE;
  if(latex_formula)      formula_style = LATEX_TYPE;

  if(render_mode) {
    bool is_png = (format_string == "png");
    if(is_png) {
      return renderPng(formula_string.c_str(), formulalatex_string.c_str(), width, height,
          winmin_string.c_str(), winmax_string.c_str(), output_string.c_str(),
          seed, colornan, realmode, comment_string, autoscale);
    } else {
      return renderBmp(formula_string.c_str(), width, height,
          winmin_string.c_str(), winmax_string.c_str(), output_string.c_str(),
          seed, colornan, realmode, autoscale);
    }
  }
  if(simplify_mode) {
    return simplify_formula(formulalatex_string.c_str(), seed, formula_style, autoscale);
  }
  if(new_window) {
    //cout << width << ", " << height << ", " << delta_x << ", " << delta_y << endl;
    return calculateNewWindow(width, height, winmin_string.c_str(),
                              winmax_string.c_str(), delta_x, delta_y);
  }
  
  /*
  task_scheduler_init init;
  string str[N] = { string("a"), string("b") };
  for (size_t i = 2; i < N; ++i) str[i] = str[i-1]+str[i-2];
  string &to_scan = str[N-1];

  cout << "String to scan:" << endl << to_scan << endl;

  size_t *max = new size_t[to_scan.size()];
  size_t *pos = new size_t[to_scan.size()];

  parallel_for(blocked_range<size_t>(0, to_scan.size()),
      SubStringFinder(to_scan, max, pos),
      auto_partitioner());

  for (size_t i = 0; i < to_scan.size(); ++i) {
    cout << " " << max[i] << "(" << pos[i] << ")";
    if (max[i] > 0) {
      cout << " matched on " << to_scan.substr(i, max[i]+1);
    }
    cout << endl;
  }*/
  //system("pause");
  return 0;
}
