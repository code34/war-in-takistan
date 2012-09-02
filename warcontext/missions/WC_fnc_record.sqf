	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - record a discussion

	private [
		"_find",
		"_unit", 
		"_enemy", 
		"_sabotage", 
		"_sabotage2", 
		"_missioncomplete",
		"_recordingtime"
	];

	_unit = _this select 0;
	_unit allowdammage false;
	_missioncomplete = false;
	_recordingtime = 0;

	while {!_missioncomplete} do {
        	sleep 1;
		if(wcalert > 99) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
		};

		_enemy = nearestObjects [_unit, ["All"], 5];
		_find = false;
		{
			if((isplayer _x) and !_find) then {
				_recordingtime = _recordingtime + 1;
				_find = true;
			};
			if((isplayer _x) and (side _x == west)) then {
				if(random 1 > 0.2) then {
					wcalert = wcalert + 1;
				};
			};
		}foreach _enemy;

		if(_recordingtime > 120) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else {["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 1;			
		};
	};