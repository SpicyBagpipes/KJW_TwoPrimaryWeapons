#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Updates shown weapon based on _unit's currently equipped primary.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoPrimaryWeapons_fnc_updateShownWeapon
 * 
 *  Public: No
 */

private _unit = call CBA_fnc_currentUnit;

private _currentWeaponObjects = _unit getVariable [QGVAR(currentWeaponObjects),[]];
private _secondPrimaryEquipped = _unit getVariable [QGVAR(secondPrimaryEquipped),false];
private _weaponInfo = if (_secondPrimaryEquipped) then {
	_unit getVariable [QGVAR(primaryPrimaryInfo),[]];
} else {
	_unit getVariable [QGVAR(secondPrimaryInfo),[]];
};
private _currentPositionSelection = if (_secondPrimaryEquipped) then {
	GVAR(selectedPositionPrimary);	
} else {
	GVAR(selectedPositionSecondary);
};

if (_currentPositionSelection isEqualTo []) exitWith {};

private _positions = [_currentPositionSelection];
private _objects = [];

{
	deleteVehicle _x;
} forEach _currentWeaponObjects;

if (_weaponInfo isEqualTo []) exitWith {};
{
	private _holder = createVehicle [QGVAR(GWH),[0,0,0]];
	_holder addWeaponWithAttachmentsCargoGlobal [_weaponInfo, 1];
	_holder setDamage 1;
	_holder attachTo [_unit, _x#2, _x#0, true];
	_holder setVectorDirAndUp _x#1;
	_objects pushBack _holder;
} forEach _positions;
_unit setVariable [QGVAR(currentWeaponObjects), _objects, true];

/*
	Positions array:
	[mempoint,vectordirandup,position]
*/