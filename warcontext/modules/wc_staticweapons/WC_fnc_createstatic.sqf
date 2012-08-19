	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Createstatic in houses
	// -----------------------------------------------
	
	private [
		"_arrayofpos", 
		"_buildings", 
		"_location", 
		"_position", 
		"_index", 
		"_vehicle", 
		"_staticclass", 
		"_static", 
		"_ammobox", 
		"_count"
	];

	_position = _this select 0;

	_buildings = nearestObjects [_position, ["House"], 350];
	_arrayofpos = [];
	{
		if(getdammage _x < 0.4) then {
			_index = 0;
			while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
				_position = _x buildingPos _index;
				if (_position select 2 > 1) then {
					_arrayofpos = _arrayofpos + [_position];
				};
				_index = _index + 1;
				sleep 0.05;
			};
		};
	}foreach _buildings;

	_count = 0;
	_staticclass = ["AGS_TK_INS_EP1", "KORD_TK_EP1", "DSHkM_Mini_TriPod_TK_INS_EP1", "DSHKM_TK_GUE_EP1", "KORD_high_TK_EP1", "Metis_TK_EP1", "SPG9_TK_INS_EP1"];
	{
		if(random 1 > 0.95) then {
			_static = _staticclass call BIS_fnc_selectRandom;
			_vehicle = _static createVehicle _x;
			_vehicle setposatl _x;
			wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;

			if((position _vehicle) select 2 < 0.4) then {
				deletevehicle _vehicle;
			} else {
				wcvehicles = wcvehicles + [_vehicle];
				_count = _count + 1;
			};
		};
	}foreach _arrayofpos;

	diag_log format["WARCONTEXT: GENERATE %1 STATICS", _count];

	