	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext - civilian build thing

	 private [
		"_count",
		"_distancemax",
		"_needpropagander",
		"_number",
		"_position",
		"_sabotage",
		"_target",
		"_typeof",
		"_unit"
	];

	_unit = _this select 0;
	_needpropagander = true;

	{
		if(_x distance _unit < 500) then {
			_needpropagander = false;
		};
		if(isnull _x) then { wcpropagander = wcpropagander - [_x]; };
	}foreach wcpropagander;

	if (!_needpropagander) exitWith{};

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

	diag_log format["WARCONTEXT: BUILD 1 BUILDER - fame: %1", wcfame];

	wcpropagander = wcpropagander + [_unit];

	_unit allowfleeing 0;
	_position = (position _unit) findEmptyPosition [8, 100];
	_unit setpos _position;

	while { alive _unit } do {


		sleep 1;
	};