/*******************************
 * Name:	functions.cpp
 * Author:	Mikaël Mayer
 * Purpose:	Implements the Function class
 * History: Work started 20070901
 *********************************/
#include <iostream>
#include <math.h>
#include "stdafx.h"
#include "functions.h"
#define isfinite(x) ((x)-(x)==0)

using namespace std;

//FunctionUnary basic implementations.
FunctionUnary::FunctionUnary(Function* theArgument, bool _marked):Function(_marked) {
	setArgument(theArgument);
}
//FunctionUnary basic implementations.
FunctionUnary::FunctionUnary(Function* theArgument, bool _marked, NAME_VARIANT n):Function(_marked, n) {
	setArgument(theArgument);
}
//delete est seulement la destruction du noeud (pour les simplifications p.ex)
FunctionUnary::~FunctionUnary() {
}

Function* FunctionUnary::kill() {
  if(argument)
  	argument = argument->kill();
	delete this;
  return NULL;
}

void FunctionUnary::setArgument(Function* theArgument) {
	argument=(theArgument==NULL?new Identity(false):theArgument);
}

bool FunctionUnary::simplifieArgFunctionUnary() {
	argument=argument->simplifie();
	return argument->isConstant() && !this->marked && !argument->marked;
}

Function *FunctionUnary::simplifie() {
	//Si la fonction est constante, on la simplifie.
	if(!simplifieArgFunctionUnary()) return this;
	//Ici, cela veut dire que l'argument est constant.
	//On fait donc simple... on garde la constante de l'argument, modifièe, et on se supprime.
	cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
	kill();//On tue récursivement le noeud et son fils.
	return new Constante(res);//Et on retourne une nouvelle constante.
}

//FunctionBinary basic implementations.
FunctionBinary::FunctionBinary(Function* theArgument, Function* theArgument2, bool _marked):FunctionUnary(theArgument, _marked) {
setArgument2(theArgument2);
}
//FunctionBinary basic implementations.
FunctionBinary::FunctionBinary(Function* theArgument, Function* theArgument2, bool _marked, NAME_VARIANT n):FunctionUnary(theArgument, _marked, n) {
setArgument2(theArgument2);
}
//delete just this node.
FunctionBinary::~FunctionBinary() {
}

Function* FunctionBinary::kill() {
	if(argument2)
  	argument2 = argument2->kill();
  return FunctionUnary::kill();
}

void FunctionBinary::setArgument2(Function *theArgument2) {
	argument2=(theArgument2==NULL?new Identity(false):theArgument2);
}
bool FunctionBinary::simplifieArgFunctionBinary() {
	bool resultat = simplifieArgFunctionUnary();
	argument2 = argument2->simplifie();
	return resultat && argument2->isConstant() && !argument2->marked;
}
Function *FunctionBinary::simplifie() {
	if(!simplifieArgFunctionBinary()) return this;
	cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
	kill();						//On tue rècurivement le noeud et son fils.
	return new Constante(res);	//On rècupère une nouvelle constante.
}

//FunctionTernary basic implementations.
FunctionTernary::FunctionTernary(Function* theArgument, Function* theArgument2, Function* theArgument3, bool _marked):FunctionBinary(theArgument, theArgument2, _marked),argument3(theArgument3) {
}
//FunctionTernary basic implementations.
FunctionTernary::FunctionTernary(Function* theArgument, Function* theArgument2, Function* theArgument3,bool _marked, NAME_VARIANT n):FunctionBinary(theArgument, theArgument2, _marked, n),argument3(theArgument3) {
}
//delete just this node.
FunctionTernary::~FunctionTernary() {
}

Function* FunctionTernary::kill() {
	if(argument3)
  	argument3 = argument3->kill();
  return FunctionBinary::kill();
}

void FunctionTernary::setArgument3(Function *theArgument3) {
	argument3=(theArgument3==NULL?new Identity(false):theArgument3);
}
bool FunctionTernary::simplifieArgFunctionTernary() {
	bool resultat = simplifieArgFunctionBinary();
	argument3 = argument3->simplifie();
	return resultat && argument3->isConstant() && !argument3->marked;
}
Function *FunctionTernary::simplifie() {
	if(!simplifieArgFunctionTernary()) return this;
	cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
	kill();						//On tue rècursivement le noeud et son fils.
	return new Constante(res);	//On récupère une nouvelle constante.
}

