	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create a destroy group mission

	private [
		"_group", 
		"_missioncomplete",
		"_sizeofgroup",
		"_unit", 
		"_vehicle", 
		"_vehicle2",
		"_position",
		"_missioncomplete",
		"_counter"
		];

	_unit = _this select 0;

	_missioncomplete = false;
	_position = getpos _unit;
	_sizeofgroup = ceil (random 10);

	_group = creategroup east;
	for "_i" from 1 to _sizeofgroup do {
		_position = (position _unit) findEmptyPosition [2, 30];
		if(count _position == 0) then {
			diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CREATE DESTROY GROUP";
		};

		_vehicle = _group createUnit [(wcspecialforces call BIS_fnc_selectRandom), _position, [], 0, "NONE"];
		wcgarbage = [_vehicle] spawn WC_fnc_patrol;
		wcgarbage = [_vehicle] spawn WC_fnc_dosillything;
	};

	wcgarbage = [_group] spawn WC_fnc_grouphandler;
	diag_log format ["WARCONTEXT: COMPUTING A SPECIAL FORCE GROUP OF %1 UNITS AS DESTROY GOAL", _sizeofgroup];

	_missioncomplete = false;
	_counter = 0;
	while { !_missioncomplete } do {
		_counter = _counter + 1;
		if((count units _group == 0) or (damage _unit > 0.8)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else {["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			wcmessageW spawn EXT_fnc_infotext;
			_missioncomplete = true;
			wcleveltoadd = 1;
		};
		if(_counter > 60) then {
			{
				if(position _x distance _position > 100) then {
					_x domove _position;
				};
			}foreach units _group;
			_counter = 0;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", format["Still %1 enemies", count units _group]];
			if!(isDedicated) then { wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
		};
		sleep 1;
	};
