/*******************************
 * Name:	lexeme.h
 * Author:	Mika�l Mayer
 * Purpose:	The lexeme class and its derived
	enable to get a small part of string and
	to interpret it correctly
 * History: Work started 20070901
 *********************************/

#ifndef LEXEME_H
#define LEXEME_H
#include "complex.h"
#include "functions.h"
#include "functionFactory.h"
#include <stdlib.h>

enum PARSE_ERROR {
PARSE_ERROR_SPECIALIZED,
PARSE_ERROR_END,
PARSE_ERROR_UNKNOWN,
PARSE_ERROR_OPENING_PARENTHESIS,
PARSE_ERROR_CLOSING_PARENTHESIS,
PARSE_ERROR_COMA,
PARSE_ERROR_VARIABLE,
PARSE_ERROR_INT,
PARSE_ERROR_FLOAT,
PARSE_ERROR_UNKNOWN_FUNCTION,
PARSE_ERROR_EMPTY,
NUM_PARSE_ERRORS,
NO_PARSE_ERROR = -1} ;

class Lexeme {
public:
	Lexeme *lexPrec;//Pour tous les tuer � la fin.
	virtual bool isComplex()			{return false;}
	virtual bool isFloat()				{return false;}
	virtual bool isInt()				{return false;}
	virtual bool isChain()				{return false;}
	virtual bool isFunction()			{return false;}
	virtual int  numberArguments()		{return false;}
	virtual bool isOperator()			{return false;}
	virtual bool isOpeningParenthesis()	{return false;}
	virtual bool isClosingParenthesis()	{return false;}
	virtual bool isComa()				{return false;}
	virtual bool isVariable()			{return false;}

	virtual bool isOperatorNormal()		{throw PARSE_ERROR_SPECIALIZED;}
	virtual cplx valueComplex()			{throw PARSE_ERROR_SPECIALIZED;}
	virtual int valueInt()				{throw PARSE_ERROR_SPECIALIZED;}
	virtual double valueFloat()			{throw PARSE_ERROR_SPECIALIZED;}
	virtual TCHAR* valueChain()			{throw PARSE_ERROR_SPECIALIZED;}
	virtual TCHAR* valueFunction()		{throw PARSE_ERROR_SPECIALIZED;}
	virtual TCHAR valueOperator()		{throw PARSE_ERROR_SPECIALIZED;}
	virtual TCHAR* valueVariable()		{throw PARSE_ERROR_SPECIALIZED;}
	virtual Function *getFunction1(Function *argument1, bool marked)	{throw PARSE_ERROR_SPECIALIZED;}
  virtual FunctionFactory* getFunctionFactory()	{throw PARSE_ERROR_SPECIALIZED;}
	virtual Function *getOperator(Function *argument1, Function *argument2, bool marked)	{throw PARSE_ERROR_SPECIALIZED;}
	virtual Function *getOperatorPuissance(Function *argument1, int argument2, bool marked)	{throw PARSE_ERROR_SPECIALIZED;}
	virtual ~Lexeme() {}
};

class LexInt:public Lexeme {public:
	int valeur;
	LexInt(int valeur):valeur(valeur) {}
	bool isInt() {return true;}
	int valueInt() {return valeur;}
};

class LexFloat:public Lexeme {public:
	double valeur;
	LexFloat(double valeur):valeur(valeur) {}
	bool isFloat() {return true;}
	double valueFloat() {return valeur;}
};

class LexComplex:public Lexeme {public:
	cplx valeur;
	LexComplex(cplx valeur):valeur(valeur) {};
	bool isComplex() {return true;}
	cplx valueComplex() {return valeur;}
};

class LexChain:public Lexeme {public:
	TCHAR *nom;
	LexChain(TCHAR* nom, int count) {
		this->nom = nom;
//		_tcscpy(this->nom, nom);
	}
	~LexChain() {free(nom);}
	bool isChain() {return true;}
	TCHAR *valueChain() {return nom;}
};

