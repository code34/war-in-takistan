	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
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

	_roads = _position nearRoads 400;
	{
		if!((count (roadsConnectedTo _x) > 1) and (count (nearestObjects [_x,["house"], 20]) > 0))then{
			_roads = _roads - [_x];
		};
	}forEach _roads;

	if(count _roads == 0) exitwith {};

	_active = createTrigger["EmptyDetector", _position];
	_active setTriggerArea[1000, 1000, 0, false];
	_active setTriggerActivation["WEST", "PRESENT", TRUE];
	_active setTriggerStatements["", "", ""];

	_group = creategroup civilian;
	for "_x" from 1 to (random 4) step 1 do {
		_road = _roads call BIS_fnc_selectRandom;

		if(random 1 > 0.1) then {
			_position = ((selectBestPlaces [position _road, 100, "hills",1,10] select 0) select 0);
		} else {
			_position = position _road;
		};


		for "_x" from 1 to (random 30) step 1 do {
			_type = wcsheeps call BIS_fnc_selectRandom;
			_back = _back + [[_type, _position]];
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
				_civil = _group createUnit [_civiltype, (_x select 1), [], 5, "NONE"];
				_civil setspeedmode "limited";
				_civil setbehaviour "safe";
				_civil allowFleeing random (0.8);
				_civil stop true;
				_civil setdir (random 360);
				_civil setvariable ["wcprotected", true, false];
				_civil setvariable ["civilrole", "animal", true];
			}foreach _back;
			_allunits = units _group;
			_back = [];
		};
		sleep 5;
	};

	diag_log "WARCONTEXT: GENERATE SHEEPS ON ROAD";