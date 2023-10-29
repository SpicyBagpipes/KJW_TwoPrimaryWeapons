#include "script_component.hpp"

class CfgPatches {
    class COMPONENT {
        author = "KJW";
        requiredAddons[] = {
            "A3_Data_F",
            "A3_Weapons_F",
            "A3_Characters_F",
            "A3_Data_F_AoW_Loadorder"
        };
        units[] = {""};
        weapons[] = {""};
        vehicles[] = {""};
        requiredVersion = REQUIRED_VERSION;
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgMovesBasic.hpp"
#include "CfgVehicles.hpp"

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
