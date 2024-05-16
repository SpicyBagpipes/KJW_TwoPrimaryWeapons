#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Format of
 *  private _weapon = primaryWeapon player;
 *  private _weaponInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
 * 
 *  Arguments:
 *  0: Objects <ARRAY>
 *  1: All <BOOL>
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  [_weaponInfo] call KJW_TwoPrimaryWeapons_fnc_addSecondWeapon
 * 
 *  Public: Yes
 */

params ["_weaponInfo"];

private _secondPrimaryEquipped = player getVariable [QGVAR(secondPrimaryEquipped),false];

if (_secondPrimaryEquipped) then {
    player setVariable [QGVAR(primaryPrimaryInfo),_weaponInfo,true];
} else {
    player setVariable [QGVAR(secondPrimaryInfo),_weaponInfo,true];
};

call FUNC(updateShownWeapon);