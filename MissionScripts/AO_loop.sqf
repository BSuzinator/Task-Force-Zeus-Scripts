_startingAO = _this select 0;
_enemyAOs = _this select 1;
_rotationType = _this select 2;

_friendlyAOs = [_startingAO];

_prevAO = _startingAO;

CustomAOCompleted = 0;
_completedAOs = 0;
DeployedUnits = [];
ScenarioComplete = 0;

fnc_get_next_AO = {	
	_prevAO = _this select 0;
	_retAO = "";	
	if (_rotationType == "random") then {
		_randIndex = floor(random (count _enemyAOs));
		_retAO = _enemyAOs select _randIndex;
	}
	else {		
		_candidateAOs = [];
			
		_row = parseNumber (_prevAO select [2,2]);
		_col = parseNumber (_prevAO select [4,2]);
		
		_neighborRow = _row + 1;
		_neighborCol = _col;
		_neighborRowStr = str _neighborRow;
		_neighborColStr = str _neighborCol;
		
		if (_neighborRow < 10) then {
			_neighborRowStr = format["0%1",_neighborRow];
		};
		if (_neighborCol < 10) then {
			_neighborColStr = format["0%1",_neighborCol];
		};
		_neighborAO = format["ao%1%2",_neighborRowStr,_neighborColStr];
		
		if (_enemyAOs find _neighborAO != -1) then {
			_candidateAOs pushBack _neighborAO;
		};
		
		_neighborRow = _row;
		_neighborCol = _col + 1;
		_neighborRowStr = str _neighborRow;
		_neighborColStr = str _neighborCol;
		
		if (_neighborRow < 10) then {
			_neighborRowStr = format["0%1",_neighborRow];
		};
		if (_neighborCol < 10) then {
			_neighborColStr = format["0%1",_neighborCol];
		};
		_neighborAO = format["ao%1%2",_neighborRowStr,_neighborColStr];
		
		if (_enemyAOs find _neighborAO != -1) then {
			_candidateAOs pushBack _neighborAO;
		};
		
		_neighborRow = _row - 1;
		_neighborCol = _col;
		_neighborRowStr = str _neighborRow;
		_neighborColStr = str _neighborCol;
		
		if (_neighborRow < 10) then {
			_neighborRowStr = format["0%1",_neighborRow];
		};
		if (_neighborCol < 10) then {
			_neighborColStr = format["0%1",_neighborCol];
		};
		_neighborAO = format["ao%1%2",_neighborRowStr,_neighborColStr];
		
		if (_enemyAOs find _neighborAO != -1) then {
			_candidateAOs pushBack _neighborAO;
		};
		
		_neighborRow = _row;
		_neighborCol = _col - 1;
		_neighborRowStr = str _neighborRow;
		_neighborColStr = str _neighborCol;
		
		if (_neighborRow < 10) then {
			_neighborRowStr = format["0%1",_neighborRow];
		};
		if (_neighborCol < 10) then {
			_neighborColStr = format["0%1",_neighborCol];
		};
		_neighborAO = format["ao%1%2",_neighborRowStr,_neighborColStr];
		
		if (_enemyAOs find _neighborAO != -1) then {
			_candidateAOs pushBack _neighborAO;
		};
		
		if (count _candidateAOs == 0) then {
			
			{
				_row = parseNumber (_x select [2,2]);
				_col = parseNumber (_x select [4,2]);
				
				_neighborRow = _row + 1;
				_neighborCol = _col;
				_neighborRowStr = str _neighborRow;
				_neighborColStr = str _neighborCol;
				
				if (_neighborRow < 10) then {
					_neighborRowStr = format["0%1",_neighborRow];
				};
				if (_neighborCol < 10) then {
					_neighborColStr = format["0%1",_neighborCol];
				};
				_neighborAO = format["ao%1%2",_neighborRowStr,_neighborColStr];
				
				if (_enemyAOs find _neighborAO != -1) then {
					_candidateAOs pushBack _neighborAO;
				};
				
				_neighborRow = _row;
				_neighborCol = _col + 1;
				_neighborRowStr = str _neighborRow;
				_neighborColStr = str _neighborCol;
				
				if (_neighborRow < 10) then {
					_neighborRowStr = format["0%1",_neighborRow];
				};
				if (_neighborCol < 10) then {
					_neighborColStr = format["0%1",_neighborCol];
				};
				_neighborAO = format["ao%1%2",_neighborRowStr,_neighborColStr];
				
				if (_enemyAOs find _neighborAO != -1) then {
					_candidateAOs pushBack _neighborAO;
				};
				
				_neighborRow = _row - 1;
				_neighborCol = _col;
				_neighborRowStr = str _neighborRow;
				_neighborColStr = str _neighborCol;
				
				if (_neighborRow < 10) then {
					_neighborRowStr = format["0%1",_neighborRow];
				};
				if (_neighborCol < 10) then {
					_neighborColStr = format["0%1",_neighborCol];
				};
				_neighborAO = format["ao%1%2",_neighborRowStr,_neighborColStr];
				
				if (_enemyAOs find _neighborAO != -1) then {
					_candidateAOs pushBack _neighborAO;
				};
				
				_neighborRow = _row;
				_neighborCol = _col - 1;
				_neighborRowStr = str _neighborRow;
				_neighborColStr = str _neighborCol;
				
				if (_neighborRow < 10) then {
					_neighborRowStr = format["0%1",_neighborRow];
				};
				if (_neighborCol < 10) then {
					_neighborColStr = format["0%1",_neighborCol];
				};
				_neighborAO = format["ao%1%2",_neighborRowStr,_neighborColStr];
				
				if (_enemyAOs find _neighborAO != -1) then {
					_candidateAOs pushBack _neighborAO;
				};
			} forEach _friendlyAOs;
		
			if (count _candidateAOs > 0) then {
				_randIndex = floor(random (count _candidateAOs));
				_retAO = _candidateAOs select _randIndex;	
			}
			else {
				_randIndex = floor(random (count _enemyAOs));
				_retAO = _enemyAOs select _randIndex;
			};
		}
		else {
			_randIndex = floor(random (count _candidateAOs));
			_retAO = _candidateAOs select _randIndex;	
		};	
	};	
	_retAO
};

