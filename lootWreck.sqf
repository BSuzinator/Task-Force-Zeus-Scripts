/*
Description:
Randomizes a time to search a wreck for specified items.
In the init.sqf file, place the following line: called = 0;

Place the following line in an oject's init feild to add the search function:
this addAction ["Search the Wreck", "search.sqf"]
*/
_rnd = random 100; //Generates a random number between 0 and 100

_chance = _rnd / 100; // Takes that number and converts it to a percent

if (_chance < .1) then {_chance = _chance + .3;}; // If number is lower than 10%, adds 30% to it.

_searchTime = 300; // Sets maximun time for search.

_searchTime = _searchTime * _chance; // Multiplies the max time by the chance, reducing overall time.


// Sets the conditions
_called = called
_obj = s1;
_failed = 0; 
_unit = player;
_started = getPosASL _unit;
titleText["Stay still to search the wreck.","PLAIN"]; //Warns Player to stay still to search

//Spawns box loot will go into
if (_called == 0)then {
	_bdir = getdir player;
	_bpos = getposATL player;
	_bpos = [(_bpos select 0)+1*sin(_bdir),(_bpos select 1)+1*cos(_bdir), (_bpos select 2)];
	lootBox = "Land_PlasticCase_01_medium_F" createVehicle _bpos;
	lootBox setDir _bdir;
	lootBox setposATL _bpos;
	//clears out box's original inventory 
	clearWeaponCargo lootBox;
	clearMagazineCargo lootBox;
	clearItemCargo lootBox;
	clearBackpackCargo lootBox;
	called = _called + 1;
};

//Checks for movement


	

	//Displays how long player has been searching.
	for "_i" from 1 to _searchTime do {
		hintSilent format ["You have been searching for %1 seconds", _i ];
		
		if(_unit distance2D _started > 2 || speed _unit > 11) exitWith{_failed = 1}; //Exits search if plaayer moves more than 2 meters or moves faster than 11 km/h
		
		sleep 1; //Waits 1 second until next time display
	};

	//Handles the end of search
	if (_failed == 1) then {
		hintSilent format ["You have moved away from the wreck."]} 
//Use the following area to add object that the unit wil find
	else {
		/*
		To Add more items or times to search, copy the first set, 
		then change the number in the "_called == 1" line to the next sequential number.
		add in the items following the "{" 
		then add in the items to the hint below.
		*/
		
		if (_called == 1)then {
			lootBox addBackpack "tf_rt1523g_black";
			lootBox addBackpack "B_TacticalPack_rgr";
			lootBox addBackpack "B_TacticalPack_rgr";
			hintSilent "You have found some Backpacks and a Radio!";
			called = _called + 1;
		};
		if (_called == 2) then {
			lootBox addItem FirstAidKit;
			lootBox addItem FirstAidKit;
			lootBox addItem FirstAidKit;
			lootBox addItem FirstAidKit;
			lootBox addItem FirstAidKit;
			lootBox addItem FirstAidKit;
			lootBox addItem Medikit;
			lootBox addItem Medikit;
			hintSilent "You have found some Medical Supplies!";
			called = _called + 1;
		};
		if (_called == 3) then {
			lootBox addItem "100Rnd_65x39_caseless_mag";
			lootBox addItem "100Rnd_65x39_caseless_mag";
			lootBox addItem "100Rnd_65x39_caseless_mag";
			lootBox addItem "100Rnd_65x39_caseless_mag";
			lootBox addItem "arifle_MX_SW_F";
			 hintSilent "You have found a Weapon and some Ammo!";
			called = _called + 1;
		};
		*/
		if (_called == 4) then {
			 hintSilent "You have found a Data Terminal!";
			_bpos = getposATL player;
			dt = "Land_DataTerminal_01_F" createVehicle _bpos;
			dt addAction ["<t color='#FF0000'>Activate</t>", "dataConfirm.sqf"] call BIS_fnc_MP;
			called = _called + 1;
		};
		//End search ability
		if (_called > 4) then {
			 hintSilent "There is no more to be found in the wreck.";
			 titleText ["There is no more to be found in the wreck", "PLAIN"];
			called = _called + 1;
			//_obj removeAllActions; 
		};
	};
/*
Extra Box Choices:
Land_PlasticCase_01_small_F
Land_PlasticCase_01_medium_F
Land_PlasticCase_01_large_F
Land_MetalCase_01_small_F
Land_MetalCase_01_medium_F
Land_MetalCase_01_large_F
*/
