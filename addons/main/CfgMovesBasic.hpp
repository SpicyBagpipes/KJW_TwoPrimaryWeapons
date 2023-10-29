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
