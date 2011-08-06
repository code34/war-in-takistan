	// -----------------------------------------------
	// Author: team =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private ["_tmparray"];

	_tmparray = [];
	{
		// if marker is a mission marker (not protected)
		if (!(_x select 9)) then {
			call compile format [" deleteMarker '%1'; ", _x select 0];
		} else {
			_tmparray = _tmparray + [_x];
		};
	}foreach wcarraymarker;

	wcarraymarker = _tmparray;

	true;

