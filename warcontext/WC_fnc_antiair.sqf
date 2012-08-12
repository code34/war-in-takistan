	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create an antiair site at random position on map

	private [
		"_echo",
		"_position", 
		"_marker", 
		"_vehicle", 
		"_arrayofpilot", 
		"_group", 
		"_gunner", 
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

	wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	_gunner = gunner _vehicle;

	if(wcwithaamarkers == 1) then {
		_marker = [format['antiair%1', wcaaindex], 0.5, position _gunner, 'ColorRED', 'ICON', 'FDIAGONAL', 'mil_triangle', 0, 'AA site', false] call WC_fnc_createmarker;
		wcaaindex = wcaaindex + 1;
	};

	while { (damage _vehicle) < 0.9 } do {
		_enemys = nearestObjects[_gunner, ["Air"], 3000];
		if (count _enemys > 0) then {
			_echo = _enemys call BIS_fnc_selectRandom;
		};
		if((getposatl _echo) select 2 > 50) then {		
			if(side ((crew _echo) select 0) == west) then {
				{
					_x dotarget _echo;
					_x dofire _echo;
					_x reveal _echo;
				} foreach (crew _vehicle);
			};
		};
		sleep 30;
	};

	deletemarker _marker;