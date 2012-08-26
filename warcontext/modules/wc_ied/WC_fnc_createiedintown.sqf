	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - IED in town 
	
	private [
		"_buildings",
		"_iedobjects", 
		"_iedtype",
		"_max",
		"_object", 
		"_position"
	];

	_iedobjects = wciedobjects;
	_position = _this select 0;

	_buildings = nearestObjects [_position,["Building"], 300];
	sleep 1;

	_max = round (random wcwithied);

	for "_x" from 1 to _max step 1 do {
		_position =  position (_buildings call BIS_fnc_selectRandom);
		_position =  _position findEmptyPosition [1, 10];

		if(count _position > 0) then {
			_iedtype = _iedobjects call BIS_fnc_selectRandom;
			_iedobjects = _iedobjects - [_iedtype];
	
			_object = _iedtype createVehicle _position;
			_object setpos _position;
			_object setdir (random 360);

			_name = format["mrkied%1", wciedindex];
			wciedindex = wciedindex + 1;
			_marker = [_name, 0.5, _position, 'ColorRed', 'ICON', 'FDIAGONAL', 'dot', 0, ("IED: "+(typeof _object)), false] call WC_fnc_createmarkerlocal;
			wcgarbage = [_object] spawn WC_fnc_createied;

			wcobjecttodelete = wcobjecttodelete + [_object];
		};
	};