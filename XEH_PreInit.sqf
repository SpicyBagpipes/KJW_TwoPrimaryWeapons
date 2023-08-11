#include "macro_general.hpp"
/*
 *  Author: KJW
 * 
 *  Handles relevant code to be run pre init.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoPrimaryWeapons_XEH_PreInit
 * 
 *  Public: No
 */


call FUNC(addSettings);
call FUNC(addCBAKeybinds);