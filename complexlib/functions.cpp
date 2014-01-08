/*******************************
 * Name:	functions.cpp
 * Author:	Mika�l Mayer
 * Purpose:	Implements the Function class
 * History: Work started 20070901
 *********************************/

#include "stdafx.h"
#include "functions.h"

//FunctionUnary basic implementations.
FunctionUnary::FunctionUnary(Function* theArgument, bool _marked):Function(_marked) {
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
	return argument->isConstant();
}

Function *FunctionUnary::simplifie() {
	//Si la fonction est constante, on la simplifie.
	if(!simplifieArgFunctionUnary()) return this;
	//Ici, cela veut dire que l'argument est constant.
	//On fait donc simple... on garde la constante de l'argument, modifi�e, et on se supprime.
	cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
	kill();//On tue r�cursivement le noeud et son fils.
	return new Constante(res);//Et on retourne une nouvelle constante.
}

//FunctionBinary basic implementations.
FunctionBinary::FunctionBinary(Function* theArgument, Function* theArgument2, bool _marked):FunctionUnary(theArgument, _marked) {
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
	return resultat && argument2->isConstant();
}
Function *FunctionBinary::simplifie() {
	if(!simplifieArgFunctionBinary()) return this;
	cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
	kill();						//On tue r�curivement le noeud et son fils.
	return new Constante(res);	//On r�cup�re une nouvelle constante.
}

//Cas particulier de la fonction compose.
Function *Compose::simplifie() {
	simplifieArgFunctionBinary();
	if(argument->isConstant()) {//Le premier argument est constant.
		cplx res = dynamic_cast<Constante*>(argument)->valeur;
		kill();
		return new Constante(res);
	} else if(argument2->isConstant()) {
    cplx tmp(0);
		cplx res = eval(tmp);//Peu importe l'endroit o� on l'�value.
		kill();
		return new Constante(res);
  } else if(argument->isIdentity()) {
		//une composition avec l'identit� => c'est la deuxi�me fonction
		Function *f = argument2;
    argument2 = NULL;
		delete this;
		return f;
	} else if(argument2->isIdentity()) {
		//une composition avec l'identit� => c'est la deuxi�me fonction
		Function *f = argument;
    argument = NULL;
		delete this;
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
cplx Somme::eval(const cplx & z)			      {return argument->eval(z)+argument2->eval(z);}
cplx Multiplication::eval(const cplx & z)	  {return argument->eval(z)*argument2->eval(z);}
cplx Soustraction::eval(const cplx & z)	    {return argument->eval(z)-argument2->eval(z);}
cplx Division::eval(const cplx & z)		      {return argument->eval(z)/argument2->eval(z);}
cplx Compose::eval(const cplx & z)		      {cplx tmp = argument2->eval(z); return argument->eval(tmp);}
cplx ExposantComplexe::eval(const cplx & z) {
  cplx w = argument2->eval(z);
  if(w.real()!=w.real() && w.imag()!=w.imag()) return cplx(1);
  cplx tmp = argument->eval(z);
  cplx exparg = w*ln(tmp);
  return exp(exparg);
}

cplx CompositionRecursive::eval(const cplx & z) {
	cplx resultat=z;
  cplx resultat_tmp=resultat;
	int i=nbCompose;
	while(i>0) {
    resultat_tmp = argument->eval(resultat);
    resultat = resultat_tmp;
    i--;}//si i<0, on laisse l'identit� (l'inverse n'est pas d�fini)
	return resultat;
}

Constante::Constante(double _valeur):Function(false),valeur(_valeur) {
  if(valeur.real() != valeur.real()) {
    valeur = 1;
  }
}

Constante::Constante(cplx _valeur):Function(false),valeur(_valeur) {
  if(valeur.real()!=valeur.real() || valeur.imag() != valeur.imag()) {
    valeur = 1;
  }
}

cplx Exposant::eval(const cplx & z) {	return argument->eval(z)^exposant;}
cplx Oppose::eval(const cplx & z) { return -argument->eval(z); }
cplx Sin::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return sin(tmp); }
cplx Cos::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return cos(tmp); }
cplx Tan::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return tan(tmp); }
cplx Exp::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return exp(tmp); }
cplx Sinh::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return sinh(tmp); }
cplx Cosh::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return cosh(tmp); }
cplx Tanh::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return tanh(tmp); }
cplx Ln::eval(const cplx & z)		{ cplx tmp = argument->eval(z); return ln(tmp); }
cplx Sqrt::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return sqrt(tmp); }
cplx Argsh::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return argsh(tmp); }
cplx Argch::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return argch(tmp); }
cplx Argth::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return argth(tmp); }

