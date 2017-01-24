/*******************************
 * Name:	functions_tostring.cpp
 * Author:	Mikaël Mayer
 * Purpose:	Implements the toString methods of Function class
 * History: Work started 20070901
 *********************************/
#include <stdio.h>
#include <iostream>
#include "stdafx.h"
#include "functions.h"
using namespace std;

void renderFunctionName(StringRendering &s, bool marked, TCHAR* name) {
  TCHAR first = name[0];
  TCHAR first_upper = first >= 'a' && first <= 'z' ? first - 32: first;
  TCHAR* remaining = name + 1;
  
  if(s.type() == LATEX_TYPE) {
    if(marked) { s << TEXT("\\text{\\Huge ");
    s << TEXTC(first_upper);
    if(*remaining != 0) s << "}\\text{";
    } else { s << TEXT("\\text{") << TEXTC(first); }
    if(*remaining != 0) s << TEXT(remaining);
    s << TEXTC('}');
  } else {
    if(marked) {
      s << TEXTC('_');
    }
    s << TEXT(name);
  }
}

TCHAR *Function::toStringConst(TCHAR* const data_const, TCHAR *max_data, STRING_TYPE string_type) {
  TCHAR* data = data_const;
  if(string_type == OPENOFFICE3_TYPE) {
    StringRenderingOpenOffice s(data_const, max_data);
    s << this;
    return s.data;
  } else if(string_type == LATEX_TYPE) {
    StringRenderingLaTeX s(data_const, max_data);
    *dynamic_cast<StringRendering*>(&s) << TEXT("\\left{");
    s << this;
    *dynamic_cast<StringRendering*>(&s) << TEXT("\\right}");
    return s.data;
  }
  //if(string_type == DEFAULT_TYPE) {
  StringRendering s(data_const, max_data);
  s << this;
  return s.data;
  //}
}

void FunctionUnary::toString_name(StringRendering &s,
                                  TCHAR* function_name, bool parenthesis) {
  if(parenthesis) {
    s << function_name << TEXTC('(') << argument << TEXTC(')');
  } else if(s.type() == OPENOFFICE3_TYPE || s.type() == LATEX_TYPE) {
    s << function_name << TEXTC('{') << argument << TEXTC('}');
  } else {
    s << function_name << argument;
  }
}

void FunctionBinary::toString_symbol(StringRendering &s, TCHAR* symbol, bool parentheses_possibles) {
  if(argument->priorite() < priorite() && parentheses_possibles) {
    s << TEXTC('(') << argument << TEXTC(')');
  } else if(s.type() == OPENOFFICE3_TYPE || s.type() == LATEX_TYPE) {
    s << TEXTC('{') << argument << TEXTC('}');
  } else {
    s << argument;
  }

  s << symbol;

	if(argument2->priorite() <= priorite())
    s << TEXTC('(') << argument2 << TEXTC(')');
  else if(s.type() == OPENOFFICE3_TYPE || s.type() == LATEX_TYPE)
    s << TEXTC('{') << argument2 << TEXTC('}');
  else
    s << argument2;
}
void Identity::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("z"));
}
void Identity_x::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("x"));
}
void Identity_y::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("y"));
}


// Les fonction toString:

void Somme::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    toString_symbol(s, TEXT("+"));
  } else if(name_variant == PLUS) {
    renderFunctionName(s, this->marked, TEXT("plus"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void Soustraction::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    toString_symbol(s, TEXT("-"));
  } else if(name_variant == MOINS) {
    renderFunctionName(s, this->marked, TEXT("moins"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  } else if(name_variant == MINUS) {
    renderFunctionName(s, this->marked, TEXT("minus"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void Modulo::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    toString_symbol(s, TEXT("%"));
  } else if(name_variant == MODULO) {
    renderFunctionName(s, this->marked, TEXT("modulo"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  } else if(name_variant == MOD) {
    renderFunctionName(s, this->marked, TEXT("mod"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void Multiplication::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    if(s.type() == OPENOFFICE3_TYPE)
      toString_symbol(s, TEXT(" cdot "));
    else if(s.type() == LATEX_TYPE)
      toString_symbol(s, TEXT("\\cdot{}"));
    else
      toString_symbol(s, TEXT("*"));
  } else if(name_variant == MULTIPLIE) {
    renderFunctionName(s, this->marked, TEXT("multiplie"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  } else if(name_variant == MULTIPLY) {
    renderFunctionName(s, this->marked, TEXT("multiply"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void LessEq::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    if(s.type() == LATEX_TYPE) toString_symbol(s, TEXT("\\le{}")); else toString_symbol(s, TEXT("<="));
  } else if(name_variant == LESSEQ) {
    renderFunctionName(s, this->marked, TEXT("lesseq"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void Less::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    toString_symbol(s, TEXT("<"));
  } else if(name_variant == LESS) {
    renderFunctionName(s, this->marked, TEXT("less"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void GreaterEq::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    if(s.type() == LATEX_TYPE) toString_symbol(s, TEXT("\\ge{}")); else toString_symbol(s, TEXT(">="));
  } else if(name_variant == GREATEREQ) {
    renderFunctionName(s, this->marked, TEXT("greatereq"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void Greater::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    toString_symbol(s, TEXT(">"));
  } else if(name_variant == GREATER) {
    renderFunctionName(s, this->marked, TEXT("greater"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void Equals::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    toString_symbol(s, TEXT("=="));
  } else if(name_variant == EQUALS) {
    renderFunctionName(s, this->marked, TEXT("equals"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void NotEquals::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    toString_symbol(s, TEXT("<>"));
  } else if(name_variant == NOTEQUALS) {
    renderFunctionName(s, this->marked, TEXT("notequals"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void Division::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    if(s.type() == OPENOFFICE3_TYPE)
      toString_symbol(s, TEXT(" over "), false);
    else if(s.type() == LATEX_TYPE) {
      s << TEXT("\\frac");
      s << TEXTC('{') << argument << TEXTC('}');
      s << TEXTC('{') << argument2 << TEXTC('}');
    } else {
      toString_symbol(s, TEXT("/"));
    }
  } else if(name_variant == DIVISION) {
    renderFunctionName(s, this->marked, TEXT("division"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  } else if(name_variant == QUOTIENT) {
    renderFunctionName(s, this->marked, TEXT("quotient"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void ExposantComplexe::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    if(argument->priorite() <= priorite()) {
      s << TEXTC('(') << argument << TEXTC(')');
    } else if(s.type() == OPENOFFICE3_TYPE || s.type() == LATEX_TYPE) {
      s << TEXTC('{') << argument << TEXTC('}');
    } else {
      s << argument;
    }
    s << TEXTC('^');
    if(s.type() == OPENOFFICE3_TYPE || s.type() == LATEX_TYPE)
      s << TEXTC('{') << argument2 << TEXTC('}');
    else if(argument2->priorite() <= priorite()) {
      s << TEXTC('(') << argument2 << TEXTC(')');
    } else {
      s << argument2;
    }
  } else if(name_variant == EXPOSANT) {
    renderFunctionName(s, this->marked, TEXT("exposant"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  } else if(name_variant == PUISSANCE) {
    renderFunctionName(s, this->marked, TEXT("puissance"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void Repeat::toString(StringRendering &s) {
  if(name_variant == REPEAT) {
    renderFunctionName(s, this->marked, TEXT("repeat"));
  } else if(name_variant == REPETE) {
    renderFunctionName(s, this->marked, TEXT("repete"));
  }
  s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
}

void IfThenElse::toString(StringRendering &s) {
  if(name_variant == IFTHENELSE) {
    renderFunctionName(s, this->marked, TEXT("ifthenelse"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(',') << argument3 << TEXTC(')');
  } else if(name_variant == IF) {
    renderFunctionName(s, this->marked, TEXT("if"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(',') << argument3 << TEXTC(')');
  } else if(name_variant == IF_THEN_ELSE) {
    renderFunctionName(s, this->marked, TEXT("if "));
    s << argument;
    renderFunctionName(s, this->marked, TEXT(" then "));
    s << argument2;
    renderFunctionName(s, this->marked, TEXT(" else "));
    s << argument3;
  }
}


void Compose::toString(StringRendering &s) {
  if(name_variant == COMPOSE) {
    renderFunctionName(s, this->marked, TEXT("o"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  } else if(name_variant == DIRECT) {
    s << argument << TEXTC('(') << argument2 << TEXTC(')');
  }
}

void Diff::toString(StringRendering &s) {
  if(name_variant == DIFF) {
    renderFunctionName(s, this->marked, TEXT("diff"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  } else if(name_variant == DERIVE) {
    renderFunctionName(s, this->marked, TEXT("derive"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void IfError::toString(StringRendering &s) {
  if(name_variant == IFERROR) {
    renderFunctionName(s, this->marked, TEXT("iferror"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  } else if(name_variant == COLORNAN) {
    renderFunctionName(s, this->marked, TEXT("colornan"));
    s << TEXTC('(') << argument << TEXTC(',') << argument2 << TEXTC(')');
  }
}

void CompositionRecursive::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("oo"));
  s << TEXTC('(') << argument << TEXTC(',') << nbCompose << TEXTC(')');
}


void Exposant::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    if(argument->priorite() <= priorite()) {
      s << TEXTC('(');
      s << argument;
      s << TEXTC(')');
    } else if(s.type() == OPENOFFICE3_TYPE || s.type() == LATEX_TYPE) {
      s << TEXTC('{') << argument << TEXTC('}');
    } else {
      s << argument;
    }
    s << TEXTC('^') << exposant;
  } else if(name_variant == SQUARE){
    renderFunctionName(s, this->marked, TEXT("square"));
    s << TEXTC('(') << argument << TEXTC(')');
  } else if(name_variant == CARRE){
    renderFunctionName(s, this->marked, TEXT("carre"));
    s << TEXTC('(') << argument << TEXTC(')');
  } else if(name_variant == CUBE){
    renderFunctionName(s, this->marked, TEXT("cube"));
    s << TEXTC('(') << argument << TEXTC(')');
  }
}

void Constante::toString(StringRendering &s) {
	TCHAR nombre[256];
  if(marked) {
    if(s.type() == LATEX_TYPE) {
      valeur.toStringMarkedLatex(nombre);
    } else {
      valeur.toStringMarked(nombre);
    }
  } else {
	  valeur.toString(nombre);
  }
  //bool parenthesis = (_tcschr(nombre, TEXTC('+'))!=NULL || _tcschr(nombre, TEXTC('-'))!=NULL);
	//if(parenthesis) s << TEXTC('(');
  s << nombre;
	//if(parenthesis) s << TEXTC(')');
}

void Oppose::toString(StringRendering &s) {
  FunctionUnary::toString_name(s, TEXT("-"));
}

void Module::toString(StringRendering &s) {
  if(name_variant == MODULE) {
    renderFunctionName(s, this->marked, TEXT("module"));
  } else if(name_variant == MODULUS) {
    renderFunctionName(s, this->marked, TEXT("modulus"));
  } else if(name_variant == ABS) {
    renderFunctionName(s, this->marked, TEXT("abs"));
  } else if(name_variant == VALABS) {
    renderFunctionName(s, this->marked, TEXT("valabs"));
  }
  FunctionUnary::toString_name(s, TEXT(""));
}

void Inverse::toString(StringRendering &s) {
  if(name_variant == INVERSE) {
    renderFunctionName(s, this->marked, TEXT("inverse"));
  } else if(name_variant == INV) {
    renderFunctionName(s, this->marked, TEXT("inv"));
  }
  FunctionUnary::toString_name(s, TEXT(""));
}

void Heaviside::toString(StringRendering &s) {
  if(name_variant == HEAVISIDE) {
    renderFunctionName(s, this->marked, TEXT("heaviside"));
  } else if(name_variant == HEAV) {
    renderFunctionName(s, this->marked, TEXT("heav"));
  }
  FunctionUnary::toString_name(s, TEXT(""));
}

void Newton::toString(StringRendering &s) {
  if(name_variant == NEWTON) {
    renderFunctionName(s, this->marked, TEXT("newton"));
  }
  FunctionUnary::toString_name(s, TEXT(""));
}

void Gamma::toString(StringRendering &s) {
  if(name_variant == GAMMA) {
    renderFunctionName(s, this->marked, TEXT("gamma"));
  }
  FunctionUnary::toString_name(s, TEXT(""));
}

void Factorial::toString(StringRendering &s) {
  if(name_variant == SYMBOL) {
    if(argument->priorite() < priorite()) {
      s << TEXTC('(') << argument << TEXTC(')');
    } else if(s.type() == OPENOFFICE3_TYPE || s.type() == LATEX_TYPE) {
      s << TEXTC('{') << argument << TEXTC('}');
    } else {
      s << argument;
    }
    s << "!";
  } else {
    if(name_variant == FACTORIAL) {
      renderFunctionName(s, this->marked, TEXT("factorial"));
    } else if(name_variant = FACT) {
      renderFunctionName(s, this->marked, TEXT("fact"));
    } else if(name_variant = FACTORIELLE) {
      renderFunctionName(s, this->marked, TEXT("factorielle"));
    }
    FunctionUnary::toString_name(s, TEXT(""));
  }
}

void Floor::toString(StringRendering &s) {
  if(name_variant == FLOOR) {
    renderFunctionName(s, this->marked, TEXT("floor"));
  }
  FunctionUnary::toString_name(s, TEXT(""));
}

void Beta::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge B}\\text{eta}"));
    } else {
      FunctionUnary::toString_name(s, TEXT("\\text{beta}"));
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_beta"));
    } else {
      FunctionUnary::toString_name(s, TEXT("beta"));
    }
  }
}

void Zeta::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge Z}\\text{eta}"));
    } else {
      FunctionUnary::toString_name(s, TEXT("\\text{zeta}"));
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_zeta"));
    } else {
      FunctionUnary::toString_name(s, TEXT("zeta"));
    }
  }
}

void Unitary::toString(StringRendering &s) {
  if(name_variant == UNITARY) {
    renderFunctionName(s, this->marked, TEXT("unitary"));
  } else if(name_variant == UNITAIRE) {
    renderFunctionName(s, this->marked, TEXT("unitaire"));
  } else if(name_variant == UNIT) {
    renderFunctionName(s, this->marked, TEXT("unit"));
  } else if(name_variant == SIGN) {
    renderFunctionName(s, this->marked, TEXT("sign"));
  } else if(name_variant == SIGNE) {
    renderFunctionName(s, this->marked, TEXT("signe"));
  }
  FunctionUnary::toString_name(s, TEXT(""));
}


void Sin::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge S}\\text{in}"));
    } else {
      FunctionUnary::toString_name(s, TEXT("\\text{sin}"));
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_sin"));
    } else {
      FunctionUnary::toString_name(s, TEXT("sin"));
    }
  }
}




void Cos::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE){
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge C}\\text{os}"));
    } else {
      FunctionUnary::toString_name(s, TEXT("\\text{cos}"));
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_cos"));
    } else {
      FunctionUnary::toString_name(s, TEXT("cos"));
    }
  }
}
void Tan::toString(StringRendering &s) {
	if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge T}\\text{an}"));
    } else {
      FunctionUnary::toString_name(s, TEXT("\\text{tan}"));
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_tan"));
    } else {
      FunctionUnary::toString_name(s, TEXT("tan"));
    }
  }
}

void Exp::toString(StringRendering &s) {
  if(s.type() == OPENOFFICE3_TYPE || s.type() == LATEX_TYPE) {
    if(s.type() == LATEX_TYPE && this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge E}\\text{xp}"));
    } else {
      s << TEXT("e^{") << argument << TEXT("}");
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_exp"));
    } else {
      FunctionUnary::toString_name(s, TEXT("exp"));
    }
  }
}

void Cosh::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge C}\\text{osh}"));
    } else {
      FunctionUnary::toString_name(s, TEXT("\\text{cosh}"));
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_cosh"));
    } else {
      FunctionUnary::toString_name(s, TEXT("cosh"));
    }
  }
}

void Sinh::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge S}\\text{inh}"));
    } else {
      FunctionUnary::toString_name(s, TEXT("\\text{sinh}"));
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_sinh"));
    } else {
      FunctionUnary::toString_name(s, TEXT("sinh"));
    }
  }
}

void Tanh::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE){
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge T}\\text{anh}"));
    } else {
      FunctionUnary::toString_name(s, TEXT("\\text{tanh}"));
    }
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_tanh"));
    } else {
      FunctionUnary::toString_name(s, TEXT("tanh"));
    }
  }
}

void Ln::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("ln"));
  s << TEXTC('(') << argument;
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    s << TEXTC(',') << argument2;
  }
  s << TEXTC(')');
}


void Arg::toString(StringRendering &s) {
  if(name_variant == ARG) {
    renderFunctionName(s, this->marked, TEXT("arg"));
  } else if(name_variant == ARGUMENT) {
    renderFunctionName(s, this->marked, TEXT("argument"));
  }
  s << TEXTC('(') << argument;
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    s << TEXTC(',') << argument2;
  }
  s << TEXTC(')');
}

void Sqrt::toString(StringRendering &s) {
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    if(name_variant == SQRT) {
      renderFunctionName(s, this->marked, TEXT("sqrt"));
    } else if(name_variant == RACINE) {
      renderFunctionName(s, this->marked, TEXT("racine"));
    }
    s << TEXTC('(') << argument;
    if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
      s << TEXTC(',') << argument2;
    }
    s << TEXTC(')');
  } else if(s.type() == LATEX_TYPE) { // Argument 2 is null
    if(this->marked) {
      if(name_variant == SQRT) {
        renderFunctionName(s, this->marked, TEXT("sqrt"));
      } else if(name_variant == RACINE) {
        renderFunctionName(s, this->marked, TEXT("racine"));
      }
      s << TEXTC('(') << argument << TEXTC(')');
    } else {
      s << TEXT("\\sqrt{") << argument << TEXT("}");
    }
  } else if(s.type() == OPENOFFICE3_TYPE) {
    s << TEXT("sqrt{") << argument << TEXT("}");
  } else {
    if(this->marked) {
      s << TEXT("_");
    }
    if(name_variant == SQRT) {
      FunctionUnary::toString_name(s, TEXT("sqrt"));
    } else if(name_variant == RACINE) {
      FunctionUnary::toString_name(s, TEXT("racine"));
    }
  }
}

void Argsh::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("argsh"));
  s << TEXTC('(') << argument;
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    s << TEXTC(',') << argument2;
  }
  s << TEXTC(')');
}

void Argch::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("argch"));
  s << TEXTC('(') << argument;
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    s << TEXTC(',') << argument2;
  }
  s << TEXTC(')');
}

