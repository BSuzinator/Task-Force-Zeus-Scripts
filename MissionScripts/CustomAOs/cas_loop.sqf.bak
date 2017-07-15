while {true} do {
	_targetList = [];
	
	{
		if (((east knowsAbout _x) >= 1.5) and (_x distance (getMarkerPos "respawn_west") > 1000)) then {
			_targetList pushBack _x;
		};
	} forEach allPlayers;
	
	if (count _targetList > 0) then {		
	
		_randTarget = selectRandom _targetList;
		_posX = (getPosWorld _randTarget) select 0;
		_posY = (getPosWorld _randTarget) select 1;
		
		_randDir = selectRandom ["n","s","w","e"];			
		
		_grp = createGroup east;
		
		_cas = null;
		_cas = createVehicle ["RHS_Su25SM_vvsc", [0,0,1000], [], 0, "FLY"];
		_cas addMagazine "rhs_mag_fab250";
		_cas addMagazine "rhs_mag_fab250";
		_cas addMagazine "rhs_mag_fab250";
		_cas addMagazine "rhs_mag_fab250";
		_cas addMagazine "rhs_mag_fab250";
		_cas addMagazine "rhs_mag_fab250";
		switch (_randDir) do {			
			case "n" : {
				_cas setPos [_posX,_posY+10000,2000];				
			};
			case "s" : {
				_cas setPos [_posX,_posY-10000,2000];				
			};
			case "w" : {
				_cas setPos [_posX-10000,_posY,2000];				
			};
			case "e" : {
				_cas setPos [_posX+10000,_posY,2000];				
			};
		};		
		_cas flyInHeight 100;
		
		_u = _grp createUnit ["rhs_msv_emr_rifleman",[0,0,0], [], 0, "FORM"];				
		_u moveInDriver _cas;		
		
		_u disableAI "TARGET";
		_u disableAI "AUTOTARGET";
		_u disableAI "AUTOCOMBAT";				
		
		switch (_randDir) do {			
			case "n" : {			
				_wp = _grp addWaypoint [[_posX,_posY+2000],0];
				_wp setWaypointSpeed "FULL";
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
			
				_wp = _grp addWaypoint [[_posX,_posY+500],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+400],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+300],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+200],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+100],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-100],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
			
				_wp = _grp addWaypoint [[_posX,_posY-200],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-300],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-400],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-500],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-10000],0];
				_wp setWaypointSpeed "FULL";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","deleteVehicle vehicle this; deleteVehicle this;"];
			};
			case "s" : {
				_wp = _grp addWaypoint [[_posX,_posY-2000],0];
				_wp setWaypointSpeed "FULL";
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";	

				_wp = _grp addWaypoint [[_posX,_posY-600],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-500],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-400],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-300],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-200],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY-100],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+100],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+200],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+300],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+400],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+500],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX,_posY+10000],0];
				_wp setWaypointSpeed "FULL";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","deleteVehicle vehicle this; deleteVehicle this;"];
			};
			case "w" : {
				_wp = _grp addWaypoint [[_posX-2000,_posY],0];
				_wp setWaypointSpeed "FULL";
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
			
				_wp = _grp addWaypoint [[_posX-500,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-400,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-300,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-200,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-100,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+100,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+200,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+300,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+400,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+500,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+10000,_posY],0];
				_wp setWaypointSpeed "FULL";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","deleteVehicle vehicle this; deleteVehicle this;"];
			};
			case "e" : {
				_wp = _grp addWaypoint [[_posX+2000,_posY],0];
				_wp setWaypointSpeed "FULL";
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";			
				
				_wp = _grp addWaypoint [[_posX+500,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+400,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+300,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+200,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX+100,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-100,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-200,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-300,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-400,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-500,_posY],0];
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","driver this forceWeaponFire [""rhs_weap_fab250"", ""rhs_weap_fab250""];"];
				
				_wp = _grp addWaypoint [[_posX-10000,_posY],0];
				_wp setWaypointSpeed "FULL";
				_wp setWaypointType "MOVE";
				_wp setWaypointStatements ["true","deleteVehicle vehicle this; deleteVehicle this;"];
			};
		};	
		
		_u setCaptive true;
		
		_randSleep = floor(random 600) + 300;
		
		sleep _randSleep;		
	};
	
	sleep 60;
		
};