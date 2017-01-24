/*******************************
 * Name:	lexeur.cpp
 * Author:	Mikaël Mayer
 * Purpose:	Implements lexeur and Parser class
 * History: Work started 20070901
 *********************************/

 #include <iostream>
#include "stdafx.h"
#include "lexeur.h"
#include "funcalea.h"
using namespace std;
/*
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
NUM_PARSE_ERRORS
*/

//TODO(mikael): Import those errors strings from outside.
TCHAR* Parseur::errorNum[NUM_PARSE_ERRORS] = {
	TEXT("Impossible call to a specialized function"),
	TEXT("Unexpected end of formula"),
	TEXT("Error at this point"),
	TEXT("Missing '(' for function"),
	TEXT("Missing ')'"),
	TEXT("Missing ','"),
	TEXT("Missing ';'"),
	TEXT("Missing 'then' keyword"),
	TEXT("Missing 'else' keyword"),
	TEXT("Missing '='"),
	TEXT("Missing a variable name (e.g. $i)"),
	TEXT("Missing an integer"),
	TEXT("Missing a float number"),
	TEXT("Unknown function name"),
  TEXT("Missing expression"),
  TEXT("Variable or function used but never declared")
};

Lexeur::Lexeur(const TCHAR* carCourant) {
	this->carCourant = carCourant;
	k=*carCourant;
	counter=0;
  counter_previous=counter;
}

void Lexeur::savePosition() {
  counter_previous=counter;
}

int Lexeur::getPosition() {
	return counter;
}

int Lexeur::getPositionPrevious() {
	return counter_previous;
}

void Lexeur::setPosition(int c) {
	counter = c;
}

void Lexeur::sauterLesBlancs() {
  bool isComment = false;
	while(((isComment && k!= L'\n') || (isWhiteCharacter() || isPound()))&&k!=L'\0') {
    if(isPound()) {
      isComment = true;
    }
    if(isComment && k==L'\n') {
      isComment = false;
    }
		avancerCar();
  }
}


void Lexeur::avancerCar() {
	if(k!=L'\0') {
		carCourant++;
		k=*carCourant;
		counter++;
	}
	else
		throw PARSE_ERROR_END;
}

void Lexeur::reculerCar() {
  carCourant--;
  k=*carCourant;
  counter--;
}

bool Lexeur::isPound() {
	return k==L'#';
}

bool Lexeur::isOperator() {
	return k==L'+'||k==L'-'||k==L'*'||k==L'/'||k==L'^'||k==L'!'||k==L'%'||k==L'<'||k==L'>'||k==L'=';
}

bool Lexeur::isLetter() {
	return (k>=L'a' && k<=L'z')||(k>=L'A' && k<=L'A')||k==L'_';
}

bool Lexeur::isDigit() {
	return (k>=L'0' && k<=L'9');
}

bool Lexeur::isExponent() {
	return (k==L'e' || k==L'E');
}

bool Lexeur::isParenthesis() {
	return k==L'(' || k==L')';
}

bool Lexeur::isWhiteCharacter() {
	return k==L' ' || k==L'\n' || k==L'\r' || k==L'\t';
}

bool Lexeur::isComa() {
	return k==L',';
}

bool Lexeur::isSemicolon() {
  return k==L';';
}

bool Lexeur::isEqual() {
	return k==L'=';
}

bool Lexeur::isPoint() {
	return k==L'.';
}

bool Lexeur::isDollar() {
	return k==L'$';
}

bool Lexeur::isBang() {
	return k==L'!';
}

Lexeme* Lexeur::readLexeme() {
	sauterLesBlancs();
  savePosition();
	if(k == L'\0')
		return NULL;
	if(isLetter())
		return readChain();
	if(isParenthesis())
		return readParenthesis();
	if(isDigit()||isPoint())
		return readNumber();
	if(isOperator())
		return readOperator();
	if(isComa())
		return readComa();
  if(isSemicolon())
		return readSemicolon();
  if(isEqual())
		return readEqual();
	if(isDollar())
		return readVariable();
	throw PARSE_ERROR_UNKNOWN;
}

