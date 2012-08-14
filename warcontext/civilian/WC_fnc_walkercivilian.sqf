	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - walker civilian

	private [
		"_allunits",
		"_buildings",
		"_civil",
		"_index",
		"_group",
		"_position",
		"_positions"
	];

	_allunits = [];
	_positions = [];

	_group = _this select 0;

	_group setcombatmode "RED";
	_group allowfleeing 0;
	_group setspeedmode "limited";

	{
		_x setbehaviour "safe";
		_x allowFleeing 0;
		_x setvariable ["lastpos", position _x, false];
		_x setvariable ["destination", position _x, false];
		_x setvariable ["moveretry", 0, false];
		_x setunitpos "UP";
	} foreach (units _group);
	
	_position = position (leader _group);
	_buildings = nearestObjects[_position,["Building"], 500];
	sleep 1;

	{
		_index = 0;
		while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
			_position = _x buildingPos _index;
			_positions = _positions + [_position];
			_index = _index + 1;
		};
	}foreach _buildings;

	while { count (units _group) > 0 } do {
		if(count _allunits == 0) then {
			_allunits = units _group;
		};

		_civil = _allunits select 0;
		_allunits = _allunits - [_civil];

		// exclude all non civilian
		if (_civil getvariable "civilrole" == "civil") then {
			if(position _civil distance (_civil getvariable "destination") < 8) then {
				_position = _positions call BIS_fnc_selectRandom;
				_civil setvariable ["destination", _position, false];
				_civil stop false;
				_civil domove _position;
				_civil setvariable ["moveretry", 0, false];
			} else {
				_civil stop false;
				_civil domove (_civil getvariable "destination");
			};
		
			if(format["%1", _civil getvariable "lastpos"] == format["%1", position _civil]) then {
				_civil setvariable ["moveretry", (_civil getvariable "moveretry") + 1, false];
			};
		
			_civil setvariable ["lastpos", position _civil, false];
		
			if(_civil getvariable "moveretry" > 3) then {
				_position = _positions call BIS_fnc_selectRandom;
				_civil stop false;
				_civil setvariable ["destination", _position, false];
				_civil domove _position;
				_civil setvariable ["moveretry", 0, false];
			};
			sleep 5;
		};
	};
