// admin_uid.sqf
waitUntil {(getPlayerUID player) != ""};

_uid = getPlayerUID player;

switch(_uid)do
{
	case "76561198080019809": // BSuz
 	{
	player addAction ["<t color='#FF0000'>Admin Spectate</t>", "scripts\spectator\specta.sqf", [], -99, false];
 	};
	 		
default
  {
 	};
};