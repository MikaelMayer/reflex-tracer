/*******************************
 * Name:	functionFactory.h
 * Author:	Mika�l Mayer
 * Purpose:	Creates functions factories for several functions.
 * History: Work started 20080910
 *********************************/


#ifndef FUNCTION_FACTORY_H
#define FUNCTION_FACTORY_H

#include "functions.h"

class FunctionFactory {
public:
  virtual Function* create(Function *argument1, bool marked)=0;
};

class IdentityFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Identity(marked); }
};

class Identity_xFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Identity_x(marked); }
};

class Identity_yFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Identity_y(marked); }
};

class SinFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Sin(argument1, marked); }
};

class CosFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Cos(argument1, marked); }
};

class TanFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Tan(argument1, marked); }
};

class ExpFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Exp(argument1, marked); }
};

class SinhFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Sinh(argument1, marked); }
};

class CoshFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Cosh(argument1, marked); }
};

class TanhFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Tanh(argument1, marked); }
};

class LnFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Ln(argument1, marked); }
};

class SqrtFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Sqrt(argument1, marked); }
};

class ArgshFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Argsh(argument1, marked); }
};

class ArgchFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Argch(argument1, marked); }
};

class ArgthFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Argth(argument1, marked); }
};

class ArcsinFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Arcsin(argument1, marked); }
};

class ArccosFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Arccos(argument1, marked); }
};

class ArctanFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Arctan(argument1, marked); }
};

class RealFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Real(argument1, marked); }
};

class ImagFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Imag(argument1, marked); }
};

class CircleFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Circle(argument1, marked); }
};

class ConjFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Conj(argument1, marked); }
};

#endif //FUNCTION_FACTORY_H
