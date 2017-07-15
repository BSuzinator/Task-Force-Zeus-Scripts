/*
Animates the Data Terminal and creates the updated positions on map
*/
	dt removeAllActions;
	_i = 1;
	dt = _this select 0;
	
	[dt,3] call BIS_fnc_dataTerminalAnimate;
		for "_i" from 1 to 60 do {
		playSound3D ["A3\Sounds_F\sfx\alarm_3.wss", dt, false, getPosASL dt, 10, 1, 25] call BIS_fnc_MP;
		//playSound3D ["A3\Sounds_F\sfx\blip1.wav", oVehicleObject, false, getPos oVehicleObject, 9, 1.1, 50];
		sleep 2; //Waits 1 second until next time display
	};
	hint "this works";	
//create a marker around the data terminal
_markerstr = createMarker ["markername", dt];
_markerstr setMarkerShape "Ellipse";
_markerstr setMarkerSize [150,150];
