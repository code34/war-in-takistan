	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - sabotage - mission file

	private [
		"_unit", 
		"_enemy", 
		"_enemy", 
		"_missioncomplete"
	];

	_unit = _this select 0;
	_unit setVehicleInit "this lock true;";
	_unit setvariable ["wcsabotage", false, true];
	_unit setVehicleInit "this lock true; this addAction ['<t color=''#ff4500''>Sabotage</t>', 'warcontext\actions\WC_fnc_dosabotage.sqf',[],6,false];";
	processInitCommands;

	_missioncomplete = false;

	while {!_missioncomplete} do {
        	sleep 1;
		if(wcalert > 99) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;
		};
		if((!alive _unit) or (damage _unit > 0.9)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;
			_unit setdamage 1;
		};
		if(_unit getvariable "wcsabotage") then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;
			wcleveltoadd = 1;
			wcsabotagelist = wcsabotagelist + [(typeof _unit)];
			wcfame = wcfame + wcbonusfame;
			wcenemyglobalelectrical = wcenemyglobalelectrical + wcbonuselectrical;
			wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
		};
	};

	sleep 60;

	deletevehicle _unit;
	