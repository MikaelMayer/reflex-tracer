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

#define PI 3.14159265359
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
	inline double real() { return r; }
	inline double imag() { return i; }
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

	double module() const;
	double moduleCarre() const;
	cplx conj() const;
	cplx invs() const;
	double argument() const;

	friend cplx exp(cplx & z);
	friend cplx arctan(cplx & z);
	friend cplx operator -(const cplx & z);

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
};

const cplx I(0,1);
const cplx ZERO(0,0);
const cplx If2(0,2);
const cplx mI(0,-1);
const cplx Un(1,0);
const cplx mUn(-1,0);
const cplx J(-0.5,SQ3*0.5);

/*
 *Op�rateurs permettant l'utilisation facile des complexes.
 */

cplx operator +(const cplx & z, const cplx & w);
cplx operator -(const cplx & z, const cplx & w);
cplx operator *(const cplx & z, const cplx & w);
cplx operator /(const cplx & z, const cplx & w);
cplx operator ^(const cplx & z, int w);


/*
 *Fonctions r�ciproques
 */

cplx ln(cplx z);
cplx sqrt(cplx z);

cplx argsh(cplx & z);
cplx argch(cplx & z);
cplx argth(cplx & z);

cplx arcsin(cplx & z);
cplx arccos(cplx & z);
cplx arctan(cplx & z);

#endif
