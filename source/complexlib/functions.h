/*******************************
 * Name:	functions.h
 * Author:	Mikaël Mayer
 * Purpose:	The Function class enables to dynamically calculate
		expressions with complex-number.
			The Identity::get() is a substitute for calculating z.
 * History: Work started 20070901
 *********************************/

//To delete a node without deleting children, call the delete function.
//to completely delete a tree, call the kill function before.

#ifndef FUNCTIONS_H
#define FUNCTIONS_H
#include <iostream>
#include "complex.h"
class VariableRef;
class Variable;
class StringRendering;
typedef int NAME_VARIANT;
#define SYMBOL 0
#define DEFAULT_NAME_VARIANT 0
using namespace std;

enum STRING_TYPE {
  DEFAULT_TYPE,
  OPENOFFICE3_TYPE,
  LATEX_TYPE
};

class Function {
	public:
    bool marked;
    NAME_VARIANT name_variant;

    virtual bool isIdentity() {return false;}
		virtual bool isConstant() {return false;}
		virtual bool isVariable() {return false;}
		//virtual bool isVariable() {return false;}
		virtual Function* simplifie() {return this;}
		virtual cplx eval(const cplx & z)=0;
		virtual void toString(StringRendering &s)=0;

    TCHAR *toStringConst(TCHAR* const data, TCHAR *max_data, STRING_TYPE type=DEFAULT_TYPE);
		virtual Function* kill()=0;	//Fonction récursive.
		virtual int priorite()=0;
		virtual ~Function() {}
		Function(bool _marked, NAME_VARIANT n) { marked = _marked; name_variant = n; }
    Function(bool _marked) { marked = _marked; name_variant = DEFAULT_NAME_VARIANT; }
};
//La priorité est utilisée pour mettre des parenthèses dans la fonction toString().
//si un argument a une priorité plus grande, pas la peine de le mettre en parenthèses.
//Sinon, parenthèses obligatoire.
// + a une priorité de 1
// - a une priorité de 2
// * a une priorité de 3
// / a une priorité de 4
// ^ a une priorité de 5
//sin a une priorité de 6 comme les autres fonctions.
//Les variables et constantes ont une priorité de 10 (pas besoin de parenthèses).
//Les constantes se mettent automatiquement des parenthèses.


class Constante:public Function {
public:
	cplx valeur;
	bool isConstant() {return true;}
	Constante(double valeur);
	Constante(cplx valeur);
  Constante(cplx valeur, bool marked);
	void setCplx(cplx c) {valeur = c;}
	void setReal(double re) {valeur.setreal(re);}
	void setImag(double im) {valeur.setimag(im);}
	Function* kill() { delete this; return NULL; }
	cplx eval(const cplx & z) {return valeur;}
	virtual void toString(StringRendering &s);
	int priorite() {
    if(valeur.imag() == ZERO || valeur == J) {
      return 10;
    }
    if(valeur.real() != 0 && valeur.imag() != 0) {
      return 1;
    }
    if(valeur.real() == 0) {
      if(valeur.imag() < 0) {
        return 1;
      } else {
        if(valeur.imag() == 1) {
          return 10;
        } else { 
          return 4;
        }
      }
    } else if(valeur.real() < 0) {
      return 1;
    } else return 10;
  }
  bool isInt() {
    double intpart;
    return valeur.imag() == 0 && modf(valeur.real(), &intpart) == 0.0; }
};

//Identity function.
class Identity:public Function {
public:
  Identity(bool _marked):Function(_marked) {}
	~Identity() {}
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	Function* kill() { delete this; return NULL; }
	int priorite() { return 10; }
  virtual bool isIdentity() {return true;}
};

class Identity_x:public Function {
public:
	Identity_x(bool _marked):Function(_marked) {}
	~Identity_x () {}
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	Function* kill() { delete this; return NULL; }
	int priorite() { return 10; }
};

class Identity_y:public Function {
public:
	Identity_y(bool _marked):Function(_marked) {}
	~Identity_y () {}
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	Function* kill() { delete this; return NULL; }
	int priorite() { return 10; }
};

