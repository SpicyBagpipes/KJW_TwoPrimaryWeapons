#include "macro_general.hpp"
#define MACRO_FUNCPATH(FUNCNAME) COMPONENT##\functions\fnc_##FUNCNAME

#define FUNCTION_DECLARE(FUNCTIONNAME) class FUNCTIONNAME {\
                file = QUOTE(MACRO_FUNCPATH(FUNCTIONNAME).sqf);\
            };