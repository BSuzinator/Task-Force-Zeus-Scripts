// Restrict vehicle crews

if (!isServer) exitWith {};

_unit = _this select 0;

switch (typeOf _unit) do {

	case "rhsusf_M977A4_REPAIR_BKIT_usarmy_wd" : {
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if ((typeof (_this select 2) != "B_Pilot_F") and (typeof (_this select 2) != "B_Helipilot_F")) then {				
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};
	
	case "rhsusf_M978A4_usarmy_wd" : {
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if ((typeof (_this select 2) != "B_Pilot_F") and (typeof (_this select 2) != "B_Helipilot_F")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};
	
	case "rhsusf_M977A4_AMMO_BKIT_usarmy_wd" : {
		_unit addEventHandler ["GetIn",
		{		
			if (typeof (_this select 2) != "B_officer_F") then {
				if ((typeof (_this select 2) != "B_Pilot_F") and (typeof (_this select 2) != "B_Helipilot_F")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};

	//case "rhs_l159_cdf_b_CDF_plamen" : {
	//	_unit addEventHandler ["GetIn",
	//	{			
	//		if (typeof (_this select 2) != "B_officer_F") then {
	//			if ((typeof (_this select 2) != "B_Pilot_F") or ((typeof (_this select 2) == "B_Pilot_F") and ((rank (_this select 2)) != "CORPORAL"))) then {
	//				(_this select 2) action ["getout", _this select 0];				
	//			};
	//		} else {
	//			if (rank (_this select 2) != "CAPTAIN") then {
	//				(_this select 2) action ["getout", _this select 0];
	//			};
	//		};
	//	}];
	//};	
	case "RHS_A10_AT" : {
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if ((typeof (_this select 2) != "B_Pilot_F") or ((typeof (_this select 2) == "B_Pilot_F") and ((rank (_this select 2)) != "CORPORAL"))) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};
	
	//case "CUP_B_C130J_USMC" : {
	//	_unit addEventHandler ["GetIn",
	//	{			
	//		if (typeof (_this select 2) != "B_officer_F") then {
	//			if (((typeof (_this select 2) != "B_Pilot_F") and ((_this select 1) != "cargo")) or ((typeof (_this select 2) == "B_Pilot_F") and ((rank (_this select 2)) != "PRIVATE") and ((_this select 1) != "cargo"))) then {
	//				(_this select 2) action ["getout", _this select 0];				
	//			};
	//		} else {
	//			if (rank (_this select 2) != "CAPTAIN") then {
	//				(_this select 2) action ["getout", _this select 0];
	//			};
	//		};
	//	}];
	//	_unit addEventHandler ["SeatSwitched",
	//	{	
	//		if (typeof (_this select 2) != "B_officer_F") then {
	//			if ((typeof (_this select 2) != "B_Pilot_F") or ((typeof (_this select 2) == "B_Pilot_F") and ((rank (_this select 2)) != "PRIVATE"))) then {
	//				_crew = _this select 1;
	//				if (assignedVehicleRole _crew select 0 != "Cargo") then {
	//					_crew action ["getout", _this select 0];		
	//				};
	//			};
	//			
	//			if ((typeof (_this select 2) != "B_Pilot_F") or ((typeof (_this select 2) == "B_Pilot_F") and ((rank (_this select 2)) != "PRIVATE"))) then {
	//				_crew = _this select 2;
	//				if (assignedVehicleRole _crew select 0 != "Cargo") then {
	//					_crew action ["getout", _this select 0];		
	//				};
	//			};
	//		} else {
	//			if (rank (_this select 2) != "CAPTAIN") then {
	//				_crew = _this select 1;
	//				if (assignedVehicleRole _crew select 0 != "Cargo") then {
	//					_crew action ["getout", _this select 0];		
	//				};
	//				
	//				_crew = _this select 2;
	//				if (assignedVehicleRole _crew select 0 != "Cargo") then {
	//					_crew action ["getout", _this select 0];		
	//				};
	//			};
	//		};
	//	}];	
	//};		
		
	case "RHS_CH_47F" : {
		_unit enableCoPilot false;
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if (((typeof (_this select 2) != "B_Helipilot_F") or ((typeof (_this select 2) == "B_Helipilot_F") and ((rank (_this select 2)) != "PRIVATE"))) and ((_this select 1) == "driver")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};	
	
	case "RHS_UH60M" : {
		_unit enableCoPilot false;
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if (((typeof (_this select 2) != "B_Helipilot_F") or ((typeof (_this select 2) == "B_Helipilot_F") and ((rank (_this select 2)) != "PRIVATE"))) and ((_this select 1) == "driver")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};
	case "RHS_MELB_MH6M" : {
		_unit enableCoPilot false;
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if (((typeof (_this select 2) != "B_Helipilot_F") or ((typeof (_this select 2) == "B_Helipilot_F") and ((rank (_this select 2)) != "PRIVATE"))) and ((_this select 1) == "driver")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};
	
	case "B_Heli_Light_01_F" : {
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if (((typeof (_this select 2) != "B_Helipilot_F") or ((typeof (_this select 2) == "B_Helipilot_F") and ((rank (_this select 2)) != "PRIVATE"))) and ((_this select 1) != "cargo")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};	
	
	case "rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd" : {		
		_unit addEventHandler ["GetIn",
		{		
			if (typeof (_this select 2) != "B_officer_F") then {
				if ((typeof (_this select 2) != "B_soldier_repair_F") and ((_this select 1) != "cargo")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
		_unit addEventHandler ["SeatSwitched",
		{	
			if (typeof (_this select 2) != "B_officer_F") then {
				if (typeof (_this select 2) != "B_soldier_repair_F") then {
					_crew = _this select 1;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
				
				if (typeof (_this select 2) != "B_soldier_repair_F") then {
					_crew = _this select 2;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					_crew = _this select 1;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
					
					_crew = _this select 2;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
			};
		}];
	};
	
	case "rhsusf_M978A4_BKIT_usarmy_wd" : {		
		_unit addEventHandler ["GetIn",
		{		
			if (typeof (_this select 2) != "B_officer_F") then {
				if ((typeof (_this select 2) != "B_soldier_repair_F") and ((_this select 1) != "cargo")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
		_unit addEventHandler ["SeatSwitched",
		{	
			if (typeof (_this select 2) != "B_officer_F") then {
				if (typeof (_this select 2) != "B_soldier_repair_F") then {
					_crew = _this select 1;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
				
				if (typeof (_this select 2) != "B_soldier_repair_F") then {
					_crew = _this select 2;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					_crew = _this select 1;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
					
					_crew = _this select 2;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
			};
		}];	
	};
	
	case "rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd" : {		
		_unit addEventHandler ["GetIn",
		{		
			if (typeof (_this select 2) != "B_officer_F") then {
				if ((typeof (_this select 2) != "B_soldier_repair_F") and ((_this select 1) != "cargo")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
		_unit addEventHandler ["SeatSwitched",
		{	
			if (typeof (_this select 2) != "B_officer_F") then {
				if (typeof (_this select 2) != "B_soldier_repair_F") then {
					_crew = _this select 1;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
				
				if (typeof (_this select 2) != "B_soldier_repair_F") then {
					_crew = _this select 2;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					_crew = _this select 1;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
					
					_crew = _this select 2;
					if (assignedVehicleRole _crew select 0 != "Cargo") then {
						_crew action ["getout", _this select 0];		
					};
				};
			};
		}];	
	};
		
	case "RHS_MELB_AH6M_H" : {
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if (((typeof (_this select 2) != "B_Helipilot_F") or ((typeof (_this select 2) == "B_Helipilot_F") and ((rank (_this select 2)) != "CORPORAL"))) and ((_this select 1) == "driver")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
				if (((typeof (_this select 2) != "B_helicrew_F") or ((typeof (_this select 2) == "B_helicrew_F") and ((rank (_this select 2)) != "CORPORAL"))) and ((_this select 1) == "gunner")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};	
	case "RHS_AH64D_wd" : {
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if (((typeof (_this select 2) != "B_Helipilot_F") or ((typeof (_this select 2) == "B_Helipilot_F") and ((rank (_this select 2)) != "CORPORAL"))) and ((_this select 1) == "driver")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
				if (((typeof (_this select 2) != "B_helicrew_F") or ((typeof (_this select 2) == "B_helicrew_F") and ((rank (_this select 2)) != "CORPORAL"))) and ((_this select 1) == "gunner")) then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};
		}];
	};
	
	//case "CUP_B_M1129_MC_MK19_Woodland" : {
	//	_unit addEventHandler ["GetIn",
	//	{			
	//		if ((typeof (_this select 2) != "B_officer_F") and (rank (_this select 2) != "CAPTAIN")) then {
	//			if (typeof (_this select 2) != "B_Soldier_A_F") then {
	//				(_this select 2) action ["getout", _this select 0];				
	//			};
	//		};
	//	}];
	//};	
	//
	//case "CUP_B_M1129_MC_MK19_Desert" : {
	//	_unit addEventHandler ["GetIn",
	//	{		
	//		if ((typeof (_this select 2) != "B_officer_F") and (rank (_this select 2) != "CAPTAIN")) then {
	//			if (typeof (_this select 2) != "B_Soldier_A_F") then {
	//				(_this select 2) action ["getout", _this select 0];				
	//			};
	//		};
	//	}];
	//};
	
	case "B_Mortar_01_F" : {		
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {				
				if (typeof (_this select 2) != "B_Soldier_A_F") then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};			
		}];
	};
	
	//case "CUP_B_M1128_MGS_Desert_Slat" : {
	//	_unit addEventHandler ["GetIn",
	//	{			
	//		if (typeof (_this select 2) != "B_crew_F") then {
	//			(_this select 2) action ["getout", _this select 0];				
	//		};
	//	}];
	//};
	//
	//case "CUP_B_M1128_MGS_Woodland_Slat" : {
	//	_unit addEventHandler ["GetIn",
	//	{			
	//		if (typeof (_this select 2) != "B_crew_F") then {
	//			(_this select 2) action ["getout", _this select 0];				
	//		};
	//	}];
	//};
	//
	case "rhsusf_m1a1aim_tuski_wd" : {
		_unit addEventHandler ["GetIn",
		{
			if ((_this select 1) != "cargo") then {
				if (typeof (_this select 2) != "B_officer_F") then {
					if (typeof (_this select 2) != "B_crew_F") then {
						(_this select 2) action ["getout", _this select 0];				
					};
				} else {
					if (rank (_this select 2) != "CAPTAIN") then {
						(_this select 2) action ["getout", _this select 0];
					};
				};
			};			
		}];
	};
	case "rhsusf_m1a2sep1tuskiid_usarmy" : {
		_unit addEventHandler ["GetIn",
		{
			if ((_this select 1) != "cargo") then {
				if (typeof (_this select 2) != "B_officer_F") then {
					if (typeof (_this select 2) != "B_crew_F") then {
						(_this select 2) action ["getout", _this select 0];				
					};
				} else {
					if (rank (_this select 2) != "CAPTAIN") then {
						(_this select 2) action ["getout", _this select 0];
					};
				};
			};			
		}];
	};	
	case "rhsusf_mrzr4_d" : {
		_unit addEventHandler ["GetIn",
		{			
			if (typeof (_this select 2) != "B_officer_F") then {
				if (typeof (_this select 2) != "B_recon_F") then {
					(_this select 2) action ["getout", _this select 0];				
				};
			} else {
				if (rank (_this select 2) != "CAPTAIN") then {
					(_this select 2) action ["getout", _this select 0];
				};
			};					
		}];
	};	
};
