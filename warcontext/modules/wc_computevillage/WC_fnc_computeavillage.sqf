	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Compute a wild village !
	// -----------------------------------------------

	private [
		"_kindofhouses",
		"_size", 
		"_vehicle", 
		"_vehicles",
		"_location", 
		"_position", 
		"_isflat",
		"_dir"
	];

	_location = _this select 0;
	_kindofhouses = _this select 1;

	if(typename _location != "LOCATION") exitwith {
		hintc "computeavillage script: location parameter should be a location variable";
	};

	if(typename _kindofhouses != "ARRAY") exitwith {
		hintc "computeavillage script: kindofhouse parameter should be an array variable";
	};

	if(count _kindofhouses == 0) exitwith {
		diag_log "WARCONTEXT: NO KIND OF HOUSES WERE SETTED";
	};

	_vehicles = [];

	for "_i" from 0 to ceil(random(100)) do {
		_position = (position _location) findEmptyPosition [(5 + random 10), 400];
		if(count _position > 0) then {
			if(count(_position nearRoads 15) == 0) then {
				_isflat = _position isflatempty [5, 0, 0, 20, 0, false];  
				if (count _isflat != 0) then { 
					_vehicle = (_kindofhouses call BIS_fnc_selectRandom) createvehicle _position;
					_vehicle setdir (random 360);
					_vehicles  = _vehicles + [_vehicle];
				};
			};
		};
		sleep 0.005;
	};

	wcobjecttodelete  = wcobjecttodelete + _vehicles;
	
	diag_log "WARCONTEXT: COMPUTING A VILLAGE";