void Argth::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("argth"));
  s << TEXTC('(') << argument;
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    s << TEXTC(',') << argument2;
  }
  s << TEXTC(')');
}

void Arcsin::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("arcsin"));
  s << TEXTC('(') << argument;
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    s << TEXTC(',') << argument2;
  }
  s << TEXTC(')');
}

void Arccos::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("arccos"));
  s << TEXTC('(') << argument;
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    s << TEXTC(',') << argument2;
  }
  s << TEXTC(')');
}

void Arctan::toString(StringRendering &s) {
  renderFunctionName(s, this->marked, TEXT("arctan"));
  s << TEXTC('(') << argument;
  if(argument2 != NULL && !(argument2->isConstant() && dynamic_cast<Constante*>(argument2)->valeur == ZERO)) {
    s << TEXTC(',') << argument2;
  }
  s << TEXTC(')');
}


void Real::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge R}\\text{eal}"));
    } else {
      s << TEXT("\\Re(") << argument << TEXT(")");
    }
  } else if(s.type() == OPENOFFICE3_TYPE) {
    s << TEXT("Re(") << argument << TEXT(")");
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_real"));
    } else {
      FunctionUnary::toString_name(s, TEXT("real"));
    }
  }
}

void Imag::toString(StringRendering &s) {
	if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge I}\\text{mag}"));
    } else {
      s << TEXT("\\Im(") << argument << TEXT(")");
    }
  } else if(s.type() == OPENOFFICE3_TYPE) {
    s << TEXT("Im(") << argument << TEXT(")");
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_imag"));
    } else {
      FunctionUnary::toString_name(s, TEXT("imag"));
    }
  }
}