{
	_x setMarkerAlpha 0;

	_currObj = 1;
	while {(getMarkerPos format["%1_obj%2",_x,_currObj]) select 0 != 0} do {
		format["%1_obj%2",_x,_currObj] setMarkerAlpha 0;
		_currObj = _currObj + 1;
	};
} forEach _enemyAOs;

// Collect specific locations for precise object positioning

// Collect Locations List

// [["ao0000",ListOfLocations],...,["ao9999",ListOfLocations]]
// ListOfLocations = [ 1stPlatoonLocationsList,2ndPlatoonLocationsList,3rdPlatoonLocationsList, // 4 x Squads + 4 x MG/Vehicle + 1 x FS/V + 1 x AA + Structures						
//						SupplyDepotLocationsList,AssassinationTargetLocationsList,IntelLocationsList, // Objectives + 3 x Squads + 3 x MG/Vehicle + 1 x FS/V + 1 x AA + Structures
//						MortarSectionLocationsList,AASectionLocationsList,CommsRelayLocationsList, // Objectives + 2 x Squads + 2 x MG/Vehicle + 1 x FS/V + 1 x AA + Structures
//						MobileReserveLocationsList,SniperTeamLocationsList,RangerTeamLocationsList]
//
//	Lists Structure	
//
// 	1stPlatoonsLocationsList = [Deployment1,...,DeploymentN] - "1stplt"
// 		Deployment = [SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,AAVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,AALocationsList,PatrolList]
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			AAVehicleLocationsList = [Location1,...,LocationN] - "aav"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			AALocationsList = [Location1,...,LocationN] - "aag"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
// 	2ndPlatoonLocationsList = [Deployment1,...,DeploymentN] - "2ndplt"
// 		Deployment = [SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,AAVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,AALocationsList,PatrolList]
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			AAVehicleLocationsList = [Location1,...,LocationN] - "aav"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			AALocationsList = [Location1,...,LocationN] - "aag"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
// 	3rdPlatoonLocationsList = [Deployment1,...,DeploymentN] - "3rdplt"
// 		Deployment = [SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,AAVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,AALocationsList,PatrolList]
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			AAVehicleLocationsList = [Location1,...,LocationN] - "aav"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			AALocationsList = [Location1,...,LocationN] - "aag"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
//	MortarSectionLocationsList = [Deployment1,...,Deployment1] - "art"
//		Deployment = [TubeLocationsList,SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,AAVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,AALocationsList,PatrolList]
//			TubeLocationsList = [Location1,Location2,Location3] - "gun"
//				Location = [x,y,z]
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			AAVehicleLocationsList = [Location1,...,LocationN] - "aav"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			AALocationsList = [Location1,...,LocationN] - "aag"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
//	AASectionLocationsList = [Deployment1,...,DeploymentN] - "aas"
//		Deployment = [AALocationsList,SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,PatrolList]
//			AALocationsList = [Location1,Location2,Location3] - "aag"
//				Location = [x,y,z,heading]
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
//	CommsRelayLocationsList = [Deployment1,...,DeploymentN] - "com"
//		Deployment = [RelayLocation,SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,AAVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,AALocationsList,PatrolList]
//			RelayLocation = [x,y,z] - "rel"
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			AAVehicleLocationsList = [Location1,...,LocationN] - "aav"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			AALocationsList = [Location1,...,LocationN] - "aag"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
//  SupplyDepotLocationsList = [Deployment1,...,DeploymentN] - "sup"
//		Deployment = [SupplyObjectsList,SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,AAVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,AALocationsList,PatrolList]
//			SupplyObjectsList = [Locations1,...,LocationsN] - "obj"
//				Location = [x,y,z,heading,typeOf]
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			AAVehicleLocationsList = [Location1,...,LocationN] - "aav"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			AALocationsList = [Location1,...,LocationN] - "aag"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
//  AssassinationTargetLocationsList = [Deployment1,...,DeploymentN] - "tgt"
//		Deployment = [TargetLocationsList,SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,AAVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,AALocationsList,PatrolList]
//			TargetLocationsList = [Locations1,...,LocationsN] - "loc"
//				Location = [x,y,z,heading,typeOf]
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			AAVehicleLocationsList = [Location1,...,LocationN] - "aav"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			AALocationsList = [Location1,...,LocationN] - "aag"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
//  IntelLocationsList = [Deployment1,...,DeploymentN] - "int"
//		Deployment = [DocumentsLocationsList,SquadLocationsList,GarrisonBuildingsList,VehicleLocationsList,FireSupportVehicleLocationsList,AAVehicleLocationsList,FSLocationsList,MGLowTripodLocationsList,MGHighTripodLocationsList,AALocationsList,PatrolList]
//			DocumentsLocationsList = [Locations1,...,LocationsN] - "doc"
//				Location = [x,y,z,heading,typeOf]
// 			SquadLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "sqd"
//			GarrisonBuildingsList = [Building1,...,BuildingN] - "gar"
//				Building1 = [Position1,...,PositionN]
//					Position = [x,y,z,heading]
//			VehicleLocationsList = [Location1,...,LocationN] - "veh"
//				Location = [x,y,z,heading]
//			FireSupportVehicleLocationsList = [Location1,...,LocationN] - "fsv"
//				Location = [x,y,z,heading]
//			AAVehicleLocationsList = [Location1,...,LocationN] - "aav"
//				Location = [x,y,z,heading]
//			FSLocationsList = [Location1,...,LocationN] - "fsg"
//				Location = [x,y,z,heading]
//			MGLowTripodLocationsList = [Location1,...,LocationN] - "mgl"
//				Location = [x,y,z,heading]
//			MGHighTripodLocationsList = [Location1,...,LocationN] - "mgh"
//				Location = [x,y,z,heading]
//			AALocationsList = [Location1,...,LocationN] - "aag"
//				Location = [x,y,z,heading]
//			PatrolList = [Location1,...,LocationN] - "ptr"
//				Location = [x,y,z]
//	MobileReserveLocationsList = [Deployment1,...,DeploymentN] - "mob"
//		Deployment = [Location1,...,LocationN]
//			Location = [x,y,z,heading] 
//	SniperTeamLocationsList = [Deployment1,...,DeploymentN] - "snp"
//		Deployment = [Location1,...,LocationN]		
//			Location = [x,y,z]
//	RangerTeamLocationsList = [[x1,y1,z1],...,[xn,yn,zn]] - "rng"
//		Deployment = [Location1,...,LocationN]		
//			Location = [x,y,z]

