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
		if(count _position > 0) then {
			if(count(_position nearRoads 15) == 0) then {
				_isflat = _position isflatempty [5, 0, 0.3, 20, 0, false];  
				if (count _isflat != 0) then { 
					_vehicle = (wcvillagehouses call BIS_fnc_selectRandom) createvehicle _position;
					_vehicle setdir (random 360);
					_vehicles  = _vehicles + [_vehicle];
				};
			};
		};
		sleep 0.005;
	};

	wcobjecttodelete  = wcobjecttodelete + _vehicles;
	
	diag_log "WARCONTEXT: COMPUTING A VILLAGE";