//Cas particulier de la fonction compose.
Function *Compose::simplifie() {
	simplifieArgFunctionBinary();
	if(argument->isConstant() && !argument->marked && !this->marked) {//Le premier argument est constant.
		cplx res = dynamic_cast<Constante*>(argument)->valeur;
		kill();
		return new Constante(res);
	} else if(argument2->isConstant() && !argument2->marked && !this->marked) {
    Constante* c = dynamic_cast<Constante*>(argument2);
		cplx res = argument->eval(c->valeur);
		kill();
		return new Constante(res);
  } else if(argument->isIdentity() && !argument->marked && !this->marked) {
		//une composition avec l'identitè => c'est la deuxième fonction
		Function *f = argument2;
    argument2 = NULL;
		kill();
		return f;
	} else if(argument2->isIdentity() && !argument2->marked && !this->marked) {
		//une composition avec l'identitè => c'est la deuxième fonction
		Function *f = argument;
    argument = NULL;
		kill();
		return f;
	}
	return this;
}

cplx Identity::eval(const cplx & z) {
	return z;
}
cplx Identity_x::eval(const cplx & z) {
	return z.realcplx();
}
cplx Identity_y::eval(const cplx & z) {
	return z.imagcplx();
}

//Some binary functions.
cplx Somme::eval(const cplx & z)			      {
  cplx z1 = argument->eval(z);
  z1+=argument2->eval(z);
  return z1;}
cplx Multiplication::eval(const cplx & z)	  {
  cplx z1 = argument->eval(z);
  z1*=argument2->eval(z);
  return z1;}
cplx Soustraction::eval(const cplx & z)	    {
  cplx z1 = argument->eval(z);
  z1-=argument2->eval(z);
  return z1;}
cplx Division::eval(const cplx & z)		      {
  cplx z1 = argument->eval(z);
  z1/=argument2->eval(z);
  return z1;
}
cplx IfThenElse::eval(const cplx & z) {
  cplx z1 = argument->eval(z);
  if(z1.real() != 0 || z1.imag() != 0) {
    cplx z2 = argument2->eval(z);
    return z2;
  } else {
    cplx z3 = argument3->eval(z);
    return z3;
  }
}
cplx Compose::eval(const cplx & z)		      {cplx tmp = argument2->eval(z); return argument->eval(tmp);}
cplx Modulo::eval(const cplx & z)	    {
  cplx z1 = argument->eval(z);
  z1 %= argument2->eval(z);
  return z1;
}
cplx ExposantComplexe::eval(const cplx & z) {
  cplx w = argument2->eval(z);
  if(w.real()!=w.real() && w.imag()!=w.imag()) return cplx(1);
  cplx tmp = argument->eval(z);
  cplx exparg = w*ln(tmp);
  return exp(exparg);
}

cplx Repeat::eval(const cplx & z) {
  cplx w = argument2->eval(z);
  int num = (int)w.real();
  int i = 0;
  cplx res = 0;
  while(i < num) {
    res = argument->eval(z);
    i += 1;
  }
  return res;
}

//Cas particulier de la fonction compose.
Function *Repeat::simplifie() {
	simplifieArgFunctionBinary();
	if(argument->isConstant() && !argument->marked && !this->marked) {//Le premier argument est constant.
		cplx res = dynamic_cast<Constante*>(argument)->valeur;
		kill();
		return new Constante(res);
	}
	return this;
}

cplx Diff::eval(const cplx & z) {
  cplx w = argument2->eval(z);
  if((w.real()!=w.real() && w.imag()!=w.imag()) || (w.real() == 0 && w.imag() == 0)) return cplx(1);
  cplx tmp1 = argument->eval(z);
  cplx tmp3 = argument->eval(z + w);
  tmp1 = (tmp3 - tmp1) / w;
  return tmp1;
}

cplx IfError::eval(const cplx & z) {
  cplx w = argument->eval(z);
  if(!isfinite(w.real()) || !isfinite(w.imag())) {
    return argument2->eval(z);
  }
  return w;
}

