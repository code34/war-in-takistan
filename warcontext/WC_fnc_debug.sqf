	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Debuger - works only on local

	if (local player and isserver) then {
		waituntil { wcclientinitialized };
		execVM "extern\R3F_DEBUG\scripts\functions_R3F_Debug.sqf";
	};
