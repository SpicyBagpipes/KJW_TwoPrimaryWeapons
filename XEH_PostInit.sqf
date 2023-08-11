#include "macro_general.hpp"
/*
 *  Author: KJW
 * 
 *  Handles relevant code to be run post init.
 * 
 *  Arguments:
 *	None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoPrimaryWeapons_XEH_PostInit
 * 
 *  Public: No
 */


call FUNC(addEventHandlers);
call FUNC(addSettings);
call FUNC(addCBAKeybinds);