Lexeme* Lexeur::readSemicolon() {
	avancerCar();
	return new LexSemicolon();
}

Lexeme* Lexeur::readComa() {
	avancerCar();
	return new LexComa();
}

Lexeme* Lexeur::readEqual() {
	avancerCar();
	return new LexEqual();
}

Lexeme* Lexeur::readChain() {
	const TCHAR *debut=carCourant;
	int count = 0;
	while(isLetter()||isDigit()||isDollar()) {
		count++;
		avancerCar();
	}
	if(count==1) {//Variables prédéfinies
		if(*debut == L'i' || *debut == L'I')
			return new LexComplex(cplx(0,1));
		if(*debut == L'j' || *debut == L'J')
			return new LexComplex(J);
	}
	if(count==2 && (*debut == L'p' && *(debut+1) == L'i'))
		return new LexComplex(cplx(PI, 0));
  if(count==3 && (*debut == L'i' && *(debut+1) == L'n' && *(debut+2) == L'f'))
		return new LexComplex(cplx(INFINITY, 0));
  if(count==3 && (*debut == L'n' && *(debut+1) == L'a' && *(debut+2) == L'n'))
		return new LexComplex(cplx(nan(NULL), 0));
  if(count==2 && (*debut == L'i' && *(debut+1) == L'n'))
		return new LexIn();
  if(count==4 && (*debut == L't' && *(debut+1) == L'h' && *(debut+2) == L'e' && *(debut+3) == L'n'))
		return new LexThen();
  if(count==4 && (*debut == L'e' && *(debut+1) == L'l' && *(debut+2) == L's' && *(debut+3) == L'e'))
		return new LexElse();
  if(count>=2 && *debut == L'_') // Fonction marquée.
    return new LexFunction(debut+1, count-1, true);
    //Une chaîne de caractères est actuellement une fonction..
	return new LexFunction(debut, count, false);
	//return new LexChain(nom);
}

Lexeme* Lexeur::readVariable() {
	const TCHAR *debut=carCourant;
	int count = 0;
	while(isLetter()||isDigit()||isDollar()) {
		count++;
		avancerCar();
	}
  if(count >= 3 && *(debut+1) == L'_') // $_x
    return new LexVariable(debut, count, true);
	//Variables prédéfinies à mettre ici.
	return new LexVariable(debut, count, false);
}

Lexeme* Lexeur::readOperator() {
	TCHAR ksauv = k;
  const TCHAR *debut=carCourant;
	avancerCar();
  if((k==L'=' || k==L'>') && (ksauv==L'<' || ksauv==L'=' || ksauv==L'>' || ksauv==L'!')) {
    avancerCar();
    return new LexComparison(debut, 2);
  } else if(ksauv==L'<' || ksauv==L'>') {
    return new LexComparison(debut, 1);
  } else if(ksauv==L'=') {
    return new LexEqual();
  } else {
    return new LexOperator(ksauv);
  }
}

int Lexeur::_readInteger(int &count) {
  int total = 0;
  count = 0;
	while(isDigit()) {
		total = total*10+(int)(k - L'0');
		count++;
		avancerCar();
	}
  return total;
}

