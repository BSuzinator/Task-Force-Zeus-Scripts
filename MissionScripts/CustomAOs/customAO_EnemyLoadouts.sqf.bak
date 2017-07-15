_unit = _this select 0;
_unitType = _this select 1;

removeAllWeapons _unit;
removeGoggles _unit; 
removeVest _unit;
removeUniform _unit;
removeHeadGear _unit;
removeBackPack _unit;

_unit forceAddUniform "rhs_uniform_flora_patchless";
_unit addVest "rhs_6b23_6sh92";			
_unit addBackpack "rhs_assault_umbts";
_unit addHeadgear "rhs_6b7_1m_flora";	
_unit linkItem "rhs_1PN138";

switch (_unitType) do
{
	// SL,TL	
	
	case "ldr" : 
	{		
		_unit addWeapon "rhs_weap_ak74m_gp25";		
		_unit addPrimaryWeaponItem "rhs_acc_1p78";			
		_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_AK_green";			
	
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_30Rnd_545x39_AK_green"} foreach [1,2,3,4,5,6,7,8,9,10];		
		{_unit addMagazine "rhs_VOG25"} foreach [1,2,3,4,5,6,7,8,9,10];				
	};
	
	// AR

	case "ar" : 
	{		
		_unit addWeapon "rhs_weap_pkp";		
		_unit addPrimaryWeaponItem "rhs_acc_1p78";	
		_unit addPrimaryWeaponItem "rhs_100Rnd_762x54mmR_green";
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_100Rnd_762x54mmR_green"} foreach [1,2,3];			
	};

	// AT
	
	case "at" : 
	{	
		_unit addWeapon "rhs_weap_ak74m";		
		_unit addPrimaryWeaponItem "rhs_acc_1p63";	
		_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_AK_green";
		_unit addWeapon "rhs_weap_rpg7";	
		_unit addSecondaryWeaponItem "rhs_rpg7_PG7VR_mag";		
		_unit addSecondaryWeaponItem "rhs_acc_pgo7v3";		
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_30Rnd_545x39_AK_green"} foreach [1,2,3,4,5];
		{_unit addMagazine "rhs_rpg7_PG7VR_mag"} foreach [1,2,3];
	};
	
	// AA
	
	case "aa" : 
	{		
		_unit addWeapon "rhs_weap_ak74m";		
		_unit addPrimaryWeaponItem "rhs_acc_1p63";	
		_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_AK_green";		
		_unit addWeapon "rhs_weap_igla";				
		_unit addSecondaryWeaponItem "rhs_mag_9k38_rocket";
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_30Rnd_545x39_AK_green"} foreach [1,2,3,4,5];
		{_unit addMagazine "rhs_mag_9k38_rocket"} foreach [1];
	};
	
	// Marksman
	
	case "mrk" : 
	{			
		_unit addWeapon "rhs_weap_svds";		
		_unit addPrimaryWeaponItem "rhs_acc_pso1m21";			
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_10Rnd_762x54mmR_7N1"} foreach [1,2,3,4,5,6,7,8,9,10];			
	};
	
	// Rifleman
	
	case "rfl" : 
	{		
		_unit addWeapon "rhs_weap_ak74m";		
		_unit addPrimaryWeaponItem "rhs_acc_1p63";	
		_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_AK_green";	
					
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_30Rnd_545x39_AK_green"} foreach [1,2,3,4,5,6,7,8,9,10];		
	};
	
	// Sniper
	
	case "snp" :
	{
		removeAllWeapons _unit;
		removeGoggles _unit; 
		removeVest _unit;
		removeUniform _unit;
		removeHeadGear _unit;
		removeBackPack _unit;
			
		_unit forceAddUniform "U_I_FullGhillie_sard";
		_unit addBackpack "rhs_assault_umbts";
	
		_unit addWeapon "rhs_weap_t5000";		
		_unit addPrimaryWeaponItem "optic_Nightstalker";			
					
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "SmokeShell"} foreach [1,2,3];
		{_unit addMagazine "CUP_HandGrenade_RGD5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_5Rnd_338lapua_t5000"} foreach [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];		
	};
	
	// Ranger TL
	
	case "rng_ldr" : 
	{	
		_unit addWeapon "rhs_weap_ak74m_gp25";		
		_unit addPrimaryWeaponItem "rhs_acc_1p78";			
		_unit addPrimaryWeaponItem "rhs_acc_tgpa";	
		_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_7U1_AK";			
	
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_30Rnd_545x39_7U1_AK"} foreach [1,2,3,4,5,6,7,8,9,10];		
		{_unit addMagazine "rhs_VOG25"} foreach [1,2,3,4,5,6,7,8,9,10];				
	};
	
	// Ranger MRK

	case "rng_mrk" : 
	{		
		_unit addWeapon "rhs_weap_vss_grip";		
		_unit addPrimaryWeaponItem "rhs_acc_pso1m21";			
		_unit addPrimaryWeaponItem "rhs_20rnd_9x39mm_SP5";			
	
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_20rnd_9x39mm_SP5"} foreach [1,2,3,4,5,6,7,8,9,10];		
	};

	// Ranger AT

	case "rng_at" : 
	{		
		_unit addWeapon "rhs_weap_ak74m";		
		_unit addPrimaryWeaponItem "rhs_acc_1p63";	
		_unit addPrimaryWeaponItem "rhs_acc_tgpa";	
		_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_7U1_AK";
		_unit addWeapon "rhs_weap_rpg7";	
		_unit addSecondaryWeaponItem "rhs_rpg7_PG7VR_mag";		
		_unit addSecondaryWeaponItem "rhs_acc_pgo7v3";		
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_30Rnd_545x39_7U1_AK"} foreach [1,2,3,4,5];
		{_unit addMagazine "rhs_rpg7_PG7VR_mag"} foreach [1,2,3];
	};
	
	// Ranger AA
	
	case "rng_aa" : 
	{		
		_unit addWeapon "rhs_weap_ak74m";		
		_unit addPrimaryWeaponItem "rhs_acc_1p63";	
		_unit addPrimaryWeaponItem "rhs_acc_tgpa";	
		_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_7U1_AK";		
		_unit addWeapon "rhs_weap_igla";				
		_unit addSecondaryWeaponItem "rhs_mag_9k38_rocket";
			
		{_unit addItem "ACE_fieldDressing"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addItem "ACE_morphine"} foreach [1,2,3,4,5,6,7,8,9,10];	
		{_unit addMagazine "rhs_mag_rdg2_white"} foreach [1,2,3];
		{_unit addMagazine "rhs_mag_rgd5"} foreach [1,2,3];
		
		{_unit addMagazine "rhs_30Rnd_545x39_7U1_AK"} foreach [1,2,3,4,5];
		{_unit addMagazine "rhs_mag_9k38_rocket"} foreach [1];
	};
	
	case "tgt" :
	{
		removeAllWeapons _unit;
		removeGoggles _unit; 
		removeVest _unit;
		removeUniform _unit;
		removeHeadGear _unit;
		removeBackPack _unit;
		_unit unlinkItem "CUP_NVG_HMNVS";
		
		_unit forceAddUniform "rhs_uniform_mvd_izlom";
		_unit addHeadgear "rhs_beret_milp";
		_unit addGoggles "G_Aviator";
				
		_unit addWeapon "rhs_weap_pp2000_folded";
		
		{_unit addMagazine "rhs_mag_9x19mm_7n31_20"} forEach [1,2,3];
	};
};