class LexFunction:public Lexeme {public:
	TCHAR *nom;
  bool marked; // Has a mark in front of it, used for rendering.
	LexFunction(const TCHAR* debut, int count, bool _marked) {
		nom = (TCHAR*)malloc((count+1)*sizeof(TCHAR));
		memcpy(nom, debut, count*sizeof(TCHAR));
		*(nom+count)=L'\0';	//Terminal character.
    marked = _marked;
	}
	~LexFunction() {
		free(nom);
	}
  bool hasZeroArguments() {
    return (*nom == L'z' || *nom == L'x' || *nom == L'y') && (*(nom+1) == L'\0');
  }
  bool isFunction()		{
    return true;
  }
	TCHAR *valueFunction()	{
		return nom;
	}
  FunctionFactory* getFunctionFactory() {
           if(_tcscmp(nom, TEXT("z"))==0) {
			return new IdentityFactory();
		} else if(_tcscmp(nom, TEXT("x"))==0) {
			return new Identity_xFactory();
		} else if(_tcscmp(nom, TEXT("y"))==0) {
			return new Identity_yFactory();
		} else if(_tcscmp(nom, TEXT("sin"))==0) {
			return new SinFactory();
		} else if(_tcscmp(nom, TEXT("cos"))==0) {
			return new CosFactory();
		} else if(_tcscmp(nom, TEXT("tan"))==0) {
			return new TanFactory();
		} else if(_tcscmp(nom, TEXT("exp"))==0) {
			return new ExpFactory();
		} else if(_tcscmp(nom, TEXT("sinh"))==0) {
			return new SinhFactory();
		} else if(_tcscmp(nom, TEXT("cosh"))==0) {
			return new CoshFactory();
		} else if(_tcscmp(nom, TEXT("tanh"))==0) {
			return new TanhFactory();
		} else if(_tcscmp(nom, TEXT("ln"))==0) {
			return new LnFactory();
		} else if(_tcscmp(nom, TEXT("sqrt"))==0) {
			return new SqrtFactory();
		} else if(_tcscmp(nom,TEXT("argsh"))==0) {
			return new ArgshFactory();
		} else if(_tcscmp(nom, TEXT("argch"))==0) {
			return new ArgchFactory();
		} else if(_tcscmp(nom, TEXT("argth"))==0) {
			return new ArgthFactory();
		} else if(_tcscmp(nom, TEXT("arcsin"))==0) {
			return new ArcsinFactory();
		} else if(_tcscmp(nom, TEXT("arccos"))==0) {
			return new ArccosFactory();
		} else if(_tcscmp(nom, TEXT("arctan"))==0) {
			return new ArctanFactory();
		} else if(_tcscmp(nom, TEXT("real"))==0) {
			return new RealFactory();
		} else if(_tcscmp(nom, TEXT("imag"))==0) {
			return new ImagFactory();
		} else if(_tcscmp(nom, TEXT("circle"))==0) {
			return new CircleFactory();
		} else if(_tcscmp(nom, TEXT("conj"))==0) {
			return new ConjFactory();
		} else
			throw PARSE_ERROR_UNKNOWN_FUNCTION;
  }

  Function *getFunction1(Function *argument1, bool marked) {
		       if(_tcscmp(nom, TEXT("z"))==0) {
			return new Identity(marked);
		} else if(_tcscmp(nom, TEXT("x"))==0) {
			return new Identity_x(marked);
		} else if(_tcscmp(nom, TEXT("y"))==0) {
			return new Identity_y(marked);
		} else if(_tcscmp(nom, TEXT("sin"))==0) {
			return new Sin(argument1, marked);
		} else if(_tcscmp(nom, TEXT("cos"))==0) {
			return new Cos(argument1, marked);
		} else if(_tcscmp(nom, TEXT("tan"))==0) {
			return new Tan(argument1, marked);
		} else if(_tcscmp(nom, TEXT("exp"))==0) {
			return new Exp(argument1, marked);
		} else if(_tcscmp(nom, TEXT("sinh"))==0) {
			return new Sinh(argument1, marked);
		} else if(_tcscmp(nom, TEXT("cosh"))==0) {
			return new Cosh(argument1, marked);
		} else if(_tcscmp(nom, TEXT("tanh"))==0) {
			return new Tanh(argument1, marked);
		} else if(_tcscmp(nom, TEXT("ln"))==0) {
			return new Ln(argument1, marked);
		} else if(_tcscmp(nom, TEXT("sqrt"))==0) {
			return new Sqrt(argument1, marked);
		} else if(_tcscmp(nom,TEXT("argsh"))==0) {
			return new Argsh(argument1, marked);
		} else if(_tcscmp(nom, TEXT("argch"))==0) {
			return new Argch(argument1, marked);
		} else if(_tcscmp(nom, TEXT("argth"))==0) {
			return new Argth(argument1, marked);
		} else if(_tcscmp(nom, TEXT("arcsin"))==0) {
			return new Arcsin(argument1, marked);
		} else if(_tcscmp(nom, TEXT("arccos"))==0) {
			return new Arccos(argument1, marked);
		} else if(_tcscmp(nom, TEXT("arctan"))==0) {
			return new Arctan(argument1, marked);
		} else if(_tcscmp(nom, TEXT("real"))==0) {
			return new Real(argument1, marked);
		} else if(_tcscmp(nom, TEXT("imag"))==0) {
			return new Imag(argument1, marked);
		} else if(_tcscmp(nom, TEXT("circle"))==0) {
			return new Circle(argument1, marked);
		} else if(_tcscmp(nom, TEXT("conj"))==0) {
			return new Conj(argument1, marked);
		} else
			throw PARSE_ERROR_UNKNOWN_FUNCTION;
	}
	Function *getFunctionBinaire(Function *argument1, Function *argument2, bool marked) {
		if(_tcscmp(nom, TEXT("o"))==0) {
			return new Compose(argument1, argument2, marked);
		} else
			throw PARSE_ERROR_UNKNOWN_FUNCTION;
	}
	Function *getFunctionRecursive(Function *argument1, int argument2, bool marked) {
		if(_tcscmp(nom, TEXT("oo"))==0) {
			return new CompositionRecursive(argument1, argument2, marked);
		} else
			throw PARSE_ERROR_UNKNOWN_FUNCTION;
	}
	Function *getFunctionIncrementale(Function *argument, Variable* var, Function* debut, Function* fin, Function* step, bool _marked) {
		if(_tcscmp(nom, TEXT("sum"))==0) {
			return new SommeMultiple(argument, var, debut, fin, step, _marked);
		} else if(_tcscmp(nom, TEXT("prod"))==0) {
			return new ProduitMultiple(argument, var, debut, fin, step, _marked);
		} else if(_tcscmp(nom, TEXT("comp"))==0) {
      step->kill();
			return new CompositionMultiple(argument, var, debut, fin, _marked);
		} else
			throw PARSE_ERROR_UNKNOWN_FUNCTION;
	}

