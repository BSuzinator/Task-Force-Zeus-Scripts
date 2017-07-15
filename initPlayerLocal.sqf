waitUntil {!isNull player};
player execVM "scripts\fn_statusBar.sqf";										//Status Bar
[player] execVM "MissionScripts\player_init.sqf";								//Unsused Scripts
_null = [] execVM "scripts\admin_uid.sqf";										// MP spectator
[] execVM "QS_icons.sqf";														//Group Markers
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;						//Dynamic Groups