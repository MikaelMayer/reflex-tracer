/*******************************
 * Name:	funcalea.h
 * Author:	Mika�l Mayer
 * Purpose:	This file enable to c
 reate random functions thanks to a random-tree.
 * History: Work started 20071028
 *********************************/
#ifndef FUNCALEA_H
#define FUNCALEA_H
#include "functions.h"

class Tree;

class Tree2 {
public:
  Tree* parent;

	Tree2* left;
	Tree2* right;
	int numberEmpty; // Number of empty leaves
  int numberFinalNodes;
  int indexFinalNode; // Index of this final node, if any
	Tree2(Tree* parent_) {numberEmpty = 2;left=NULL;right=NULL;numberFinalNodes=1;this->parent=parent_;}
	~Tree2() {if(left) delete left; if(right) delete right;}
  // Fills the i-th node in infix reading with a new tree.
  // returns the number of final nodes.
	int fillEmptyNumber(int i);
  // For all final nodes (left == NULL, right == NULL), compute their indexes (1, 2, 3 ...)
  // The first start should be 1.
  // Return the number of final nodes.
  int computeIndexFinalNode(int start);

	Function* convertToFunction(bool holo);
};

class Tree {
private:
	Tree2* t;
	Tree() {t=NULL;subFunction=NULL;chosenSubFunctionIndex=0;}
public:
  Function *subFunction; // Function to include in the random function generator.
  int chosenSubFunctionIndex;
	~Tree() {if(t) delete t;}
	int numberEmpty() {if(!t) return 1; else return t->numberEmpty;}
	void fillEmptyNumber(int i);
	void addRandomNodes(int n);
	Function* convertToFunction(bool holo);
	static Function* createFuncAlea(int n, bool holo, Function* subFunction=NULL);
};

#endif
