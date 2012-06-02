	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - call a defend mission

	_object = _this select 0;

	_units = nearestObjects[position player,["Man"], 1000];
	if ((west countside _units) < (ceil((playersNumber west) * 0.2))) exitwith {hint "There is not enough player around flag to start mission";};

	_object setVehicleInit "this removeAction 0;";
	processInitCommands;

	wcmessageW = ["Defense mission", "starts now"];
	["wcmessageW", "client"] call WC_fnc_publicvariable;
	wcmessageW spawn EXT_fnc_infotext;

	wcbegindefend = true;
	["wcbegindefend", "server"] call WC_fnc_publicvariable;