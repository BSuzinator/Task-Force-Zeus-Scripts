_currAO = _this select 0;
_locationsList = _this select 1;

_enemySoldier = "rhs_msv_emr_rifleman";

// Deploy objectives depending on number of players

_objectiveList = ["1stplatoon","2ndplatoon","3rdplatoon","supply_depot","assassination","intel","mortar","aa","comms"];
_selectedObjectives = [];

_noOfPlayers = count allPlayers;
_noOfObjectives = 1 + floor(_noOfPlayers/10);

// Enemy force level based on player assets
//
// Level 0 - BLUFOR Infantry = OPFOR Static Weapons / UAZs for Mobile Reserve
// Level 1 - BLUFOR Humvees/Static HMG = OFPOR UAZs (MG + SPG-9) + AA Truck / GAZ-233011 for Mobile Reserve
// Level 2 - BLUFOR MRAPs/APCs = OPFOR APC (BTR-80A + BTR-80) + AA Truck / BTR-80 for Mobile Reserve
// Level 3 - BLUFOR Bradleys/Attack Rotary/Static ATGM = OPFOR MECH BASIC (T-80U + BMP-2 mod. 1986) + Shilka / BMP-2 mod. 1986 for Mobile Reserve
// Level 4 - BLUFOR Abrams/Attack Fixed Wing = OPFOR MECH ADVANCED (T-90A + BMP-3 Vesna-K/A) + Shilka / BMP-3 Vesna-K/A for Mobile Reserve

// AA Level
// Level 0 - BLUFOR Infantry = Static AA
// Level 1 - BLUFOR Armor = Shilka
// Level 2 - BLUFOR Air = Tigris

_forceLevel = 0;
_aaLevel = 0;

{
	if (typeOf(vehicle _x) in ["rhsusf_m1025_w_m2","RHS_M2StaticMG_MiniTripod_WD"]) then {
		if (_forceLevel < 1) then {
			_forceLevel = 1;
		};
	};
	
	if (typeOf(vehicle _x) in ["rhsusf_M1237_M2_usarmy_wd"]) then {
		if (_forceLevel < 2) then {
			_forceLevel = 2;
		};
	};
	
	if (typeOf(vehicle _x) in ["RHS_M2A3_BUSKIII_wd","RHS_MELB_AH6M_H","RHS_TOW_TriPod_WD"]) then {
		if (_forceLevel < 3) then {
			_forceLevel = 3;
		};
		if (_aaLevel < 1) then {
			_aaLevel = 1;
		};
	};
	
	if (typeOf(vehicle _x) in ["rhsusf_m1a1aim_tuski_wd","RHS_A10_AT","RHS_AH64D_wd"]) then {
		if (_forceLevel < 4) then {
			_forceLevel = 4;
		};
		if (_aaLevel < 1) then {
			_aaLevel = 1;
		};
	};	
	
	if (typeOf(vehicle _x) in ["RHS_MELB_AH6M_H","RHS_A10_AT","RHS_AH64D_wd"]) then {
		if (_aaLevel < 2) then {
			_aaLevel = 2;
		};
	};
} forEach allPlayers;

_1stplatoonLoc = [];
_2ndplatoonLoc = [];
_3rdplatoonLoc = [];
_supplyLoc = [];
_assassinationLoc = [];
_intelLoc = [];
_mortarLoc = [];
_aaLoc = [];
_commsLoc = [];

_mobResLoc = [];
_snpLoc = [];
_rngLoc = [];

_1stplatoonCompleted = 1;
_2ndplatoonCompleted = 1;
_3rdplatoonCompleted = 1;
_supplyDepotCompleted = 1;
_assassinationCompleted = 1;
_intelCompleted = 1;
_mortarCompleted = 1;
_aaCompleted = 1;
_commsCompleted = 1;

_1stplatoonUnitList = [];
_2ndplatoonUnitList = [];
_3rdplatoonUnitList = [];
_supplyObjectList = [];
_assassinationTarget = "";
_intelObject = "";
_mortarTubeList = [];
_aaUnitList = [];
_commRelayObject = "";

_mrk1stPlatoon = "";
_mrk2ndPlatoon = "";
_mrk3rdPlatoon = "";
_mrkSupply = "";
_mrkTarget = "";
_mrkIntel = "";
_mrkMortar = "";
_mrkAA = "";
_mrkComm = "";

_handle_mortar_loop = null;
_handle_cas_loop = null;
_handle_mobres_loop = null;
_handle_sniper_loop = null;
_handle_ranger_loop = null;

_mobres_active = 0;
_rng_active = 0;
_snp_active = 0;