void Conj::toString(StringRendering &s) {
	if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("\\text{\\Huge C}\\text{onj}"));
    } else {
      s << TEXT("\\overline{") << argument << TEXT("}");
    }
  } else if(s.type() == OPENOFFICE3_TYPE) {
    s << TEXT("Bar{") << argument << TEXT("}");
  } else {
    if(this->marked) {
      FunctionUnary::toString_name(s, TEXT("_conj"));
    } else {
      FunctionUnary::toString_name(s, TEXT("conj"));
    }
  }
}

void Circle::toString(StringRendering &s) {
  TCHAR* ircle = name_variant == CIRCLE ? TEXT("ircle") : TEXT("ercle");
  if(s.type() == LATEX_TYPE) {
    if(this->marked) {
      s << TEXT("\\text{\\Huge C}\\text{") << ircle << TEXT("}");
    } else {
      s << TEXT("\\text{c") << ircle << TEXT("}");
    }
    FunctionUnary::toString_name(s, TEXT(""));
  } else if(s.type() == OPENOFFICE3_TYPE) {
    if(this->marked) {
      s << TEXT("\"c") << ircle << TEXT("\"");
    } else {
      s << TEXT("\"c") << ircle << TEXT("\"");
    }
    FunctionUnary::toString_name(s, TEXT(""));
  } else {
    if(this->marked) {
      s << TEXT("_c");
    } else s << TEXT("c");
    s << ircle;
    FunctionUnary::toString_name(s, TEXT(""));
  }
}