_masterDeploymentList = [];

{
	_listOfLocations = [];
	
	_1stplatoonLocations = [];
	_2ndplatoonLocations = [];
	_3rdplatoonLocations = [];	
	_supplyDepotLocations = [];
	_assasinationLocations = [];
	_intelLocations = [];
	_mortarLocations = [];
	_aaLocations = [];
	_commsLocations = [];
	_mobileReserveLocations = [];
	_sniperTeamLocations = [];
	_rangerTeamLocations = [];
							
	// === Collect 1st Platoon Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_1stplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
	while {typeOf(_foundObj) != ""} do {
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];		
		_aaVehicleList = [];
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];		
		_aagList = [];
		_patroList = [];
				
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_1stplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_aav_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_aav_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aagList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_1stplt%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};			
		
		_1stplatoonLocations pushBack [_squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_aaVehicleList,_mgLowList,_mgHighList,_fsglList,_aagList,_patroList];		
		
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_1stplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect 2nd Platoon Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
	while {typeOf(_foundObj) != ""} do {
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];		
		_aaVehicleList = [];
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];		
		_aagList = [];
		_patroList = [];		
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_aav_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_aav_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aagList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_2ndplatoonLocations pushBack [_squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_aaVehicleList,_mgLowList,_mgHighList,_fsglList,_aagList,_patroList];		
				
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_2ndplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect 3rd Platoon Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
	while {typeOf(_foundObj) != ""} do {
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];		
		_aaVehicleList = [];
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];		
		_aagList = [];
		_patroList = [];
				
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_aav_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_aav_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aagList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_3rdplatoonLocations pushBack [_squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_aaVehicleList,_mgLowList,_mgHighList,_fsglList,_aagList,_patroList];		
				
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_3rdplt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect Supply Depot Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_sup%2_obj_%3",_x,_counter1,_counter2] , objNull];	
	
	while {typeOf(_foundObj) != ""} do {
		_objList = [];
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];		
		_aaVehicleList = [];
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];		
		_aagList = [];	
		_patroList = [];		
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_obj_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_objList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_obj_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_sup%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_aav_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_aav_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aagList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_sup%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_supplyDepotLocations pushBack [_objList, _squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_aaVehicleList,_mgLowList,_mgHighList,_fsglList,_aagList,_patroList];		
			
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_sup%2_obj_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect Assasination Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_tgt%2_loc_%3",_x,_counter1,_counter2] , objNull];
	while {typeOf(_foundObj) != ""} do {
		_targetList = [];
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];		
		_aaVehicleList = [];
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];		
		_aagList = [];	
		_patroList = [];		
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_loc_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_targetList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_loc_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_tgt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_aav_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_aav_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aagList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_tgt%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_assasinationLocations pushBack [_targetList, _squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_aaVehicleList,_mgLowList,_mgHighList,_fsglList,_aagList,_patroList];		
			
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_tgt%2_loc_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect Intel Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_int%2_doc_%3",_x,_counter1,_counter2] , objNull];
	while {typeOf(_foundObj) != ""} do {
		_docList = [];
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];		
		_aaVehicleList = [];
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];		
		_aagList = [];	
		_patroList = [];		
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_doc_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_docList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_doc_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_int%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_aav_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_aav_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aagList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};			
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_int%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};	
				
		_intelLocations pushBack [_docList, _squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_aaVehicleList,_mgLowList,_mgHighList,_fsglList,_aagList,_patroList];		
				
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_int%2_doc_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect Mortar Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_art%2_gun_%3",_x,_counter1,_counter2] , objNull];
	while {typeOf(_foundObj) != ""} do {
		_tubeList = [];
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];		
		_aaVehicleList = [];
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];		
		_aagList = [];	
		_patroList = [];
				
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_gun_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_tubeList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_gun_%3",_x,_counter1,_counter2] , objNull];
		};	

		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_art%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_aav_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_aav_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aagList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};			
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_art%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};		
		
		_mortarLocations pushBack [_tubeList, _squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_aaVehicleList,_mgLowList,_mgHighList,_fsglList,_aagList,_patroList];		
			
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_art%2_gun_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect AA Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_aas%2_aag_%3",_x,_counter1,_counter2] , objNull];
	while {typeOf(_foundObj) != ""} do {
		_aaGunList = [];
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];			
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];	
		_patroList = [];
				
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaGunList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_aas%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};			
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_aas%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};	
				
		_aaLocations pushBack [_aaGunList, _squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_mgLowList,_mgHighList,_fsglList,_patroList];		
		
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_aas%2_aag_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect Comms Relay Locations ===
	
	_counter1 = 1;
	_counter2 = 1;
	_foundObj = missionNamespace getVariable [format["%1_com%2_rel_%3",_x,_counter1,_counter2] , objNull];
	while {typeOf(_foundObj) != ""} do {
		_relayList = [];
		_squadList = [];
		_garrisonList = [];
		_vehicleList = [];
		_fireSupportVehicleList = [];		
		_aaVehicleList = [];
		_mgLowList = [];
		_mgHighList = [];
		_fsglList = [];		
		_aagList = [];	
		_patroList = [];
			
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_rel_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_relayList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_rel_%3",_x,_counter1,_counter2] , objNull];
		};	
	
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_squadList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_sqd_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_counter3 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_garrisonSquad = [];
			while {typeOf(_foundObj) != ""} do {
			
				_garrisonSquad pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
				deleteVehicle _foundObj;
			
				_counter3 = _counter3 + 1;
				_foundObj = missionNamespace getVariable [format["%1_com%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
			};
			
			_garrisonList pushBack _garrisonSquad;
			
			_counter2 = _counter2 + 1;
			_counter3 = 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_gar%3_%4",_x,_counter1,_counter2,_counter3] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_veh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_vehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_veh_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fireSupportVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_fsv_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_aav_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aaVehicleList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_aav_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgLowList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_mgl_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_mgHighList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_mgh_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_fsglList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_fsg_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_aag_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_aagList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_aag_%3",_x,_counter1,_counter2] , objNull];
		};			
	
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_patroList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_com%2_ptr_%3",_x,_counter1,_counter2] , objNull];
		};	
		
		_commsLocations pushBack [_relayList, _squadList,_garrisonList,_vehicleList,_fireSupportVehicleList,_aaVehicleList,_mgLowList,_mgHighList,_fsglList,_aagList,_patroList];		
			
		_counter1 = _counter1 + 1;
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_com%2_rel_%3",_x,_counter1,_counter2] , objNull];
	};
	
	// === Collect Mobile Reserve Locations ===
	
	_counter1 = 1;
	_foundObj = missionNamespace getVariable [format["%1_mob%2_1",_x,_counter1] , objNull];
	while {typeOf(_foundObj) != ""} do {
	
		_locationList = [];
	
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_mob%2_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_locationList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2,getDir _foundObj];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_mob%2_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_mobileReserveLocations pushBack _locationList;
	
		_counter1 =_counter1 + 1;
		_foundObj = missionNamespace getVariable [format["%1_mob%2_1",_x,_counter1] , objNull];
	};
	
	// === Collect Sniper Team Locations ===
	
	_counter1 = 1;
	_foundObj = missionNamespace getVariable [format["%1_snp%2_1",_x,_counter1] , objNull];
	while {typeOf(_foundObj) != ""} do {
	
		_locationList = [];
	
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_snp%2_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_locationList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_snp%2_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_sniperTeamLocations pushBack _locationList;
	
		_counter1 =_counter1 + 1;
		_foundObj = missionNamespace getVariable [format["%1_snp%2_1",_x,_counter1] , objNull];
	};
	
	// === Collect Ranger Team Locations ===
	
	_counter1 = 1;
	_foundObj = missionNamespace getVariable [format["%1_rng%2_1",_x,_counter1] , objNull];
	while {typeOf(_foundObj) != ""} do {
	
		_locationList = [];
	
		_counter2 = 1;
		_foundObj = missionNamespace getVariable [format["%1_rng%2_%3",_x,_counter1,_counter2] , objNull];
		while {typeOf(_foundObj) != ""} do {
		
			_locationList pushBack [(getPosATL _foundObj) select 0,(getPosATL _foundObj) select 1,(getPosATL _foundObj) select 2];
			deleteVehicle _foundObj;
		
			_counter2 = _counter2 + 1;
			_foundObj = missionNamespace getVariable [format["%1_rng%2_%3",_x,_counter1,_counter2] , objNull];
		};
		
		_rangerTeamLocations pushBack _locationList;
	
		_counter1 =_counter1 + 1;
		_foundObj = missionNamespace getVariable [format["%1_rng%2_1",_x,_counter1] , objNull];
	};
	
	// Centralize lists	
	
	_listOfLocations = [_1stplatoonLocations,_2ndplatoonLocations,_3rdplatoonLocations,
							_supplyDepotLocations,_assasinationLocations,_intelLocations,
							_mortarLocations,_aaLocations,_commsLocations,
							_mobileReserveLocations,_sniperTeamLocations,_rangerTeamLocations];
	
	_masterDeploymentList pushBack [_x,_listOfLocations];
} forEach _enemyAOs;

