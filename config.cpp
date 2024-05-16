#include "macro_function.hpp"

class CfgPatches {
    class COMPONENT {
        author="KJW";
        requiredAddons[]=
        {
            "A3_Data_F",
            "A3_Weapons_F",
            "A3_Characters_F",
            "A3_Data_F_AoW_Loadorder"
        };
        requiredVersion=1;
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
	};
};

class CfgFunctions {
    class KJW_TwoPrimaryWeapons {
        class functions {
            FUNCTION_DECLARE(addCBAKeybinds)
            FUNCTION_DECLARE(addSettings)
            FUNCTION_DECLARE(addEventHandlers)
            FUNCTION_DECLARE(switchPrimaryHandler)
            FUNCTION_DECLARE(updateShownWeapon)
            FUNCTION_DECLARE(addSecondWeapon)
        };
    };
};

class Extended_PostInit_EventHandlers {
	class COMPONENT_POSTINIT {
		init = QUOTE(call compileScript ['COMPONENT\XEH_PostInit.sqf']);
	};
};

class Extended_PreInit_EventHandlers {
	class COMPONENT_PREINIT {
		init = QUOTE(call compileScript ['COMPONENT\XEH_PreInit.sqf']);
	};
};

/*
    Creating GWH for 3den:
    private _obj = create3DENEntity ["Object", "KJW_TwoPrimaryWeapons_GWH", [0,0,0]];
    _obj addWeaponWithAttachmentsCargo [["arifle_MX_F", "", "", "", [], [], ""], 1]

    Finding positions:
    _obj1 = bob;
    _logic = "Logic" createVehicleLocal [0,0,0];
    _logic attachTo [player, [0,0,0], "pelvis", true];

    private _orient = [_obj1, _logic] call BIS_fnc_vectorDirAndUpRelative; 
    private _relPos = _logic worldToModelVisual ASLtoAGL getPosWorld _obj1;
    [_orient, _relpos]
*/

class CfgVehicles
{
	class CargoNet_01_box_F;
	class GVAR(GWH): CargoNet_01_box_F
	{
        scope = 1;
		model="\A3\Weapons_f\DummyWeapon_Single.p3d";
		showWeaponCargo=1;
	};
};