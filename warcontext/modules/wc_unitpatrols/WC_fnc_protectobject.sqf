	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - defend an objet 
	// by patroling around with special force (side mission)

	private [
		"_group", 
		"_missioncomplete",
		"_sizeofgroup",
		"_unit", 
		"_vehicle", 
		"_vehicle2",
		"_position"
		];

	_unit = _this select 0;

	_missioncomplete = false;
	_position = getpos _unit;
	_sizeofgroup = ceil (random 10);

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

	wcgarbage = [_group, 100] spawn WC_fnc_patrol;
	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	diag_log format ["WARCONTEXT: COMPUTING A SPECIAL FORCE GROUP OF %1 UNITS FOR PROTECT GOAL", _sizeofgroup];