cplx Newton::eval(const cplx & z) {
  cplx w = 0.000001;
  cplx tmp1 = argument->eval(z);
  cplx tmp3 = argument->eval(z + w);
  tmp1 = z - tmp1 / ((tmp3 - tmp1)/w);
  return tmp1;
}

double gamma_g = 7;
double gamma_p[] = {0.99999999999980993, 676.5203681218851, -1259.1392167224028,
     771.32342877765313, -176.61502916214059, 12.507343278686905,
     -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7};

cplx Gamma::eval(const cplx & in) {
  cplx z = argument->eval(in);
  if(z.real() < 0.5) {
    z = Un-z;
    cplx tmp2 = PI*z;
    z = z - 1;
    cplx x =  gamma_p[0];
    for(int i = 1; i <= gamma_g+1; i++) {
      x = x + gamma_p[i]/(z+i);
    }
    cplx t = z + gamma_g + 0.5; 
    cplx mt = -t;
    return cplx(PI)/(sin(tmp2)*2.5066282746310002 * (t^(z+0.5)) * exp(mt) * x);
  } else {
    z = z - 1;
    cplx x =  gamma_p[0];
    for(int i = 1; i <= gamma_g+1; i++) {
      x = x + gamma_p[i]/(z+i);
    }
    cplx t = z + gamma_g + 0.5; 
    cplx mt = -t;
    return 2.5066282746310002 * (t^(z+0.5)) * exp(mt) * x;
  }
}

cplx Factorial::eval(const cplx & in) {
  cplx z = argument->eval(in) + Un;
  if(z.real() < 0.5) {
    z = Un-z;
    cplx tmp2 = PI*z;
    z = z - 1;
    cplx x =  gamma_p[0];
    for(int i = 1; i <= gamma_g+1; i++) {
      x = x + gamma_p[i]/(z+i);
    }
    cplx t = z + gamma_g + 0.5; 
    cplx mt = -t;
    return cplx(PI)/(sin(tmp2)*2.5066282746310002 * (t^(z+0.5)) * exp(mt) * x);
  } else {
    z = z - 1;
    cplx x =  gamma_p[0];
    for(int i = 1; i <= gamma_g+1; i++) {
      x = x + gamma_p[i]/(z+i);
    }
    cplx t = z + gamma_g + 0.5; 
    cplx mt = -t;
    return 2.5066282746310002 * (t^(z+0.5)) * exp(mt) * x;
  }
}

cplx Floor::eval(const cplx & in) {
  cplx z = argument->eval(in);
  return cplx(floor(z.real()), floor(z.imag()));
}

cplx CompositionRecursive::eval(const cplx & z) {
	cplx resultat=z;
  cplx resultat_tmp=resultat;
	int i=nbCompose;
	while(i>0) {
    resultat_tmp = argument->eval(resultat);
    resultat = resultat_tmp;
    i--;}//si i<0, on laisse l'identité (l'inverse n'est pas défini)
	return resultat;
}

Constante::Constante(double _valeur):Function(false),valeur(_valeur) {
}

Constante::Constante(cplx _valeur):Function(false),valeur(_valeur) {
}
Constante::Constante(cplx _valeur, bool marked):Function(marked),valeur(_valeur) {
}

cplx Exposant::eval(const cplx & z) {	return argument->eval(z)^exposant;}
cplx Oppose::eval(const cplx & z) { return -argument->eval(z); }
cplx Arg::eval(const cplx & z)	{
  cplx tmp = argument->eval(z);
  if(argument2 == NULL) {
    return cplx(tmp.argument(), 0);
  } else {
    return cplx(tmp.argument(argument2->eval(z).real()), 0);
  }
}
cplx Module::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return cplx(tmp.module(), 0); }
cplx Inverse::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return tmp.invs(); }
cplx Heaviside::eval(const cplx & z)	{ cplx tmp = argument->eval(z); if(tmp.real() >= 0) return Un; else return ZERO; }
cplx Sin::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return sin(tmp); }
cplx Cos::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return cos(tmp); }
cplx Tan::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return tan(tmp); }
cplx Exp::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return exp(tmp); }
cplx Sinh::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return sinh(tmp); }
cplx Cosh::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return cosh(tmp); }
cplx Tanh::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return tanh(tmp); }
cplx Ln::eval(const cplx & z)		{
  if(argument2 == NULL) {
    cplx tmp = argument->eval(z);
    return ln(tmp);
  } else {
    cplx m = argument2->eval(z);
    cplx tmp = argument->eval(z);
    return ln(tmp, m.real());
  }}
