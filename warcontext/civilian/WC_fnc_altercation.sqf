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

	diag_log format["WARCONTEXT: BUILD 1 ALTERCATION - fame: %1", wcfame];

	wcpropagander = wcpropagander + [_unit];

	_check = false;
	_count = 0;
	while { !_check} do {
		if(alive _unit) then {
			if!((west countSide nearestObjects[_unit,["Man"], 400]) > 0) then {
				_check = true;
			} else {
				_count = _count + 1;
				if(_count > 60) then {
					_check = true;
				};
			};
		} else {
			_check = true;
		};
		sleep 10;
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

	while { ((alive _target) or ((_target distance _unit) < 400)) } do {
		_position = position _target;
		_men = nearestObjects[_target,["Man"], 30];
		if(count _men < 10) then {
			_positions = [_position, 5, 360, getdir _target, 5] call WC_fnc_docircle;
			_men = nearestObjects[_target,["Man"], 400];
			{
				if(side _x == civilian) then {
					if(_x distance _target > 5) then {
						_x domove (_positions call BIS_fnc_selectRandom);
					} else {
						dostop _x;
						_x dowatch _target;
					};
				};
			}foreach _men;
		};
		sleep 5;
	};