class FunctionUnary:public Function {
protected:
	Function* argument;	//Jamais NULL
public:
	FunctionUnary(Function* theArgument, bool _marked);
  FunctionUnary(Function* theArgument, bool _marked, NAME_VARIANT n);
	virtual ~FunctionUnary();
	virtual Function* kill();
	void setArgument(Function* theArgument);
	virtual Function* simplifie();
  void toString_name(StringRendering &s, TCHAR* function_name, bool parenthesis = true);
	bool simplifieArgFunctionUnary();
};

class FunctionBinary:public FunctionUnary {
protected:
	Function* argument2;  //Jamais NULL
public:
	FunctionBinary(Function* theArgument, Function* theArgument2, bool _marked);
	FunctionBinary(Function* theArgument, Function* theArgument2, bool _marked, NAME_VARIANT n);
	virtual ~FunctionBinary();
	virtual Function* kill();
	void setArgument2(Function* theArgument2);
	virtual Function* simplifie();
  void toString_symbol(StringRendering &s, TCHAR *symbol, bool parentheses_possibles=true);
	bool simplifieArgFunctionBinary();
};

class FunctionTernary:public FunctionBinary {
protected:
	Function* argument3;  //Jamais NULL
public:
	FunctionTernary(Function* theArgument, Function* theArgument2, Function* theArgument3, bool _marked);
	FunctionTernary(Function* theArgument, Function* theArgument2, Function* theArgument3, bool _marked, NAME_VARIANT n);
	virtual ~FunctionTernary();
	virtual Function* kill();
  void setArgument3(Function* theArgument3);
	virtual Function* simplifie();
  void toString_symbol(StringRendering &s, TCHAR *symbol, bool parentheses_possibles=true);
	bool simplifieArgFunctionTernary();
};

#define ZEROCONST new Constante(ZERO)

#define ARG 0
#define ARGUMENT 1
class Arg:public FunctionBinary {
public:
	Arg(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
  Arg(Function* argument, bool _marked, NAME_VARIANT n):FunctionBinary(argument, ZEROCONST, _marked, n) {};
  Arg(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

// The second parameter is the value taken for the argument modulo 2pi
class Ln:public FunctionBinary {
private:
public: //new Constante(ZERO)
  Ln(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	Ln(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define SQRT 0
#define RACINE 1
class Sqrt:public FunctionBinary {
public:
	Sqrt(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked, SQRT) {};
  Sqrt(Function* argument, bool _marked, NAME_VARIANT n):FunctionBinary(argument, ZEROCONST, _marked, n) { };
  Sqrt(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) { };
  
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define PLUS 1
class Somme:public FunctionBinary {
public:
	Somme(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked, SYMBOL){}
  Somme(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n){ }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 2;}
};

#define MULTIPLIE 1
#define MULTIPLY 2
class Multiplication:public FunctionBinary {
public:
	Multiplication(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked, SYMBOL){}
  Multiplication(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n){ }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 3;}
};

#define MOINS 1
#define MINUS 2
class Soustraction:public FunctionBinary {
public:
	Soustraction(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked, SYMBOL){}
  Soustraction(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n){
  }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 2;}
};


#define MOD 1
#define MODULO 2
class Modulo:public FunctionBinary {
public:
	Modulo(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked, SYMBOL){}
  Modulo(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n){
  }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 3;}
};


#define DIVISION 1
#define QUOTIENT 2
class Division:public FunctionBinary {
public:
	Division(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked, SYMBOL){}
  Division(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n){ }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 3;}
};

#define COMPOSE 0
// Corresponds to direct composition $f(z+1) is interpreted as o($f,z+1)
#define DIRECT 1 
class Compose:public FunctionBinary {
public:
	Compose(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked) {}
  Compose(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {}
	virtual Function *simplifie();
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define REPEAT 0
#define REPETE 1
class Repeat:public FunctionBinary {
public:
	Repeat(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked) {}
  Repeat(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) { }
	virtual Function *simplifie();
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define EXPOSANT 1
#define PUISSANCE 2
class ExposantComplexe:public FunctionBinary {
public:
	ExposantComplexe(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked, SYMBOL) {}
  ExposantComplexe(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) { }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 5;}
};

#define DIFF 0
#define DERIVE 1
class Diff:public FunctionBinary {
public:
	Diff(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked, DIFF) {}
  Diff(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) { }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 5;}
};


#define IFERROR 0
#define COLORNAN 1
class IfError:public FunctionBinary {
public:
  IfError(Function* argument, Function* argument2, bool _marked):FunctionBinary(argument, argument2, _marked, IFERROR) {};
  IfError(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define CARRE 1
#define SQUARE 2
#define CUBE 3
class Exposant:public FunctionUnary {
public:
	Exposant(Function* argument, int exposant, bool _marked):FunctionUnary(argument, _marked, SYMBOL),exposant(exposant) {}
  Exposant(Function* argument, int exposant, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n),exposant(exposant) {}
	int exposant;
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 5;}
};

class CompositionRecursive:public FunctionUnary {
public:
	CompositionRecursive(Function* argument, int nbCompose, bool _marked):FunctionUnary(argument, _marked),nbCompose(nbCompose) {}
	int nbCompose;
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};



#define NEWTON 0
class Newton:public FunctionUnary {
public:
	Newton(Function* argument, bool _marked):FunctionUnary(argument, _marked, NEWTON) {}
  Newton(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) { }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 5;}
};

#define GAMMA 0
class Gamma:public FunctionUnary {
public:
	Gamma(Function* argument, bool _marked):FunctionUnary(argument, _marked, NEWTON) {}
  Gamma(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) { }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 5;}
};

#define FACTORIAL 1
#define FACT 2
#define FACTORIELLE 3
class Factorial:public FunctionUnary {
public:
	Factorial(Function* argument, bool _marked):FunctionUnary(argument, _marked, FACTORIAL) {}
  Factorial(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) { }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 5;}
};

#define FLOOR 0
class Floor:public FunctionUnary {
public:
	Floor(Function* argument, bool _marked):FunctionUnary(argument, _marked, NEWTON) {}
  Floor(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) { }
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 5;}
};