cplx Sqrt::eval(const cplx & z)	{
  cplx tmp = argument->eval(z);
  if(argument2 == NULL) {
    return sqrt(tmp);
  } else {
    cplx m = argument2->eval(z);
    return sqrt(tmp, m.real());
  }}
cplx Argsh::eval(const cplx & z)	{ cplx tmp = argument->eval(z); if(argument2 == NULL) return argsh(tmp);else{cplx m = argument2->eval(z); return argsh(tmp, m); }}
cplx Argch::eval(const cplx & z)	{ cplx tmp = argument->eval(z); if(argument2 == NULL) return argch(tmp);else{cplx m = argument2->eval(z); return argch(tmp, m);}}
cplx Argth::eval(const cplx & z)	{ cplx tmp = argument->eval(z); if(argument2 == NULL)return argth(tmp);else{cplx m = argument2->eval(z);return argth(tmp,m.real());}}

cplx Arcsin::eval(const cplx & z)	{ cplx tmp = argument->eval(z); if(argument2 == NULL) return arcsin(tmp);else{ cplx m = argument2->eval(z); return arcsin(tmp, m); }}
cplx Arccos::eval(const cplx & z)	{ cplx tmp = argument->eval(z); if(argument2 == NULL) return arccos(tmp);else{ cplx m = argument2->eval(z); return arccos(tmp, m); }}
cplx Arctan::eval(const cplx & z)	{ cplx tmp = argument->eval(z);if(argument2==NULL)return arctan(tmp);else{cplx m = argument2->eval(z);return arctan(tmp,m.real());}}

cplx Real::eval(const cplx & z)   { return argument->eval(z).realcplx(); }
cplx Imag::eval(const cplx & z)   { return argument->eval(z).imagcplx(); }
cplx Conj::eval(const cplx & z)   { return argument->eval(z).conj(); }
cplx Circle::eval(const cplx & z) { cplx w=argument->eval(z); return w.conj()-w.invs(); }//Optimiser?

cplx Unitary::eval(const cplx & z)	{ cplx tmp = argument->eval(z); double m = tmp.module();
  return cplx(tmp.real()/m, tmp.imag()/m); }

cplx LessEq::eval(const cplx & z)	{
  cplx a = argument->eval(z);
  cplx b = argument2->eval(z);
  if(a.real() <= b.real()) return Un;
  else return ZERO;
}

cplx Less::eval(const cplx & z)	{
  cplx a = argument->eval(z);
  cplx b = argument2->eval(z);
  if(a.real() < b.real() || (a.real() == b.real() && a.imag() < b.imag())) return Un;
  else return ZERO;
}

cplx GreaterEq::eval(const cplx & z)	{
  cplx a = argument->eval(z);
  cplx b = argument2->eval(z);
  if(a.real() >= b.real()) return Un;
  else return ZERO;
}

cplx Greater::eval(const cplx & z)	{
  cplx a = argument->eval(z);
  cplx b = argument2->eval(z);
  if(a.real() > b.real() || (a.real() == b.real() && a.imag() > b.imag())) return Un;
  else return ZERO;
}

cplx Equals::eval(const cplx & z)	{
  cplx a = argument->eval(z);
  cplx b = argument2->eval(z);
  if(a.real() == b.real() && a.imag() == b.imag()) return Un;
  else return ZERO;
}

cplx NotEquals::eval(const cplx & z)	{
  cplx a = argument->eval(z);
  cplx b = argument2->eval(z);
  if(a.real() != b.real() || a.imag() != b.imag()) return Un;
  else return ZERO;
}

cplx Beta::eval(const cplx & z)	{
    cplx tmp = argument->eval(z);
    double resultat = 0;
	double x = tmp.real();
	double y = tmp.imag();
	double dt = 0.015625;
	double tmp1 = 0;
	double tmp2 = 0;
    for(double t = dt; t < 1;  t += dt) {
	  tmp1 = log(t);
	  tmp2 = log(-t + 1);
	  tmp2 = tmp1*(x - 1)+tmp2*(y-1);
	  tmp2 = exp(tmp2);
	  resultat = resultat + tmp2*dt;
	}
  return cplx(resultat);
}

