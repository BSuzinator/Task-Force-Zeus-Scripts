if (!isServer) exitWith {};

while {true} do {
	sleep 900;
	
	_clear = nearestObjects[base_cleanup,["weaponholder"],200];
	for "_i" from 0 to count _clear - 1 do {
		deleteVehicle (_clear select _i);		
	};	
	
	_clear = base_cleanup nearObjects ["ACE_Wheel",200];
	for "_i" from 0 to count _clear - 1 do {
		deleteVehicle (_clear select _i);		
	};	
	
	_clear = base_cleanup nearObjects ["ACE_Track",200];
	for "_i" from 0 to count _clear - 1 do {
		deleteVehicle (_clear select _i);		
	};	
	
	_clear = base_cleanup nearObjects ["ACE_SandbagObject",200];
	for "_i" from 0 to count _clear - 1 do {
		deleteVehicle (_clear select _i);		
	};	
		
	{
		if (_x distance base_cleanup <= 2000)  then {
			deleteVehicle _x;
		};
	} forEach allDead;
			
	{deleteVehicle _x;} forEach (allMissionObjects "CraterLong");
	
	{
		if (count units _x == 0) then {
			deleteGroup _x;
		};
	} forEach allGroups;
};