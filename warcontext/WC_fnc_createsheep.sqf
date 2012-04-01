	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// create sheeps on road
	// -----------------------------------------------

	private [
		"_active",
		"_back",
		"_civil",
		"_civiltype",
		"_road", 
		"_roads", 
		"_position", 
		"_car", 
		"_count", 
		"_location", 
		"_pos",
		"_type"
	];

	_position = _this select 0;
	_back = [];

	_active = createTrigger["EmptyDetector", _position];
	_active setTriggerArea[1000, 1000, 0, false];
	_active setTriggerActivation["WEST", "PRESENT", TRUE];
	_active setTriggerStatements["", "", ""];

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

	_group = creategroup civilian;

	for "_x" from 1 to (random 4) step 1 do {
		_road = _roads call BIS_fnc_selectRandom;
		for "_x" from 1 to (random 30) step 1 do {
			_type = ["Sheep01_EP1", "Sheep02_EP1"] call BIS_fnc_selectRandom;
			_back = _back + [[_type, position _road]];
		};
	};

	while { true } do {
		// restore civils
		if(west countside list _active == 0) then {
			{
				_back = _back + [[typeof _x, position _x]];
				_x removeAllEventHandlers "Killed";
				_x setdammage 1;
				deletevehicle _x;
			}foreach (units _group);
			waituntil {(west countside list _active > 0)};
			_group = creategroup civilian;
			{
				_civiltype = _x select 0;
				_civil = _group createUnit [_civiltype, (_x select 1), [], 0, "FORM"];
				_civil setspeedmode "limited";
				_civil setbehaviour "safe";
				_civil allowFleeing random (0.8);
				dostop _civil;
				_civil setdir (random 360);
				_civil setvariable ["wcprotected", true, false];
			}foreach _back;
			_allunits = units _group;
			_back = [];
		};
		sleep 5;
	};

	diag_log "WARCONTEXT: GENERATE SHEEPS ON ROAD";