void VariableRef::toString(StringRendering &s) {
  bool tmp = pointer->marked;
  pointer->marked = this->marked;
  pointer->toString(s);
  pointer->marked = tmp;
}

void Variable::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE && this->marked) {
    if(*nom == TEXTC('$')) {
      TCHAR first_upper = *(nom+1) >= 'a' && *(nom+1) <= 'z' ? *(nom+1) - 32: *(nom+1);
      s << TEXT("\\text{\\Huge ") << first_upper << TEXT("}");
    } else {
      TCHAR first_upper = *nom >= 'a' && *nom <= 'z' ? *nom - 32: *nom;
      s << TEXT("\\text{\\Huge ") << nom << TEXT("}");
    }
  } else {
    if(this->marked) {
      if(*nom == TEXTC('$')) {
        s << TEXT("$_") << (nom+1);
      } else {
        s << TEXTC('_') << nom;
      }
    } else {
      if((s.type() == LATEX_TYPE || s.type() == OPENOFFICE3_TYPE) && *nom == TEXTC('$')) {
        s << (nom + 1);
      } else {
        s << nom;
      }
    }
  }
}

void FunctionMultiple::toString_multiple(StringRendering &s, TCHAR* function_name) {
  if(s.type() == LATEX_TYPE && !this->marked) {
    s << function_name << TEXT("_{");
    s << var << TEXT("=") << debut;
    if(!(step->isConstant() && step->eval(I).real() == 1 && step->eval(I).imag() == 0)) {
      s << TEXT(",") << var << TEXT("+=") << step;
    }
    s << TEXT("}^{");
    s << fin;
    s << TEXT("}{");
    s << argument;
    s << TEXT("}");
    return;
  } else if(s.type() == OPENOFFICE3_TYPE) {
    s << function_name << TEXT(" from {");
    s << var << TEXT("=") << debut;
    if(!(step->isConstant() && step->eval(I).real() == 1 && step->eval(I).imag() == 0)) {
      s << TEXT(", ") << var << TEXT("+=") << step;
    }
    s << TEXT("} to {");
    s << fin;
    s << TEXT("} {");
    s << argument;
    s << TEXT("}");
    return;
  }
  renderFunctionName(s, this->marked, function_name);
  s << TEXTC('(');
    s << argument;
  s << TEXTC(',');
	  s << var;
	s << TEXTC(',');
    s << debut;
	s << TEXTC(',');
    s << fin;
	s << TEXTC(',');
    s << step;
	s << TEXTC(')');
}

