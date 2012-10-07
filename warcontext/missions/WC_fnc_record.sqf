	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - record a discussion

	private [
		"_find",
		"_units", 
		"_enemy", 
		"_leader",
		"_position",
		"_sabotage", 
		"_sabotage2", 
		"_missioncomplete",
		"_recordingtime"
	];

	_group = _this select 0;
	_leader = leader _group;
	
	_units = units _group;

	(_units select 0) setdir 0; 
	_position = position (_units select 0);
	(_units select 1) setpos [_position select 0, ((_position select 1) + 0.5),0];
	(_units select 1) setdir 180; 

	(_units select 0) disableAI "ANIM";  
	(_units select 1) disableAI "ANIM"; 

	(_units select 0) switchmove "AidlPercSnonWnonDnon_talk1";
	sleep 5 + (random 10);
	(_units select 1) switchmove "AidlPercSnonWnonDnon_talk1";

	_missioncomplete = false;
	_recordingtime = 0;

	while {!_missioncomplete} do {
        	sleep 1;
		if(wcalert > 99) then {
			(_units select 0) enableAI "ANIM";
			(_units select 1) enableAI "ANIM";
			wcgarbage = [_group, (position(leader _group)), 300] spawn WC_fnc_patrol;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
		};

		_enemy = nearestObjects [_leader, ["All"], 7];
		_find = false;
		{
			if((isplayer _x) and !_find) then {
				_recordingtime = _recordingtime + 1;
				_count = _count + 1;
				_find = true;
			};
			if((isplayer _x) and (side _x == west) and (_leader knowsabout player > 1)) then {
				wcalert = 100;
			};
		}foreach _enemy;

		if(_recordingtime > 100) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else {["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 1;			
		} else {
			if(_find) then {
				if((_recordingtime mod 10) == 0) then {
					_message = format["Progression: %1", _recordingtime] + "%";
					wcmessageW = ["Recording", _message];
					if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
				};
			};
		};
	};