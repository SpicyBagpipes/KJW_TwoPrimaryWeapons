#include "script_component.hpp"
/*
 *  Author: Jenna
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


private _primaryPrimaryWeapon = (player getVariable [QGVAR(primaryPrimaryInfo),[""]])#0;
private _secondPrimaryWeapon = (player getVariable [QGVAR(secondPrimaryInfo),[""]])#0;

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
	player setVariable [QGVAR(primaryPrimaryInfo),nil]
};

if !_secondaryIsValid then {
	player setVariable [QGVAR(secondPrimaryInfo),nil]
};
