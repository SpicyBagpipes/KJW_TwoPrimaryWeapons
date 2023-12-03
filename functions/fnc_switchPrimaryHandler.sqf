#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Handles switching primary.
 * 
 *  Arguments:
 *  0: Delay <NUMBER>
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  [1.4] call KJW_TwoPrimaryWeapons_fnc_switchPrimaryHandler
 * 
 *  Public: Yes
 */


params ["_delay"];

private _unit = call CBA_fnc_currentUnit;

private _weapon = primaryWeapon _unit;
private _systemEnabled = GVAR(Enabled);
private _weaponIsValid = true;
if (_systemEnabled && (_weapon isNotEqualTo "")) then {
	private _weaponLowered = toLowerANSI _weapon;
	private _whitelist = (parseSimpleArray GVAR(whitelistedClasses) apply {toLowerANSI _x});
	private _blacklist = (parseSimpleArray GVAR(blacklistedClasses) apply {toLowerANSI _x});
	private _whitelistHasValues = (count _whitelist) > 0;

	private _matchesWhitelist = (!_whitelistHasValues) || (_weaponLowered in _whitelist);
	private _matchesBlacklist = _weaponLowered in _blacklist;

	_weaponIsValid = (!_matchesBlacklist) && _matchesWhitelist;
};

if ((!_systemEnabled) || (!_weaponIsValid)) exitWith {};

private _secondPrimaryEquipped = _unit getVariable [QGVAR(secondPrimaryEquipped),false];
if (_secondPrimaryEquipped) then {
	//De-equip second primary.
	private _secondPrimaryInfo = ((weaponsItems _unit) select {_x#0 isEqualTo _weapon})#0;
	_unit action ["SwitchWeapon", _unit, _unit, 299]; //Put weapon away action.
	_unit setVariable [QGVAR(secondPrimaryInfo), _secondPrimaryInfo];
	[
		{
			params ["_weapon"];
			private _primaryPrimaryInfo = _unit getVariable [QGVAR(primaryPrimaryInfo),[]];
			_unit removeWeaponGlobal _weapon;
			_unit addWeaponGlobal _primaryPrimaryInfo#0;
			_primaryPrimaryInfo deleteAt 0;
			private _autoLoadedMagazine = primaryWeaponMagazine _unit;
			private _autoLoadedMagazineCount = _unit ammo primaryWeapon _unit;
			{
				if (_x isEqualTo []) then {continue};
				if (typeName _x isEqualTo "ARRAY") then {
					if (_autoLoadedMagazine isEqualTo []) then {
						_unit addPrimaryWeaponItem _x#0;
						_unit setAmmo [primaryWeapon _unit, _x#1];
					} else {
						[_unit, _x#0,_x#1, true] call CBA_fnc_addMagazine;
					};
				} else {
					_unit addPrimaryWeaponItem _x;
				};
			} forEach _primaryPrimaryInfo;
			_unit setVariable [QGVAR(secondPrimaryEquipped), false];
			if (primaryWeapon _unit isNotEqualTo "") then {
				private _muzzleIndex = (_unit weaponsInfo [primaryWeapon _unit, false])#0#0;
				_unit action ["SwitchWeapon", _unit, _unit, _muzzleIndex];
			};
			if (vehicle _unit != _unit) exitWith {}; //_unit is in vehicle.
			call FUNC(updateShownWeapon);
		},
		[
			_weapon
		],
		_delay
	] call CBA_fnc_waitAndExecute;
} else {
	//Equip second primary.
	private _weapon = primaryWeapon _unit;
	private _primaryPrimaryInfo = ((weaponsItems _unit) select {_x#0 isEqualTo _weapon})#0;
	private _shouldBeshown = getNumber (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "holsterScale") isNotEqualTo 0;
	_unit action ["SwitchWeapon", _unit, _unit, 299]; //Put weapon away action.
	_unit setVariable [QGVAR(primaryPrimaryInfo), _primaryPrimaryInfo];
	[
		{
			params["_weapon"];
			private _secondPrimaryInfo = _unit getVariable [QGVAR(secondPrimaryInfo),[]];
			_unit removeWeaponGlobal _weapon;
			_unit addWeaponGlobal _secondPrimaryInfo#0;
			_secondPrimaryInfo deleteAt 0;
			private _autoLoadedMagazine = primaryWeaponMagazine _unit;
			private _autoLoadedMagazineCount = _unit ammo primaryWeapon _unit;
			{
				if (_x isEqualTo []) then {continue};
				if (typeName _x isEqualTo "ARRAY") then {
					if (_autoLoadedMagazine isEqualTo []) then {
						_unit addPrimaryWeaponItem _x#0;
						_unit setAmmo [primaryWeapon _unit, _x#1];
					} else {
						[_unit, _x#0,_x#1, true] call CBA_fnc_addMagazine;
					};
				} else {
					_unit addPrimaryWeaponItem _x;
				};
			} forEach _secondPrimaryInfo;
			_unit setVariable [QGVAR(secondPrimaryEquipped), true];
			if (primaryWeapon _unit isNotEqualTo "") then {
				private _muzzleIndex = (_unit weaponsInfo [primaryWeapon _unit, false])#0#0;
				_unit action ["SwitchWeapon", _unit, _unit, _muzzleIndex];
			};
			if (vehicle _unit != _unit) exitWith {}; //_unit is in vehicle.
			call FUNC(updateShownWeapon);
		},
		[
			_weapon
		],
		_delay
	] call CBA_fnc_waitAndExecute;
};