	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// Compute a wild village !
	// -----------------------------------------------

	private [
		"_size", 
		"_vehicle", 
		"_vehicles",
		"_location", 
		"_position", 
		"_isflat",
		"_dir"
	];

	_location = _this select 0;
	_vehicles = [];

	for "_i" from 0 to ceil(random(100)) do {
		_position = (position _location) findEmptyPosition [(5 + random 10), 400];
		if(count(_position nearRoads 15) == 0) then {
			_isflat = _position isflatempty [5, 0, 0.3, 20, 0, false];  
			if (count _isflat != 0) then { 
				_vehicle = (["Land_House_C_5_V3_EP1", "Land_House_C_5_EP1", "Land_House_L_8_EP1", "Land_House_K_3_EP1", "Land_House_C_5_V1_EP1", "Land_A_Mosque_small_2_EP1", "Land_Wall_L_Mosque_1_EP1", "Land_A_Mosque_small_1_EP1", "Land_House_L_7_EP1", "Land_House_K_5_EP1", "Land_House_K_1_EP1", "Land_House_L_6_EP1", "Land_House_L_9_EP1", "Land_House_L_4_EP1", "Land_House_L_3_EP1", "Land_Wall_L3_5m_EP1"] call BIS_fnc_selectRandom) createvehicle _position;
				_vehicle setdir (random 360);
				_vehicles  = _vehicles + [_vehicle];
			};
		};
		//else {
		//	_vehicle = "Land_bags_EP1" createvehicle _position;
		//	_vehicle setdir (random 360);
		//};
		sleep 0.005;
	};

	wcobjecttodelete  = wcobjecttodelete + _vehicles;
	
	diag_log "WARCONTEXT: COMPUTING A VILLAGE";