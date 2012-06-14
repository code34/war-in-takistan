	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create an antiair site at random position on map

	private [
		"_position", 
		"_mount", 
		"_vehicle", 
		"_arrayofpilot", 
		"_group", 
		"_pilot", 
		"_type"
	];

	_hill = nearestLocations [getmarkerpos "respawn_west", ["hill"], 20000];

	sleep 1;
	
	_position = (position (_hill call BIS_fnc_selectRandom)) findEmptyPosition [2, 20];

	_type = wcaavehicles call BIS_fnc_selectRandom;
	_arrayofvehicle = [_position, 0, _type, resistance] call BIS_fnc_spawnVehicle;

	_vehicle 	= _arrayofvehicle select 0;
	_arrayofpilot 	= _arrayofvehicle select 1;
	_group 		= _arrayofvehicle select 2;	

	_pilot = driver _vehicle;

	wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	while { alive _pilot } do {
		_enemys = nearestObjects[_pilot, ["Air"], 2000];
		{	
			if(random 1 > 0.8) then {		
				if(side _x == west) then {
					_pilot dofire _x;
					_pilot reveal _x;
				};
			};
		}foreach _enemys;
		sleep 30;
	};



	