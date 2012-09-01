	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - altercation
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_unit", 
		"_count", 
		"_group", 
		"_men", 
		"_position", 
		"_counter", 
		"_maxconversion", 
		"_target", 
		"_targets", 
		"_vehicle", 
		"_positions",
		"_check",
		"_needpropagander"
		];

	_unit = _this select 0;
	_needpropagander = true;
	_targets = [];

	{
		if(_x distance _unit < 500) then {
			_needpropagander = false;
		};
		if(isnull _x) then { wcpropagander = wcpropagander - [_x]; };
	}foreach wcpropagander;

	if (!_needpropagander) exitWith{};

	wcpropagander = wcpropagander + [_unit];

	diag_log format["WARCONTEXT: BUILD 1 ALTERCATION - fame: %1", wcfame];

	_check = false;
	_count = 0;
	while { ((!_check) and (alive _unit)) } do {
		if((west countSide nearestObjects[_unit,["Man"], 200]) > 0) then {
			_check = true;
		};
		sleep 1;
	};

	if!(alive _unit) exitwith {};
	if(_count > 60) exitwith {};

	_men = nearestObjects[_unit,["Man"], 400];
	{
		if(isplayer _x) then {
			_targets = _targets + [_x];
		};
	}foreach _men;

	_target = _targets call BIS_fnc_selectRandom;
	_check = false;

	//create a crowd arround an alone player
	while { ((alive _unit) and (alive _target) and ((_target distance _unit) < 400) and !_check) } do {
		_position = position _target;
		_count = west countside nearestObjects[_target,["Man"], 20];

		// if less than 4 players - crowd
		if(_count < 4) then {
			_positions = [_position, 5, 360, getdir _target, 5] call WC_fnc_createcircleposition;
			_men = nearestObjects[_target,["Man"], 400];
			_men = _men - [_unit];
			{
				if(side _x == civilian) then {
					if(_x distance _target > 5) then {
						_position = (_positions call BIS_fnc_selectRandom);
						_x setvariable ["destination", _position, false];
						_x setvariable ["civilrole", "crowd", true];
						_x setvariable ["target", _target, false];
						_x stop false;
						_x domove _position;
					} else {
						_x dowatch _target;
						sleep 3;
						_x stop true;
					};
				};
			}foreach _men;
		} else {
			_men = nearestObjects[_target,["Man"], 400];
			_men = _men - [_unit];
			{
				if(side _x == civilian) then {
					_x setvariable ["civilrole", "civil", true];
				};
			}foreach _men;
		};
		sleep 15;
	};