Lexeme* Lexeur::readNumber() {
	int total = 0;
	double totald=0;
	int count = 0;
  total = _readInteger(count);
	if(isPoint() || isExponent()) {
		totald=(double)total;
		double puissanceDix = 0.1;
    if(!isExponent()) {
		  avancerCar();
		  while(isDigit()) {
			  totald += puissanceDix * (double)(k - L'0');
			  puissanceDix*=0.1;
			  avancerCar();
		  }
      if(puissanceDix==0.1 && count == 0) {
        return new LexOperator(TEXTC('*'));
      }
    }
    // TODO: Lire l'exposant.
    if(isExponent()) {
      avancerCar();
      int sign = 0;
      if(isOperator()) {
        if(k==L'+' || k==L'-') {
          if(k==L'-') {
            sign = -1;
          } else {
            sign = 1;
          }
          avancerCar();
        } else {
          //Erreur: 1.3e*3 ne veut rien dire.
          throw PARSE_ERROR_UNKNOWN;
        }
      }
      if(!isDigit()) {
        //cela peut être 10.3exp(z), on revient à 10.3
        //ou bien 10.3e+exp qui ne veut rien dire.
        reculerCar();
        if(isOperator()) {
          //ou bien 10.3e+exp qui ne veut rien dire.
          throw PARSE_ERROR_UNKNOWN;
        } // else le prochain caractère non traité est 'e'
      } else {
        int count=0;
        int exponent = _readInteger(count);
        if(sign < 0) {
          puissanceDix = 0.1;
          //exponent = -exponent;
        } else {
          puissanceDix = 10.0;
        }
        double reste = 1.0;
        // A chaque itération, Cste = puissanceDix^exponent*reste
        // Au début, puissanceDix = 10 donc Cste = 10^exponent
        // A la fin, exponent = 1 donc puissanceDix*reste = Cste
        if(exponent == 0) {
          puissanceDix = 1.0;
        }
        while(exponent > 1) {
          if (exponent % 2 == 0) {
            puissanceDix *= puissanceDix;
            exponent /= 2;
          } else {
            exponent = (exponent-1)/2;
            reste *= puissanceDix;
            puissanceDix *= puissanceDix;
          }
        }
        puissanceDix *= reste;
        totald *= puissanceDix;
//TODO: tester!
      }
    }

		if(k==L'i'||k==L'I') {
			avancerCar();
			return new LexComplex(cplx(0,totald));
		}
		return new LexFloat(totald);
	}
	if(k==L'i'||k==L'I') {
		avancerCar();
		return new LexComplex(cplx(0,(double)total));
	}
	return new LexInt(total);
}

Lexeme* Lexeur::readParenthesis() {
	if(k == L'(') {
		avancerCar();
		return new LexOpeningParenthesis();
	} else {
		avancerCar();
		return new LexClosingParenthesis();
	}
}

Parseur::Parseur(const TCHAR *chaine) {
	ec=NO_PARSE_ERROR;
	entree = new Lexeur(chaine);
	lexCourant=NULL;
  lexDestruction=NULL;
  try {
	  avancerLex();
  } catch(PARSE_ERROR p) {
    ec = p;
  }
	macro=false;
}

Parseur::~Parseur() {
	//On détruit les lexèmes utilisés. Chaque lexème détruit les données allouées.
	Lexeme *lexTemp=NULL;
	while(lexDestruction!=NULL) {
		lexTemp = lexDestruction->lexPrec;
		delete lexDestruction;
		lexDestruction = lexTemp;
	}
	delete entree;
}

bool Parseur::termine() {
	return !lexCourant || lexCourant->isClosingParenthesis() || lexCourant->isComa() || lexCourant->isSemicolon() || lexCourant->isIn() || lexCourant->isThen() || lexCourant->isElse();
}

bool Parseur::hasBeenMacro() {
	return this->macro;
}

int Parseur::errorCode() {
	return ec;
}

int Parseur::getPosition() {
	return entree->getPosition();
}

int Parseur::getPositionPrevious() {
	return entree->getPositionPrevious();
}

void Parseur::setPosition(int c) {
  entree->setPosition(c);
}

void Parseur::avancerLex() {
	Lexeme *lexTemp = lexCourant;
	lexCourant = entree->readLexeme();
	//Stockage du dernier lexème non nul pour la destruction de tous.
	if(lexCourant) {
		lexCourant->lexPrec = lexTemp;
		lexDestruction = lexCourant;
	}
}

void Parseur::lireParentheseOuvrante() {
  if(!lexCourant || !lexCourant->isOpeningParenthesis()) {
		parseBackwardsAndThrowError(PARSE_ERROR_OPENING_PARENTHESIS);
  }
	avancerLex();
}
void Parseur::lireParentheseFermante() {
  if(!lexCourant || !lexCourant->isClosingParenthesis()) {
		parseBackwardsAndThrowError(PARSE_ERROR_CLOSING_PARENTHESIS);
  }
	avancerLex();
}

void Parseur::eatComa() {
  if(!lexCourant || !lexCourant->isComa()) {
		parseBackwardsAndThrowError(PARSE_ERROR_COMA);
  }
	avancerLex();
}

