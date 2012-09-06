	// -----------------------------------------------
	// Author:   code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create an antiair site at random position on map

	private [
		"_check",
		"_count",
		"_exit",
		"_echo",
		"_position", 
		"_marker", 
		"_vehicle", 
		"_arrayofpilot", 
		"_group", 
		"_gunner", 
		"_type"
	];

	_hill = nearestLocations [wcmapcenter, ["hill"], 20000];

	if(count _hill < (wcaalevel + 1)) exitwith {
		diag_log "WARCONTEXT: Not enough hill on this map to build AA SITE";
	};

	sleep 1;
	
	_check = false;
	_count = 0;
	_exit = false;

	while { !_check } do {
		_check = true;
		_position = (position (_hill call BIS_fnc_selectRandom)) findEmptyPosition [2, 20];

		{
			if(_position distance _x < 100) then {
				_check = false;
			};
		}foreach wcallaaposition;
		_count = _count + 1;
		if(_count > 10) then {_exit = true; _check = true;}; 
		sleep 0.1;
	};

	if(_exit) exitwith { 
		diag_log "WARCONTEXT: hill are too near on this map to build AA SITE";
	};

	wcallaaposition = wcallposition + [_position];

	if(count _position == 0) exitwith {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR AA SITE";
	};

	_type = wcaavehicles call BIS_fnc_selectRandom;
	_arrayofvehicle = [_position, 0, _type, east] call BIS_fnc_spawnVehicle;

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
			if((getposatl _echo) select 2 > 50) then {		
				if(side ((crew _echo) select 0) == west) then {
					{
						_x dotarget _echo;
						_x dofire _echo;
						_x reveal _echo;
					} foreach (crew _vehicle);
				};
			};
		};
		sleep 10;
	};

	deletemarker _marker;