	bool isBinaire() {
		if(_tcscmp(nom, TEXT("o"))==0)
			return true;
		return false;
	}
	bool isCompositionRecursive() {
		return _tcscmp(nom, TEXT("oo"))==0;
	}
	bool isIncrementeur() {
		return _tcscmp(nom, TEXT("sum"))==0 || _tcscmp(nom, TEXT("prod"))==0 || _tcscmp(nom, TEXT("comp"))==0;
	}
	int isAlea() {
		return _tcscmp(nom, TEXT("randh"))==0?1:_tcscmp(nom, TEXT("randf"))==0?2:0;
	}
};

class LexOperator:public Lexeme {public:
	TCHAR nom;
	LexOperator(TCHAR nom) { this->nom=nom; }
	bool isOperator() {return true;}
	bool isOperatorNormal() {return nom==L'+'||nom==L'-'||nom==L'*'||nom==L'/';}
	TCHAR valueOperator() {return nom;}
	Function *getOperator(Function *argument1, Function *argument2, bool marked) {
		if(nom==L'+') {
			return new Somme(argument1, argument2, marked);
		} else if(nom==L'*') {
			return new Multiplication(argument1, argument2, marked);
		} else if(nom==L'/') {
			return new Division(argument1, argument2, marked);
		} else if(nom==L'-') {
			return new Soustraction(argument1, argument2, marked);
		}
		throw PARSE_ERROR_UNKNOWN;
	}
	virtual Function *getOperatorPuissance(Function *argument1, int argument2, bool marked) {
		if(nom==L'^') {
			return new Exposant(argument1, argument2, marked);
		}
		throw PARSE_ERROR_UNKNOWN;
	}
};

class LexOpeningParenthesis:public Lexeme {public:
	LexOpeningParenthesis() {}
	bool isOpeningParenthesis() {return true;}
};

class LexClosingParenthesis:public Lexeme {public:
	LexClosingParenthesis() {}
	bool isClosingParenthesis() {return true;}
};

class LexComa:public Lexeme{public:
	LexComa() {}
	bool isComa() {return true;}
};

class LexVariable:public Lexeme{public:
  bool marked;
	LexVariable(const TCHAR* debut, int count, bool _marked) {
    marked = _marked;
    if(!marked) {
		  nom = (TCHAR*)malloc((count+1)*sizeof(TCHAR));
		  memcpy(nom, debut, count*sizeof(TCHAR));
		  *(nom+count)=L'\0';	//Terminal character.
    } else {
      nom = (TCHAR*)malloc((count+1-1)*sizeof(TCHAR));
		  memcpy(nom, debut, count*sizeof(TCHAR));
      memcpy(nom+1, debut+2, (count-2)*sizeof(TCHAR));
		  *(nom+count-1)=L'\0';	//Terminal character.
    }
	}
	~LexVariable() { free(nom);	}
	bool isVariable() { return true; }
	TCHAR *valueVariable() {return nom;}
private:
	TCHAR *nom;
};

#endif