void Parseur::lireSemicolon() {
  if(!lexCourant || !lexCourant->isSemicolon()) {
		parseBackwardsAndThrowError(PARSE_ERROR_SEMICOLON);
  }
	avancerLex();
}

void Parseur::lireIn() {
  if(!lexCourant || !lexCourant->isIn()) {
		parseBackwardsAndThrowError(PARSE_ERROR_SEMICOLON);
  }
	avancerLex();
}

void Parseur::lireThen() {
  if(!lexCourant || !lexCourant->isThen()) {
		parseBackwardsAndThrowError(PARSE_ERROR_THEN);
  }
	avancerLex();
}

void Parseur::lireElse() {
  if(!lexCourant || !lexCourant->isElse()) {
		parseBackwardsAndThrowError(PARSE_ERROR_ELSE);
  }
	avancerLex();
}

void Parseur::lireEqual() {
  if(!lexCourant || !lexCourant->isEqual()) {
		parseBackwardsAndThrowError(PARSE_ERROR_EQUAL);
  }
	avancerLex();
}


/* Grammaire utilisée: Alphabet E,P,F,G,X, +les fonctions de base + les nombres.
 * Axiome: D.
 * Actions: D-> D<=E, D>=E, D<E, D>E, D<>E, D==E, D->E
 *      E->E+P	E->E-P	E->P
 *			P->F*P	P->F/P	P->F	P->F P (au moins un séparateur)
 *			F->F^I	F->G	F^G si le lexéme aprés ^ n'est pas un entier.
 *      G->X    G->X!
 *			X->z	X->constante complexe|i|$variable
 *			X->fonction_unaire(E)	X->(E)	X->-F
 *			X->fonction_binaire(E, E)	pour la composition ou autres fonctions.
 *			X->oo(E, I)	pour la composition multiple
 *			I->entier
 *      X->fonction_multiple(E, var, debut, fin, step)
 * Comme cela, on récupère facilement les z+(2+i)
 * Pour en faire un meilleur langage de programmation, on peut utiliser les formules suivantes:
 *      E->let $f z = E in E  pour décrire les fonctions (le z est obligatoire) 
 */
 
Function *Parseur::lireD() {
	Function *Total = NULL, *F2 = NULL;
	PARSE_ERROR f;
	try {
		Total = lireE();
		Lexeme *E1=NULL;
		while(!termine()) {
			if(lexCourant->isComparison()) {
        E1=lexCourant;
        avancerLex();
        F2=lireE();
        Total=E1->getOperator(Total, F2,false);
			} else break;
		}
		return Total;
	} catch(PARSE_ERROR e) {//On supprime ce qu'on a déjà fabriquè, et on renvoie une erreur.
		if(Total)
			Total->kill();
		f=e;
	}
	throw f;
}

Function *Parseur::lireE() {
	Function *Total = NULL, *F2 = NULL;
	PARSE_ERROR f;
	try {
		Total = lireP();
		Lexeme *E1=NULL;
		while(!termine()) {
			if(lexCourant->isOperator()) {
				TCHAR op = lexCourant->valueOperator();
				if(op==L'+' || op==L'-') {
					E1=lexCourant;
					avancerLex();
					F2=lireP();
					Total=E1->getOperator(Total, F2,false);
				} else break;
			} else break;
		}
		return Total;
	} catch(PARSE_ERROR e) {//On supprime ce qu'on a déjà fabriquè, et on renvoie une erreur.
		if(Total)
			Total->kill();
		f=e;
	}
	throw f;
}

