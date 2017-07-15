_mortarList = _this select 0;

while {true} do {	
	
	_targetList = [];
	
	{
		if (((east knowsAbout _x) >= 1.5) and (_x distance (getMarkerPos "respawn_west") > 1000)) then {
			_targetList pushBack _x;
		};
	} forEach allPlayers;
	
	if (count _targetList > 0) then {		
	
		_randTarget = selectRandom _targetList;
		_loc = getPosWorld _randTarget;
		
		
		sleep 120;
		
		{			
			_artLocX = (_loc select 0) + 50 - floor(random 100);
			_artLocY = (_loc select 1) + 50 - floor(random 100);
			_x doArtilleryFire [[_artLocX,_artLocY],"8Rnd_82mm_Mo_shells",1];		
		} forEach _mortarList;
		
		sleep 2;
		
		{			
			_artLocX = (_loc select 0) + 50 - floor(random 100);
			_artLocY = (_loc select 1) + 50 - floor(random 100);
			_x doArtilleryFire [[_artLocX,_artLocY],"8Rnd_82mm_Mo_shells",1];
		} forEach _mortarList;
		
		sleep 2;
		
		{			
			_artLocX = (_loc select 0) + 50 - floor(random 100);
			_artLocY = (_loc select 1) + 50 - floor(random 100);
			_x doArtilleryFire [[_artLocX,_artLocY],"8Rnd_82mm_Mo_shells",1];	
		} forEach _mortarList;
		
		sleep 2;
		
		{			
			_artLocX = (_loc select 0) + 50 - floor(random 100);
			_artLocY = (_loc select 1) + 50 - floor(random 100);
			_x doArtilleryFire [[_artLocX,_artLocY],"8Rnd_82mm_Mo_shells",1];		
		} forEach _mortarList;
		
		_randSleep = floor(random 600) + 300;
		
		sleep _randSleep;
	};
	
	sleep 60;
};