sleep 30;

while {count _enemyAOs > 0} do {

	_currAO = [_prevAO] call fnc_get_next_AO;	
	
	_currAO setMarkerAlpha 0.5;	
		
	[["TaskAssigned",["","NEW AO ASSIGNED - CHECK MAPS!"]],"BIS_fnc_showNotification"] call BIS_fnc_MP;	
	
	sleep 1;
	
	_specificLocations = [];
	{
		if (_x select 0 == _currAO) then {
			_specificLocations = _x select 1;
		};
	} forEach _masterDeploymentList;
	
	_customAO_handle = [_currAO,_specificLocations] execVM "MissionScripts\CustomAOs\customAO_loop.sqf";		
	
	while {CustomAOCompleted == 0} do {
		sleep 10;
	};
	
	CustomAOCompleted = 0;		
	terminate _customAO_handle;
		
	_currAO setMarkerColor "colorBLUFOR";
	_friendlyAOs pushBack _currAO;
	_currIndex = _enemyAOs find _currAO;
	_enemyAOs deleteAt _currIndex;
	
	_prevAO = _currAO;	
	
	_completedAOs = _completedAOs + 1;
	if (_completedAOs mod 3 == 0) then {
		_completedAOs = 0;
		{				
			_x setDamage 1;			
		} forEach DeployedUnits;
		{				
			deleteVehicle _x;			
		} forEach DeployedUnits;
		DeployedUnits = [];
	};

	sleep 1;
};

//{
//	_x setMarkerAlpha 0;
//} forEach allMapMarkers;

ScenarioComplete = 1;

//{
//	deleteMarker _x;
//} forEach allMapMarkers;

//remoteExec ["{deleteMarker _x;} forEach allMapMarkers;"];

[["end1",true], "BIS_fnc_endMission", true, true] call BIS_fnc_MP;
//"end1" call BIS_fnc_endMission;