cplx Arcsin::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return arcsin(tmp); }
cplx Arccos::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return arccos(tmp); }
cplx Arctan::eval(const cplx & z)	{ cplx tmp = argument->eval(z); return arctan(tmp); }

cplx Real::eval(const cplx & z)   { return argument->eval(z).realcplx(); }
cplx Imag::eval(const cplx & z)   { return argument->eval(z).imagcplx(); }
cplx Conj::eval(const cplx & z)   { return argument->eval(z).conj(); }
cplx Circle::eval(const cplx & z) { cplx w=argument->eval(z); return w.conj()-w.invs(); }//Optimiser?

//Function with variables.
FunctionMultiple::FunctionMultiple(
    Function* _arg,      Variable *_var, Function *_debut, Function *_fin, Function* _step, bool _marked):
    FunctionUnary(_arg, _marked), var(_var),      debut(_debut),    fin(_fin),      step(_step) {
}
FunctionMultiple::FunctionMultiple(
  Function *_arg,     Variable *_var, Function *_debut, Function *_fin, bool _marked):
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
  fin = fin->simplifie();
  if(step)
    step = step->simplifie();
  return result && debut->isConstant() && fin->isConstant() && (step ? step->isConstant() : TRUE);
}

Function* FunctionMultiple::simplifie() {
  if(!simplifieArgFunctionMultiple()) return this;
	//Ici, cela veut dire que l'argument est constant.
	//On fait donc simple... on garde la constante de l'argument, modifi�e, et on se supprime.
	cplx res = eval((dynamic_cast<Constante*>(argument))->valeur);
	kill();//On tue r�cursivement le noeud et son fils.
	return new Constante(res);//Et on retourne une nouvelle constante.
}

SommeMultiple::SommeMultiple(Function* argument, Variable *theVar, Function* theDebut, Function* theFin, Function* theStep, bool _marked)
	:FunctionMultiple(argument, theVar, theDebut, theFin, theStep, _marked) {
}
SommeMultiple::SommeMultiple(Function* argument, Variable *theVar, Function* theDebut, Function* theFin, bool _marked)
	:FunctionMultiple(argument, theVar, theDebut, theFin, _marked) {
}
cplx SommeMultiple::eval(const cplx & z) {
	cplx resultat = 0;
  double d = debut->eval(z).real();
  double f = fin->eval(z).real();
  double s = step->eval(z).real();
  if( d*s > f*s || s == 0)
    return resultat;
	for(double k=d; k<=f; k+=s) {
    cplx tmp(k, 0); 
		var->set(tmp);//Effet de bord, les sous-fonctions vont voir la variable changer.
		resultat += argument->eval(z);
	}
	return resultat;
}

ProduitMultiple::ProduitMultiple(Function* argument, Variable *theVar, Function* theDebut, Function* theFin, Function* theStep, bool _marked)
	:FunctionMultiple(argument, theVar, theDebut, theFin, theStep, _marked) {
}
ProduitMultiple::ProduitMultiple(Function* argument, Variable *theVar, Function* theDebut, Function* theFin, bool _marked)
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

CompositionMultiple::CompositionMultiple(Function* argument, Variable *theVar, Function* theDebut, Function* theFin, bool _marked)
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
		delete temp;	//il n'y a qu'ici qu'on a le droit de d�truire les variables
		temp=suivante;
	}
	delete varList;
}

Variable* VariableListe::getVariable(TCHAR *nom, bool marked){
	Variable* temp=varList->tete;
	while(temp) {
		if(_tcscmp(temp->nom, nom)==0)
			return temp;
		temp = temp->prec;
	}
	//Not found: lets create it.
	temp = new Variable(nom, marked);
	temp->prec = varList->tete;
	varList->tete = temp;
	return temp;
}

VariableListe *VariableListe::varList=NULL;
