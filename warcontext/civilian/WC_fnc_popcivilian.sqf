	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - pop civilian (replace BIS MODULE)
	// -----------------------------------------------

	
	private [
		"_buildings", 
		"_number", 
		"_civil", 
		"_civiltype", 
		"_group", 
		"_marker", 
		"_size", 
		"_name", 
		"_allunits", 
		"_position", 
		"_positions", 
		"_index", 
		"_active", 
		"_back",
		"_count",
		"_location"
	];

	_location = (_this select 0);
	_position = position (_this select 0);


	_positions = [];
	_allunits = [];
	_back = [];

	_name = format["civiltown%1", wcciviltownindex];
	wcciviltownindex  = wcciviltownindex + 1;
	_marker = [_name, 500, _position, 'ColorBLACK', 'ELLIPSE', 'FDIAGONAL', 'EMPTY', 0, '', false] call WC_fnc_createmarkerlocal;

	_active = createTrigger["EmptyDetector", _position];
	_active setTriggerArea[1000, 1000, 0, false];
	_active setTriggerActivation["WEST", "PRESENT", TRUE];
	_active setTriggerStatements["", "", ""];

	_count = count (nearestObjects [_position, ["House"] , 150]);
	while { _count < 4 } do {
		_count = count (nearestObjects [_position, ["House"] , 150]);
		sleep 1;
	};

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

	_number = random wcwithcivilian;
	_group = creategroup civilian;
	for "_x" from 0 to _number do {
		_civiltype = wccivilclass call BIS_fnc_selectRandom;
		_position = _positions call BIS_fnc_selectRandom;
		_back = _back + [[_civiltype, _position]];

	};

	while { _count > 4 } do {
		if(count _allunits < 1) then {
			_allunits = units _group;
		};

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
				//_position = [_marker, "onground", "onflat"] call WC_fnc_createpositioninmarker;
				_position = _positions call BIS_fnc_selectRandom;
				_civil setvariable ["destination", _position, false];
				_civil setvariable ["wcprotected", true, false];
				wccivilianstoinit = wccivilianstoinit + [_civil];
			}foreach _back;
			_allunits = units _group;
			_back = [];
		};

		_group setCombatMode "RED";
		_civil = _allunits select 0;
		_allunits = _allunits - [_civil];

		_civil setspeedmode "limited";
		_civil setbehaviour "safe";
		_civil allowFleeing 0;

		if(position _civil distance (_civil getvariable "destination") < 8) then {
			_position = _positions call BIS_fnc_selectRandom;
			_civil setvariable ["destination", _position, false];
			_civil domove _position;
			_civil setvariable ["moveretry", 0, false];
		} else {
			_civil domove (_civil getvariable "destination");
		};

		if(format["%1", _civil getvariable "lastpos"] == format["%1", position _civil]) then {
			_civil setvariable ["moveretry", (_civil getvariable "moveretry") + 1, false];
		};

		_civil setvariable ["lastpos", position _civil, false];

		if(_civil getvariable "moveretry" > 3) then {
			_position = _positions call BIS_fnc_selectRandom;
			_civil setvariable ["destination", _position, false];
			_civil domove _position;
			_civil setvariable ["moveretry", 0, false];
		};

		_count = count (nearestObjects [_position, ["House"] , 150]);
		sleep 5;
	};

	{
		_x removeAllEventHandlers "Killed";
		_x setdammage 1;
		deletevehicle _x;
	}foreach (units _group);

	deletevehicle _active;

