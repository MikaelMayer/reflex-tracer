/*******************************
 * Name:	lexeur.h
 * Author:	Mika�l Mayer
 * Purpose:	The Lexeur Class can interpret a chain into Lexemes,
 *		which are more easy to interpret after.
 *			The Parser Class uses a Lexeur and a grammar
 *		in order to build a function out of the expression
 *			Example: parse("sin(z+z^2"); will works.
 * History: Work started 20070901
 *********************************/

#ifndef LEXEUR_H
#define LEXEUR_H
#include "lexeme.h"

class Lexeur {
	const TCHAR* carCourant;
	TCHAR k;
	int counter;
  int counter_previous;
public:
	Lexeur(const TCHAR* carCourant);
	int getPosition();
  int getPositionPrevious();
  void savePosition();
  void setPosition(int c);

	void sauterLesBlancs();
	void avancerCar();
  void reculerCar();
	bool isOperator();
	bool isLetter();
	bool isDigit();
  bool isExponent();
	bool isParenthesis();
	bool isWhiteCharacter();
	bool isComa();
	bool isPoint();
	bool isDollar();

	Lexeme* readChain();
	Lexeme* readNumber();
	Lexeme* readParenthesis();
	Lexeme* readOperator();
	Lexeme* readVariable();
	Lexeme* readLexeme();
	Lexeme* readComa();

  int _readInteger(int &count);
};

class Parseur {
private:
	Lexeur* entree;
	Lexeme* lexCourant;
	Lexeme* lexDestruction;
	void avancerLex();
	void lireParentheseOuvrante();
	void lireParentheseFermante();
	void lireVirgule();
	int lireEntier();
	double lireFloat();
	Variable* lireVariable();

  void parseBackwardsAndThrowError(PARSE_ERROR e);
	bool termine();
	Function *lireE();
	Function *lireP();
	Function *lireF();
	Function *lireX();
	Function *lireConstante();
	Function *lireFunction();

	bool macro;
	PARSE_ERROR ec;
public:
	Parseur(const TCHAR* chaine);
	~Parseur();
	Function *valeurFonction();
	bool hasBeenMacro();
	int errorCode(void);
	int getPosition(void);
  int getPositionPrevious(void);
  void setPosition(int c);

	static TCHAR* errorNum[NUM_PARSE_ERRORS];
};

#endif
