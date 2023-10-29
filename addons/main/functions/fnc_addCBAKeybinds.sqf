#include "..\script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Adds keybindings required for the mod to function.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoPrimaryWeapons_fnc_addCBAKeybinds
 * 
 *  Public: No
 */


#include "\a3\ui_f\hpp\defineDIKCodes.inc"

[
    QUOTE(COMPONENT_BEAUTIFIED),
    QGVAR(SwitchToSecondPrimary),
    [
        "Switch to Second Primary",
        "Switch to second primary weapon"
    ],
    {
        if (commandingMenu isNotEqualTo "") exitWith {};
        private _delay = if (currentWeapon player isEqualTo "") then {
            0.1
        } else {
            1.4
        };
        [_delay] call FUNC(switchPrimaryHandler)
    },
    {
        //Keyup
    },
    [
        DIK_4,
        [
            false,
            false,
            false
        ]
    ]
] call CBA_fnc_addKeybind;
