	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext : do a construction for mission
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

	[localize "Build a construction", localize "STR_WC_MESSAGEBUILDING", localize "STR_WC_MESSAGEBUILDINGINFORMATION", 8] spawn WC_fnc_playerhint;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 8;

	if!(alive player) exitwith {};

	_object setvariable ["wcbuild", true, true];

	_object setVehicleInit "this removeAction 0;";
	processInitCommands;