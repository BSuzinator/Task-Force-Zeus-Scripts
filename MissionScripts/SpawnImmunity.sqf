_unit = _this select 0;

while {alive _unit} do {
	_unit allowDamage true;
	
	if (count(nearestObjects[position _unit, ["B_supplyCrate_F"], 100]) > 0) then {
		_unit allowDamage false;
	};
	
	sleep 10;
};