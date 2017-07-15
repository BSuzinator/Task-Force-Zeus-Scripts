if (!isServer) exitWith {};

_unit = _this select 0;

switch (typeOf _unit) do {
	case "rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd" : {
		_unit setVariable ["ace_isRepairVehicle", true, true];
	};	
	case "rhsusf_M977A4_REPAIR_BKIT_usarmy_wd" : {
		_unit setVariable ["ace_isRepairVehicle", true, true];
	};	
};

while {alive _unit} do {
	switch (typeOf _unit) do {
		case "B_Truck_01_fuel_F" : {
			_unit setFuelCargo 1;
		};	
		case "B_Truck_01_ammo_F" : {
			_unit setAmmoCargo 1;
		};	
		case "B_Truck_01_Repair_F" : {
			_unit setRepairCargo 1;
		};	
		case "B_Slingload_01_Fuel_F" : {
			_unit setFuelCargo 1;
		};	
		case "B_Slingload_01_Ammo_F" : {
			_unit setAmmoCargo 1;
		};	
		case "B_Slingload_01_Repair_F" : {
			_unit setRepairCargo 1;
		};		
		case "B_G_Van_01_fuel_F" : {
			_unit setFuelCargo 1;
		};			
		case "B_G_Offroad_01_repair_F" : {
			_unit setRepairCargo 1;
		};		
		case "B_T_Truck_01_ammo_F" : {
			_unit setAmmoCargo 1;
		};	
		case "B_T_Truck_01_fuel_F" : {
			_unit setFuelCargo 1;
		};	
		case "rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd" : {
			_unit setAmmoCargo 1;
		};	
		case "rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd" : {
			_unit setRepairCargo 1;
		};	
		case "rhsusf_M978A4_BKIT_usarmy_wd" : {
			_unit setFuelCargo 1;
		};	
		case "rhsusf_M977A4_AMMO_BKIT_usarmy_wd" : {
			_unit setAmmoCargo 1;
		};	
		case "rhsusf_M977A4_REPAIR_BKIT_usarmy_wd" : {
			_unit setRepairCargo 1;
		};	
		case "rhsusf_M978A4_usarmy_wd" : {
			_unit setFuelCargo 1;
		};	
	};
	
	[_unit, 1, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
	[_unit, 1, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
	
	sleep 60;
};