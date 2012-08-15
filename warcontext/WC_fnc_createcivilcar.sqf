	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  create civils car in a location
	// + Rework of PDB function FlashpointChernarus107 - thomsonb 

	private [
		"_car", 
		"_count", 
		"_location", 
		"_max",
		"_pos",
		"_position", 
		"_roads"
		];

	_location = _this select 0;
	_position = [_location] call WC_fnc_relocatelocation;	

	WC_fnc_PDB = {
		_pos = _this select 0;
		_bearing = _this select 1;
		_distance = _this select 2;
		[ (_pos select 0) + (_distance*(sin _bearing)) ,(_pos select 1)+(_distance*(cos _bearing))];
	};

	_roads = _position nearRoads 400;
	{
		if!((count (roadsConnectedTo _x) > 1) and (count (nearestObjects [_x,["house"], 20]) > 0))then{
			_roads = _roads - [_x];
		};
	}forEach _roads;

	_max = random wcwithcivilcar;
	_count = 0;
	{
		if(_count < _max) then {
			if(position _x distance getmarkerpos "respawn_west" > 1000) then {
				if(random 1 > 0.9) then {
					_dir = getdir _x;
					_pos = [getpos _x, _dir + 90, ceil(random 3)] call WC_fnc_PDB;
					_car = (wcvehicleslistC call BIS_fnc_selectRandom) createvehicle _pos;
					_car setpos [(position _car select 0), (position _car select 1), 1];
					_car setdir _dir;

					_name = format["mrkcivilcar%1", wccivilcarindex];
					wccivilcarindex = wccivilcarindex + 1;
					_marker = [_name, 0.5, position _car, 'ColorBlack', 'ICON', 'FDIAGONAL', 'dot', 0, "", false] call WC_fnc_createmarkerlocal;
					wcambiantmarker = wcambiantmarker + [_marker];

					diag_log format["WARCONTEXT: GENERATE %1 CIVIL CAR", typeof _car];

					// simulation mode
					if(wckindofgame == 2) then {
						_car setfuel (random 1);
						_car setdamage (random 1);
					};

					if(random 1> 0.95) then {
						_car setVectorUp [1, 0, 0];
						_car setdamage (random 1);
					};

					if(random 1 > 0.95) then {
						wcgarbage = [_car] spawn WC_fnc_nastyvehicleevent;
					};
					wcvehicles = wcvehicles + [_car];
					_count = _count + 1;
				};
			};
		};
	}foreach _roads;