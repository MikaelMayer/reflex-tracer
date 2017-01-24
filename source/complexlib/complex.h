/*******************************
 * Name:	complex.h
 * Author:	Mika�l Mayer
 * Purpose:	The complex class,
 *   with operators and 16bits color converting.
 * History: Work started 20070901
 *********************************/

#ifndef COMPLEX_H
#define COMPLEX_H

#include <limits>
#include <math.h>

#define PI  3.141592653589793
#define PITIMES2 6.283185307179586
#define SQ3 1.73205080757
class cplx {
private:
	double r,i;

public:

/*
 *Fonctions de base, gestion bas niveau des complexes
 */

	cplx();
	cplx(double rr);
	cplx(double rr, double ii);
	inline double real() const { return r; }
	inline double imag() const{ return i; }
	cplx& setreal(double rr);
	cplx& setimag(double ii);
	cplx realcplx() const;
	cplx imagcplx() const;

/*
 *Op�rateurs de base et propri�t�s des complexes.
 */

	cplx& operator+= (const cplx &);
	cplx& operator*= (const cplx &);
	cplx& operator/= (const cplx &);
	cplx& operator-= (const cplx &);
  cplx& operator%= (const cplx &);

	double module() const;
	double moduleCarre() const;
	cplx conj() const;
	cplx invs() const;
	double argument() const;
	double argument(double modulo) const;

	friend cplx exp(cplx & z);
  friend cplx expDirect(cplx z);
	friend cplx arctan(cplx & z);
	friend cplx arctan(cplx & z, double modulo);
	friend cplx operator -(const cplx & z);
  friend bool operator ==(const cplx & z, const cplx & w);

	//Fonctions trigonom�triques associ�es (calcul acc�l�r�);
	friend cplx sin(cplx & z);
	friend cplx cos(cplx & z);
	friend cplx tan(cplx & z);
	/*
	 *Fonctions trigonom�triques et hyperboliques.
	 */

	friend cplx sinh(cplx & z);
	friend cplx cosh(cplx & z);
	friend cplx tanh(cplx & z);
/*
 *Fonction d'association de couleurs
 */
	COLORREF couleur24();
	unsigned short couleur16();
  static COLORREF color_NaN;
//Fonction pour en faire une cha�ne lisible.
	void toStringLeft(TCHAR*, int sizeBuffer);
	void toStringRight(TCHAR*, int sizeBuffer);
	void toString(TCHAR*);
  void toStringMarked(TCHAR*);
  void toStringMarkedLatex(TCHAR*);
};

const cplx I(0,1);
const cplx ZERO(0,0);
const cplx If2(0,2);
const cplx mI(0,-1);
const cplx Un(1,0);
const cplx mUn(-1,0);
const cplx J(-0.5,SQ3*0.5);

cplx expDirect(cplx z);

/*
 *Op�rateurs permettant l'utilisation facile des complexes.
 */

cplx operator +(const cplx & z, const cplx & w);
cplx operator -(const cplx & z, const cplx & w);
cplx operator *(const cplx & z, const cplx & w);
cplx operator /(const cplx & z, const cplx & w);
cplx operator ^(const cplx & z, const cplx & w);
cplx operator ^(const cplx & z, int w);
bool operator== (const cplx &z, const cplx &w);
cplx operator %(const cplx & z, const cplx & w);

/*
 *Fonctions réciproques
 */

cplx ln(cplx z);
cplx ln(cplx z, double modulo);

cplx sqrt(cplx z);
cplx sqrt(cplx z, double modulo);

cplx argsh(cplx & z);
cplx argsh(cplx & z, cplx & w);
cplx argch(cplx & z);
cplx argch(cplx & z, cplx & w);
cplx argth(cplx & z);
cplx argth(cplx & z, double modulo);

cplx arcsin(cplx & z);
cplx arcsin(cplx & z, cplx & w);
cplx arccos(cplx & z);
cplx arccos(cplx & z, cplx & w);
cplx arctan(cplx & z);
cplx arctan(cplx & z, double modulo);

#endif
