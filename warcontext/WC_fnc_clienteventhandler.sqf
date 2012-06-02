	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// Warcontext - async event handler

	wcclientqueue = [];

	while { true } do {
		waituntil {count wcclientqueue > 0};
		_variablename = (wcclientqueue select 0) select 0;
		_variable = (wcclientqueue select 0) select 1;
		wcclientqueue set [0,-1]; 
		wcclientqueue = wcclientqueue - [-1];
		call compile format["wcgarbage = [_variable] spawn WC_fnc_netcode_%1;", _variablename];
	};

