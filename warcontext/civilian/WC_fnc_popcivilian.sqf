	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - pop civilian (replace BIS MODULE)
	// -----------------------------------------------

	
	private ["_buildings", "_position", "_number", "_civil", "_civiltype", "_group", "_marker", "_size", "_name", "_allunits", "_positions", "_index", "_active", "_back"];

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

	_buildings = nearestObjects[_position,["Building"], 500];
	sleep 1;
	_number = random 10;

	{
		_index = 0;
		while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
			_position = _x buildingPos _index;
			_positions = _positions + [_position];
			_index = _index + 1;
		};
	}foreach _buildings;

	_group = creategroup civilian;
	for "_x" from 0 to _number do {
		_civiltype = wccivilclass call BIS_fnc_selectRandom;
		//_civil = _group createUnit [_civiltype, _position, [], 0, "FORM"];
		_position = [_marker, "onground", "onflat"] call WC_fnc_createpositioninmarker;
		//_civil domove _position;
		_back = _back + [[_civiltype, _position]];

	};

	while { true } do {
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
				_position = [_marker, "onground", "onflat"] call WC_fnc_createpositioninmarker;
				_civil domove _position;
				wccivilianstoinit = wccivilianstoinit + [_civil];
			}foreach _back;
			_allunits = units _group;
			_back = [];
		};

		_group setCombatMode "RED";
		_group setBehaviour "COMBAT";
		_civil = _allunits select 0;
		_allunits = _allunits - [_civil];
		//if(random 1 > 0.9) then {
		//	_position = [_marker, "onground", "onflat"] call WC_fnc_createpositioninmarker;
		//} else {
			_position = _positions call BIS_fnc_selectRandom;
		//};
		_civil domove _position;
		sleep 5;
	};



