#include "macro_general.hpp"
/*
 *  Author: KJW
 * 
 *  Handles relevant code to be run pre init.
 * 
 *  Arguments:
 *  None
 * 
 *  Return Value:
 *  None
 * 
 *  Example:
 *  call KJW_TwoPrimaryWeapons_XEH_PreInit
 * 
 *  Public: No
 */


call FUNC(addCBAKeybinds);
call FUNC(addSettings);

GVAR(positions) = [
	[
		"spine3", //Mempoint
		[
			[-0.942853,0.330874,0.0362221], //VectorDir
			[-0.33272,-0.939935,-0.0747082] //VectorUp
		],
		[-0.145057,-0.196157,0.06247] //Position relative to player
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
		[-0.228363,-0.109022,0.067251] //Position relative to player
	],
	[
		[]
	]
];
GVAR(displayNames) = [
	"Back",
	"Slung to side",
	"Slung to front",
	"Breacher",
	"Backpack",
	"Back 2",
	"Disabled"
];