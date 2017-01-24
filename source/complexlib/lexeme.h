/*******************************
 * Name:	lexeme.h
 * Author:	Mikaël Mayer
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

#define EQ(a,b) (_tcscmp(a, TEXT(b))==0)

enum PARSE_ERROR {
PARSE_ERROR_SPECIALIZED,
PARSE_ERROR_END,
PARSE_ERROR_UNKNOWN,
PARSE_ERROR_OPENING_PARENTHESIS,
PARSE_ERROR_CLOSING_PARENTHESIS,
PARSE_ERROR_COMA,
PARSE_ERROR_SEMICOLON,
PARSE_ERROR_THEN,
PARSE_ERROR_ELSE,
PARSE_ERROR_EQUAL,
PARSE_ERROR_VARIABLE,
PARSE_ERROR_INT,
PARSE_ERROR_FLOAT,
PARSE_ERROR_UNKNOWN_FUNCTION,
PARSE_ERROR_EMPTY,
PARSE_ERROR_VARIABLE_USED_NOT_DECLARED,
NUM_PARSE_ERRORS,
NO_PARSE_ERROR = -1} ;

class Lexeme {
public:
	Lexeme *lexPrec;//Pour tous les tuer à la fin.
	virtual bool isComplex()			{return false;}
	virtual bool isFloat()				{return false;}
	virtual bool isInt()				{return false;}
	virtual bool isChain()				{return false;}
	virtual bool isFunction()			{return false;}
	virtual int  numberArguments()		{return false;}
	virtual bool isOperator()			{return false;}
	virtual bool isComparison()			{return false;}
	virtual bool isOpeningParenthesis()	{return false;}
	virtual bool isClosingParenthesis()	{return false;}
	virtual bool isComa()				{return false;}
	virtual bool isSemicolon()				{return false;}
  virtual bool isEqual()				{return false;}
	virtual bool isVariable()			{return false;}
	virtual bool isIn()			  {return false;}
	virtual bool isThen()			{return false;}
	virtual bool isElse()			{return false;}

	virtual bool isOperatorNormal()		{throw PARSE_ERROR_SPECIALIZED;}
	virtual cplx valueComplex()			{throw PARSE_ERROR_SPECIALIZED;}
	virtual int valueInt()				{throw PARSE_ERROR_SPECIALIZED;}
	virtual double valueFloat()			{throw PARSE_ERROR_SPECIALIZED;}
	virtual TCHAR* valueChain()			{throw PARSE_ERROR_SPECIALIZED;}
	virtual TCHAR* valueFunction()		{throw PARSE_ERROR_SPECIALIZED;}
	virtual TCHAR valueOperator()		{throw PARSE_ERROR_SPECIALIZED;}
	virtual TCHAR* valueVariable()		{throw PARSE_ERROR_SPECIALIZED;}
	//virtual Function *getFunction1(Function *argument1, bool marked)	{throw PARSE_ERROR_SPECIALIZED;}
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
    return (*nom == L'z' || *nom == L'x' || *nom == L'y' || *nom == L'i' || *nom == L'j') && (*(nom+1) == L'\0');
  }
  bool isFunction()		{
    return true;
  }
	TCHAR *valueFunction()	{
		return nom;
	}
  FunctionFactory* getFunctionFactory() {
           if(EQ(nom,"z")) {
			return new IdentityFactory();
		} else if(EQ(nom,"x")) {
			return new Identity_xFactory();
		} else if(EQ(nom,"y")) {
			return new Identity_yFactory();
		} else if(EQ(nom,"i")) {
			return new ConstFactory(I);
		} else if(EQ(nom,"j")) {
			return new ConstFactory(J);
		} else if(EQ(nom,"arg")) {
			return new ArgFactory();
		} else if(EQ(nom,"argument")) {
			return new ArgumentFactory();
		} else if(EQ(nom,"inverse")) {
			return new InverseFactory();
		} else if(EQ(nom,"inv")) {
			return new InvFactory();
		} else if(EQ(nom,"module")) {
			return new ModuleFactory();
		} else if(EQ(nom,"modulus")) {
			return new ModulusFactory();
		} else if(EQ(nom,"abs")) {
			return new AbsFactory();
		} else if(EQ(nom,"valabs")) {
			return new ValAbsFactory();
		} else if(EQ(nom,"beta")) {
			return new BetaFactory();
		} else if(EQ(nom,"zeta")) {
			return new ZetaFactory();
		} else if(EQ(nom,"sin")) {
			return new SinFactory();
		} else if(EQ(nom,"cos")) {
			return new CosFactory();
		} else if(EQ(nom,"tan")) {
			return new TanFactory();
		} else if(EQ(nom,"exp")) {
			return new ExpFactory();
		} else if(EQ(nom,"sinh")) {
			return new SinhFactory();
		} else if(EQ(nom,"cosh")) {
			return new CoshFactory();
		} else if(EQ(nom,"tanh")) {
			return new TanhFactory();
		} else if(EQ(nom,"ln")) {
			return new LnFactory();
		} else if(EQ(nom,"sqrt")) {
			return new SqrtFactory();
		} else if(EQ(nom,"racine")) {
			return new RacineFactory();
    } else if(EQ(nom,"unitary")) {
			return new UnitaryFactory();
    } else if(EQ(nom,"unitaire")) {
			return new UnitaireFactory();
    } else if(EQ(nom,"unit")) {
			return new UnitFactory();
		} else if(EQ(nom,"sign")) {
			return new SignFactory();
		} else if(EQ(nom,"signe")) {
			return new SigneFactory();
		} else if(EQ(nom,"heaviside")) {
			return new HeavisideFactory();
		} else if(EQ(nom,"heav")) {
			return new HeavFactory();
		} else if(EQ(nom,"argsh")) {
			return new ArgshFactory();
		} else if(EQ(nom,"argch")) {
			return new ArgchFactory();
		} else if(EQ(nom,"argth")) {
			return new ArgthFactory();
		} else if(EQ(nom,"arcsin")) {
			return new ArcsinFactory();
		} else if(EQ(nom,"arccos")) {
			return new ArccosFactory();
		} else if(EQ(nom,"arctan")) {
			return new ArctanFactory();
		} else if(EQ(nom,"real")) {
			return new RealFactory();
		} else if(EQ(nom,"imag")) {
			return new ImagFactory();
		} else if(EQ(nom,"circle")) {
			return new CircleFactory();
		} else if(EQ(nom,"cercle")) {
			return new CercleFactory();
		} else if(EQ(nom,"newton")) {
			return new NewtonFactory();
		} else if(EQ(nom,"gamma")) {
			return new GammaFactory();
		} else if(EQ(nom,"factorial")) {
			return new FactorialFactory(FACTORIAL);
		} else if(EQ(nom,"factorielle")) {
			return new FactorialFactory(FACTORIELLE);
		} else if(EQ(nom,"fact")) {
			return new FactorialFactory(FACT);
		} else if(EQ(nom,"floor")) {
			return new FloorFactory();
		} else if(EQ(nom,"conj")) {
			return new ConjFactory();
		} else if(EQ(nom,"cube")) {
			return new CubeFactory();
		} else if(EQ(nom,"carre")) {
			return new CarreFactory();
		} else if(EQ(nom,"square")) {
			return new SquareFactory();
		} else {
      return new VariableFactory(nom);// Check if this variable is good.
    }
		//	throw PARSE_ERROR_UNKNOWN_FUNCTION;
  }
  
  Function *getFunctionTernary(Function *argument1, Function *argument2, Function *argument3, bool marked, bool spaced=false) {
		if(EQ(nom,"if")) {
			return new IfThenElse(argument1, argument2, argument3, marked, spaced?IF_THEN_ELSE:IF);
    } else if(EQ(nom,"ifthenelse")) {
			return new IfThenElse(argument1, argument2, argument3, marked, IFTHENELSE);
    } else {
      throw PARSE_ERROR_UNKNOWN_FUNCTION;
    }
  }

	Function *getFunctionBinary(Function *argument1, Function *argument2, bool marked) {
		if(EQ(nom,"o")) {
			return new Compose(argument1, argument2, marked);
		} else if(EQ(nom,"diff")) {
      return new Diff(argument1, argument2, marked, DIFF);
    } else if(EQ(nom,"derive")) {
      return new Diff(argument1, argument2, marked, DERIVE);
    } else if(EQ(nom,"iferror")) {
      return new IfError(argument1, argument2, marked, IFERROR);
    } else if(EQ(nom,"colornan")) {
      return new IfError(argument1, argument2, marked, COLORNAN);
		} else if(EQ(nom,"division")) {
      return new Division(argument1, argument2, marked, DIVISION);
    } else if(EQ(nom,"quotient")) {
      return new Division(argument1, argument2, marked, QUOTIENT);
		} else if(EQ(nom,"plus")) {
      return new Somme(argument1, argument2, marked, PLUS);
		} else if(EQ(nom,"multiplie")) {
      return new Multiplication(argument1, argument2, marked, MULTIPLIE);
		} else if(EQ(nom,"multiply")) {
      return new Multiplication(argument1, argument2, marked, MULTIPLY);
		} else if(EQ(nom,"exposant")) {
      return new ExposantComplexe(argument1, argument2, marked, EXPOSANT);
		} else if(EQ(nom,"puissance")) {
      return new ExposantComplexe(argument1, argument2, marked, PUISSANCE);
		} else if(EQ(nom,"repete")) {
      return new Repeat(argument1, argument2, marked, REPETE);
		} else if(EQ(nom,"repeat")) {
      return new Repeat(argument1, argument2, marked, REPEAT);
		} else if(EQ(nom,"moins")) {
      return new Soustraction(argument1, argument2, marked, MOINS);
		} else if(EQ(nom,"minus")) {
      return new Soustraction(argument1, argument2, marked, MINUS);
		} else if(EQ(nom,"modulo")) {
      return new Modulo(argument1, argument2, marked, MODULO);
		} else if(EQ(nom,"mod")) {
      return new Modulo(argument1, argument2, marked, MOD);
		} else
			throw PARSE_ERROR_UNKNOWN_FUNCTION;
	}
	Function *getFunctionRecursive(Function *argument1, int argument2, bool marked) {
		if(EQ(nom,"oo")) {
			return new CompositionRecursive(argument1, argument2, marked);
		} else
			throw PARSE_ERROR_UNKNOWN_FUNCTION;
	}
	Function *getFunctionIncrementale(Function *argument, VariableRef* var, Function* debut, Function* fin, Function* step, bool _marked, bool spaced=false) {
		if(EQ(nom,"sum")) {
			return new SommeMultiple(argument, var, debut, fin, step, _marked);
		} else if(EQ(nom,"somme")) {
			return new SommeMultiple(argument, var, debut, fin, step, _marked, SOMME);
		} else if(EQ(nom,"prod")) {
			return new ProduitMultiple(argument, var, debut, fin, step, _marked);
		} else if(EQ(nom,"let")) {
      fin->kill();
      step->kill();
			return new LetIn(argument, var, debut, _marked, LET + (spaced?LET_SPACE_ADD:0));
		} else if(EQ(nom,"function")) {
      fin->kill();
      step->kill();
			return new LetIn(argument, var, debut, _marked, FUNCTION + (spaced?LET_SPACE_ADD:0));
		} else if(EQ(nom,"fonction")) {
      fin->kill();
      step->kill();
			return new LetIn(argument, var, debut, _marked, FONCTION + (spaced?LET_SPACE_ADD:0));
		} else if(EQ(nom,"func")) {
      fin->kill();
      step->kill();
			return new LetIn(argument, var, debut, _marked, FUNC + (spaced?LET_SPACE_ADD:0));
		} else if(EQ(nom,"fonc")) {
      fin->kill();
      step->kill();
			return new LetIn(argument, var, debut, _marked, FONC + (spaced?LET_SPACE_ADD:0));
		} else if(EQ(nom,"set")) {
      fin->kill();
      step->kill();
			return new SetIn(argument, var, debut, _marked, SET + (spaced?SET_SPACE_ADD:0));
		} else if(EQ(nom,"soit")) {
      fin->kill();
      step->kill();
			return new SetIn(argument, var, debut, _marked, SOIT + (spaced?SET_SPACE_ADD:0));
		} else if(EQ(nom,"comp")) {
      step->kill();
			return new CompositionMultiple(argument, var, debut, fin, _marked);
		} else
			throw PARSE_ERROR_UNKNOWN_FUNCTION;
	}
  
  bool isBinder() {
    return EQ(nom,"let") || EQ(nom,"letin") || EQ(nom,"set") || EQ(nom,"setin") || EQ(nom,"soit") || EQ(nom,"where") || EQ(nom,"func") || EQ(nom,"function") || EQ(nom,"fonc") || EQ(nom,"fonction");
  }
  
  bool isIf() {
    return EQ(nom,"if");
  }
  
  bool isRepeat() {
    if(EQ(nom,"repete") || EQ(nom,"repeat")) return true;
    return false;
  }
  
  bool isTernary() {
    return EQ(nom,"if");
  }

	bool isBinary() {
		if(EQ(nom,"o"))
			return true;
    if(EQ(nom,"diff") || EQ(nom,"derive")) return true;
    if(EQ(nom,"colornan") || EQ(nom,"iferror")) return true;
    if(EQ(nom,"division") || EQ(nom,"quotient")) return true;
    if(EQ(nom,"exposant") || EQ(nom,"puissance")) return true;
    if(EQ(nom,"moins") || EQ(nom,"minus")) return true;
    if(EQ(nom,"multiplie") || EQ(nom,"multiply")) return true;
    if(EQ(nom,"plus")) return true;
    if(EQ(nom,"mod") || EQ(nom,"modulo")) return true;
    if(EQ(nom,"repete") || EQ(nom,"repeat")) return true;
		return false;
	}
	bool isCompositionRecursive() {
		return EQ(nom,"oo");
	}
	bool isIncrementeur() {
		return EQ(nom,"sum") || EQ(nom,"somme") || EQ(nom,"prod") || EQ(nom,"comp") || EQ(nom,"let") || EQ(nom,"fonction") || EQ(nom,"function") || EQ(nom,"func") || EQ(nom,"fonc") || EQ(nom, "soit") || EQ(nom, "set");
	}
	int isAlea() {
		return EQ(nom,"randh")?1:EQ(nom,"randf")?2:0;
	}
};

class LexComparison:public Lexeme {public:
  TCHAR *nom;
	LexComparison(const TCHAR* debut, int count) {
		nom = (TCHAR*)malloc((count+1)*sizeof(TCHAR));
		memcpy(nom, debut, count*sizeof(TCHAR));
		*(nom+count)=L'\0';	//Terminal character.
	}
	~LexComparison() {
		free(nom);
	}
  bool isComparison() {return true;}
  Function *getOperator(Function *argument1, Function *argument2, bool marked) {
		if(EQ(nom,"<=")) {
      return new LessEq(argument1, argument2, marked, SYMBOL);
    } else if(EQ(nom,">=")) {
      return new GreaterEq(argument1, argument2, marked, SYMBOL);
    } else if(EQ(nom,"<")) {
      return new Less(argument1, argument2, marked, SYMBOL);
    } else if(EQ(nom,">")) {
      return new Greater(argument1, argument2, marked, SYMBOL);
    } else if(EQ(nom,"<>")) {
      return new NotEquals(argument1, argument2, marked, SYMBOL);
    } else if(EQ(nom,"!=")) {
      return new NotEquals(argument1, argument2, marked, SYMBOL);
    } else if(EQ(nom,"==")) {
      return new Equals(argument1, argument2, marked, SYMBOL);
    }
    throw PARSE_ERROR_UNKNOWN;
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
		} else if(nom==L'%') {
			return new Modulo(argument1, argument2, marked);
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

class LexSemicolon:public Lexeme{public:
	LexSemicolon() {}
	bool isSemicolon() {return true;}
};

class LexIn:public Lexeme{public:
	LexIn() {}
	bool isIn() {return true;}
};

class LexThen:public Lexeme{public:
	LexThen() {}
	bool isThen() {return true;}
};

class LexElse:public Lexeme{public:
	LexElse() {}
	bool isElse() {return true;}
};

class LexEqual:public Lexeme{public:
	LexEqual() {}
	bool isEqual() {return true;}
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
