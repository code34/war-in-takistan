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
	_side = [east, west, resistance] call BIS_fnc_selectRandom;

	// create a new unit not depending of ALICE
	_position = position _unit;
	_typeof = typeof _unit;
	_unit removeAllEventHandlers "killed";
	_unit setpos [0,0];
	_unit setdamage 1;
	deletevehicle _unit;

	_group = creategroup civilian;
	_unit = _group createUnit [_typeof, [0,0], [], 0, "FORM"];
	_unit setpos _position;

	_unit allowfleeing 0;

	_position = (position _unit) findEmptyPosition [8, 100];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CIVILIAN HEALER";
	};

	_unit setpos _position;

	while { alive _unit } do {
		_men = nearestObjects[_unit,["Man"], 400];
		{
			if(side _x == _side) then {
				if(getdammage _x > 0.10) then {
					while { ((position _unit distance position _x > 3) and (position _unit distance position _x < 100) and (alive _unit) and (alive _x)) } do {
						_unit domove position _x;
						sleep 10;
					};
					if ((alive _unit) and (alive _x)) then {
						_x action ["heal", _unit];
						sleep 8;
					};
				};
			};
		}foreach _men;
		sleep 1;
	};