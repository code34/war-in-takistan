	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
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

	wcpropagander = wcpropagander + [_unit];

	diag_log format["WARCONTEXT: BUILD 1 BUILDER - fame: %1", wcfame];

	_position = (position _unit) findEmptyPosition [8, 100];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CIVILIAN BUILDER";
	} else {
		_unit setpos _position;
	};

	while { alive _unit } do {
		sleep 1;
	};