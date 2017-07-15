if (!isServer) exitWith {};

_unit = _this select 0;
_marker = createMarker[format["veh_%1",typeOf(_unit)+ str (getPos _unit select 0) + str (getPos _unit select 1)],[0,0,0]];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_dot";
_marker setMarkerText format["%1",getText(configfile >> "CfgVehicles" >> typeOf(_unit) >> "displayName")];

while {alive _unit} do {
	if (count(crew _unit) == 0) then {
		_marker setMarkerPos (getPos _unit);
		_marker setMarkerAlpha 1;
	}
	else {
		_marker setMarkerPos [0,0,0];
		_marker setMarkerAlpha 0;
	};
	
	sleep 60;
};

deleteMarker _marker;