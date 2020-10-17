class CfgPatches {
    class VKN_Joint_Ops {
        name = VKN_Joint_Ops;
        author = "Curious";
		version = 1.0.0;
		versionStr = "1.0.0";
		versionAr[] = {0,1,0};

		units[] = {
      "B_BArmy_Squad_leader_01",
      "B_BArmy_Rifleman_01",
      "B_BArmy_Auto_Rifleman_01",
      "B_BArmy_AT_Specialist_01",
      "B_BArmy_Combat_Life_Saver_01",
      "B_BArmy_Marksman_01",
      "B_BArmy_Heavy_Gunner_01",
      "B_BArmy_Crewman_01"
    };

		requiredAddons[] = {
      "rhsgref_c_troops",
      "asr_ai3_rhs_gr_c",
      "A3_Characters_F",
      "rhsusf_c_troops",
      "A3_Sounds_F",
      "A3_Sounds_F_Exp",
      "hlcweapons_AUG",
      "ace_gforces",
      "ace_goggles",
      "ace_interaction",
      "ace_movement",
      "A3_Data_F",
      "A3_Data_F_Curator",
      "A3_Air_F_Heli",
      "task_force_radio_items",
      "ace_refuel",
      "CUP_Core",
      "cba_xeh",
      "rhs_c_troops",
      "rhs_cti_insurgents",
      "rhssaf_c_troops"
    };
    weapons[] = {};
	};
};

#define private 0       // Hidden to all
#define protected 1     // Can use but still hidden
#define public 2        // Visible to all


///Factions

class cfgFactionClasses {
  #include "\VKN_Joint_Ops\Factions\cfgFactionClasses\bbarmy.hpp"
};

class CfgVehicles {
  #include "\VKN_Joint_Ops\Factions\imports.hpp"

  #include "\VKN_Joint_Ops\Factions\cfgVehicles\bbarmy.hpp"

};

class cfgGroups {

  class West {
    #include "\VKN_Joint_Ops\Factions\cfgGroups\bbarmy.hpp"
  };




};