Function *Parseur::lireP() {
	Function *Total = NULL, *F2 = NULL;
	PARSE_ERROR f;
	try {
		Total = lireF();
		Lexeme *E1=NULL;
		while(!termine() && lexCourant) {
			if(lexCourant->isOperator()) {
				TCHAR op = lexCourant->valueOperator();
				if(op==L'*' || op==L'/' || op==L'%') {
					E1=lexCourant;
					avancerLex();
					F2=lireF();
					Total=E1->getOperator(Total, F2, false);
				} else break;
			} else if(!lexCourant->isComparison()) {
        //Ce n'est pas un opérateur, c'est donc une multiplication implicite si l'opérande à gauche n'est pas une variable.
        //Si l'opérande à gauche est une variable, c'est l'application d'une fonction.
        //De plus grande priorité. Donc z%2pi = (z%2)*pi
				F2=lireP();
				Total=new Multiplication(Total, F2, false);
			} else {
        break;
      }
		}
		return Total;
	} catch(PARSE_ERROR e) {//On supprime ce qu'on a déjà fabriqué, et on renvoie une erreur.
		if(Total)
			Total->kill();
		f=e;
	}
	throw f;
}
Function *Parseur::lireF() {
	Function *Total = NULL;
	PARSE_ERROR f;
	try {
		Total = lireG();
		while(!termine()) {
			if(lexCourant->isOperator()) {
				if(lexCourant->valueOperator()==L'^') {
					avancerLex();
          Function *k = lireF();
          if(lexCourant && k->isConstant()) {
            Constante *c = dynamic_cast<Constante*>(k);
            if(c->isInt()) {
              Total = new Exposant(Total, c->valeur.real(), false);
            } else {
              Total = new ExposantComplexe(Total, c, false);
            }
          } else {
            Total = new ExposantComplexe(Total, k, false);
          }
					/*if(lexCourant && lexCourant->isInt()) {
						int k=lireEntier();
						Total = new Exposant(Total, k, false);
					} else if(lexCourant) {
						Function *k = lireX();
						Total = new ExposantComplexe(Total, k, false);
					} else break;*/
				} else break;
			} else break;
		}
		return Total;
	} catch(PARSE_ERROR e) {//On supprime ce qu'on a déjà fabriqué, et on renvoie une erreur.
		if(Total)
			Total->kill();
		f=e;
	}
	throw f;
}
Function *Parseur::lireG() {
	Function *Total = NULL;
	PARSE_ERROR f;
	try {
		Total = lireX();
		while(!termine()) {
			if(lexCourant->isOperator()) {
				if(lexCourant->valueOperator()==L'!') {
          Total = new Factorial(Total, false, SYMBOL);
          avancerLex();
				} else break;
			} else break;
		}
		return Total;
	} catch(PARSE_ERROR e) {//On supprime ce qu'on a déjà fabriqué, et on renvoie une erreur.
		if(Total)
			Total->kill();
		f=e;
	}
	throw f;
}
Function *Parseur::lireX() {
	PARSE_ERROR f;
	Lexeme *E1 = lexCourant;
  if (!E1)
    throw PARSE_ERROR_EMPTY;
	if(E1->isOpeningParenthesis()) {
		avancerLex();
		Function *Total = lireD();
		try {
			lireParentheseFermante();
			return Total;
		} catch(PARSE_ERROR e) {
			if(Total)
				Total->kill();
			f=e;
		}
		throw f;
	} else if(E1->isFloat()) {
		return new Constante(lireFloat());
	} else if(E1->isInt()) {
		return new Constante(lireEntier());
	} else if(E1->isComplex()) {
		avancerLex();
		return new Constante(E1->valueComplex());
	} else if(E1->isFunction()) {
		return lireFunction();
	} else if(E1->isVariable()) {
    Function* F1 = lireVariable();
    E1 = lexCourant;
    if(E1 && E1->isOpeningParenthesis()) {
      avancerLex();
      Function *Total = lireD();
      try {
        lireParentheseFermante();
        return new Compose(F1,Total,false,DIRECT);
      } catch(PARSE_ERROR e) {
        if(Total)
          Total->kill();
        f=e;
      }
      throw f;
    } else {
      return F1;
    }
		return lireVariable();
	} else if(E1->isOperator()&&E1->valueOperator()==L'-') {
		avancerLex();
		return new Oppose(lireF(), false);
  } else {
    if(E1->isComa() || E1->isClosingParenthesis()) {
      parseBackwardsAndThrowError(PARSE_ERROR_EMPTY);
    } else {
  	  parseBackwardsAndThrowError(PARSE_ERROR_UNKNOWN);
    }
    return NULL;
  }
}

