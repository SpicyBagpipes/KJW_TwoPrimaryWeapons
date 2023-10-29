#define MAINPREFIX kjw
#define PREFIX two_primaries

#include "script_version.hpp"

#define VERSION MAJOR.MINOR.PATCH
#define VERSION_AR MAJOR,MINOR,PATCH

#define REQUIRED_VERSION 2.14

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(KJW Two Primary Weapons - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(KJW Two Primary Weapons - COMPONENT)
#endif
