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
			//If player has second primary weapon equipped, update second primary weapon info variable.
			private _secondPrimaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
			player setVariable [QGVAR(secondPrimaryInfo),_secondPrimaryInfo];
		} else {
			//If player has primary primary weapon equipped, update primary primary weapon info variable.
			private _primaryPrimaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
			player setVariable [QGVAR(primaryPrimaryInfo),_primaryPrimaryInfo];
		};
	}
] call CBA_fnc_addPlayerEventHandler;

player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	private _secondPrimaryEquipped = player getVariable [QGVAR(secondPrimaryEquipped),false];
	private _weaponInfo = if (_secondPrimaryEquipped) then {
		player getVariable [QGVAR(primaryPrimaryInfo),[]];
	} else {
		player getVariable [QGVAR(secondPrimaryInfo),[]];
	};
	player setVariable [QGVAR(secondPrimaryInfo),[]];
	player setVariable [QGVAR(primaryPrimaryInfo),[]];
	player setVariable [QGVAR(secondPrimaryEquipped),false];
	private _objects = player getVariable [QGVAR(currentWeaponObjects),[]];
	{
		deleteVehicle _x;
	} forEach _objects;
	player setVariable [QGVAR(currentWeaponObjects),[]];
	private _holder = createVehicle ["WeaponHolderSimulated",[0,0,0]];
	_holder addWeaponWithAttachmentsCargoGlobal [_weaponInfo, 1];
	_holder setPosASL (getPosASL _unit);
}];

["CBA_loadoutSet", {
	params ["_unit", "_loadout", "_extradata"];
	private _secondPrimaryInfo = _extradata getOrDefault [QGVAR(secondPrimaryInfo),[]];
	private _primaryPrimaryInfo = _extradata getOrDefault [QGVAR(primaryPrimaryInfo),[]];
	private _secondPrimaryEquipped = _extradata getOrDefault [QGVAR(secondPrimaryEquipped),false];
	_unit setVariable [QGVAR(secondPrimaryInfo), _secondPrimaryInfo];
	_unit setVariable [QGVAR(primaryPrimaryInfo), _primaryPrimaryInfo];
	_unit setVariable [QGVAR(secondPrimaryEquipped), _secondPrimaryEquipped];
	call FUNC(updateShownWeapon);
}] call CBA_fnc_addEventHandler;

["CBA_loadoutGet", {
	params ["_unit", "_loadout", "_extradata"];
	private _primaryPrimaryInfo = _unit getVariable [QGVAR(primaryPrimaryInfo), []];
	private _secondPrimaryInfo = _unit getVariable [QGVAR(secondPrimaryInfo), []];
	private _secondPrimaryEquipped = player getVariable [QGVAR(secondPrimaryEquipped),false];
	_extradata set [QGVAR(primaryPrimaryInfo), _primaryPrimaryInfo];
	_extradata set [QGVAR(secondPrimaryInfo), _secondPrimaryInfo];
	_extradata set [QGVAR(secondPrimaryEquipped), _secondPrimaryEquipped];
	private _oldInfo = _extradata getOrDefault ["KJW_ShotgunClass",""];
	if (_oldInfo isNotEqualTo "") then {_extradata deleteAt "KJW_ShotgunClass"};
}] call CBA_fnc_addEventHandler;

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	private _currentWeaponObjects = player getVariable [QGVAR(currentWeaponObjects),[]];
	{
		deleteVehicle _x;
	} forEach _currentWeaponObjects;
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	call FUNC(updateShownWeapon);
}];