	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext : do sabotage
	// -----------------------------------------------

	 private [
		"_position", 
		"_object", 
		"_typeof", 
		"_light",
		"_list", 
		"_dir", 
		"_mydir", 
		"_dammage", 
		"_name"
	];

	_mydir = getdir player;
	_object = _this select 0;
	_param = _this select 3;

	if(count _param == 0) then { _light = false; } else { _light = true; };

	["Sabotage",  localize "STR_WC_MESSAGESABOTING", localize "STR_WC_MESSAGESABOTINGINFORMATION", 8] spawn WC_fnc_playerhint;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 8;
	if!(alive player) exitwith {};

	["Sabotage", localize "STR_WC_MESSAGESABOTINGFINISHED", localize "STR_WC_MESSAGESABOTINGINFORMATION", 8] spawn WC_fnc_playerhint;

	_object setvariable ["wcsabotage", true, true];

	_object setVehicleInit "this removeAction 0;";
	processInitCommands;

	if(_light) then {
		_object setvehicleinit "{_x switchLight 'OFF';}foreach(this nearObjects ['Streetlamp', 400]);";
		processInitCommands;
	};