Function *Parseur::lireConstante() {
	return NULL;
}

Function *Parseur::lireFunction() {
	Function *Total=NULL, *F2=NULL, *F3=NULL, *F4=NULL;
  FunctionFactory* ff=NULL;
	PARSE_ERROR f;
  bool function_valid = true;
	int counter_initial = getPositionPrevious();
	try {
		int k=0;
		LexFunction *E1=dynamic_cast<LexFunction *>(lexCourant);
    avancerLex();
    if(E1->hasZeroArguments()) {
      function_valid = false; //A priori, on ne connait pas la fonction
      ff = E1->getFunctionFactory();
      function_valid = true; //Maintenant on la connait
      Total = ff->create(NULL, E1->marked);
    } else if(lexCourant && lexCourant->isOpeningParenthesis()){
		  lireParentheseOuvrante();
		  if(E1->isAlea()!=0) {
			  int k = (int)lireFloat();
        if(lexCourant && lexCourant->isComa()) {
				  eatComa();
				  F4 = lireD();
          Total = Tree::createFuncAlea(k, E1->isAlea()==1, F4);
          // Now F4 is integrated to Total, we don't care about it anymore.
          F4 = NULL;
			  } else {
          Total = Tree::createFuncAlea(k, E1->isAlea()==1);
        }
			  macro=true;
		  } else if(E1->isBinary()) {
			  Total = lireD();
			  eatComa();
			  F2 = lireD();
        Total = E1->getFunctionBinary(Total,F2,E1->marked);
        F2 = NULL;
		  } else if(E1->isTernary()) {
			  Total = lireD();
			  eatComa();
			  F2 = lireD();
			  eatComa();
			  F3 = lireD();
        Total = E1->getFunctionTernary(Total,F2,F3, E1->marked);
        F2 = NULL;
        F3 = NULL;
		  } else if(E1->isCompositionRecursive()) {
			  Total=lireD();
			  eatComa();
			  k=(int)lireFloat();
        Total=E1->getFunctionRecursive(Total,k,E1->marked);
		  } else if(E1->isIncrementeur()) {
			  Total=lireD();
			  eatComa();
			  VariableRef *v=lireVariable();
        v->setPosition(getPosition());
        v->setDeclared();
			  eatComa();
			  F2 = lireD();  // Debut
			  if(lexCourant && lexCourant->isComa()) {
          eatComa();
          F3 = lireD();  // Fin
        } else {
          F3 = new Constante(0.0);
        }
			  if(lexCourant && lexCourant->isComa()) {
				  eatComa();
				  F4 = lireD();
			  } else {
          F4 = new Constante(1.0);
        }
        Total = E1->getFunctionIncrementale(Total, v, F2, F3, F4, E1->marked);
        F2 = NULL;
        F3 = NULL;
        F4 = NULL;
		  } else {
			  //TODO: Lire d'abord la fonction, ensuite mettre son argument.
        function_valid = false; //A priori, on ne connait pas la fonction
        ff = E1->getFunctionFactory();
        function_valid = true; //Maintenant on la connait
			  Total=lireD();
        if(ff->mayHaveTwoArgs() && lexCourant && lexCourant->isComa()) {
          eatComa();
          F3 = lireD();
          Total = ff->create(Total, F3, E1->marked);
          F3 = NULL;
        } else {
          Total = ff->create(Total, E1->marked);
        }
			  //Total=E1->getFunction1(Total);
		  }
		  lireParentheseFermante();
    } else if(lexCourant && (lexCourant->isFunction() || lexCourant->isVariable()) && E1->isBinder()){ // Alternative let $f = ... in or ; and set $f = ... in or ; syntax:
      VariableRef *v=lireVariable();
      v->setDeclared();
      v->setPosition(getPosition());
      lireEqual();
      F2 = lireD();
      if(lexCourant && lexCourant->isSemicolon()) {
        lireSemicolon();
        F3 = lireD();
        Total = E1->getFunctionIncrementale(F3, v, F2, new Constante(0.0), new Constante(1.0), E1->marked, true);
      } else if(lexCourant && lexCourant->isIn()) {
        lireIn();
        F3 = lireD();
        Total = E1->getFunctionIncrementale(F3, v, F2, new Constante(0.0), new Constante(1.0), E1->marked, true);
      } else {
        parseBackwardsAndThrowError(PARSE_ERROR_SEMICOLON);
      }
      F2 = NULL;
      F3 = NULL;
    } else if(lexCourant && E1->isIf()){ // Alternative let $f = ... in or ; and set $f = ... in or ; syntax:
      F2 =lireD();
      lireThen();
      F3 = lireD();
      lireElse();
      F4 = lireD();
      Total = E1->getFunctionTernary(F2,F3,F4,E1->marked,true);
      F2 = NULL;
      F3 = NULL;
      F4 = NULL;
    } else if(E1->isRepeat()){ // Alternative repeat 50 in 
      F2 = lireD();
      if(lexCourant && lexCourant->isSemicolon()) {
        lireSemicolon();
        Total = lireD();
        Total = E1->getFunctionBinary(Total, F2, E1->marked);
      } else if(lexCourant && lexCourant->isIn()) {
        lireIn();
        Total = lireD();
        Total = E1->getFunctionBinary(Total, F2, E1->marked);
      } else {
        parseBackwardsAndThrowError(PARSE_ERROR_SEMICOLON);
      }
      F2 = NULL;
    } else {
      // Simple variable without arguments.
      function_valid = false; //A priori, on ne connait pas la fonction
      ff = E1->getFunctionFactory();
      function_valid = true; //Maintenant on la connait
      Total = ff->create(NULL, E1->marked);
    }/* else {
      parseBackwardsAndThrowError(PARSE_ERROR_EMPTY);
    }*/
    return Total;
	} catch(PARSE_ERROR e) {
		//TODO corriger erreur de l'erreur qui remonte.
		if(Total)
			Total->kill();
    if(F2)
			F2->kill();
    if(F3)
			F3->kill();
    if(F4)
			F4->kill();
    if(ff)
			delete ff;
		f=e;
    if(!function_valid) {
      setPosition(counter_initial);
    }
	}
	throw f;
}

