	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Admin cancel mission

	wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", localize "STR_WC_MISSIONCANCELED"];
	["wcmessageW", "client"] call WC_fnc_publicvariable;

	wcmissionsuccess = true;
	["wcmissionsuccess", "server"] call WC_fnc_publicvariable;