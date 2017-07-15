_grpList = _this select 0;
_currAO = _this select 1;

_origLocList = [];
{
	_origLocList pushBack (getPos leader _x);
} forEach _grpList;

while {true} do {

	_targetList = [];
	
	{
		if (((east knowsAbout _x) >= 1.5) and (_x distance (getMarkerPos "respawn_west") > 1000) and (_x distance (getMarkerPos _currAO) < 1500)) then {
			_targetList pushBack _x;
		};
	} forEach allPlayers;
	
	if (count _targetList > 0) then {		
	
		{
		
			 while {(count (waypoints _x)) > 0} do
			{
				deleteWaypoint ((waypoints _x) select 0);
			};
		
			_randTarget = selectRandom _targetList;
			_loc = getPosWorld _randTarget;		
			
			_origPos = _origLocList select _forEachIndex;
			
			_wp1 = _x addWaypoint [_loc,50];
			_wp1 setWaypointType "MOVE";
			
			_wp2 = _x addWaypoint [_origPos,50];
			_wp2 setWaypointType "MOVE";
		} forEach _grpList;
		
		_randSleep = floor(random 600) + 300;
		
		sleep _randSleep;
	};

	sleep 60;
};