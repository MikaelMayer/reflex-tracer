/*******************************
 * Name:	lexeur.h
 * Author:	Mikaël Mayer
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
  const TCHAR debugChar() { return k; };

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
  bool isSemicolon();
  bool isEqual();
	bool isPoint();
	bool isDollar();
	bool isPound();
	bool isBang();

	Lexeme* readChain();
	Lexeme* readNumber();
	Lexeme* readParenthesis();
	Lexeme* readOperator();
	Lexeme* readVariable();
	Lexeme* readLexeme();
	Lexeme* readComa();
  Lexeme* readSemicolon();
  Lexeme* readEqual();

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
	void eatComa();
  void lireSemicolon();
  void lireEqual();
  void lireIn();
  void lireThen();
  void lireElse();
	int lireEntier();
	double lireFloat();
	VariableRef* lireVariable();

  void parseBackwardsAndThrowError(PARSE_ERROR e);
	bool termine();
	Function *lireD();
	Function *lireE();
	Function *lireP();
	Function *lireF();
	Function *lireG();
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
