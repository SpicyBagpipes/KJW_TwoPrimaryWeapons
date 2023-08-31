#include "script_component.hpp"
/*
 *  Author: KJW
 * 
 *  Adds CBA Settings required for the mod to function.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoPrimaryWeapons_fnc_addSettings
 * 
 *  Public: No
 */


private _arr = [];
private _componentBeautified = QUOTE(COMPONENT_BEAUTIFIED);
private _positions = [
	[
		"spine3", //Mempoint
		[
			[-0.942853,0.330874,0.0362221], //VectorDir
			[-0.33272,-0.939935,-0.0747082] //VectorUp
		],
		[-0.085057,-0.196157,0.106247] //Position relative to player
	],
	[
		"pelvis", //Mempoint
		[
			[-0.0943458,-0.427608,0.899012], //VectorDir
			[-0.967039,0.253845,0.0192545] //VectorUp
		],
		[-0.252735,-0.122696,-0.1525394] //Position relative to player
	],
	[
		"spine3", //Mempoint
		[
			[-0.959775,-0.212544,0.18281], //VectorDir
			[-0.200409,0.976095,0.0826827] //VectorUp
		],
		[0.0795696,0.2779,-0.314365] //Position relative to player
	],
	[
		"pelvis", //Mempoint
		[
			[-0.713304,0.700795,-0.00756299], //VectorDir
			[0.698764,0.710324,-0.0845198]  //VectorUp
		],
		[-0.163846,-0.163029,-0.1981146] //Position relative to player
	],
	[
		"spine3",
		[
			[0.901187,0.00443262,0.433132], //VectorDir
			[0.0447066,-0.99544,-0.0828307] //VectorUp
		],
		[-0.0853765,-0.324295,0.106977] //Position relative to player
	],
	[
		"spine3",
		[
			[0.748651,-0.66266,-0.012813], //VectorDir
			[-0.662772,-0.748614,-0.00845503] //VectorUp
		],
		[-0.228363,-0.109022,0.167251] //Position relative to player
	],
	[
		[]
	]
];
private _displayNames = [
	"Back",
	"Slung to side",
	"Slung to front",
	"Breacher",
	"Backpack",
	"Back 2",
	"Disabled"
];

[
	QGVAR(Enabled), //Setting classname
	"CHECKBOX", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Enable Two Primary Weapons", //Display name
		"Stops keybind from working. Does NOT remove currently equipped second primary." //Tooltip
	],
	_componentBeautified, //Category
	true, //Setting properties. Varies based on type
	1, //1: all clients share the same setting, 2: setting can’t be overwritten
	{}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;

[
	QGVAR(blacklistedClasses), //Setting classname
	"EDITBOX", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Blacklisted Classes", //Display name
		"Primaries will not be able to be equipped as second primaries if they are in this array. Array of string classnames." //Tooltip
	],
	_componentBeautified, //Category
	str _arr, //Setting properties. Varies based on type
	1, //1: all clients share the same setting, 2: setting can’t be overwritten
	{}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;

[
	QGVAR(whitelistedClasses), //Setting classname
	"EDITBOX", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Whitelisted Classes", //Display name
		"Primaries will be able to be equipped as second primaries if they are in this array. Array of string classnames. If empty, all weapons not blacklisted will be allowed" //Tooltip
	],
	_componentBeautified, //Category
	str _arr, //Setting properties. Varies based on type
	1, //1: all clients share the same setting, 2: setting can’t be overwritten
	{}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;

[
	QGVAR(selectedPositionPrimary), //Setting classname
	"LIST", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Selected Position (First Primary)", //Display name
		"Selected Position for first Primary to appear." //Tooltip
	],
	_componentBeautified, //Category
	[
		_positions, //Values
		_displayNames, //Displaynames.
		0
	], //Setting properties. Varies based on type
	0, //1: all clients share the same setting, 2: setting can’t be overwritten
	{call FUNC(updateShownWeapon)}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;

[
	QGVAR(selectedPositionSecondary), //Setting classname
	"LIST", //Setting type. Can be CHECKBOX, LIST, SLIDER, COLOR, EDITBOX, TIME
	[
		"Selected Position (Second Primary)", //Display name
		"Selected Position for second Primary to appear." //Tooltip
	],
	_componentBeautified, //Category
	[
		_positions, //Values
		_displayNames, //Displaynames.
		0
	], //Setting properties. Varies based on type
	0, //1: all clients share the same setting, 2: setting can’t be overwritten
	{call FUNC(updateShownWeapon)}, //Code to execute upon setting change
	false //Requires restart?
] call CBA_fnc_addSetting;