void SommeMultiple::toString(StringRendering &s) {
  //sum from{i=1} to{3} {}
  if(name_variant == SUM) {
    if(s.type() == LATEX_TYPE)
      toString_multiple(s, TEXT("\\sum"));
    else if(s.type() == OPENOFFICE3_TYPE)
      toString_multiple(s, TEXT("sum"));
    else
      toString_multiple(s, TEXT("sum"));
  } else if(name_variant == SOMME) {
    if(s.type() == LATEX_TYPE)
      toString_multiple(s, TEXT("\\somme"));
    else if(s.type() == OPENOFFICE3_TYPE)
      toString_multiple(s, TEXT("somme"));
    else
      toString_multiple(s, TEXT("somme"));
  }
}

void ProduitMultiple::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE && !this->marked)
    toString_multiple(s, TEXT("\\prod"));
  else if(s.type() == OPENOFFICE3_TYPE)
    toString_multiple(s, TEXT("prod"));
  else
    toString_multiple(s, TEXT("prod"));
}

//Open Office model?
void CompositionMultiple::toString(StringRendering &s) {
  if(s.type() == LATEX_TYPE) {
    s << TEXT("\\text{comp}");
  } else if(s.type() == OPENOFFICE3_TYPE) {
    s << TEXT("\"comp\"");
  } else {
    renderFunctionName(s, this->marked, TEXT("comp"));
  }
  s << TEXTC('(');
    s << argument;
	s << TEXTC(',');
	  s << var;
	s << TEXTC(',');
    s << debut;
	s << TEXTC(',');
    s << fin;
	s << TEXTC(')');
}

