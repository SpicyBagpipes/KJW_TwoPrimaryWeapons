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

private _weapon = primaryWeapon player;
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

private _secondPrimaryEquipped = player getVariable [QGVAR(secondPrimaryEquipped),false];
if (_secondPrimaryEquipped) then {
	//De-equip second primary.
	private _secondPrimaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
	player action ["SwitchWeapon", player, player, 299]; //Put weapon away action.
	player setVariable [QGVAR(secondPrimaryInfo), _secondPrimaryInfo];
	[
		{
			params ["_weapon"];
			private _primaryPrimaryInfo =+ (player getVariable [QGVAR(primaryPrimaryInfo),[]]);
			player removeWeaponGlobal _weapon;
			player addWeaponGlobal _primaryPrimaryInfo#0;
			_primaryPrimaryInfo deleteAt 0;
			private _autoLoadedMagazine = primaryWeaponMagazine player;
			private _autoLoadedMagazineCount = player ammo primaryWeapon player;
			{
				if (_x isEqualTo []) then {continue};
				if (typeName _x isEqualTo "ARRAY") then {
					if (_autoLoadedMagazine isEqualTo []) then {
						player addPrimaryWeaponItem _x#0;
						player setAmmo [primaryWeapon player, _x#1];
					} else {
						player addPrimaryWeaponItem _x#0;
						player setAmmo [primaryWeapon player, _x#1];
						[player, _autoLoadedMagazine,_autoLoadedMagazineCount, true] call CBA_fnc_addMagazine;
					};
				} else {
					player addPrimaryWeaponItem _x;
				};
			} forEach _primaryPrimaryInfo;
			player setVariable [QGVAR(secondPrimaryEquipped), false];
			if (primaryWeapon player isNotEqualTo "") then {
				private _muzzleIndex = (player weaponsInfo [primaryWeapon player, false])#0#0;
				player action ["SwitchWeapon", player, player, _muzzleIndex];
			};
			if (vehicle player != player) exitWith {}; //Player is in vehicle.
			call FUNC(updateShownWeapon);
		},
		[
			_weapon
		],
		_delay
	] call CBA_fnc_waitAndExecute;
} else {
	//Equip second primary.
	private _weapon = primaryWeapon player;
	private _primaryPrimaryInfo = ((weaponsItems player) select {_x#0 isEqualTo _weapon})#0;
	private _shouldBeshown = getNumber (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "holsterScale") isNotEqualTo 0;
	player action ["SwitchWeapon", player, player, 299]; //Put weapon away action.
	player setVariable [QGVAR(primaryPrimaryInfo), _primaryPrimaryInfo];
	[
		{
			params["_weapon"];
			private _secondPrimaryInfo =+ (player getVariable [QGVAR(secondPrimaryInfo),[]]);
			player removeWeaponGlobal _weapon;
			player addWeaponGlobal _secondPrimaryInfo#0;
			_secondPrimaryInfo deleteAt 0;
			private _autoLoadedMagazine = primaryWeaponMagazine player;
			private _autoLoadedMagazineCount = player ammo primaryWeapon player;
			{
				if (_x isEqualTo []) then {continue};
				if (typeName _x isEqualTo "ARRAY") then {
					if (_autoLoadedMagazine isEqualTo []) then {
						player addPrimaryWeaponItem _x#0;
						player setAmmo [primaryWeapon player, _x#1];
					} else {
						player addPrimaryWeaponItem _x#0;
						player setAmmo [primaryWeapon player, _x#1];
						[player, _autoLoadedMagazine,_autoLoadedMagazineCount, true] call CBA_fnc_addMagazine;
					};
				} else {
					player addPrimaryWeaponItem _x;
				};
			} forEach _secondPrimaryInfo;
			player setVariable [QGVAR(secondPrimaryEquipped), true];
			if (primaryWeapon player isNotEqualTo "") then {
				private _muzzleIndex = (player weaponsInfo [primaryWeapon player, false])#0#0;
				player action ["SwitchWeapon", player, player, _muzzleIndex];
			};
			if (vehicle player != player) exitWith {}; //Player is in vehicle.
			call FUNC(updateShownWeapon);
		},
		[
			_weapon
		],
		_delay
	] call CBA_fnc_waitAndExecute;
};