	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - civilian heal

	 private [
		"_count",
		"_distancemax",
		"_needpropagander",
		"_number",
		"_position",
		"_sabotage",
		"_target",
		"_typeof",
		"_unit",
		"_men",
		"_side"
	];

	_unit = _this select 0;

	diag_log format["WARCONTEXT: BUILD 1 HEALER - fame: %1", wcfame];

	_needpropagander = true;

	{
		if(_x distance _unit < 500) then {
			_needpropagander = false;
		};
		if(isnull _x) then { wcpropagander = wcpropagander - [_x]; };
	}foreach wcpropagander;

	if (!_needpropagander) exitWith{};

	wcpropagander = wcpropagander + [_unit];

	_position = (position _unit) findEmptyPosition [8, 100];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CIVILIAN HEALER";
	} else {
		_unit setpos _position;
	};

	_side = [east, west, resistance] call BIS_fnc_selectRandom;

	while { alive _unit } do {
		_men = nearestObjects[_unit,["Man"], 400];
		{
			if(side _x == _side) then {
				if(getdammage _x > 0.10) then {
					while { ((position _unit distance position _x > 3) and (position _unit distance position _x < 100) and (alive _unit) and (alive _x)) } do {
						_unit domove position _x;
						_unit setvariable ["destination", _position, false];
						sleep 10;
					};
					if ((alive _unit) and (alive _x)) then {
						_unit action ["heal", _x];
						_x setdammage 0;
						sleep 8;
					};
				};
			};
		}foreach _men;
		sleep 1;
	};