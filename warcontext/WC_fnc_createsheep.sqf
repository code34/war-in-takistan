	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// create sheeps on road
	// -----------------------------------------------

	private ["_road", "_roads", "_position", "_car", "_count", "_location", "_pos"];

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

	_road = _roads call BIS_fnc_selectRandom;

	_group = creategroup civilian;
	for "_x" from 1 to (random 8) step 1 do {
		_type = ["Sheep01_EP1", "Sheep02_EP1"] call BIS_fnc_selectRandom;
		_unit = _group createUnit [_type, position _road, [], 0, "NONE"];
		wcobjecttodelete = wcobjecttodelete + [_unit];
	};

	diag_log "WARCONTEXT: GENERATE SHEEPS ON ROAD";