cplx Zeta::eval(const cplx & z)	{
  cplx tmp = argument->eval(z);
  cplx resultat(1);
  double lntmp = 0;
  double r = -tmp.real();
  cplx i = I*(-tmp.imag());
  for(double k=2; k < 1000; k++) {
    lntmp = log(k);
    resultat += expDirect(i*lntmp)*exp(r*lntmp);
  }
	return resultat;
}


//Function with variables.
FunctionMultiple::FunctionMultiple(
    Function* _arg,      VariableRef *_var, Function *_debut, Function *_fin, Function* _step, bool _marked):
    FunctionUnary(_arg, _marked), var(_var),      debut(_debut),    fin(_fin),      step(_step) {
}
FunctionMultiple::FunctionMultiple(
  Function *_arg,     VariableRef *_var, Function *_debut, Function *_fin, bool _marked):
  FunctionUnary(_arg, _marked),var(_var),      debut(_debut),    fin(_fin),     step(new Constante(1.0))
 {
}
//delete est seulement la destruction du noeud (pour les simplifications p.ex)
FunctionMultiple::~FunctionMultiple() {
}

Function* FunctionMultiple::kill() {
  if(debut)
    debut = debut->kill();
  if(fin)
    fin = fin->kill();
  if(step)
    step = step->kill();
  return FunctionUnary::kill();
}

bool FunctionMultiple::simplifieArgFunctionMultiple() {
  bool result = simplifieArgFunctionUnary();
  debut = debut->simplifie();
  if(fin)
    fin = fin->simplifie();
  if(step)
    step = step->simplifie();
  return result && debut->isConstant() && fin->isConstant() && (step ? step->isConstant() : TRUE) && !this->marked;
}

Function* FunctionMultiple::simplifie() {
  if(!simplifieArgFunctionMultiple()) return this;
	//Ici, cela veut dire que l'argument est constant.
	//On fait donc simple... on garde la constante de l'argument, modifiée, et on se supprime.
	cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
	kill();//On tue récursivement le noeud et son fils.
	return new Constante(res);//Et on retourne une nouvelle constante.
}

SommeMultiple::SommeMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, Function* theStep, bool _marked)
	:FunctionMultiple(argument, theVar, theDebut, theFin, theStep, _marked) {
}
SommeMultiple::SommeMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, Function* theStep, bool _marked, NAME_VARIANT n)
	:FunctionMultiple(argument, theVar, theDebut, theFin, theStep, _marked) {
  this->name_variant = n;
}
SommeMultiple::SommeMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, bool _marked)
	:FunctionMultiple(argument, theVar, theDebut, theFin, _marked) {
}
cplx SommeMultiple::eval(const cplx & z) {
	cplx resultat = 0;
  double d = debut->eval(z).real();
  double f = fin->eval(z).real();
  double s = step->eval(z).real();
  if( d*s > f*s || s == 0)
    return resultat;
	for(double k=d; (!(s>0) || k<=f) && (!(s<0) || k>=f); k+=s) {
    cplx tmp(k, 0); 
		var->set(tmp);//Effet de bord, les sous-fonctions vont voir la variable changer.
		resultat += argument->eval(z);
	}
	return resultat;
}

ProduitMultiple::ProduitMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, Function* theStep, bool _marked)
	:FunctionMultiple(argument, theVar, theDebut, theFin, theStep, _marked) {
}
ProduitMultiple::ProduitMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, bool _marked)
	:FunctionMultiple(argument, theVar, theDebut, theFin, _marked) {
}
cplx ProduitMultiple::eval(const cplx & z) {
	cplx resultat(1.0);
  double d = debut->eval(z).real();
  double f = fin->eval(z).real();
  double s = step->eval(z).real();
  if( d*s > f*s || s == 0)
    return resultat;
	for(double k=d; k<=f; k+=s) {
		cplx tmp(k, 0); 
    var->set(tmp);//Effet de bord, les sous-fonctions vont voir la variable changer.
		resultat*= argument->eval(z);
	}
	return resultat;
}

