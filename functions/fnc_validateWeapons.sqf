#include "script_component.hpp"
/*
 *  Author: Jenna
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

params ["_unit"];

private _primaryPrimaryWeapon = (_unit getVariable [QGVAR(primaryPrimaryInfo),[""]])#0;
private _secondPrimaryWeapon = (_unit getVariable [QGVAR(secondPrimaryInfo),[""]])#0;

private _primaryIsValid = true;
private _secondaryIsValid = true;
if ((_primaryPrimaryWeapon isNotEqualTo "")) then {
	private _weaponLowered = toLowerANSI _primaryPrimaryWeapon;
	private _whitelist = (parseSimpleArray GVAR(whitelistedClasses) apply {toLowerANSI _x});
	private _blacklist = (parseSimpleArray GVAR(blacklistedClasses) apply {toLowerANSI _x});
	private _whitelistHasValues = (count _whitelist) > 0;

	private _matchesWhitelist = (!_whitelistHasValues) || (_weaponLowered in _whitelist);
	private _matchesBlacklist = _weaponLowered in _blacklist;

	_primaryIsValid = (!_matchesBlacklist) && _matchesWhitelist;
};

if ((_secondPrimaryWeapon isNotEqualTo "")) then {
	private _weaponLowered = toLowerANSI _secondPrimaryWeapon;
	private _whitelist = (parseSimpleArray GVAR(whitelistedClasses) apply {toLowerANSI _x});
	private _blacklist = (parseSimpleArray GVAR(blacklistedClasses) apply {toLowerANSI _x});
	private _whitelistHasValues = (count _whitelist) > 0;

	private _matchesWhitelist = (!_whitelistHasValues) || (_weaponLowered in _whitelist);
	private _matchesBlacklist = _weaponLowered in _blacklist;

	_secondaryIsValid = (!_matchesBlacklist) && _matchesWhitelist;
};

if !_primaryIsValid then {
	_unit setVariable [QGVAR(primaryPrimaryInfo),nil]
};

if !_secondaryIsValid then {
	_unit setVariable [QGVAR(secondPrimaryInfo),nil]
};
