	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Rework of FlashpointChernarus107 - thomsonb
	// -----------------------------------------------

	private ["_roads", "_position", "_car", "_count", "_location", "_pos","_max"];

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
					// simulation = 2
					if(wckindofgame == 2) then {
						_car setfuel (random 1);
						_car setdamage (random 1);
					};
					if(random 1> 0.95) then {
						_car setVectorUp [1, 0, 0];
					};
					if(random 1 > 0.95) then {
						wcgarbage = [_car] spawn WC_fnc_createied;
					};
					wcvehicles = wcvehicles + [_car];
					_count = _count + 1;
				};
			};
		};
	}foreach _roads;

	diag_log format["WARCONTEXT: GENERATE %1 CIVIL CARS IN ZONE OF %2", _count, text _location];