CompositionMultiple::CompositionMultiple(Function* argument, VariableRef *theVar, Function* theDebut, Function* theFin, bool _marked)
	:FunctionMultiple(argument, theVar, theDebut, theFin, NULL, _marked) {
}
cplx CompositionMultiple::eval(const cplx & z) {
  cplx tmp = debut->eval(z);
  var->set(tmp);
  double count = fin->eval(z).real();
  while (count > 0) {
    cplx tmp=argument->eval(z);
    var->set(tmp);
    count--;
  }
	return var->evalFast();
}

LetIn::LetIn(Function* argument, VariableRef *theVar, Function* debut, bool _marked, NAME_VARIANT n)
	:FunctionMultiple(argument, theVar, debut, NULL, NULL, _marked) {
  this->name_variant = n;
}
cplx LetIn::eval(const cplx & z) {
  var->set(debut);
  return argument->eval(z);
}

Function* LetIn::simplifie() {
  debut = debut->simplifie();
  var->set(debut);
  if(!simplifieArgFunctionUnary()) {
    return this;
  }
	//Ici, cela veut dire que l'argument est constant.
	//On fait donc simple... on garde la constante de l'argument, modifiée, et on se supprime.
	cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
	kill();//On tue récursivement le noeud et son fils.
	return new Constante(res);//Et on retourne une nouvelle constante.
}

SetIn::SetIn(Function* argument, VariableRef *theVar, Function* debut, bool _marked, NAME_VARIANT n)
	:FunctionMultiple(argument, theVar, debut, NULL, NULL, _marked) {
  this->name_variant = n;
}
cplx SetIn::eval(const cplx & z) {
  cplx tmp = debut->eval(z);
  var->set(tmp);
  return argument->eval(z);
}

Function* SetIn::simplifie() {
  debut = debut->simplifie();
  if(debut->isConstant()) {
    Constante *c = dynamic_cast<Constante*>(debut);
    var->set(c->valeur);
    if(!simplifieArgFunctionUnary()) {
      return this;
    }
    //Ici, cela veut dire que l'argument est constant.
    //On fait donc simple... on garde la constante de l'argument, modifiée, et on se supprime.
    cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
    kill();//On tue récursivement le noeud et son fils.
    return new Constante(res);//Et on retourne une nouvelle constante.
  }
  return this;
}

cplx VariableRef::eval(const cplx & z) {
  return pointer->eval(z);
}

VariableRef::~VariableRef() {
	return;
}


Function *VariableRef::simplifie() {
	if(pointer->fun == NULL) {
    return this;
    /*cplx res = pointer->val;
    kill();
    return new Constante(res);*/
  } else if(pointer->fun->isConstant()) {
    cplx res = dynamic_cast<Constante*>(pointer->fun)->valeur;
    kill();
    return new Constante(res);
  } else {
    return this;
  }
}


//Implementation of variables.
void Variable::setNom(const TCHAR* theNom) {
	//Copy the name to the buffer.
	size_t taille = _tcslen(theNom);
	nom = new TCHAR[taille+1];
	memcpy(nom, theNom, sizeof(TCHAR)*taille);
	*(nom+taille)=L'\0';
}

Variable::~Variable() {
	delete [] nom;
}

VariableListe* VariableListe::get() {
	if(varList==NULL) {
		varList=new VariableListe();
	}
	return varList;
}

void VariableListe::killf() {
	if(!varList) return;
	Variable* temp=varList->tete;
	while(temp) {
		Variable *suivante=temp->prev();
		delete temp;	//il n'y a qu'ici qu'on a le droit de détruire les variables
		temp=suivante;
	}
	delete varList;
}

VariableRef* VariableListe::getVariable(TCHAR *nom, bool marked){
	Variable* temp=VariableListe::get()->tete;
	while(temp) {
		if(_tcscmp(temp->nom, nom)==0) {
      return new VariableRef(temp, marked);
			//return temp;
    }
		temp = temp->prec;
	}
	//Not found: lets create it.
	temp = new Variable(nom, marked);
	temp->prec = varList->tete;
	varList->tete = temp;
	return new VariableRef(temp, marked);
}

Variable* VariableListe::getNonDeclared(){
	Variable* temp=VariableListe::get()->tete;
	while(temp) {
		if(!temp->isDeclared()) {
      return temp;
    }
		temp = temp->prec;
	}
  return NULL;
}



VariableListe *VariableListe::varList=NULL;
