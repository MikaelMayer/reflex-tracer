/*******************************
 * Name:	lexeur.cpp
 * Author:	Mika�l Mayer
 * Purpose:	Implements lexeur and Parser class
 * History: Work started 20070901
 *********************************/

#include "stdafx.h"
#include "lexeur.h"
#include "funcalea.h"

/*
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
	TEXT("Missing a variable name (e.g. $i)"),
	TEXT("Missing an integer"),
	TEXT("Missing a float number"),
	TEXT("Unknown function name"),
  TEXT("Missing function")
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
	while(isWhiteCharacter()&&k!=L'\0')
		avancerCar();
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

bool Lexeur::isOperator() {
	return k==L'+'||k==L'-'||k==L'*'||k==L'/'||k==L'^';
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
	return k==L' ' || k==L'\n';
}

bool Lexeur::isComa() {
	return k==L',' || k==L';';
}

bool Lexeur::isPoint() {
	return k==L'.';
}

bool Lexeur::isDollar() {
	return k==L'$';
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
	if(isDollar())
		return readVariable();
	throw PARSE_ERROR_UNKNOWN;
}

Lexeme* Lexeur::readComa() {
	avancerCar();
	return new LexComa();
}

Lexeme* Lexeur::readChain() {
	const TCHAR *debut=carCourant;
	int count = 0;
	while(isLetter()||isDigit()) {
		count++;
		avancerCar();
	}
	if(count==1) {//Variables pr�d�finies
		if(*debut == L'i' || *debut == L'I')
			return new LexComplex(cplx(0,1));
		if(*debut == L'j' || *debut == L'J')
			return new LexComplex(J);
	}
	if(count==2 && (*debut == L'p' || *(debut+1) == L'i'))
		return new LexComplex(cplx(PI, 0));
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
	avancerCar();
	return new LexOperator(ksauv);
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
        //cela peut �tre 10.3exp(z), on revient � 10.3
        //ou bien 10.3e+exp qui ne veut rien dire.
        reculerCar();
        if(isOperator()) {
          //ou bien 10.3e+exp qui ne veut rien dire.
          throw PARSE_ERROR_UNKNOWN;
        } // else le prochain caract�re non trait� est 'e'
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
        // A chaque it�ration, Cste = puissanceDix^exponent*reste
        // Au d�but, puissanceDix = 10 donc Cste = 10^exponent
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
	//On d�truit les lex�mes utilis�s. Chaque lex�me d�truit les donn�es allou�es.
	Lexeme *lexTemp=NULL;
	while(lexDestruction!=NULL) {
		lexTemp = lexDestruction->lexPrec;
		delete lexDestruction;
		lexDestruction = lexTemp;
	}
	delete entree;
}

bool Parseur::termine() {
	return !lexCourant || lexCourant->isClosingParenthesis() || lexCourant->isComa();
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
	//Stockage du dernier lex�me non nul pour la destruction de tous.
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

void Parseur::lireVirgule() {
  if(!lexCourant || !lexCourant->isComa()) {
		parseBackwardsAndThrowError(PARSE_ERROR_COMA);
  }
	avancerLex();
}

/* Grammaire utilis�e: Alphabet E,P,F,X, +les fonctions de base + les nombres.
 * Axiome: E.
 * Actions: E->E+P	E->E-P	E->P
 *			P->F*P	P->F/P	P->F	P->F P (au moins un s�parateur)
 *			F->F^I	F->X	F^X si le lex�me apr�s ^ n'est pas un entier.
 *			X->z	X->constante complexe|i|$variable
 *			X->fonction_unaire(E)	X->(E)	X->-X
 *			X->fonction_binaire(E, E)	pour la composition
 *			X->oo(E, I)	pour la composition multiple
 *			I->entier
 * Comme cela, on r�cup�re facilement les z+(2+i)
 * Pour traiter les (z+1)z
 */

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
	} catch(PARSE_ERROR e) {//On supprime ce qu'on a d�j� fabriqu�, et on renvoie une erreur.
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
				if(op==L'*' || op==L'/') {
					E1=lexCourant;
					avancerLex();
					F2=lireF();
					Total=E1->getOperator(Total, F2, false);
				} else break;
			} else {//Ce n'est pas un op�rateur, c'est donc une multiplication cach�e.
				F2=lireP();
				Total=new Multiplication(Total, F2, false);
			}
		}
		return Total;
	} catch(PARSE_ERROR e) {//On supprime ce qu'on a d�j� fabriqu�, et on renvoie une erreur.
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
		Total = lireX();
		while(!termine()) {
			if(lexCourant->isOperator()) {
				if(lexCourant->valueOperator()==L'^') {
					avancerLex();
					if(lexCourant && lexCourant->isInt()) {
						int k=lireEntier();
						Total = new Exposant(Total, k, false);
					} else if(lexCourant) {
						Function *k = lireX();
						Total = new ExposantComplexe(Total, k, false);
					} else break;
				} else break;
			} else break;
		}
		return Total;
	} catch(PARSE_ERROR e) {//On supprime ce qu'on a d�j� fabriqu�, et on renvoie une erreur.
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
		Function *Total = lireE();
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
		return lireVariable();
	} else if(E1->isOperator()&&E1->valueOperator()==L'-') {
		avancerLex();
		return new Oppose(lireX(), false);
  } else {
    if(E1->isComa() || E1->isClosingParenthesis())
      parseBackwardsAndThrowError(PARSE_ERROR_EMPTY);
    else
  	  parseBackwardsAndThrowError(PARSE_ERROR_UNKNOWN);
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
    } else {
		  lireParentheseOuvrante();
		  if(E1->isAlea()!=0) {
			  int k = (int)lireFloat();
        if(lexCourant && lexCourant->isComa()) {
				  lireVirgule();
				  F4 = lireE();
          Total = Tree::createFuncAlea(k, E1->isAlea()==1, F4);
          // Now F4 is integrated to Total, we don't care about it anymore.
          F4 = NULL;
			  } else {
          Total = Tree::createFuncAlea(k, E1->isAlea()==1);
        }
			  macro=true;
		  } else if(E1->isBinaire()) {
			  Total = lireE();
			  lireVirgule();
			  F2 = lireE();
        Total = E1->getFunctionBinaire(Total,F2,E1->marked);
        F2 = NULL;
		  } else if(E1->isCompositionRecursive()) {
			  Total=lireE();
			  lireVirgule();
			  k=(int)lireFloat();
        Total=E1->getFunctionRecursive(Total,k,E1->marked);
		  } else if(E1->isIncrementeur()) {
			  Total=lireE();
			  lireVirgule();
			  Variable *v=lireVariable();
			  lireVirgule();
			  F2 = lireE();  // Debut
			  lireVirgule();
			  F3 = lireE();  // Fin
			  if(lexCourant && lexCourant->isComa()) {
				  lireVirgule();
				  F4 = lireE();
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
			  Total=lireE();
        Total = ff->create(Total, E1->marked);
			  //Total=E1->getFunction1(Total);
		  }
		  lireParentheseFermante();
    }
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

Variable* Parseur::lireVariable() {
  if(!lexCourant || !lexCourant->isVariable()) {
		parseBackwardsAndThrowError(PARSE_ERROR_VARIABLE);
  }
	LexVariable *E1=dynamic_cast<LexVariable *>(lexCourant);
	avancerLex();
	return VariableListe::get()->getVariable(E1->valueVariable(), E1->marked);
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
		Function *resultat = lireE();
		resultat = resultat->simplifie();
		return resultat;
	} catch(PARSE_ERROR code) {
		ec = code;
		return NULL;
	}
}
