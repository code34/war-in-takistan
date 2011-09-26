	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext  - Heal a civilian

	private [
		"_arrayofpos", 
		"_buildings", 
		"_index",
		"_enemy", 
		"_enemys",
		"_missioncomplete", 
		"_position", 
		"_unit"
		];

	_unit = _this select 0;

	_arrayofpos = [];
	_missioncomplete = false;

	_unit setvariable ["wcprotected", true];
	_unit setcaptive true;
	_unit allowFleeing 0;
	_unit setUnitPos "Up"; 
	dostop _unit;
	removeallweapons _unit;

	_buildings = nearestObjects [position _unit, ["House"], 350];
	{
		if(getdammage _x == 0) then {
			_index = 0;
			while { format ["%1", _x buildingPos _index] != "[0,0,0]" } do {
				_position = _x buildingPos _index;
				_arrayofpos = _arrayofpos + [_position];
				_index = _index + 1;
				sleep 0.05;
			};
		};
	}foreach _buildings;

	_position = _arrayofpos call BIS_fnc_selectRandom;

	_unit setpos _position;
	_unit setdamage 0.9;
	processInitCommands;

	_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	_unit setvariable ["wchostage", true, true];

	[_unit] spawn {
		private ["_unit"];
		_unit = _this select 0;
		while { ((alive _unit) and (_unit getvariable "wchostage")) } do {
			wchostage = _unit;
			["wchostage", "client"] call WC_fnc_publicvariable;
			sleep (5 + random (15));
		};
	};

	while {!_missioncomplete} do {
		if(!alive _unit) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			wcmessageW spawn WC_fnc_infotext;
			_missioncomplete = true;
		};
		if(getdammage _unit < 0.1) then {
			_unit setvariable ["wchostage", false, true];
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			wcmessageW spawn WC_fnc_infotext;
			_missioncomplete = true;
			wcleveltoadd = 1;
			_enemy = true;
		};

        	sleep 1;
	};

	sleep 120;

	_unit setdamage 1;
	deletevehicle _unit;
