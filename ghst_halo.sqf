_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_params = _this select 3;
_typehalo = _params select 1;//true for all group, false for player only.

if (not alive _host) exitwith {
hint "Halo Not Available"; 
_host removeaction _id;
};

_caller groupchat "Left click on the map where you want to insert";

openMap true;

mapclick = false;

onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

waituntil {mapclick or !(visiblemap)};
if (!visibleMap) exitwith {
	_caller groupchat "Im too scared to jump";
	};
_pos = clickpos;

[_caller,1500] spawn bis_fnc_halo;

_caller setpos _pos;

sleep 1;

openMap false;

sleep 5;

_caller groupchat "Have a nice trip and dont forget to open your chute!";

//auto open before impact
waituntil {(position _caller select 2) <= 50};

if ((vehicle _caller) iskindof "ParachuteBase") exitwith {};

_caller groupchat "Deploying Chute";

[_caller] spawn bis_fnc_halo;