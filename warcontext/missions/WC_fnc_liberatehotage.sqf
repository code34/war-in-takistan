	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - liberate hotage -  side mission
	// locality: server side

	private [
		"_arrayofpos", 
		"_buildings", 
		"_index",
		"_enemy", 
		"_enemys",
		"_missioncomplete", 
		"_position", 
		"_unit", 
		"_vehicle", 
		"_vehicle2"
		];

	_unit = _this select 0;
	_unit setVehicleInit "this addAction ['<t color=''#ffcb00''>Follow me</t>', 'warcontext\actions\WC_fnc_dofollowme.sqf',[],6,false, true];";
	processInitCommands;

	_arrayofpos = [];
	_missioncomplete = false;

	_unit setvariable ["wcprotected", true];
	_unit setcaptive true;
	_unit allowFleeing 0;
	_unit setUnitPos "Up"; 
	removeallweapons _unit;

	_arrayofpos = [position _unit, "all"] call WC_fnc_gethousespositions;
	_position = _arrayofpos call BIS_fnc_selectRandom;

	_unit setpos _position;
	_unit setdamage 0;
	_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	_unit setvariable ["wchostage", true, true];
	_unit stop true;

	_group = createGroup east;
	_vehicle = _group createUnit [(wcspecialforces call BIS_fnc_selectRandom), position _unit, [], 1, "NONE"];
	_vehicle2 = _group createUnit [(wcspecialforces call BIS_fnc_selectRandom), position _unit, [], 8, "NONE"];

	_vehicle allowdammage false;
	_vehicle2 allowdammage false;

	wcgarbage = [_group] spawn WC_fnc_grouphandler;
	wcgarbage = [_group, (position(leader _group)), 30] spawn WC_fnc_patrol;

	wcgarbage = [_vehicle] spawn WC_fnc_dosillything;
	wcgarbage = [_vehicle2] spawn WC_fnc_dosillything;

	sleep 10;
	
	_vehicle allowdammage true;
	_vehicle2 allowdammage true;

	wcgarbage = [_unit] spawn {
		private ["_unit"];
		_unit = _this select 0;
		while { ((alive _unit) and (_unit getvariable "wchostage")) } do {
			wchostage = _unit;
			["wchostage", "client"] call WC_fnc_publicvariable;
			sleep (5 + random (15));
		};
	};

	while {!_missioncomplete} do {
		if((!alive _unit) or (damage _unit > 0.7)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
		};
		if((getmarkerpos "respawn_west") distance _unit < 100) then {
			_unit setvariable ["wchostage", false, true];
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 1;
			_enemy = true;
		};

        	sleep 1;
	};

	sleep 120;

	_unit setdamage 1;
	_vehicle setdamage 1;
	_vehicle2 setdamage 1;

	deletevehicle _unit;
	deletevehicle _vehicle;
	deletevehicle _vehicle2;
