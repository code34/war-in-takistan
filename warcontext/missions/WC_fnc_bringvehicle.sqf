	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext  - bring vehicle to a position

	private [
		"_unit", 
		"_enemy", 
		"_startpos", 
		"_missioncomplete"
	];

	_unit = _this select 0;
	_startpos = position (_this select 1);
	_missioncomplete = false;

	_unit setdamage floor(0.1 + random 0.7);
	_unit setVehicleInit "this setfuel 0;";
	processInitCommands;
	
	while {!_missioncomplete} do {
        	sleep 1;
		if((!alive _unit) or (damage _unit > 0.9)) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONFAILED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			_missioncomplete = true;
		};
		if(_startpos distance position _unit < 100) then {
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMPLETED", localize "STR_WC_MESSAGELEAVEZONE"];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
			wcmissionsuccess = true;
			wcobjectiveindex = wcobjectiveindex + 1;
			_missioncomplete = true;
			wcleveltoadd = 1;
			wcenemyglobalfuel = wcenemyglobalfuel + wcbonusfuel;
		};
		if(isplayer (driver _unit)) then {
			if(fuel _unit < 0.1) then {
				_unit setVehicleInit "this setfuel 1;";
				processInitCommands;
			};
		};
	};