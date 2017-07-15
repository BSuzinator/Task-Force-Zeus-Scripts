//Applies loadouts to players.
// place the following line in the onPlayerRespawn.sqf file : _handle = []execVM "gearUp.sqf";
//If using TFAR, replace ItemRadio with tf_anprc152
//Commented out lines are the TFAR Radio shtuff
waitUntil {!isNull player};

//Select Player and get unit info
_unit = player;
_unitType = typeOf _unit;

[player,"Curator"] call BIS_fnc_setUnitInsignia;


switch _unitType do {

	//Recon Team Lead
	case "B_recon_TL_F": {

		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;

		_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
		for "_i" from 1 to 4 do {_unit addItemToUniform "FirstAidKit";};
		for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
		_unit addVest "V_TacVest_khk";
		for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_unit addItemToVest "Laserbatteries";
		_unit addItemToVest "Chemlight_red";
		_unit addItemToVest "Chemlight_green";
		_unit addHeadgear "H_HelmetSpecB_snakeskin";
		_unit addGoggles "G_Balaclava_lowprofile";

		_unit addWeapon "arifle_MX_Black_F";
		_unit addPrimaryWeaponItem "muzzle_snds_H";
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addPrimaryWeaponItem "optic_Hamr";
		_unit addPrimaryWeaponItem "bipod_01_F_blk";
		_unit addWeapon "Laserdesignator";

		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "tf_anprc152";
		_unit linkItem "ItemGPS";
		_unit linkItem "NVGoggles_OPFOR";
		
		_unit addBackpack "tf_rt1523g_big_bwmod"
		
	};
	//Recon Demo Specialist
	case "B_recon_exp_F": {
	
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;

		_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
		for "_i" from 1 to 4 do {_unit addItemToUniform "FirstAidKit";};
		for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
		_unit addVest "V_TacVest_khk";
		for "_i" from 1 to 3 do {_unit addItemToVest "APERSMine_Range_Mag";};
		for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
		_unit addItemToVest "SmokeShell";
		_unit addItemToVest "SmokeShellGreen";
		for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		_unit addBackpack "B_AssaultPack_rgr_ReconExp";
		_unit addItemToBackpack "MineDetector";
		_unit addItemToBackpack "ToolKit";
		for "_i" from 1 to 2 do {_unit addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";};
		for "_i" from 1 to 3 do {_unit addItemToBackpack "APERSBoundingMine_Range_Mag";};
		_unit addItemToBackpack "DemoCharge_Remote_Mag";
		for "_i" from 1 to 2 do {_unit addItemToBackpack "SLAMDirectionalMine_Wire_Mag";};
		_unit addHeadgear "H_HelmetSpecB_snakeskin";
		_unit addGoggles "G_Balaclava_lowprofile";

		_unit addWeapon "arifle_MX_Black_F";
		_unit addPrimaryWeaponItem "muzzle_snds_H";
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addPrimaryWeaponItem "optic_Hamr";
		_unit addPrimaryWeaponItem "bipod_01_F_blk";
		_unit addWeapon "Binocular";

		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "tf_anprc152";
		_unit linkItem "ItemGPS";
		_unit linkItem "NVGoggles_OPFOR";
	};
	//Recon Sharpshooter
	case "B_Recon_Sharpshooter_F": {
	
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		
		_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
		for "_i" from 1 to 3 do {_unit addItemToUniform "FirstAidKit";};
		_unit addItemToUniform "HandGrenade";
		_unit addItemToUniform "MiniGrenade";
		_unit addVest "V_Chestrig_rgr";
		_unit addItemToVest "FirstAidKit";
		for "_i" from 1 to 8 do {_unit addItemToVest "10Rnd_338_Mag";};
		_unit addItemToVest "SmokeShell";
		for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
		_unit addHeadgear "H_Booniehat_oli";
		_unit addGoggles "G_Balaclava_lowprofile";

		_unit addWeapon "srifle_DMR_02_F";
		_unit addPrimaryWeaponItem "muzzle_snds_338_black";
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addPrimaryWeaponItem "optic_AMS";
		_unit addPrimaryWeaponItem "bipod_01_F_blk";
		_unit addWeapon "hgun_Pistol_heavy_01_F";
		_unit addHandgunItem "muzzle_snds_acp";
		_unit addHandgunItem "optic_MRD";
		_unit addWeapon "Rangefinder";

		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "tf_anprc152";
		_unit linkItem "B_UavTerminal";
		_unit linkItem "NVGoggles_OPFOR";
		
		_unit addBackpack "B_AssaultPack_mcamo";
		_unit addItemToBackpack "optic_Nightstalker";
	};
	//Recon JTAC
	case "B_recon_JTAC_F": {

		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
	
		_unit forceAddUniform "U_B_CombatUniform_mcam";
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_mag";};
		_unit addItemToUniform "Laserbatteries";
		_unit addItemToUniform "SmokeShell";
		_unit addVest "V_TacVest_khk";
		for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
		_unit addBackpack "B_AssaultPack_mcamo";
		_unit addItemToBackpack "3Rnd_SmokeOrange_Grenade_shell";
		_unit addItemToBackpack "3Rnd_SmokeBlue_Grenade_shell";
		_unit addItemToBackpack "3Rnd_SmokePurple_Grenade_shell";
		_unit addItemToBackpack "3Rnd_SmokeYellow_Grenade_shell";
		_unit addItemToBackpack "3Rnd_SmokeGreen_Grenade_shell";
		_unit addItemToBackpack "3Rnd_SmokeRed_Grenade_shell";
		_unit addItemToBackpack "3Rnd_Smoke_Grenade_shell";
		_unit addItemToBackpack "3Rnd_UGL_FlareYellow_F";
		_unit addItemToBackpack "3Rnd_UGL_FlareRed_F";
		_unit addItemToBackpack "3Rnd_UGL_FlareGreen_F";
		_unit addItemToBackpack "3Rnd_UGL_FlareWhite_F";
		for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
		_unit addHeadgear "H_HelmetSpecB_snakeskin";
		_unit addGoggles "G_Balaclava_lowprofile";

		_unit addWeapon "arifle_MX_GL_Black_F";
		_unit addPrimaryWeaponItem "muzzle_snds_H";
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addPrimaryWeaponItem "optic_Hamr";
		_unit addWeapon "Binocular";

		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "tf_anprc152";
		_unit linkItem "ItemGPS";
		_unit linkItem "NVGoggles_OPFOR";

	};
	//Recon Marksman
	case "B_recon_M_F": {
		
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		
		_unit forceAddUniform "U_B_CombatUniform_mcam";
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_mag";};
		_unit addVest "V_TacVest_khk";
		for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
		_unit addItemToVest "SmokeShell";
		_unit addItemToVest "SmokeShellGreen";
		for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer";
		_unit addHeadgear "H_HelmetSpecB_snakeskin";
		_unit addGoggles "G_Balaclava_lowprofile";

		_unit addWeapon "arifle_MXM_Black_F";
		_unit addPrimaryWeaponItem "muzzle_snds_H";
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addPrimaryWeaponItem "optic_SOS";
		_unit addPrimaryWeaponItem "bipod_01_F_blk";
		_unit addWeapon "Rangefinder";

		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "tf_anprc152";
		_unit linkItem "ItemGPS";
		_unit linkItem "NVGoggles_OPFOR";

		_unit addBackpack "B_AssaultPack_mcamo";
		_unit addItemToBackpack "optic_Nightstalker";
	};	
	//Recon Paramedic
	case "B_recon_medic_F": {
		
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;	
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		
		_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
		for "_i" from 1 to 5 do {_unit addItemToUniform "FirstAidKit";};
		_unit addVest "V_Chestrig_rgr";
		for "_i" from 1 to 3 do {_unit addItemToVest "FirstAidKit";};
		for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
		for "_i" from 1 to 10 do {_unit addItemToVest "SmokeShell";};
		_unit addItemToVest "SmokeShellGreen";
		for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		_unit addBackpack "B_AssaultPack_rgr_ReconMedic";
		_unit addItemToBackpack "Medikit";
		for "_i" from 1 to 5 do {_unit addItemToBackpack "FirstAidKit";};
		_unit addItemToBackpack "SmokeShellRed";
		_unit addItemToBackpack "SmokeShellBlue";
		_unit addItemToBackpack "SmokeShellOrange";
		for "_i" from 1 to 3 do {_unit addItemToBackpack "Chemlight_red";};
		for "_i" from 1 to 2 do {_unit addItemToBackpack "B_IR_Grenade";};
		_unit addHeadgear "H_HelmetSpecB_snakeskin";
		_unit addGoggles "G_Balaclava_lowprofile";

		_unit addWeapon "arifle_MXC_Black_F";
		_unit addPrimaryWeaponItem "muzzle_snds_H";
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addPrimaryWeaponItem "optic_Hamr";
		_unit addWeapon "Binocular";

		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "tf_anprc152";
		_unit linkItem "ItemGPS";
		_unit linkItem "NVGoggles_OPFOR";

	};
	//Recon Scout / Radio Operator
	case "B_recon_F": {
		
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		
		_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
		for "_i" from 1 to 3 do {_unit addItemToUniform "FirstAidKit";};
		_unit addVest "V_TacVest_khk";
		for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
		_unit addItemToVest "SmokeShell";
		_unit addItemToVest "SmokeShellGreen";
		for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer";
		_unit addHeadgear "H_HelmetSpecB_snakeskin";
		_unit addGoggles "G_Balaclava_lowprofile";

		_unit addWeapon "arifle_MX_Black_F";
		_unit addPrimaryWeaponItem "muzzle_snds_H";
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addPrimaryWeaponItem "optic_Hamr";
		_unit addWeapon "Binocular";

		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "tf_anprc152";
		_unit linkItem "ItemGPS";
		_unit linkItem "NVGoggles_OPFOR";
		_unit addBackpack "tf_rt1523g_big_bwmod"

	};
	//Recon Scout (AT)
	case "B_recon_LAT_F": {
		
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
		
		_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
		for "_i" from 1 to 3 do {_unit addItemToUniform "FirstAidKit";};
		_unit addVest "V_TacVest_khk";
		for "_i" from 1 to 2 do {_unit addItemToVest "MiniGrenade";};
		_unit addItemToVest "SmokeShell";
		_unit addItemToVest "SmokeShellGreen";
		for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer";
		_unit addHeadgear "H_HelmetSpecB_snakeskin";
		_unit addGoggles "G_Balaclava_lowprofile";
		_unit addBackpack "B_Kitbag_mcamo";
		_unit addItemToBackpack "Titan_AT";
		_unit addItemToBackpack "Titan_AT";
		
		_unit addWeapon "arifle_MX_Black_F";
		_unit addPrimaryWeaponItem "muzzle_snds_H";
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit addPrimaryWeaponItem "optic_Hamr";
		_unit addWeapon "launch_I_Titan_short_F";
		_unit addWeapon "Binocular";
		_unit addItemToBackpack "Titan_AT";

		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "tf_anprc152";
		_unit linkItem "ItemGPS";
		_unit linkItem "NVGoggles_OPFOR";


	};
	//Commander
	case "B_officer_F": {
		
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
	
		_unit forceAddUniform "U_Rangemaster";
		for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
		_unit addItemToUniform "Chemlight_green";
		_unit addVest "V_Rangemaster_belt";
		for "_i" from 1 to 3 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
		_unit addItemToVest "SmokeShell";
		_unit addItemToVest "SmokeShellGreen";
		_unit addItemToVest "Chemlight_green";
		_unit addBackpack "tf_rt1523g_big_bwmod";
		_unit addItemToBackpack "H_HelmetO_ViperSP_ghex_F";
		_unit addHeadgear "H_Beret_02";
		_unit addGoggles "G_Tactical_Clear";
		
		_unit addWeapon "hgun_Pistol_heavy_01_F";
		_unit addHandgunItem "muzzle_snds_acp";
		_unit addHandgunItem "optic_MRD";
		_unit addWeapon "Laserdesignator";
		
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "tf_microdagr";
		_unit linkItem "tf_anprc152";
		_unit linkItem "B_UavTerminal";

		hint "Check backpack for NVGs";
		
		};
	//Crewman Engineer
	case "B_engineer_F": {
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
		removeHeadgear _unit;
		removeGoggles _unit;
			
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadio";
		_unit linkItem "NVGoggles";
					
		_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_mag";};
		_unit addItemToUniform "Chemlight_green";
		_unit addVest "V_BandollierB_rgr";
		for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
		for "_i" from 1 to 2 do {_unit addItemToVest "16Rnd_9x21_Mag";};
		for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
		_unit addItemToVest "SmokeShell";
		_unit addItemToVest "SmokeShellGreen";
		_unit addItemToVest "Chemlight_green";
		_unit addHeadgear "H_HelmetCrew_B";
		_unit addGoggles "G_Combat";
		_unit addBackpack "B_Kitbag_mcamo_Eng";
		_unit addItemToBackpack "ToolKit";
		_unit addItemToBackpack "MineDetector";
		_unit addItemToBackpack "SatchelCharge_Remote_Mag";
		for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
		
		_unit addWeapon "arifle_MXC_F";
		_unit addWeapon "hgun_P07_F";

		};
	
	default {};
};

//Set Zeus patch
[player,"Curator"] call BIS_fnc_setUnitInsignia;

if(true) exitWith{};