while {(_noOfObjectives != 0) and (count _objectiveList > 0)} do {
	_randIndex = floor(random count _objectiveList);
	_currObj = _objectiveList select _randIndex;	
	_objectiveList deleteAt _randIndex;	
	
	switch (_currObj) do {
		case "1stplatoon" : {
			_1stplatoonLoc = _locationsList select 0;				
			if (count _1stplatoonLoc > 0) then {
				_selectedObjectives pushBack "1stplatoon";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
		case "2ndplatoon" : {
			_2ndplatoonLoc = _locationsList select 1;
			if (count _2ndplatoonLoc > 0) then {
				_selectedObjectives pushBack "2ndplatoon";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
		case "3rdplatoon" : {
			_3rdplatoonLoc = _locationsList select 2;
			if (count _3rdplatoonLoc > 0) then {
				_selectedObjectives pushBack "3rdplatoon";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
		case "supply_depot" : {
			_supplyLoc = _locationsList select 3;
			if (count _supplyLoc > 0) then {
				_selectedObjectives pushBack "supply_depot";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
		case "assassination" : {
			_assassinationLoc = _locationsList select 4;
			if (count _assassinationLoc > 0) then {
				_selectedObjectives pushBack "assassination";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
		case "intel" : {
			_intelLoc = _locationsList select 5;
			if (count _intelLoc > 0) then {
				_selectedObjectives pushBack "intel";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
		case "mortar" : {
			_mortarLoc = _locationsList select 6;
			if (count _mortarLoc > 0) then {
				_selectedObjectives pushBack "mortar";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
		case "aa" : {
			_aaLoc = _locationsList select 7;
			if (count _aaLoc > 0) then {
				_selectedObjectives pushBack "aa";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
		case "comms" : {
			_commsLoc = _locationsList select 8;
			if (count _commsLoc > 0) then {
				_selectedObjectives pushBack "comms";
				_noOfObjectives = _noOfObjectives - 1;
			};
		};
	};
};

_mobresLoc = _locationsList select 9;
_snpLoc = _locationsList select 10;
_rngLoc = _locationsList select 11;

{
	switch (_x) do {
		case "1stplatoon" : {				
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _1stplatoonLoc);
			_randPlatoon = _1stplatoonLoc select _randIndex;
			
			_squadList = _randPlatoon select 0;
			_garrisonList = _randPlatoon select 1;
			_vehicleList = _randPlatoon select 2;
			_fireSupportVehicleList = _randPlatoon select 3;			
			_aaVehicleList = _randPlatoon select 4;
			_mgLowList = _randPlatoon select 5;
			_mgHighList = _randPlatoon select 6;
			_fireSupportGunList = _randPlatoon select 7;
			_aaGunList = _randPlatoon select 8;
			_patrolList = _randPlatoon select 9;			
			
			_mrk1stPlatoon = createMarker ["mrk1stPlatoon",_squadList select 0];
			_mrk1stPlatoon setMarkerShape "ICON";
			switch (_platoonType) do {
				case 0 : {_mrk1stPlatoon setMarkerType "o_inf";};
				case 1 : {_mrk1stPlatoon setMarkerType "o_motor_inf";};
				case 2 : {_mrk1stPlatoon setMarkerType "o_mech_inf";};
				case 3 : {_mrk1stPlatoon setMarkerType "o_armor";};
				case 4 : {_mrk1stPlatoon setMarkerType "o_armor";};								
			};
			_mrk1stPlatoon setMarkerText "DEFEAT ENEMY PLATOON";
			
			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=4) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 5);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 4 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						_1stplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_1stplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_1stplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_1stplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_1stplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_1stplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_1stplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_1stplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";				
			
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=4) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};				
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_1stplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;

					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_1stplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
				
				// === AA ===
				
				if (count _aaVehicleList > 0) then {
					_vehIndex = floor(random count _aaVehicleList);
					_vehPos = _aaVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType >= 3) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_1stplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
					};
								
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};		
			};
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=4) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;
						_1stplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;
						_1stplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
				
				// === Static AA ===
				
				if (count _aaGunList > 0) then {
					_aagIndex = floor(random count _aaGunList);
					_aagPos = _aaGunList select _aagIndex;
					
					_posX = _aagPos select 0;
					_posY = _aagPos select 1;
					_posZ = _aagPos select 2;
					_heading = _aagPos select 3;
					
					_veh = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_1stplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
			};
			
			_1stplatoonCompleted = 0;			
		};
		case "2ndplatoon" : {
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _2ndplatoonLoc);
			_randPlatoon = _2ndplatoonLoc select _randIndex;
			
			_squadList = _randPlatoon select 0;
			_garrisonList = _randPlatoon select 1;
			_vehicleList = _randPlatoon select 2;
			_fireSupportVehicleList = _randPlatoon select 3;			
			_aaVehicleList = _randPlatoon select 4;
			_mgLowList = _randPlatoon select 5;
			_mgHighList = _randPlatoon select 6;
			_fireSupportGunList = _randPlatoon select 7;
			_aaGunList = _randPlatoon select 8;
			_patrolList = _randPlatoon select 9;
						
			_mrk2ndPlatoon = createMarker ["mrk2ndPlatoon",_squadList select 0];
			_mrk2ndPlatoon setMarkerShape "ICON";
			switch (_platoonType) do {
				case 0 : {_mrk2ndPlatoon setMarkerType "o_inf";};
				case 1 : {_mrk2ndPlatoon setMarkerType "o_motor_inf";};
				case 2 : {_mrk2ndPlatoon setMarkerType "o_mech_inf";};
				case 3 : {_mrk2ndPlatoon setMarkerType "o_armor";};
				case 4 : {_mrk2ndPlatoon setMarkerType "o_armor";};				
			};
			_mrk2ndPlatoon setMarkerText "DEFEAT ENEMY PLATOON";
			
			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=4) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 5);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 4 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						_2ndplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_2ndplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_2ndplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_2ndplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_2ndplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_2ndplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_2ndplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_2ndplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";			
			
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=4) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};			
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_2ndplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
				
					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_2ndplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
				
				// === AA ===
				
				if (count _aaVehicleList > 0) then {
					_vehIndex = floor(random count _aaVehicleList);
					_vehPos = _aaVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};										
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType >= 3) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_2ndplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
					};
								
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};	
			};
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=4) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;
						_2ndplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;
						_2ndplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
				
				// === Static AA ===
				
				if (count _aaGunList > 0) then {
					_aagIndex = floor(random count _aaGunList);
					_aagPos = _aaGunList select _aagIndex;
					
					_posX = _aagPos select 0;
					_posY = _aagPos select 1;
					_posZ = _aagPos select 2;
					_heading = _aagPos select 3;
					
					_veh = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_2ndplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
			};
		
			_2ndplatoonCompleted = 0;			
		};
		case "3rdplatoon" : {
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _3rdplatoonLoc);
			_randPlatoon = _3rdplatoonLoc select _randIndex;
			
			_squadList = _randPlatoon select 0;
			_garrisonList = _randPlatoon select 1;
			_vehicleList = _randPlatoon select 2;
			_fireSupportVehicleList = _randPlatoon select 3;			
			_aaVehicleList = _randPlatoon select 4;
			_mgLowList = _randPlatoon select 5;
			_mgHighList = _randPlatoon select 6;
			_fireSupportGunList = _randPlatoon select 7;
			_aaGunList = _randPlatoon select 8;
			_patrolList = _randPlatoon select 9;
						
			_mrk3rdPlatoon = createMarker ["mrk3rdPlatoon",_squadList select 0];
			_mrk3rdPlatoon setMarkerShape "ICON";
			switch (_platoonType) do {
				case 0 : {_mrk3rdPlatoon setMarkerType "o_inf";};
				case 1 : {_mrk3rdPlatoon setMarkerType "o_motor_inf";};
				case 2 : {_mrk3rdPlatoon setMarkerType "o_mech_inf";};
				case 3 : {_mrk3rdPlatoon setMarkerType "o_armor";};
				case 4 : {_mrk3rdPlatoon setMarkerType "o_armor";};									
			};
			_mrk3rdPlatoon setMarkerText "DEFEAT ENEMY PLATOON";
			
			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=4) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 5);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 4 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						_3rdplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_3rdplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_3rdplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_3rdplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_3rdplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_3rdplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_3rdplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			_3rdplatoonUnitList pushBack _u;
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";			
			
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=4) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};				
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_3rdplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
				
					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_3rdplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
				
				// === AA ===
				
				if (count _aaVehicleList > 0) then {
					_vehIndex = floor(random count _aaVehicleList);
					_vehPos = _aaVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};											
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType >= 3) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;
						_3rdplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
					};
								
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};	
			};			
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=4) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;
						_3rdplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;
						_3rdplatoonUnitList pushBack _u;
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
				
				// === Static AA ===
				
				if (count _aaGunList > 0) then {
					_aagIndex = floor(random count _aaGunList);
					_aagPos = _aaGunList select _aagIndex;
					
					_posX = _aagPos select 0;
					_posY = _aagPos select 1;
					_posZ = _aagPos select 2;
					_heading = _aagPos select 3;
					
					_veh = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;
					_3rdplatoonUnitList pushBack _u;
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
			};
		
			_3rdplatoonCompleted = 0;			
		};
		case "supply_depot" : {
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _supplyLoc);
			_randLoc = _supplyLoc select _randIndex;
			
			_objList = _randLoc select 0;
			_squadList = _randLoc select 1;
			_garrisonList = _randLoc select 2;
			_vehicleList = _randLoc select 3;
			_fireSupportVehicleList = _randLoc select 4;			
			_aaVehicleList = _randLoc select 5;
			_mgLowList = _randLoc select 6;
			_mgHighList = _randLoc select 7;
			_fireSupportGunList = _randLoc select 8;
			_aaGunList = _randLoc select 9;
			_patrolList = _randLoc select 10;
						
			_mrkSupply = createMarker ["mrkSupply",[(_objList select 0) select 0,(_objList select 0) select 1,(_objList select 0) select 2]];
			_mrkSupply setMarkerShape "ICON";
			_mrkSupply setMarkerType "o_service";			
			_mrkSupply setMarkerText "DESTROY SUPPLY DUMP";
			
			// === Supply Crates ===
			
			{
				_posX = _x select 0;
				_posY = _x select 1;
				_posZ = _x select 2;
				_heading = _x select 3;
				
				_obj = "rhs_gaz66_ammo_msv" createVehicle [0,0,0];
				_obj setPosATL [_posX,_posY,_posZ];
				_obj setDir _heading;
				_obj lock 3;
				
				_supplyObjectList pushBack _obj;
			} forEach _objList;
			
			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=3) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 5);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 4 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";			
			
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=3) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};				
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
				
				// === AA ===
				
				if (count _aaVehicleList > 0) then {
					_vehIndex = floor(random count _aaVehicleList);
					_vehPos = _aaVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};									
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType >= 3) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;
					};
								
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};	
			};
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=3) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
				
				// === Static AA ===
				
				if (count _aaGunList > 0) then {
					_aagIndex = floor(random count _aaGunList);
					_aagPos = _aaGunList select _aagIndex;
					
					_posX = _aagPos select 0;
					_posY = _aagPos select 1;
					_posZ = _aagPos select 2;
					_heading = _aagPos select 3;
					
					_veh = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
			};
		
			_supplyDepotCompleted = 0;			
		};
		case "assassination" : {
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _assassinationLoc);
			_randLoc = _assassinationLoc select _randIndex;
			
			_targetList = _randLoc select 0;
			_squadList = _randLoc select 1;
			_garrisonList = _randLoc select 2;
			_vehicleList = _randLoc select 3;
			_fireSupportVehicleList = _randLoc select 4;			
			_aaVehicleList = _randLoc select 5;
			_mgLowList = _randLoc select 6;
			_mgHighList = _randLoc select 7;
			_fireSupportGunList = _randLoc select 8;
			_aaGunList = _randLoc select 9;
			_patrolList = _randLoc select 10;
						
			_mrkTarget = createMarker ["mrkTarget",[(_targetList select 0) select 0,(_targetList select 0) select 1,(_targetList select 0) select 2]];
			_mrkTarget setMarkerShape "ICON";
			_mrkTarget setMarkerType "mil_destroy";			
			_mrkTarget setMarkerColor "colorOPFOR";			
			_mrkTarget setMarkerText "ELIMINATE OFFICER";
			
			// === Target ===
			
			_randTargetIndex = floor(random count _targetList);
			_randTarget = _targetList select _randTargetIndex;
			
			_posX = _randTarget select 0;
			_posY = _randTarget select 1;
			_posZ = _randTarget select 2;
			_heading = _randTarget select 3;
			
			_grp = createGroup east;
			
			_tgt = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_tgt setPosATL [_posX,_posY,_posZ];
			_tgt setDir _heading;
			_tgt setUnitPos "UP";
			null = [_tgt,"tgt"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_tgt] execVM "MissionScripts\AIGarrison.sqf";
						
			_grp setBehaviour "COMBAT";
			_grp setCombatMode "YELLOW";
			_grp setFormDir _heading;
			
			_assassinationTarget = _tgt;			
			
			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=3) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 4);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 4 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";			
			
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=3) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};			
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
				
				// === AA ===
				
				if (count _aaVehicleList > 0) then {
					_vehIndex = floor(random count _aaVehicleList);
					_vehPos = _aaVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};											
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType >= 3) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;
					};
								
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
			};			
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=3) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
				
				// === Static AA ===
				
				if (count _aaGunList > 0) then {
					_aagIndex = floor(random count _aaGunList);
					_aagPos = _aaGunList select _aagIndex;
					
					_posX = _aagPos select 0;
					_posY = _aagPos select 1;
					_posZ = _aagPos select 2;
					_heading = _aagPos select 3;
					
					_veh = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
			};
		
			_assassinationCompleted = 0;			
		};
		case "intel" : {
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _intelLoc);
			_randLoc = _intelLoc select _randIndex;
			
			_docList = _randLoc select 0;
			_squadList = _randLoc select 1;
			_garrisonList = _randLoc select 2;
			_vehicleList = _randLoc select 3;
			_fireSupportVehicleList = _randLoc select 4;			
			_aaVehicleList = _randLoc select 5;
			_mgLowList = _randLoc select 6;
			_mgHighList = _randLoc select 7;
			_fireSupportGunList = _randLoc select 8;
			_aaGunList = _randLoc select 9;
			_patrolList = _randLoc select 10;
						
			_mrkIntel = createMarker ["mrkIntel",[(_docList select 0) select 0,(_docList select 0) select 1,(_docList select 0) select 2]];
			_mrkIntel setMarkerShape "ICON";
			_mrkIntel setMarkerType "mil_pickup";		
			_mrkIntel setMarkerColor "colorOPFOR";				
			_mrkIntel setMarkerText "FIND INTEL";
			
			// === Documents ===
			
			_randDocIndex = floor(random count _docList);
			_randDoc = _docList select _randDocIndex;
			
			_posX = _randDoc select 0;
			_posY = _randDoc select 1;
			_posZ = _randDoc select 2;
			_heading = _randDoc select 3;
			
			_doc = "Land_Document_01_F" createVehicle [0,0,0];
			_doc enableSimulation false;
			_doc setPosATL [_posX,_posY,_posZ];
			_doc setDir _heading;
				
			_intelObject = _doc;			
			
			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=3) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 5);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 4 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";			
						
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=3) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};				
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
				
				// === AA ===
				
				if (count _aaVehicleList > 0) then {
					_vehIndex = floor(random count _aaVehicleList);
					_vehPos = _aaVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};								
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType >= 3) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;
					};
								
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};	
			};
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=3) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
				
				// === Static AA ===
				
				if (count _aaGunList > 0) then {
					_aagIndex = floor(random count _aaGunList);
					_aagPos = _aaGunList select _aagIndex;
					
					_posX = _aagPos select 0;
					_posY = _aagPos select 1;
					_posZ = _aagPos select 2;
					_heading = _aagPos select 3;
					
					_veh = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
			};
		
			_intelCompleted = 0;
		};
		case "mortar" : {
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _mortarLoc);
			_randLoc = _mortarLoc select _randIndex;
			
			_tubeList = _randLoc select 0;
			_squadList = _randLoc select 1;
			_garrisonList = _randLoc select 2;
			_vehicleList = _randLoc select 3;
			_fireSupportVehicleList = _randLoc select 4;			
			_aaVehicleList = _randLoc select 5;
			_mgLowList = _randLoc select 6;
			_mgHighList = _randLoc select 7;
			_fireSupportGunList = _randLoc select 8;
			_aaGunList = _randLoc select 9;
			_patrolList = _randLoc select 10;
						
			_mrkMortar = createMarker ["mrkMortar",[(_tubeList select 0) select 0,(_tubeList select 0) select 1,(_tubeList select 0) select 2]];
			_mrkMortar setMarkerShape "ICON";
			_mrkMortar setMarkerType "o_mortar";			
			_mrkMortar setMarkerText "NEUTRALIZE MORTAR SECTION";
			
			// === Mortars ===
			
			_mortarGunners = [];
			
			_counter = 1;
			while {(_counter <=3) and (count _tubeList > 0)} do {
				_randTubeIndex = floor(random count _tubeList);
				_randTube = _tubeList select _randTubeIndex;
				_tubeList deleteAt _randTubeIndex;
				
				_posX = _randTube select 0;
				_posY = _randTube select 1;
				_posZ = _randTube select 2;
				_heading = _randTube select 3;
				
				_tube = createVehicle ["O_Mortar_01_F", [0,0,0], [], 0, "FORM"];
				_tube setPosATL [_posX,_posY,_posZ];
				_tube setDir _heading;
				_tube lock 3;
				
				_tube setVariable ["ace_cookoff_enable", false, true];
				DeployedUnits pushBack _tube;
				
				_grp = createGroup east;
				
				_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
				_u setPosATL [_posX,_posY,_posZ];
				null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
				null = [_u] execVM "MissionScripts\AISkill.sqf";
				_mortarGunners pushBack _u;
				_u moveInGunner _tube;				
				DeployedUnits pushBack _u;
				
				_grp addVehicle _tube;
				
				_grp setBehaviour "COMBAT";
				_grp setCombatMode "YELLOW";
				_grp setFormDir _heading;
			
				_counter = _counter + 1;
				
				_mortarTubeList pushBack _tube;
			};		

			_handle_mortar_loop = [_mortarGunners] execVM "MissionScripts\CustomAOs\mortar_loop.sqf";
			
			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=2) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 5);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 4 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";			
			
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=2) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};				
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
				
				// === AA ===
				
				if (count _aaVehicleList > 0) then {
					_vehIndex = floor(random count _aaVehicleList);
					_vehPos = _aaVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};									
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType >= 3) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;
					};
								
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};		
			};
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=2) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
				
				// === Static AA ===
				
				if (count _aaGunList > 0) then {
					_aagIndex = floor(random count _aaGunList);
					_aagPos = _aaGunList select _aagIndex;
					
					_posX = _aagPos select 0;
					_posY = _aagPos select 1;
					_posZ = _aagPos select 2;
					_heading = _aagPos select 3;
					
					_veh = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
			};
		
			_mortarCompleted = 0;
		};
		case "aa" : {
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _aaLoc);
			_randLoc = _aaLoc select _randIndex;
			
			_aaGunList = _randLoc select 0;
			_squadList = _randLoc select 1;
			_garrisonList = _randLoc select 2;
			_vehicleList = _randLoc select 3;
			_fireSupportVehicleList = _randLoc select 4;				
			_mgLowList = _randLoc select 5;
			_mgHighList = _randLoc select 6;
			_fireSupportGunList = _randLoc select 7;
			_patrolList = _randLoc select 8;
									
			_mrkAA = createMarker ["mrkAA",[(_aaGunList select 0) select 0,(_aaGunList select 0) select 1,(_aaGunList select 0) select 2]];
			_mrkAA setMarkerShape "ICON";
			_mrkAA setMarkerType "o_unknown";			
			_mrkAA setMarkerText "NEUTRALIZE AA SECTION";
			
			// === AA ===
			
			_grp = createGroup east;
			
			_counter = 1;
			while {(_counter <=3) and (count _aaGunList > 0)} do {
				_randAAIndex = floor(random count _aaGunList);
				_randAA = _aaGunList select _randAAIndex;
				_aaGunList deleteAt _randAAIndex;
				
				_posX = _randAA select 0;
				_posY = _randAA select 1;
				_posZ = _randAA select 2;
				_heading = _randAA select 3;
				
				_aa = null;
				switch (_aaLevel) do {
					case 0 : {_aa = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];};
					case 1 : {_aa = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};					
					case 2 : {_aa = createVehicle ["O_T_APC_Tracked_02_AA_ghex_F", [0,0,0], [], 0, "FORM"];};					
				};
				_aa setPosATL [_posX,_posY,_posZ];
				_aa setDir _heading;
				_aa lock 3;
				
				_aa setVariable ["ace_cookoff_enable", false, true];
				DeployedUnits pushBack _aa;				
				
				if (_aaLevel > 0) then {
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInCommander _aa;				
					DeployedUnits pushBack _u;
				};
							
				_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
				_u setPosATL [_posX,_posY,_posZ];
				null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
				null = [_u] execVM "MissionScripts\AISkill.sqf";
				_u moveInGunner _aa;				
				DeployedUnits pushBack _u;		
				
				_grp setBehaviour "COMBAT";
				_grp setCombatMode "YELLOW";
				_grp setFormDir _heading;
				
				_grp addVehicle _aa;
			
				_counter = _counter + 1;
				
				_aaUnitList pushBack _aa;
			};		

			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=2) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 5);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 4 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";			
			
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=2) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};					
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};		
			};
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=2) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};				
			};
		
			_aaCompleted = 0;
		};
		case "comms" : {
		
			_platoonType = floor(random (_forceLevel + 1));
					
			_randIndex = floor(random count _commsLoc);
			_randLoc = _commsLoc select _randIndex;
			
			_relayList = _randLoc select 0;
			_squadList = _randLoc select 1;
			_garrisonList = _randLoc select 2;
			_vehicleList = _randLoc select 3;
			_fireSupportVehicleList = _randLoc select 4;			
			_aaVehicleList = _randLoc select 5;
			_mgLowList = _randLoc select 6;
			_mgHighList = _randLoc select 7;
			_fireSupportGunList = _randLoc select 8;
			_aaGunList = _randLoc select 9;
			_patrolList = _randLoc select 10;
						
			_mrkComm = createMarker ["mrkComm",[(_relayList select 0) select 0,(_relayList select 0) select 1,(_relayList select 0) select 2]];
			_mrkComm setMarkerShape "ICON";
			_mrkComm setMarkerType "o_support";			
			_mrkComm setMarkerText "DESTROY COMM RELAY";
			
			// === Relay ===
						
			_randRelayIndex = floor(random count _relayList);
			_randRelay = _relayList select _randRelayIndex;			
			
			_posX = _randRelay select 0;
			_posY = _randRelay select 1;
			_posZ = _randRelay select 2;
			_heading = _randRelay select 3;
			
			_relay = createVehicle ["Land_TTowerBig_2_F", [0,0,0], [], 0, "FORM"];
			_relay setPosATL [_posX,_posY,_posZ];
			_relay setDir _heading;			
			
			_commRelayObject = _relay;			

			_handle_cas_loop = [] execVM "MissionScripts\CustomAOs\cas_loop.sqf";
			
			// === Squads ===
			
			_counter = 1;			
			while {(_counter <=2) and ((count _squadList > 0) or (count _garrisonList > 0))} do {
				_deploymentType = floor(random 2); // 0 - Field Squad, 1 - Garrison Squad
				if (count _squadList == 0) then {
					_deploymentType = 1;
				};
				if (count _garrisonList == 0) then {
					_deploymentType = 0;
				};
				
				if (_deploymentType == 0) then {
					_sqdIndex = floor(random count _squadList);
					_sqdPos = _squadList select _sqdIndex;
					_squadList deleteAt _sqdIndex;
				
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;	

					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";					
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL _sqdPos;
					null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				}
				else {
					_garIndex = floor(random count _garrisonList);
					_garPos = _garrisonList select _garIndex;					
					_garrisonList deleteAt _garIndex;
					
					_grp = createGroup east;					
					_counter2 = 1;
					while {(_counter2 <= 7) and (count _garPos > 0)} do {
						_randSoldierIndex = floor(random count _garPos);
						_randSoldierPos = _garPos select _randSoldierIndex;
						_garPos deleteAt _randSoldierIndex;
					
						_posX = _randSoldierPos select 0;
						_posY = _randSoldierPos select 1;
						_posZ = _randSoldierPos select 2;
						_heading = _randSoldierPos select 3;
					
						_soldierClass = floor(random 5);
						_classString = "";
						
						switch (_soldierClass) do {
							case 0 : {_classString = "ldr";};
							case 1 : {_classString = "ar";};
							case 2 : {_classString = "at";};							
							case 3 : {_classString = "mrk";};
							case 3 : {_classString = "aa";};
						};
					
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						_u setDir _heading;
						_u setUnitPos "UP";
						null = [_u,_classString] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						null = [_u] execVM "MissionScripts\AIGarrison.sqf";
						DeployedUnits pushBack _u;
						
						_grp setFormDir _heading;
						
						_counter2 = _counter2 + 1;
					};
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
				};			
				
				_counter = _counter + 1;
			};
			
			// === Patrol ===
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_grp = createGroup east;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;	

			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
			_u setPosATL _patrolPos;
			null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
			null = [_u] execVM "MissionScripts\AISkill.sqf";
			DeployedUnits pushBack _u;
			
			_grp setBehaviour "SAFE";
			_grp setCombatMode "YELLOW";
			
			_wp0 = _grp addWaypoint [_patrolPos,0];
			_wp0 setWaypointType "MOVE";		
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp1 = _grp addWaypoint [_patrolPos,0];
			_wp1 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp2 = _grp addWaypoint [_patrolPos,0];
			_wp2 setWaypointType "MOVE";	
			
			_patrolIndex = floor(random count _patrolList);
			_patrolPos = _patrolList select _patrolIndex;
			_patrolList deleteAt _patrolIndex;
			
			_wp3 = _grp addWaypoint [_patrolPos,0];
			_wp3 setWaypointType "CYCLE";				
			
			// === Vehicles/Static Weapons ===
			
			if (_platoonType != 0) then {
			
				// === Vehicles ===
				
				_counter = 1;				
				while {(_counter <=2) and (count _vehicleList > 0)} do {
				
					_vehIndex = floor(random count _vehicleList);
					_vehPos = _vehicleList select _vehIndex;
					_vehicleList deleteAt _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_dshkm", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};										
					};				
									
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
	
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp addVehicle _veh;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				
					_counter = _counter + 1;
				};
				
				// === Fire Support Vehicle ===
				
				if (count _fireSupportVehicleList > 0) then {
					_vehIndex = floor(random count _fireSupportVehicleList);
					_vehPos = _fireSupportVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["rhsgref_ins_uaz_spg9", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["rhs_btr80a_msv", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_t80um", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_t90a_tv", [0,0,0], [], 0, "FORM"];};						
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType != 1) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;	
					};
		
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};
				
				// === AA ===
				
				if (count _aaVehicleList > 0) then {
					_vehIndex = floor(random count _aaVehicleList);
					_vehPos = _aaVehicleList select _vehIndex;
					
					_posX = _vehPos select 0;
					_posY = _vehPos select 1;
					_posZ = _vehPos select 2;
					_heading = _vehPos select 3;
					
					_veh = null;
					switch (_platoonType) do {					
						case 1 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 2 : {_veh = createVehicle ["RHS_Ural_Zu23_MSV_01", [0,0,0], [], 0, "FORM"];};
						case 3 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};
						case 4 : {_veh = createVehicle ["rhs_zsu234_aa", [0,0,0], [], 0, "FORM"];};									
					};		
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					if (_platoonType >= 3) then {
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInCommander _veh;				
						DeployedUnits pushBack _u;
					};
								
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;				
					DeployedUnits pushBack _u;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInDriver _veh;				
					DeployedUnits pushBack _u;
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
					
					[_grp, getPos leader _grp] call bis_fnc_taskDefend;
					
					//_veh setFuel 0;
				};		
			};
			
			if (_platoonType == 0) then {
				// === MG Low Tripod & High Tripod ===
				
				_counter = 1;			
				while {(_counter <=2) and ((count _mgLowList > 0) or (count _mgHighList > 0))} do {
					_deploymentType = floor(random 2); // 0 - Low MG, 1 - High MG
					if (count _mgLowList == 0) then {
						_deploymentType = 1;
					};
					if (count _mgHighList == 0) then {
						_deploymentType = 0;
					};
					
					if (_deploymentType == 0) then {
						_mgLowIndex = floor(random count _mgLowList);
						_mgLowPos = _mgLowList select _mgLowIndex;
						_mgLowList deleteAt _mgLowIndex;
					
						_posX = _mgLowPos select 0;
						_posY = _mgLowPos select 1;
						_posZ = _mgLowPos select 2;
						_heading = _mgLowPos select 3;
													
						_veh = createVehicle ["rhs_KORD_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					}
					else {
						_mgHighIndex = floor(random count _mgHighList);
						_mgHighPos = _mgHighList select _mgHighIndex;
						_mgHighList deleteAt _mgHighIndex;
					
						_posX = _mgHighPos select 0;
						_posY = _mgHighPos select 1;
						_posZ = _mgHighPos select 2;
						_heading = _mgHighPos select 3;
													
						_veh = createVehicle ["rhs_KORD_high_MSV", [0,0,0], [], 0, "FORM"];						
											
						_veh setPosATL [_posX,_posY,_posZ];
						_veh setDir _heading;
						_veh lock 3;
						
						_veh setVariable ["ace_cookoff_enable", false, true];
						DeployedUnits pushBack _veh;
						
						_grp = createGroup east;
						
						_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
						_u setPosATL [_posX,_posY,_posZ];
						null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
						null = [_u] execVM "MissionScripts\AISkill.sqf";
						_u moveInGunner _veh;						
						DeployedUnits pushBack _u;
						
						_grp setBehaviour "COMBAT";
						_grp setCombatMode "YELLOW";
						_grp setFormDir _heading;
				
						_grp addVehicle _veh;
					};			
					
					_counter = _counter + 1;
				};
				
				// === SPG-9 ===
				
				if (count _fireSupportGunList > 0) then {
					_fsgIndex = floor(random count _fireSupportGunList);
					_fsgPos = _fireSupportGunList select _fsgIndex;
					
					_posX = _fsgPos select 0;
					_posY = _fsgPos select 1;
					_posZ = _fsgPos select 2;
					_heading = _fsgPos select 3;
					
					_veh = createVehicle ["rhs_SPG9M_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
				
				// === Static AA ===
				
				if (count _aaGunList > 0) then {
					_aagIndex = floor(random count _aaGunList);
					_aagPos = _aaGunList select _aagIndex;
					
					_posX = _aagPos select 0;
					_posY = _aagPos select 1;
					_posZ = _aagPos select 2;
					_heading = _aagPos select 3;
					
					_veh = createVehicle ["RHS_ZU23_MSV", [0,0,0], [], 0, "FORM"];
										
					_veh setPosATL [_posX,_posY,_posZ];
					_veh setDir _heading;
					_veh lock 3;
					
					_veh setVariable ["ace_cookoff_enable", false, true];
					DeployedUnits pushBack _veh;
					
					_grp = createGroup east;
					
					_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
					_u setPosATL [_posX,_posY,_posZ];
					null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
					null = [_u] execVM "MissionScripts\AISkill.sqf";
					_u moveInGunner _veh;					
					DeployedUnits pushBack _u;			
					
					_grp setBehaviour "COMBAT";
					_grp setCombatMode "YELLOW";
					_grp setFormDir _heading;
					
					_grp addVehicle _veh;
				};
			};
		
			_commsCompleted = 0;
		};
	};
} forEach _selectedObjectives;

// === Mobile Reserve ===

_mobresIndex = floor(random count _mobresLoc);
_mobresPosList = _mobresLoc select _mobresIndex;

_reserveType = floor(random (_forceLevel + 1));

_counter = 1 + floor(_noOfPlayers / 10);
if (_counter > 5) then {_counter = 5;};

_grpList = [];

_counter1 = 1;
while {(_counter1 <= _counter) and (count _mobresPosList > 0)} do {

	_locIndex = floor(random count _mobresPosList);
	_locPos = _mobresPosList select _locIndex;
	_mobresPosList deleteAt _locIndex;
		
	_posX = _locPos select 0;
	_posY = _locPos select 1;
	_posZ = _locPos select 2;
	_heading = _locPos select 3;
	
	_veh = null;
	switch (_reserveType) do {
		case 0 : {_veh = createVehicle ["RHS_UAZ_MSV_01", [0,0,0], [], 0, "FORM"];};
		case 1 : {_veh = createVehicle ["rhs_tigr_msv", [0,0,0], [], 0, "FORM"];};
		case 2 : {_veh = createVehicle ["rhs_btr80_msv", [0,0,0], [], 0, "FORM"];};
		case 3 : {_veh = createVehicle ["rhs_bmp2_msv", [0,0,0], [], 0, "FORM"];};
		case 4 : {_veh = createVehicle ["rhs_bmp3mera_msv", [0,0,0], [], 0, "FORM"];};		
	};
	
	_veh setPosATL [_posX+2,_posY+2,_posZ];
	_veh setDir _heading;
	_veh lock 3;
	
	_veh setVariable ["ace_cookoff_enable", false, true];
	DeployedUnits pushBack _veh;
	
	_grp = createGroup east;
	
	_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
	_u setPosATL [_posX,_posY,_posZ];
	null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
	null = [_u] execVM "MissionScripts\AISkill.sqf";
	DeployedUnits pushBack _u;
	
	_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
	_u setPosATL [_posX,_posY,_posZ];
	null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
	null = [_u] execVM "MissionScripts\AISkill.sqf";
	DeployedUnits pushBack _u;
	
	_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
	_u setPosATL [_posX,_posY,_posZ];
	null = [_u,"ar"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
	null = [_u] execVM "MissionScripts\AISkill.sqf";
	DeployedUnits pushBack _u;	
	
	_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
	_u setPosATL [_posX,_posY,_posZ];
	null = [_u,"at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
	null = [_u] execVM "MissionScripts\AISkill.sqf";
	DeployedUnits pushBack _u;
	
	_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
	_u setPosATL [_posX,_posY,_posZ];
	null = [_u,"ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
	null = [_u] execVM "MissionScripts\AISkill.sqf";
	DeployedUnits pushBack _u;
	
	_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
	_u setPosATL [_posX,_posY,_posZ];
	null = [_u,"mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
	null = [_u] execVM "MissionScripts\AISkill.sqf";
	DeployedUnits pushBack _u;
	
	_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
	_u setPosATL [_posX,_posY,_posZ];
	null = [_u,"aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
	null = [_u] execVM "MissionScripts\AISkill.sqf";
	DeployedUnits pushBack _u;
	
	_grp setBehaviour "COMBAT";
	_grp setCombatMode "YELLOW";
	_grp setFormDir _heading;
	
	if (_reserveType > 1) then {
		_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
		_u setPosATL [_posX,_posY,_posZ];
		null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
		null = [_u] execVM "MissionScripts\AISkill.sqf";
		_u moveInCommander _veh;	
		DeployedUnits pushBack _u;	
		
		_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
		_u setPosATL [_posX,_posY,_posZ];
		null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
		null = [_u] execVM "MissionScripts\AISkill.sqf";
		_u moveInGunner _veh;	
		DeployedUnits pushBack _u;	
		
		_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
		_u setPosATL [_posX,_posY,_posZ];
		null = [_u,"rfl"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
		null = [_u] execVM "MissionScripts\AISkill.sqf";
		_u moveInDriver _veh;	
		DeployedUnits pushBack _u;
	};	
	
	_grp addVehicle _veh;	
	
	_grpList pushBack _grp;

	_counter1 = _counter1 + 1;
};

_handle_mobres_loop = [_grpList,_currAO] execVM "MissionScripts\CustomAOs\mobile_reserve_loop.sqf";
_mobres_active = 1;

// === Sniper Team ===

_sniperIndex = floor(random count _snpLoc);
_sniperPosList = _snpLoc select _sniperIndex;

_grpList = [];

_grp = createGroup east;

_counter1 = 1;
while {(_counter1 <= 2) and (count _sniperPosList > 0)} do {

	_locIndex = floor(random count _sniperPosList);
	_locPos = _sniperPosList select _locIndex;
	_sniperPosList deleteAt _locIndex;
		
	_posX = _locPos select 0;
	_posY = _locPos select 1;
	_posZ = _locPos select 2;		
	
	_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
	_u setPosATL [_posX,_posY,_posZ];
	null = [_u,"snp"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
	_u setSkill 1;
	_u setSkill ["aimingAccuracy",1];
	_u setSkill ["aimingShake",1];
	_u setSkill ["aimingSpeed",1];
	_u setSkill ["endurance",1];
	_u setSkill ["spotDistance",1];
	_u setSkill ["spotTime",1];
	_u setSkill ["courage",1];
	_u setSkill ["reloadSpeed",1];
	_u setSkill ["commanding",1];
	_u setSkill ["general",1];
	DeployedUnits pushBack _u;
	
	_grp setBehaviour "COMBAT";
	_grp setCombatMode "YELLOW";
	_grp setFormDir floor(random 360);		

	_counter1 = _counter1 + 1;
};

_grpList pushBack _grp;

_handle_sniper_loop = [_grpList,_currAO] execVM "MissionScripts\CustomAOs\sniper_loop.sqf";
_snp_active = 1;

// === Ranger Team ===

_rangerIndex = floor(random count _rngLoc);
_rangerPosList = _rngLoc select _rangerIndex;

_grpList = [];

_grp = createGroup east;

_locIndex = floor(random count _rangerPosList);
_locPos = _rangerPosList select _locIndex;
_rangerPosList deleteAt _locIndex;

_posX = _locPos select 0;
_posY = _locPos select 1;
_posZ = _locPos select 2;	

_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
_u setPosATL [_posX,_posY,_posZ];
null = [_u,"rng_ldr"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
_u setSkill 1;
_u setSkill ["aimingAccuracy",1];
_u setSkill ["aimingShake",1];
_u setSkill ["aimingSpeed",1];
_u setSkill ["endurance",1];
_u setSkill ["spotDistance",1];
_u setSkill ["spotTime",1];
_u setSkill ["courage",1];
_u setSkill ["reloadSpeed",1];
_u setSkill ["commanding",1];
_u setSkill ["general",1];
DeployedUnits pushBack _u;

_locIndex = floor(random count _rangerPosList);
_locPos = _rangerPosList select _locIndex;
_rangerPosList deleteAt _locIndex;

_posX = _locPos select 0;
_posY = _locPos select 1;
_posZ = _locPos select 2;	

_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
_u setPosATL [_posX,_posY,_posZ];
null = [_u,"rng_mrk"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
_u setSkill 1;
_u setSkill ["aimingAccuracy",1];
_u setSkill ["aimingShake",1];
_u setSkill ["aimingSpeed",1];
_u setSkill ["endurance",1];
_u setSkill ["spotDistance",1];
_u setSkill ["spotTime",1];
_u setSkill ["courage",1];
_u setSkill ["reloadSpeed",1];
_u setSkill ["commanding",1];
_u setSkill ["general",1];
DeployedUnits pushBack _u;

_locIndex = floor(random count _rangerPosList);
_locPos = _rangerPosList select _locIndex;
_rangerPosList deleteAt _locIndex;

_posX = _locPos select 0;
_posY = _locPos select 1;
_posZ = _locPos select 2;	

_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
_u setPosATL [_posX,_posY,_posZ];
null = [_u,"rng_aa"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
_u setSkill 1;
_u setSkill ["aimingAccuracy",1];
_u setSkill ["aimingShake",1];
_u setSkill ["aimingSpeed",1];
_u setSkill ["endurance",1];
_u setSkill ["spotDistance",1];
_u setSkill ["spotTime",1];
_u setSkill ["courage",1];
_u setSkill ["reloadSpeed",1];
_u setSkill ["commanding",1];
_u setSkill ["general",1];
DeployedUnits pushBack _u;

_locIndex = floor(random count _rangerPosList);
_locPos = _rangerPosList select _locIndex;
_rangerPosList deleteAt _locIndex;

_posX = _locPos select 0;
_posY = _locPos select 1;
_posZ = _locPos select 2;	

_u = _grp createUnit [_enemySoldier,[0,0,0], [], 0, "FORM"];
_u setPosATL [_posX,_posY,_posZ];
null = [_u,"rng_at"] execVM "MissionScripts\CustomAOs\customAO_EnemyLoadouts.sqf";
_u setSkill 1;
_u setSkill ["aimingAccuracy",1];
_u setSkill ["aimingShake",1];
_u setSkill ["aimingSpeed",1];
_u setSkill ["endurance",1];
_u setSkill ["spotDistance",1];
_u setSkill ["spotTime",1];
_u setSkill ["courage",1];
_u setSkill ["reloadSpeed",1];
_u setSkill ["commanding",1];
_u setSkill ["general",1];
DeployedUnits pushBack _u;

_grp setBehaviour "COMBAT";
_grp setCombatMode "YELLOW";
_grp setFormDir floor(random 360);	

_grpList pushBack _grp;

_handle_ranger_loop = [_grpList,_currAO] execVM "MissionScripts\CustomAOs\ranger_loop.sqf";
_rng_active = 1;


// AO Completion Checks

_1stplatoonThreshold = (count _1stplatoonUnitList)/5;
_2ndplatoonThreshold = (count _2ndplatoonUnitList)/5;
_3rdplatoonThreshold = (count _3rdplatoonUnitList)/5;

CustomAOCompleted = 0;
while {CustomAOCompleted == 0} do {

	if (_1stplatoonCompleted == 0) then {
		_tempList = [];
		
		{
			if (alive _x) then {
				_tempList pushBack _x;
			};
		} forEach _1stplatoonUnitList;
		_1stplatoonUnitList = _tempList;
		
		if (count _1stplatoonUnitList <= _1stplatoonThreshold) then {
			_1stplatoonCompleted = 1;
			[["TaskSucceeded",["","PLATOON DEFEATED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrk1stPlatoon setMarkerText "PLATOON DEFEATED";
			_mrk1stPlatoon setMarkerColor "ColorBLUFOR";
		};
	};
	
	if (_2ndplatoonCompleted == 0) then {
		_tempList = [];
		
		{
			if (alive _x) then {
				_tempList pushBack _x;
			};
		} forEach _2ndplatoonUnitList;
		_2ndplatoonUnitList = _tempList;
		
		if (count _2ndplatoonUnitList <= _2ndplatoonThreshold) then {
			_2ndplatoonCompleted = 1;
			[["TaskSucceeded",["","PLATOON DEFEATED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrk2ndPlatoon setMarkerText "PLATOON DEFEATED";
			_mrk2ndPlatoon setMarkerColor "ColorBLUFOR";
		};
	};
	
	if (_3rdplatoonCompleted == 0) then {
		_tempList = [];
		
		{
			if (alive _x) then {
				_tempList pushBack _x;
			};
		} forEach _3rdplatoonUnitList;
		_3rdplatoonUnitList = _tempList;
		
		if (count _3rdplatoonUnitList <= _3rdplatoonThreshold) then {
			_3rdplatoonCompleted = 1;
			[["TaskSucceeded",["","PLATOON DEFEATED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrk3rdPlatoon setMarkerText "PLATOON DEFEATED";
			_mrk3rdPlatoon setMarkerColor "ColorBLUFOR";
		};
	};
	
	if (_supplyDepotCompleted == 0) then {
		_tempList = [];
		{
			if (alive _x) then {
				_tempList pushBack _x;
			};
		} forEach _supplyObjectList;
		_supplyObjectList = _tempList;
		
		if (count _supplyObjectList == 0) then {
			_supplyDepotCompleted = 1;
			[["TaskSucceeded",["","SUPPLY DUMP DESTROYED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrkSupply setMarkerText "SUPPLY DUMP DESTROYED";
			_mrkSupply setMarkerColor "ColorBLUFOR";
		};
	};
	
	if (_assassinationCompleted == 0) then {
		if (!(alive _assassinationTarget)) then {
			_assassinationCompleted = 1;
			[["TaskSucceeded",["","OFFICER ELIMINATED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrkTarget setMarkerText "OFFICER ELIMINATED";
			_mrkTarget setMarkerColor "ColorBLUFOR";
		};
	};
	
	if (_intelCompleted == 0) then {
		_intelFound = 0;
		{
			if (_x distance _intelObject <= 2) then {
				_intelFound = 1;
			};
		} forEach allPlayers;
		if (_intelFound == 1) then {
			_intelCompleted = 1;
			[["TaskSucceeded",["","INTEL FOUND!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrkIntel setMarkerText "INTEL FOUND";
			_mrkIntel setMarkerColor "ColorBLUFOR";
			deleteVehicle _intelObject;
		};
	};
	
	if (_mortarCompleted == 0) then {
		_tempList = [];
		{
			if (alive _x) then {
				_tempList pushBack _x;
			};
		} forEach _mortarTubeList;
		_mortarTubeList = _tempList;
		
		if (count _mortarTubeList == 0) then {
			_mortarCompleted = 1;
			[["TaskSucceeded",["","MORTAR SECTION NEUTRALIZED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrkMortar setMarkerText "MORTAR SECTION NEUTRALIZED";
			_mrkMortar setMarkerColor "ColorBLUFOR";
			terminate _handle_mortar_loop;
		};
	};
	
	if (_aaCompleted == 0) then {
		_tempList = [];
		{
			if (alive _x) then {
				_tempList pushBack _x;
			};
		} forEach _aaUnitList;
		_aaUnitList = _tempList;
		
		if (count _aaUnitList == 0) then {
			_aaCompleted = 1;
			[["TaskSucceeded",["","AA SECTION NEUTRALIZED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrkAA setMarkerText "AA SECTION NEUTRALIZED";
			_mrkAA setMarkerColor "ColorBLUFOR";			
		};
	};
	
	if (_commsCompleted == 0) then {
		if (!(alive _commRelayObject)) then {
			_commsCompleted = 1;
			[["TaskSucceeded",["","COMM RELAY DESTROYED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;
			_mrkComm setMarkerText "COMM RELAY DESTROYED";
			_mrkComm setMarkerColor "ColorBLUFOR";
			terminate _handle_cas_loop;
		};
	};

	if ((_1stplatoonCompleted == 1) and (_2ndplatoonCompleted == 1) and (_3rdplatoonCompleted == 1) 
			and (_supplyDepotCompleted == 1) and (_assassinationCompleted == 1) and (_intelCompleted == 1) 
			and (_mortarCompleted == 1) and (_aaCompleted == 1) and (_commsCompleted == 1)) then {
			
		CustomAOCompleted = 1;
		
		deleteMarker _mrk1stPlatoon;
		deleteMarker _mrk2ndPlatoon;
		deleteMarker _mrk3rdPlatoon;
		deleteMarker _mrkSupply;
		deleteMarker _mrkTarget;
		deleteMarker _mrkIntel;
		deleteMarker _mrkMortar;
		deleteMarker _mrkAA;
		deleteMarker _mrkComm;
		
		if (_mobres_active == 1) then {
			terminate _handle_mobres_loop;			
		};
		if (_snp_active == 1) then {
			terminate _handle_sniper_loop;			
		};
		if (_rng_active == 1) then {
			terminate _handle_ranger_loop;			
		};
	};
	sleep 10;
};

[["TaskSucceeded",["","AO SECURED!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;