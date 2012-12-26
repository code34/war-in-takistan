	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - sabotage

	private [
		"_unit", 
		"_enemy", 
		"_enemy", 
		"_missioncomplete",
		"_typeof",
		"_position"
	];

	_unit = _this select 0;
	_typeof = _this select 1;

	_position = position _unit;

	_unit setvariable ["wcbuild", false, true];
	_unit setVehicleInit "this addAction ['<t color=''#ff4500''>Build</t>', 'warcontext\actions\WC_fnc_dobuild.sqf',[],6,false];";
	processInitCommands;

	_missioncomplete = false;

	while {!_missioncomplete} do {
		if(_unit getvariable "wcbuild") then {	
			deletevehicle _unit;
			_unit = _typeof createvehicle _position;
			_unit setpos _position;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 1;
			wcfame = wcfame + wcbonusfame;
			wcenemyglobalelectrical = wcenemyglobalelectrical + wcbonuselectrical;
			wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
		};
		sleep 1;
	};