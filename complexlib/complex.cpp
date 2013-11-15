/*******************************
 * Name:	complex.cpp
 * Author:	Mika�l Mayer
 * Purpose:	Implements the complex number class cplx
 * History: Work started 20070901
 *********************************/
#define _CRT_SECURE_NO_DEPRECATE
#include "stdafx.h"
#include "complex.h"

/*
 *Fonctions de base, gestion bas niveau des complexes
 */

cplx::cplx():r(0),i(0)							{}
cplx::cplx(double rr):r(rr),i(0)				{}
cplx::cplx(double rr, double ii):r(rr),i(ii)	{}
cplx& cplx::setreal(double rr)		{ r=rr; return *this;}
cplx& cplx::setimag(double ii)		{ i=ii; return *this;}
cplx cplx::realcplx() const				{ return cplx(r,0); }
cplx cplx::imagcplx() const				{ return cplx(i,0); }

/*
 *Op�rateurs de base et propri�t�s des complexes.
 */

cplx& cplx::operator+= (const cplx &z){ r+=z.r; i+=z.i; return *this;}
cplx& cplx::operator*= (const cplx &z){ double r2=r; r=r*z.r-i*z.i; i=r2*z.i+i*z.r; return *this; }
cplx& cplx::operator/= (const cplx &z){	(*this)*=z.invs(); return (*this); }
cplx& cplx::operator-= (const cplx &z)
{ r-=z.r; i-=z.i; return *this;}

double cplx::module() const						{return sqrt(r*r+i*i);}
double cplx::moduleCarre() const				{return r*r+i*i;}
cplx cplx::conj() const							{return cplx(r,-i);}
cplx cplx::invs() const							{double m=this->moduleCarre(); return cplx(r/m, -i/m);}
double cplx::argument() const {
	if(r==0&&i==0) return 0;
	if(i==0&&r<0) return PI;
	return 2*atan(i/(module()+r));
}

/*
 *Op�rateurs permettant l'utilisation facile des complexes.
 */

cplx operator +(const cplx & z, const cplx & w)	{cplx res=z; res+=w; return res;}
cplx operator *(const cplx & z, const cplx & w)	{cplx res=z; res*=w; return res;}
cplx operator -(const cplx & z, const cplx & w)	{cplx res=z; res-=w; return res;}
cplx operator /(const cplx & z, const cplx & w)	{cplx res=z; res/=w; return res;}
cplx operator -(const cplx & z)	{return cplx(-z.r,-z.i);}

cplx operator ^(const cplx & z, int w){
	if(w==0) return 1;
	cplx mult=1, res=w<0?z.invs():z;
	if(w<0) w=-w;
	while(w>1) {
		if(w%2==0) {
			w/=2;
			res = res*res;
		} else {
			w=(w-1)/2;
			mult *= res;
			res = res*res;
		}
	}
	return mult*res;
}


/*
 *Fonctions trigonom�triques et hyperboliques.
 */

cplx exp(cplx & z)		{ return cplx(exp(z.r)*cos(z.i),exp(z.r)*sin(z.i)); }

const cplx facteurSin(0,-0.5);
const cplx facteurCos(0.5,0);

//sin(x+iy)=sin(x)cosh(y)+i*cos(x)sinh(y)
cplx sin(cplx & z)		{ return cplx(sin(z.r)*cosh(z.i), cos(z.r)*sinh(z.i)); }
cplx cos(cplx & z)		{ return cplx(cos(z.r)*cosh(z.i), -sin(z.r)*sinh(z.i)); }

cplx tan(cplx & z) {
	double sr = sin(z.r), cr=cos(z.r), cr2= cr*cr;
	double exp2i = exp(2*z.i);
	double denom = exp2i*(exp2i+4.0*cr2-2.0)+1.0;
	return cplx(4*exp2i*sr*cr/denom, (exp2i*exp2i-1.0)/denom);
}

cplx sinh(cplx & z)		{ cplx mz = 0-z; return 0.5*(exp(z)-exp(mz)); }
cplx cosh(cplx & z)		{ cplx mz = 0-z; return 0.5*(exp(z)+exp(mz)); }
cplx tanh(cplx & z)		{ cplx dz = 2*z; return 1+((-2)/(exp(dz)+1));}

/*
 *Fonctions r�ciproques
 */

cplx ln(cplx z)		{ return cplx(log(z.module()),z.argument()); }
cplx sqrt(cplx z)		{ cplx tmp = cplx(0,0.5)*z.argument(); return sqrt(z.module())*exp(tmp); }

cplx argsh(cplx & z)	{ cplx tmp1 = (z^2)+1; cplx tmp2 = z+sqrt(tmp1); return ln(tmp2); }
cplx argch(cplx & z)	{ cplx tmp1 = (z^2)-1; cplx tmp2 = z+sqrt(tmp1); return ln(tmp2); }
cplx argth(cplx & z)	{ cplx tmp = (z+1)/(1-z); return 0.5*ln(tmp); }

