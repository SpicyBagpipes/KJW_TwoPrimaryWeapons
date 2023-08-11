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
    Backend:
    press 4
    stow rifle animation plays
    current rifle data is saved
    data is attachto'd on selected position on ur vest
    data from your second primary is set to ur current weapon
    press 4
    stow rifle animation plays
    rifle data loaded back to ur primary



*/


class CfgMovesBasic {
    class Actions {
        class RifleBaseStandActions;
        class RifleKneelActions: RifleBaseStandActions {
            Civil = "AmovPknlMstpSnonWnonDnon";
        };
        class RifleProneActions: RifleBaseStandActions {
            Civil = "AmovPpneMstpSnonWnonDnon";
            SecondaryWeapon = "AmovPpneMstpSrasWlnrDnon";
        };

        class PistolStandActions;
        class PistolProneActions: PistolStandActions {
            SecondaryWeapon = "AmovPpneMstpSrasWlnrDnon";
        };

        class LauncherKneelActions;
        /*class LauncherStandActions: LauncherKneelActions {
            PlayerProne = "AmovPpneMstpSrasWlnrDnon";
            Down = "AmovPpneMstpSrasWlnrDnon";
        };*/

        class LauncherProneActions: LauncherKneelActions {
            TurnL = "AmovPpneMstpSrasWlnrDnon_turnl";
            TurnLRelaxed = "AmovPpneMstpSrasWlnrDnon_turnl";
            TurnR = "AmovPpneMstpSrasWlnrDnon_turnr";
            TurnRRelaxed = "AmovPpneMstpSrasWlnrDnon_turnr";
        };
    };
};