//LetIn
void LetIn::toString(StringRendering &s) {
  if(name_variant%LET_SPACE_ADD == LET) {
    renderFunctionName(s, this->marked, TEXT("let"));
  } else if(name_variant%LET_SPACE_ADD == FUNCTION) {
    renderFunctionName(s, this->marked, TEXT("function"));
  } else if(name_variant%LET_SPACE_ADD == FONCTION) {
    renderFunctionName(s, this->marked, TEXT("fonction"));
  } else if(name_variant%LET_SPACE_ADD == FUNC) {
    renderFunctionName(s, this->marked, TEXT("func"));
  } else if(name_variant%LET_SPACE_ADD == FONC) {
    renderFunctionName(s, this->marked, TEXT("fonc"));
  }
  if(name_variant >= LET_SPACE_ADD) {
    if(s.type() == LATEX_TYPE) s << TEXT("\\text{ }"); else s << TEXTC(' ');
    s << var;
    s << TEXTC('=');
    s << debut;
    if(s.type() == LATEX_TYPE) s << TEXT("\\text{ in }"); else s << TEXT(" in ");
    s << argument;
  } else {
    s << TEXTC('(');
      s << argument;
    s << TEXTC(',');
      s << var;
    s << TEXTC(',');
      s << debut;
    s << TEXTC(')');
  }
}

