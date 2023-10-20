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

[[0], QGVAR(arsenalActions), "KJW's Two Weapons", [
	["text", "Text", {true}, "Swap Primary Weapons"],
	["statement", "Statement", {true}, ""],
	["button", "Switch", {true}, "", {}, {[0.1] call FUNC(switchPrimaryHandler); [true] call ace_arsenal_fnc_refresh}]
]] call ace_arsenal_fnc_addAction;