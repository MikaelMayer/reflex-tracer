/*******************************
 * Name:	funcalea.cpp
 * Author:	Mikaël Mayer
 * Purpose:	This file enable to create random functions thanks to a random-tree.
 * History: Work started 20071029
 *********************************/

#include "stdafx.h"
#include "funcalea.h"

int Tree2::fillEmptyNumber(int i) {
	if(numberEmpty<i)
    return this->numberFinalNodes;
	if(left==NULL) {
		if(i==1) {
      if(right == NULL) this->numberFinalNodes--;
      left = new Tree2(this->parent);
      this->numberFinalNodes++;
		} else if(right==NULL && i==2) {
      if(left == NULL) this->numberFinalNodes--;
			right = new Tree2(this->parent);
      this->numberFinalNodes++;
		} else if(right!=NULL) {
      this->numberFinalNodes = right->fillEmptyNumber(i-1);
		}
	} else { // left != NULL
		int n = left->numberEmpty;
    if(i<=n) {
			this->numberFinalNodes = left->fillEmptyNumber(i);
      if(right != NULL) this->numberFinalNodes+= right->numberFinalNodes;
    } else if (right!=NULL) {
			this->numberFinalNodes = right->fillEmptyNumber(i-n);
      this->numberFinalNodes+= left->numberFinalNodes;
		} else if(right == NULL && i==n+1) {
			right = new Tree2(this->parent);
      this->numberFinalNodes++;
		}
	}
	numberEmpty++;
  return this->numberFinalNodes;
}

int Tree2::computeIndexFinalNode(int start) {
  if(left == NULL && right == NULL){
    indexFinalNode = start;
  } else {
    int leftFinalNodes = 0;
    if(left) {
      leftFinalNodes = left->computeIndexFinalNode(start);
    }
    if(right) right->computeIndexFinalNode(start + leftFinalNodes);
  }
  return numberFinalNodes;
}

void Tree::fillEmptyNumber(int i) {
	if(t==NULL) {
		t=new Tree2(this);
		return;
	}
	t->fillEmptyNumber(i);
}

void Tree::addRandomNodes(int n) {
	int size = numberEmpty();
	for(int i=0; i<n; i++) {
		fillEmptyNumber((rand()%size)+1);
		size++;
	}
}

cplx randcplx() {
	//Nombre d�cimal al�atoire entre -4 et 4
	return cplx((double)(rand()%400)/50.0-4.0,
				(double)(rand()%400)/50.0-4.0);
}

Function* randPolynom(int degre) {
	if(degre==0) return new Constante(randcplx());
	return new Somme(randPolynom(0), new Multiplication(new Identity(false), randPolynom(degre-1), false), false);
}

Function *Tree2::convertToFunction(bool holo) {
	if(left==NULL && right==NULL) {
    Function* result = NULL;

    if(parent->subFunction && parent->chosenSubFunctionIndex == this->indexFinalNode) {
      Function* sf = parent->subFunction;
      parent->subFunction = NULL;
      return sf;
    } else {
		  int numbercasesIdentity = holo?1:4;
		  switch(rand()%numbercasesIdentity) { // 2 chances over 4 to get the normal identity
			  case 0:
			  case 1:	result = new Identity  (false); break;
			  case 2:	result = new Identity_x(false); break;
			  case 3:	result = new Identity_y(false); break;
		  }
    }
    return result;
	}
	Function *argument1=NULL, *argument2=NULL;
	if(left!=NULL)
		argument1=left->convertToFunction(holo);
	if(right!=NULL)
		argument2=right->convertToFunction(holo);
	if(argument2!=NULL && argument1==NULL) {
		argument1=argument2;
		argument2=NULL;
	}
	int numbercases;
	if(argument2==NULL) {//Fonctions unaires
    if(holo)
      numbercases=18;
    else
      numbercases = 22;
		switch(rand()%numbercases) {
			case 0: return new Exp(argument1, false);
			case 1: return new Cos(argument1, false);
			case 2: return new Sin(argument1, false);
			case 3: return new Cosh(argument1, false);
			case 4: return new Sinh(argument1, false);
			case 5: return new Arcsin(argument1, false);
			case 6: return new Arccos(argument1, false);
			case 7: return new Arctan(argument1, false);
			case 8: return new Argsh(argument1, false);
			case 9: return new Argch(argument1, false);
			case 10: return new Argth(argument1, false);
			case 11: return new Exposant(argument1,2, false);
			case 12: return new Exposant(argument1,rand()%4+2, false);
			case 13: return new Division(new Constante(1.0),argument1, false);
			case 14: return new Exposant(argument1,-(rand()%4+2), false);
			case 15: return new Multiplication(new Constante(randcplx()),argument1, false);
			case 16: return new Somme(new Constante(randcplx()),argument1, false);
			case 17: return new Compose(randPolynom(rand()%3+1), argument1, false);
			case 18: return new Real(argument1, false);
			case 19: return new Imag(argument1, false);
			case 20: return new Conj(argument1, false);
			case 21: return new Circle(argument1, false);
		}
	} else {
    if(holo)
      numbercases=6;
    else
      numbercases = 7;
		switch(rand()%numbercases) {
			case 0: return new Multiplication(argument1, argument2, false);
			case 1: return new Somme(argument1, argument2, false);
			case 2: 
        if(argument1->isIdentity() && argument2->isIdentity())
					return new Constante(1.0);
				return new Division(argument1, argument2, false);
			case 3:
				if(argument1->isIdentity() && argument2->isIdentity())
					return new Constante(-1.0);
				return new Soustraction(argument1, argument2, false);
			case 4: return new ExposantComplexe(argument1, argument2, false);
			case 5: return new Compose(argument1, argument2, false);
      case 6: return new Modulo(argument1, argument2, false);
		}
	}
	return NULL;
}

Function *Tree::convertToFunction(bool holo) {
	if(t==NULL) //Cas normalement improbable.
		return new Constante(0.0);
  chosenSubFunctionIndex = rand()%t->computeIndexFinalNode(0);
	return t->convertToFunction(holo);
}

Function* Tree::createFuncAlea(int n, bool holo, Function* subfunction) {
	Tree* t = new Tree();
	t->addRandomNodes(n);
  t->subFunction = subfunction;
	Function *resultat = t->convertToFunction(holo);
	delete t;
	return resultat;
}
