	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - defend an objet 
	// by patroling around with special force (side mission)

	private [
		"_areasize",
		"_group", 
		"_number",
		"_sizeofgroup",
		"_unit", 
		"_vehicle", 
		"_vehicle2",
		"_position"
		];

	_unit = _this select 0;
	_number =  _this select 1;

	if(isnil "_number") then { _number = 2; };

	_position = getpos _unit;

	for "_a" from 0 to (round random _number) do {
		_areasize = round (random 50);
		_sizeofgroup = round (random 4);
	
		_group = creategroup east;
		for "_i" from 1 to _sizeofgroup do {
			_position = (position _unit) findEmptyPosition [2, 30];
			if(count _position == 0) then {
				diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR PROTECT OBJECT PATROL";
			} else {
				_vehicle = _group createUnit [(wcspecialforces call BIS_fnc_selectRandom), _position, [], 5, "NONE"];
				//wcgarbage = [_vehicle] spawn WC_fnc_dosillything;
			};
		};
	
		wcgarbage = [_group, _areasize] spawn WC_fnc_patrol;
		wcgarbage = [_group] spawn WC_fnc_grouphandler;

		diag_log format ["WARCONTEXT: COMPUTING A SPECIAL FORCE GROUP OF %1 UNITS FOR PROTECT GOAL", _sizeofgroup];
	};

