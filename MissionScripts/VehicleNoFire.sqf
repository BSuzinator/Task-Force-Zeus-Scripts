if (!isServer) exitWith {};

_unit = _this select 0;

_unit addEventHandler ["Fired", {
	if ({(_this select 0) distance getMarkerPos (_x select 0) < _x select 1} count [["fob", 200]] > 0) then
	{
		deleteVehicle (_this select 6);
		titleText ["Firing weapons and placing / throwing explosives at base is STRICTLY PROHIBITED!", "PLAIN", 3];
	};
}];