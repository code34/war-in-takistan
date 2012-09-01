	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - steal an object

	private [
		"_find",
		"_unit", 
		"_enemy", 
		"_sabotage", 
		"_sabotage2", 
		"_missioncomplete"
	];

	_unit = _this select 0;
	_unit allowdammage false;
	_missioncomplete = false;

	while {!_missioncomplete} do {
        	sleep 1;
		if(wcalert > 99) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
		};

		_enemy = nearestObjects [_unit, ["All"], 2];
		_find = false;
		{
			if(isplayer _x) then {
				_find = true;
			};
		}foreach _enemy;

		if(_find) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else {["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 1;
		};
	};

	sleep 4;

	deletevehicle _unit;
	