#include "script_component.hpp"
/*
 *  Author: KJW
 *
 *  Updates shown weapon based on player's currently equipped primary.
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


private _currentWeaponObjects = player getVariable [QGVAR(currentWeaponObjects),[]];
private _secondPrimaryEquipped = player getVariable [QGVAR(secondPrimaryEquipped),false];
private _weaponInfo = if (_secondPrimaryEquipped) then {
	player getVariable [QGVAR(primaryPrimaryInfo),[]];
} else {
	player getVariable [QGVAR(secondPrimaryInfo),[]];
};
private _currentPositionSelection = if (_secondPrimaryEquipped) then {
	GVAR(selectedPositionPrimary);
} else {
	GVAR(selectedPositionSecondary);
};

private _objects = [];

{
	if (GVAR(addACEweight)) then {
		private _weaponMass = _x getVariable [QGVAR(mass), 0];
		[player, player, -_weaponMass] call ace_movement_fnc_addLoadToUnitContainer;
	};
	deleteVehicle _x;
} forEach _currentWeaponObjects;

if ((_currentPositionSelection isEqualTo [[[]]]) || (count _weaponInfo isNotEqualTo 7)) exitWith {};

{
	private _holder = createVehicle [QGVAR(GWH),[0,0,0]];
	_holder addWeaponWithAttachmentsCargoGlobal [_weaponInfo, 1];
	if (GVAR(addACEweight)) then {
		private _weaponMass = loadAbs _holder;
		_holder setVariable [QGVAR(mass), _weaponMass];
		[player, player, _weaponMass] call ace_movement_fnc_addLoadToUnitContainer;
	};
	_holder setDamage 1;
	_holder attachTo [player, _x#2, _x#0, true];
	_holder setVectorDirAndUp _x#1;
	_objects pushBack _holder;
} forEach _currentPositionSelection;
player setVariable [QGVAR(currentWeaponObjects), _objects, true];

/*
	Positions array:
	[mempoint,vectordirandup,position]
*/