VariableRef* Parseur::lireVariable() {
  if(!lexCourant || (!lexCourant->isVariable() && !lexCourant->isFunction())) {
		parseBackwardsAndThrowError(PARSE_ERROR_VARIABLE);
  }
  if(lexCourant->isVariable()) {
    LexVariable *E1=dynamic_cast<LexVariable *>(lexCourant);
    avancerLex();
    return VariableListe::get()->getVariable(E1->valueVariable(), E1->marked);
  } else { // Was a function.
    LexFunction *E1=dynamic_cast<LexFunction *>(lexCourant);
    avancerLex();
    return VariableListe::get()->getVariable(E1->nom, E1->marked);
  }
}

void Parseur::parseBackwardsAndThrowError(PARSE_ERROR e) {
  setPosition(getPositionPrevious());
  throw e;
}

int Parseur::lireEntier() {
  if(!lexCourant || !lexCourant->isInt()) {
    parseBackwardsAndThrowError(PARSE_ERROR_INT);
  }
	int k=lexCourant->valueInt();
	avancerLex();
	return k;
}

double Parseur::lireFloat() {
  double k = 0;
  if(!lexCourant)
    parseBackwardsAndThrowError(PARSE_ERROR_FLOAT);
	if(lexCourant->isFloat())
		k=lexCourant->valueFloat();
	else if(lexCourant->isInt())
		k=(double)lexCourant->valueInt();
	else
		parseBackwardsAndThrowError(PARSE_ERROR_FLOAT);
	avancerLex();
	return k;
}

Function *Parseur::valeurFonction() {
	//On lit simplement l'axiome.
	try {
    if(ec != -1)
      throw ec;
		Function *resultat = lireD();

		resultat = resultat->simplifie();
    Variable *v = VariableListe::getNonDeclared();
    if(v != NULL) {
      setPosition(v->getPosition());
      throw PARSE_ERROR_VARIABLE_USED_NOT_DECLARED;
    }
		return resultat;
	} catch(PARSE_ERROR code) {
		ec = code;
		return NULL;
	}
}
