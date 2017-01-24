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
  virtual bool mayHaveTwoArgs() { return false; }
  // Should be overriden if it can have two args.
  virtual Function* create(Function *argument1, Function *argument2, bool marked) {
    return create(argument1, marked);
  }
};

class VariableFactory: public FunctionFactory {
  TCHAR* name;
public:
  VariableFactory(TCHAR* theNom):name(theNom) {}
  Function *create(Function *argument1, bool marked) {
    if(argument1 == NULL) {
      return VariableListe::get()->getVariable(name, marked);
    } else {
      Function *tmp = VariableListe::get()->getVariable(name, marked);
      return new Compose(tmp, argument1, false, DIRECT);
    }
  }
};

class LnFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Ln(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Ln(argument1, argument2, marked);
  }
};

class SqrtFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Sqrt(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Sqrt(argument1, argument2, marked, SQRT);
  }
};

class RacineFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Sqrt(argument1, marked, RACINE); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Sqrt(argument1, argument2, marked, RACINE);
  }
};

class ArgFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Arg(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Arg(argument1, argument2, marked, ARG);
  }
};

class ArgumentFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Arg(argument1, marked, ARGUMENT); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Arg(argument1, argument2, marked, ARGUMENT);
  }
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

class ConstFactory: public FunctionFactory {
  private:
    cplx constfactor;
  public:
  ConstFactory(cplx constfactor):constfactor(constfactor) {}
  Function* create(Function *argument1, bool marked) { return new Constante(constfactor, marked); }
};

class InverseFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Inverse(argument1, marked, INVERSE); }
};

class InvFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Inverse(argument1, marked, INV); }
};

class ModuleFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Module(argument1, marked); }
};

class ModulusFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Module(argument1, marked, MODULUS); }
};

class AbsFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Module(argument1, marked, ABS); }
};

class ValAbsFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Module(argument1, marked, VALABS); }
};

class BetaFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Beta(argument1, marked); }
};

class ZetaFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Zeta(argument1, marked); }
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


class UnitaryFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Unitary(argument1, marked, UNITARY); }
};
class UnitaireFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Unitary(argument1, marked, UNITAIRE); }
};
class UnitFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Unitary(argument1, marked, UNIT); }
};
class SignFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Unitary(argument1, marked, SIGN); }
};
class SigneFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Unitary(argument1, marked, SIGNE); }
};

class HeavisideFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Heaviside(argument1, marked, HEAVISIDE); }
};
class HeavFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Heaviside(argument1, marked, HEAV); }
};

class ArgshFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Argsh(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Argsh(argument1, argument2, marked, DEFAULT_NAME_VARIANT);
  }
};

class ArgchFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Argch(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Argch(argument1, argument2, marked, DEFAULT_NAME_VARIANT);
  }
};

class ArgthFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Argth(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Argth(argument1, argument2, marked, DEFAULT_NAME_VARIANT);
  }
};

class ArcsinFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Arcsin(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Arcsin(argument1, argument2, marked, DEFAULT_NAME_VARIANT);
  }
};

class ArccosFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Arccos(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Arccos(argument1, argument2, marked, DEFAULT_NAME_VARIANT);
  }
};

class ArctanFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Arctan(argument1, marked); }
  virtual bool mayHaveTwoArgs() { return true; }
  Function* create(Function *argument1, Function *argument2, bool marked) {
    return new Arctan(argument1, argument2, marked, DEFAULT_NAME_VARIANT);
  }
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

class CercleFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Circle(argument1, marked, CERCLE); }
};


class ConjFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Conj(argument1, marked); }
};

class CubeFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Exposant(argument1, 3, marked, CUBE); }
};

class CarreFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Exposant(argument1, 2, marked, CARRE); }
};

class SquareFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Exposant(argument1, 2, marked, SQUARE); }
};

class NewtonFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Newton(argument1, marked, NEWTON); }
};

class GammaFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Gamma(argument1, marked, GAMMA); }
};

class FactorialFactory: public FunctionFactory {
  NAME_VARIANT name_variant;
  public:
  FactorialFactory(NAME_VARIANT n):name_variant(n) { }
  Function* create(Function *argument1, bool marked) { return new Factorial(argument1, marked, name_variant); }
};

class FloorFactory: public FunctionFactory {
  Function* create(Function *argument1, bool marked) { return new Floor(argument1, marked, FLOOR); }
};

#endif //FUNCTION_FACTORY_H
