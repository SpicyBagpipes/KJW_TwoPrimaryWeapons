#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Adds event handlers required for the mod to function.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoPrimaryWeapons_fnc_addEventHandlers
 * 
 *  Public: No
 */


[
	"loadout",
	{
		private _secondPrimaryEquipped = player getVariable [QGVAR(secondPrimaryEquipped),false];
		private _weapon = primaryWeapon player;
		if (_secondPrimaryEquipped) then {
			private _secondPrimaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
			player setVariable [QGVAR(secondPrimaryInfo),_secondPrimaryInfo];
		} else {
			private _primaryPrimaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
			player setVariable [QGVAR(primaryPrimaryInfo),_primaryPrimaryInfo];
		};
	}
] call CBA_fnc_addPlayerEventHandler;

player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	player setVariable [QGVAR(secondPrimaryInfo),[]];
	player setVariable [QGVAR(primaryPrimaryInfo),[]];
	player setVariable [QGVAR(secondPrimaryEquipped),false];
	private _objects = player getVariable [QGVAR(currentWeaponObjects),[]];
	{
		_x setDamage 0;
	} forEach _objects;
	player setVariable [QGVAR(currentWeaponObjects),[]];
}];

["CBA_loadoutSet", {
	params ["_unit", "_loadout", "_extradata"];
	private _secondPrimaryInfo = _extradata getOrDefault [QGVAR(secondPrimaryInfo),[]];
	_unit setVariable [QGVAR(secondPrimaryInfo), _secondPrimaryInfo];
	call FUNC(updateShownWeapon);
}] call CBA_fnc_addEventHandler;

["CBA_loadoutGet", {
	params ["_unit", "_loadout", "_extradata"];
	private _primaryPrimaryInfo = _unit getVariable [QGVAR(primaryPrimaryInfo), []];
	private _secondPrimaryInfo = _unit getVariable [QGVAR(secondPrimaryInfo), []];
	if (primaryWeapon _unit isEqualTo _primaryPrimaryInfo#0) then {
		_extradata set [QGVAR(secondPrimaryInfo), _secondPrimaryInfo];
	} else {
		_extradata set [QGVAR(secondPrimaryInfo), _primaryPrimaryInfo];
	};
	private _oldInfo = _extradata getOrDefault ["KJW_ShotgunClass",true];
	if (_oldInfo) exitWith {};
	_extradata deleteAt "KJW_ShotgunClass";
}] call CBA_fnc_addEventHandler;