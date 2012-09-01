	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext -  Do target

	private ["_unit", "_missile"];

	_unit = cursorTarget;

	if!(isnull _unit) then {
		wcgarbage = ["Target Fire", "Wait few seconds.", "You have call for a target fire", 10] spawn WC_fnc_playerhint;
		sleep 10;
		"ARTY_R_227mm_HE" createVehicle position _unit;
		"Bo_GBU12_LGB" createVehicle position _unit;
	} else {
		wcgarbage = ["Target Fire", "Point a real target.", "There is no target", 3] spawn WC_fnc_playerhint;	
	};

	