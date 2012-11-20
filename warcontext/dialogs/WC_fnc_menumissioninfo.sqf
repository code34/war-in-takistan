	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr, Xeno - domination
	// warcontext - create a mission info dialog box
	// locality : client side

	private [
		"_location", 
		"_mainmission", 
		"_color", 
		"_ctrl", 
		"_info", 
		"_count", 
		"_name", 
		"_missionnumber", 
		"_objective"
	];
	
	disableSerialization;
	_ctrl = (findDisplay 10000) displayCtrl 10004;

	WC_fnc_fixheadbug = {
		closeDialog 0;
		titleCut["","BLACK IN",1];
		_pos = position player;
		_vehicle = "Lada1" createvehiclelocal [0,0,0];
		player moveInCargo _vehicle;
		deleteVehicle _vehicle;
		player setpos _pos;
	};

	playsound "paper";

	ctrlSetText [10001, format[localize "STR_WC_BRIEFING", (wclevelmax - 1)]];

	if (!isnil "wcenemykilled") then {
		ctrlSetText [10005, format[localize "STR_WC_ENNEMYKILLED", wcenemykilled]];
	} else {
		wcenemykilled = 0;
		ctrlSetText [10005, format[localize "STR_WC_ENNEMYKILLED", wcenemykilled]];
	};

	ctrlSetText [10007, format[localize "STR_WC_IASKILL", (wcskill * 100)]+"%"];
	ctrlSetText [10012, format[localize "STR_WC_TEAMSCORE", wcteamscore]];
	ctrlSetText [10011, format[localize "STR_WC_AMMOUSED", (wcammoused - 1)]];
	ctrlSetText [10013, format[localize "STR_WC_REVIVELEFT", R3F_REV_nb_reanimations]];
	
	if (!isnil "wcobjective") then {
		_missionnumber = (wcobjective select 2);
		switch (_missionnumber) do {
			case 51: {
				_objective = format[localize "STR_WC_MISSION51", getText (configFile >> "CfgVehicles" >> typeof (wcobjective select 1) >> "DisplayName")];
			};
			case 52: {
				_objective = format[localize "STR_WC_MISSION52", getText (configFile >> "CfgVehicles" >> typeof (wcobjective select 1) >> "DisplayName")];
			};
			case 53: {
				_objective = format[localize "STR_WC_MISSION53", getText (configFile >> "CfgVehicles" >> typeof (wcobjective select 1) >> "DisplayName")];
			};
			default {
				_objective = localize (format["STR_WC_MISSION%1", _missionnumber]);
			};
		};

		ctrlSetText [10006, format["%1\n\n%2", wcobjective select 3, _objective]];
	} else {
		ctrlSetText [10006, format[localize "STR_WC_OPERATIONGOAL", localize "STR_WC_NOTYETDEFINE"]];
	};

	hintsilent wcteamspeak;

	if (wcteamlevel == 8) then { _info = localize "STR_WC_ASSHOLETEAM";};
	if (wcteamlevel == 7) then { _info = localize "STR_WC_BASTARDTEAM";};
	if (wcteamlevel == 6) then { _info = localize "STR_WC_CALAMITYTEAM";};
	if (wcteamlevel == 5) then { _info = localize "STR_WC_NOOBTEAM";};
	if (wcteamlevel == 4) then { _info = localize "STR_WC_CONFIRMEDTEAM";};
	if (wcteamlevel == 3) then { _info = localize "STR_WC_EXPERIENCEDTEAM";};
	if (wcteamlevel == 2) then { _info = localize "STR_WC_ELITETEAM";};
	if (wcteamlevel == 1) then { _info = localize "STR_WC_HEROETEAM";};
	if(wckindofserver != 3) then {
		if((name player) in wcinteam) then {
			_teampromote = localize format["STR_WC_TEAM%1", wcteamlevel];
			ctrlSetText [10009, format["%3 : %1\n\n%2", _teampromote, _info, localize "STR_WC_ACTUALLYYOURTEAMRANK"]];
		};
	};