	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - defend an objet 
	// by patroling around with special force (side mission)

	private [
		"_areasize",
		"_group", 
		"_newposition",
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

	for "_a" from 1 to (ceil random _number) do {
		_areasize = 30 + (round (random 50));
		_sizeofgroup = round (random 4);
	
		_group = creategroup east;
		for "_i" from 1 to _sizeofgroup do {
			_newposition = _position findEmptyPosition [2, 30];
			if(count _newposition == 0) then {
				diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR PROTECT OBJECT PATROL";
			} else {
				_vehicle = _group createUnit [(wcspecialforces call BIS_fnc_selectRandom), _newposition, [], 5, "NONE"];
			};
		};

		wcgarbage = [_group, _position, _areasize] spawn WC_fnc_patrol;	
		wcgarbage = [_group] spawn WC_fnc_grouphandler;

		diag_log format ["WARCONTEXT: COMPUTING A SPECIAL FORCE GROUP OF %1 UNITS FOR PROTECT GOAL", _sizeofgroup];
	};

	// create dog
	if((random 1 > 0.2) and wcpatrolwithdogs) then {
		_group = creategroup civilian;
		_class = wcdogclass call BIS_fnc_selectRandom;
		_newposition = _position findEmptyPosition [2, 30];
		_dog = _group createUnit [_class, _newposition, [], 3, "NONE"]; 
		wcgarbage = [_dog] spawn WC_fnc_dogpatrol;
	};