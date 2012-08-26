	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  create civils car in a location
	// + Rework of PDB function FlashpointChernarus107 - thomsonb 

	private [
		"_car", 
		"_dir",
		"_marker",
		"_name",
		"_max",
		"_pos",
		"_position", 
		"_road",
		"_roads"
		];

	_position = _this select 0;

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

	if(count _roads == 0) exitwith {diag_log "WARCONTEXT: no roads in this village to build civil car"; };

	_max = round (random wcwithcivilcar);

	for "_x" from 1 to _max step 1 do {
		_road = (_roads call BIS_fnc_selectRandom);
		_dir = getdir _road;
		_pos = [getpos _road, _dir + 90, ceil(random 3)] call WC_fnc_PDB;
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
	};