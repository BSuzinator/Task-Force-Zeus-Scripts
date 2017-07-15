_unit = _this select 0;
_unitType = _this select 1;

removeAllWeapons _unit;
removeGoggles _unit; 
removeVest _unit;
removeUniform _unit;
removeHeadGear _unit;
removeBackPack _unit;

_unit forceAddUniform "CUP_U_O_RUS_EMR_1";
_unit addVest "CUP_V_RUS_6B3_1";			
_unit addBackpack "CUP_B_RUS_Backpack";
_unit addHeadgear "CUP_H_RUS_6B27_NVG";	
_unit linkItem "CUP_NVG_HMNVS";

switch (_unitType) do
{

	// SL,TL	
	
	case "ldr" : 
	{	
		_unit addWeapon "Binocular";		
		_unit addWeapon "CUP_arifle_AK74M_GL";		
		_unit addPrimaryWeaponItem "CUP_optic_Kobra";		
		_unit addPrimaryWeaponItem "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";		
	
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "SmokeShell"} foreach [1,2,3,4,5];
		{_unit addMagazine "CUP_HandGrenade_RGO"} foreach [1,2];
		
		{_unit addMagazine "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M"} foreach [1,2,3,4,5,6,7,8,9,10];
		{_unit addMagazine "CUP_1Rnd_SMOKE_GP25_M"} foreach [1,2,3];	
		{_unit addMagazine "CUP_1Rnd_HE_GP25_M"} foreach [1,2,3,4,5,6,7,8,9,10];				
	};
	
	// AR

	case "ar" : 
	{		
		_unit addWeapon "CUP_lmg_Pecheneg";		
		_unit addPrimaryWeaponItem "CUP_optic_PechenegScope";
		_unit addPrimaryWeaponItem "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "SmokeShell"} foreach [1,2,3,4,5];
		{_unit addMagazine "CUP_HandGrenade_RGO"} foreach [1,2];
		
		{_unit addMagazine "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M"} foreach [1,2,3,4,5];			
	};

	// AT

	case "at" : 
	{		
		_unit addWeapon "CUP_arifle_AK74M";		
		_unit addPrimaryWeaponItem "CUP_optic_Kobra";	
		_unit addPrimaryWeaponItem "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
		_unit addWeapon "CUP_launch_RPG7V";	
		_unit addSecondaryWeaponItem "CUP_PG7VL_M";		
		_unit addSecondaryWeaponItem "CUP_optic_PGO7V3";		
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "SmokeShell"} foreach [1,2,3,4,5];
		{_unit addMagazine "CUP_HandGrenade_RGO"} foreach [1,2];
		
		{_unit addMagazine "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M"} foreach [1,2,3,4,5,6,7,8,9,10];
		{_unit addMagazine "CUP_PG7VL_M"} foreach [1,2,3];
	};
	
	// AA
	
	case "aa" : 
	{		
		_unit addWeapon "CUP_arifle_AK74M";		
		_unit addPrimaryWeaponItem "CUP_optic_Kobra";	
		_unit addPrimaryWeaponItem "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
		_unit addWeapon "CUP_launch_Igla";	
		_unit addSecondaryWeaponItem "CUP_Igla_M";		
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "SmokeShell"} foreach [1,2,3,4,5];
		{_unit addMagazine "CUP_HandGrenade_RGO"} foreach [1,2];
		
		{_unit addMagazine "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M"} foreach [1,2,3,4,5,6,7,8,9,10];
		_unit addMagazine "CUP_Igla_M";
	};
	
	// Marksman
	
	case "mrk" : 
	{			
		_unit addWeapon "CUP_srifle_SVD";		
		_unit addPrimaryWeaponItem "CUP_optic_PSO_3";			
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "SmokeShell"} foreach [1,2,3,4,5];
		{_unit addMagazine "CUP_HandGrenade_RGO"} foreach [1,2];
		
		{_unit addMagazine "CUP_10Rnd_762x54_SVD_M"} foreach [1,2,3,4,5,6,7,8,9,10];			
	};
	
	// Rifleman
	
	case "rfl" : 
	{		
		_unit addWeapon "CUP_arifle_AK74M";		
		_unit addPrimaryWeaponItem "CUP_optic_Kobra";	
		_unit addPrimaryWeaponItem "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M";
					
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "SmokeShell"} foreach [1,2,3,4,5];
		{_unit addMagazine "CUP_HandGrenade_RGO"} foreach [1,2];
		
		{_unit addMagazine "CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M"} foreach [1,2,3,4,5,6,7,8,9,10];		
	};
};