//SetIn
void SetIn::toString(StringRendering &s) {
  if(name_variant%SET_SPACE_ADD == SET) {
    renderFunctionName(s, this->marked, TEXT("set"));
  } else if(name_variant%SET_SPACE_ADD == SOIT) {
    renderFunctionName(s, this->marked, TEXT("soit"));
  }
  if(name_variant >= SET_SPACE_ADD) {
    if(s.type() == LATEX_TYPE) s << TEXT("\\text{ }"); else s << TEXTC(' ');
    s << var;
    s << TEXTC('=');
    s << debut;
    if(s.type() == LATEX_TYPE) s << TEXT("\\text{ in }"); else s << TEXT(" in ");
    s << argument;
  } else {
    s << TEXTC('(');
      s << argument;
    s << TEXTC(',');
      s << var;
    s << TEXTC(',');
      s << debut;
    s << TEXTC(')');
  }
}

StringRendering::StringRendering(TCHAR* const data_, TCHAR* const max_data_):
  data(data_), max_data(max_data_)
 {
}

bool StringRendering::notReachedEnd() {
  return data != max_data;
}

StringRendering& StringRendering::operator<<(Function* const f) {
  if(f) f->toString(*this);
  return *this;
}

StringRendering& StringRendering::operator<<(TCHAR tch) {
  if(notReachedEnd()) {
    *(data++) = tch;
  }
  return *this;
}

StringRendering& StringRendering::operator<<(TCHAR* str) {
  size_t required_tchars = _tcslen(str);
  while(required_tchars > 0) {
    *this << *(str++);
    required_tchars--;
  }
  return *this;
}



StringRendering& StringRendering::operator<<(int number) {
  TCHAR number_string[256];
	_stprintf(number_string, TEXT("%d"), number);
  *this << number_string;
  return *this;
}
StringRendering& StringRendering::operator<<(double number) {
  TCHAR number_string[256];
	_stprintf(number_string, TEXT("%g"), number);
  *this << number_string;
  return *this;
}

StringRenderingOpenOffice::StringRenderingOpenOffice(
  TCHAR* const data, TCHAR* const max_data):
    StringRendering(data, max_data) {
}

StringRendering& StringRenderingOpenOffice::operator<<(Function* const f) {
  StringRendering::operator <<(f);
  return *this;
}

StringRendering& StringRenderingOpenOffice::operator<<(TCHAR tch) {
  if(notReachedEnd()) {
    if(tch == TEXTC('(')) {
      StringRendering::operator <<(TEXT(" left "));
      StringRendering::operator <<(TEXTC('('));
    } else if(tch == TEXTC(')')) {
      StringRendering::operator <<(TEXT(" right "));
      StringRendering::operator <<(TEXTC(')'));
    } else {
      *(data++) = tch;
    }
  }
  return *this;
}

StringRenderingLaTeX::StringRenderingLaTeX(
  TCHAR* const data, TCHAR* const max_data):
    StringRendering(data, max_data) {
}
    
StringRendering& StringRenderingLaTeX::operator<<(Function* const f) {
  StringRendering::operator <<(f);
  return *this;
}

StringRendering& StringRenderingLaTeX::operator<<(TCHAR tch) {
  if(notReachedEnd()) {
    if(tch == TEXTC('(')) {
      StringRendering::operator <<(TEXT("\\left"));
      StringRendering::operator <<(TEXTC('('));
    } else if(tch == TEXTC(')')) {
      StringRendering::operator <<(TEXT("\\right"));
      StringRendering::operator <<(TEXTC(')'));
    } else {
      *(data++) = tch;
    }
  }
  return *this;
}

/*StringRendering& StringRenderingLaTeX::operator<<(TCHAR* str) {
  *(dynamic_cast<StringRendering*>(this)) << str;
  return *this;
}*/
