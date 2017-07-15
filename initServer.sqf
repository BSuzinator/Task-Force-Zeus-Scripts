
["Initialize"] call BIS_fnc_dynamicGroups;							//Dynamic Groups
null = [] execVM "MissionScripts\cleanup.sqf";						//Wreck Clean-up
//null = [] execVM "MissionScripts\cleanupExplosives.sqf";			//Unused
//null = [] execVM "MissionScripts\fogKiller.sqf";					//Unused
null = [] execVM "MissionScripts\link_zeus.sqf";					//Access placed items in Zeus
null = [] execVM "MissionScripts\give_score.sqf";					//Unused