class Oppose:public FunctionUnary {
public:
	Oppose(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx &z);
	virtual void toString(StringRendering &s);
	int priorite() {return 2;}
};

#define MODULE 0
#define MODULUS 1
#define ABS 2
#define VALABS 3
class Module:public FunctionUnary {
public:
	Module(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
  Module(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define INVERSE 0
#define INV 1
class Inverse:public FunctionUnary {
public:
	Inverse(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
  Inverse(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define HEAVISIDE 0
#define HEAV 1
class Heaviside:public FunctionUnary {
public:
	Heaviside(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
  Heaviside(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define IFTHENELSE 0
#define IF 1
#define IF_THEN_ELSE 2
class IfThenElse:public FunctionTernary {
public:
	IfThenElse(Function* argument, Function* argument2, Function* argument3, bool _marked):FunctionTernary(argument, argument2, argument3, _marked) {};
  IfThenElse(Function* argument, Function* argument2, Function* argument3, bool _marked, NAME_VARIANT n):FunctionTernary(argument, argument2, argument3, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() { if(name_variant != IF_THEN_ELSE) return 6; else return 1;}
};


class Beta:public FunctionUnary {
public:
	Beta(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Zeta:public FunctionUnary {
public:
	Zeta(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Sin:public FunctionUnary {
public:
	Sin(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};


class Cos:public FunctionUnary {
public:
	Cos(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Tan:public FunctionUnary {
public:
	Tan(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Exp:public FunctionUnary {
public:
	Exp(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Sinh:public FunctionUnary {
public:
	Sinh(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Cosh:public FunctionUnary {
public:
	Cosh(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Tanh:public FunctionUnary {
public:
	Tanh(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define UNITARY 0
#define UNITAIRE 1
#define UNIT 2
#define SIGN 3
#define SIGNE 4
class Unitary:public FunctionUnary {
public:
	Unitary(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
  Unitary(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) { };
  
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Argsh:public FunctionBinary {
public:
	Argsh(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
  Argsh(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Argch:public FunctionBinary {
public:
	Argch(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
  Argch(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Argth:public FunctionBinary {
public:
	Argth(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
  Argth(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Arcsin:public FunctionBinary {
public:
	Arcsin(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	Arcsin(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Arccos:public FunctionBinary {
public:
	Arccos(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
  Arccos(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Arctan:public FunctionBinary {
public:
	Arctan(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	Arctan(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

/***
 * Comparison functions 
 **/
#define LESSEQ 1
class LessEq:public FunctionBinary {
public:
	LessEq(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	LessEq(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 1;}
};

#define LESS 1
class Less:public FunctionBinary {
public:
	Less(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	Less(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 1;}
};

#define EQUALS 1
class Equals:public FunctionBinary {
public:
	Equals(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	Equals(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 1;}
};

#define NOTEQUALS 1
class NotEquals:public FunctionBinary {
public:
	NotEquals(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	NotEquals(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 1;}
};

#define GREATER 1
class Greater:public FunctionBinary {
public:
	Greater(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	Greater(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 1;}
};

#define GREATEREQ 1
class GreaterEq:public FunctionBinary {
public:
	GreaterEq(Function* argument, bool _marked):FunctionBinary(argument, ZEROCONST, _marked) {};
	GreaterEq(Function* argument, Function* argument2, bool _marked, NAME_VARIANT n):FunctionBinary(argument, argument2, _marked, n) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 1;}
};

//

class Real:public FunctionUnary {
public:
	Real(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Imag:public FunctionUnary {
public:
	Imag(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class Conj:public FunctionUnary {
public:
	Conj(Function* argument, bool _marked):FunctionUnary(argument, _marked) {};
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

#define CIRCLE 0
#define CERCLE 1
class Circle:public FunctionUnary {
public:
	Circle(Function* argument, bool _marked):FunctionUnary(argument, _marked, CIRCLE) {};
	Circle(Function* argument, bool _marked, NAME_VARIANT n):FunctionUnary(argument, _marked, n) { };
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};


//Variable complexe d'une valeur ou d'une fonction.
class Variable:public Function {
private:
	cplx val;
  bool declared;
  int last_position;
  Function* fun;
	TCHAR *nom;
	Variable *prec;
	Variable(TCHAR* theNom, bool _marked):Function(_marked),val(0) {setNom(theNom); declared = false; fun = NULL; last_position=0;}
	Variable(cplx & theValeur, TCHAR* theNom, bool _marked):Function(_marked),val(theValeur) {setNom(theNom); declared = false; fun = NULL; last_position=0;}
	~Variable();
	void setNom(const TCHAR* theNom);
	Variable *prev() {return prec;}
	void setPrev(Variable *prev) {prec=prev;}
public:
  TCHAR* getName() { return nom; }
  bool isDeclared() { return declared; }
  void setDeclared() { declared = true; }
  void setPosition(int i) { last_position = i; }
  int getPosition() { return last_position; }
	//bool isVariable() {return true;}
	cplx eval(const cplx & z) { cplx tmp = fun?fun->eval(z):val; return tmp;}
	cplx evalFast() {return val;} // TODO: Detect if wrong.
	virtual void toString(StringRendering &s);
	int priorite() {return 10;}
	Function* kill() { return NULL; }
	void set(cplx & z) {val=z;}
	void set(Function * fz) {fun=fz;}
	friend class VariableListe;
  friend class VariableRef;
  virtual bool isVariable() {return true;}
};


// Pointeur vers une variable
class VariableRef:public Function {
  private:
	  Variable* pointer;
  public:
    VariableRef(Variable* theRef, bool marked):Function(marked),pointer(theRef) {}
    //bool isVariable() {return true;}
    ~VariableRef();
    virtual void toString(StringRendering &s);
    int priorite() {return 10;}
    virtual Function* simplifie();
    Function* kill() { delete this; return NULL; }
    void set(cplx & z) { pointer->set(z); }
    void set(Function * fz) { pointer->set(fz); }
    friend class VariableListe;
    cplx eval(const cplx & z);
    cplx evalFast() {return pointer->val;} // TODO: Detect if wrong.
    virtual bool isVariable() {return true;}
    bool isDeclared() { return pointer->isDeclared(); }
    void setDeclared() { pointer->setDeclared(); }
    void setPosition(int i) { pointer->setPosition(i); }
    int getPosition() { return pointer->getPosition(); }
};

class FunctionMultiple:public FunctionUnary {
protected:
  VariableRef *var;
	Function *debut;  //Jamais NULL
  Function *fin;    //Jamais NULL
  Function *step;   //Jamais NULL
public:
	FunctionMultiple(Function* _arg, VariableRef *_var, Function *_debut, Function *_fin, Function* _step, bool _marked);
	FunctionMultiple(Function* _arg, VariableRef *_var, Function *_debut, Function *_fin, bool _marked);
	virtual ~FunctionMultiple();
	virtual Function* kill();
	virtual Function* simplifie();
  void toString_multiple(StringRendering &s, TCHAR* symbol);
	bool simplifieArgFunctionMultiple();
};

#define SUM 0
#define SOMME 1
class SommeMultiple:public FunctionMultiple {
public:
	SommeMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, Function* theStep, bool _marked);
  SommeMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, Function* theStep, bool _marked, NAME_VARIANT n);
	SommeMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, bool _marked);
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

class ProduitMultiple:public FunctionMultiple {
public:
	ProduitMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, Function* theStep, bool _marked);
	ProduitMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, bool _marked);
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

//theFin must give an integer to know up to which portion we will compute mandebrot.
//theStep is ignored.
class CompositionMultiple:public FunctionMultiple {
public:
	CompositionMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, bool _marked);
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
	int priorite() {return 6;}
};

//Late-variable binding
#define LET 0
#define FONCTION 1
#define FUNCTION 2
#define FUNC 3
#define FONC 4
#define LET_SPACE_ADD 5
class LetIn:public FunctionMultiple {
public:
	LetIn(Function* argument, VariableRef *theVar, Function* debut, bool _marked, NAME_VARIANT n);
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
  virtual Function* simplifie();
	int priorite() {return name_variant>=LET_SPACE_ADD?1:6;}
};

//value-bounding
#define SET 0
#define SOIT 1
#define SET_SPACE_ADD 5
class SetIn:public FunctionMultiple {
public:
	SetIn(Function* argument, VariableRef *theVar, Function* debut, bool _marked, NAME_VARIANT n);
	cplx eval(const cplx & z);
	virtual void toString(StringRendering &s);
  virtual Function* simplifie();
	int priorite() {return name_variant>=SET_SPACE_ADD?1:6;}
};

//List of variables and their name.
class VariableListe {
private:
	VariableListe() {tete=NULL;count=0;}
	~VariableListe() {}
	Variable *tete;
	int count;
	static VariableListe* varList;
public:
	static VariableListe* get();
	static void killf();
  static Variable* getNonDeclared(); // Returns the pointer to the first used variable non declared.
	//If the variable doesn't exist, it is created.
  //If it exists, a reference to it is created.
	VariableRef* getVariable(TCHAR* nom, bool marked);
};

class StringRendering {
public:
  TCHAR* data;
  const TCHAR* max_data;

  StringRendering(TCHAR* const data, TCHAR* const max_data);
  bool notReachedEnd();
  virtual StringRendering& operator<<(Function *const f);
  virtual StringRendering& operator<<(TCHAR tch);
  virtual StringRendering& operator<<(TCHAR* tch);
  virtual StringRendering& operator<<(int number);
  virtual StringRendering& operator<<(double number);
  virtual STRING_TYPE type() { return DEFAULT_TYPE; }
};

class StringRenderingOpenOffice:public StringRendering {
public:
  StringRenderingOpenOffice(TCHAR* const data, TCHAR* const max_data);

  /// Override
  StringRendering& operator<<(Function *const f);
  StringRendering& operator<<(TCHAR tch);
  STRING_TYPE type() { return OPENOFFICE3_TYPE; }
};

class StringRenderingLaTeX:public StringRendering {
public:
  StringRenderingLaTeX(TCHAR* const data, TCHAR* const max_data);

  /// Override
  StringRendering& operator<<(Function *const f);
  StringRendering& operator<<(TCHAR tch);
  STRING_TYPE type() { return LATEX_TYPE; }
};

#endif