cplx arcsin(cplx & z)	{ cplx tmp = I*z+sqrt(1-(z^2)); return mI*ln(tmp); }
cplx arccos(cplx & z)	{ return z.real()*z.imag()<0?mI*ln(z-sqrt((z^2)-1)):mI*ln(z+sqrt((z^2)-1)); }
cplx arctan(cplx & z)	{ return cplx(0,-0.5)*ln((2/(z.r*z.r+(z.i+1)*(z.i+1)))*cplx(z.i+1,z.r)-1); }

/*
 *Fonction d'association de couleurs
 */

COLORREF cplx::color_NaN = RGB(255,255,255);

COLORREF stl_to_rvb(int saturation, double re, double i, double m, int luminosite) {
	if(m==0) return 0;
	if(m>1e10||m!=m) return cplx::color_NaN;
	double r=0, g=0,b=0;
	double rpm=re+m;
	double rpm2=rpm*rpm, i2=i*i;
	double den = rpm2+i2;
	if(i==0 && re<=0) {
		g=190;
		b=190;
	} else {
		r=255*(1-i2/den);
		g=255*(0.25+0.5*i*(SQ3*rpm+i)/den);
		b=255*(0.25-0.5*i*(SQ3*rpm-i)/den);
	}
  if (luminosite<=120) {
		r=r*luminosite/120;
		g=g*luminosite/120;
		b=b*luminosite/120;
	} else {
		double k1 = 2.0-(double)luminosite/120.0, k2=(double)luminosite/120.0-1.0;
		r=r*k1+255.0*k2;
		g=g*k1+255.0*k2;
		b=b*k1+255.0*k2;
	}
	//Pour les reflex, on n'en a pas besoin.
	/*double gris_a_saturation = luminosite*1.0625;
	r=(r*saturation+gris_a_saturation*(240-saturation))/240;
	g=(g*saturation+gris_a_saturation*(240-saturation))/240;
	b=(b*saturation+gris_a_saturation*(240-saturation))/240;*/
	return RGB((int)b,(int)g,(int)r);
}

COLORREF cplx::couleur24(){
	double m=this->module();
	return stl_to_rvb(240, r, i, m,(int)(240.0*m/(m+1.0)));
}

unsigned short stl_to_rvb16(int saturation, double re, double i, double m, int luminosite) {
	if(m==0) return 0;
	if(m>1e10||m!=m) return (unsigned short)0xFFDF;
	double r=0, g=0,b=0;
	double rpm=re+m;
	double rpm2=rpm*rpm, i2=i*i;
	double den = rpm2+i2;
	if(i==0 && re<=0) {
		g=23.75;
		b=23.75;
	} else {
		r=31*(1-i2/den);
		g=31*(0.25+0.5*i*(SQ3*rpm+i)/den);
		b=31*(0.25-0.5*i*(SQ3*rpm-i)/den);
	}
    if (luminosite<=120) {
		r=r*luminosite/120;
		g=g*luminosite/120;
		b=b*luminosite/120;
	} else {
		double k1 = 2.0-(double)luminosite/120.0, k2=(double)luminosite/120.0-1.0;
		r=r*k1+31.0*k2+0.5;
		g=g*k1+31.0*k2+0.5;
		b=b*k1+31.0*k2+0.5;
	}
	//Pour les reflex, on n'en a pas besoin.
	/*double gris_a_saturation = luminosite*1.0625;
	r=(r*saturation+gris_a_saturation*(240-saturation))/240;
	g=(g*saturation+gris_a_saturation*(240-saturation))/240;
	b=(b*saturation+gris_a_saturation*(240-saturation))/240;*/
	return (((int)r & 0x1F)<< 11 |
			 ((int)g & 0x1F) << 6 |
			 ((int)b & 0x1F));
}

unsigned short cplx::couleur16(){
	double m=this->module();
	return stl_to_rvb16(240, r, i, m,(int)(240.0*m/(m+1.0)));
}

void cplx::toStringLeft(TCHAR *ibuff, int size) {
  int n =  _sntprintf(ibuff, size, TEXT("%.4g%+.4gi"), r, i), nmax = size - 1;
  while (n < nmax)
    ibuff[n++] = TEXTC(' ');
  ibuff[nmax] = TEXTC('\0');
}
void cplx::toStringRight(TCHAR *ibuff, int size) {
  int n = _sntprintf(ibuff, size, TEXT("%.4g%+.4gi"), r, i);
  int i = size - 2, imin = size - 2 - n + 1;
  ibuff[size - 1] = TEXTC('\0');
  while (i >= imin) {
    ibuff[i] = ibuff[i - imin];
    i--;
  }
  while (i >= 0) {
    ibuff[i] = TEXTC(' ');
    i--;
  }
}
void cplx::toString(TCHAR *ibuff) {
	if(i==0)
		_stprintf(ibuff, TEXT("%g"), r);
  else if(r==0) {
    if(i==1) {
		  _stprintf(ibuff, TEXT("i"));
    } else if(i==-1) {
      _stprintf(ibuff, TEXT("-i"));
    } else {
      _stprintf(ibuff, TEXT("%gi"), i);
    }
  } else {
    if(i==1) {
		  _stprintf(ibuff, TEXT("%g+i"), r);
    } else if(i==-1) {
      _stprintf(ibuff, TEXT("%g-i"), r);
    } else {
      _stprintf(ibuff, TEXT("%g%+gi"), r, i);
    }
		
  }
}
