	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - IED in town 
	
	private [
		"_count", 
		"_iedobjects", 
		"_iedtype",
		"_index", 
		"_max",
		"_object", 
		"_position", 
		"_positions"
	];

	_iedobjects = wciedobjects;
	_position = _this select 0;
	_positions = [];

	_building = nearestObjects[_position,["Building"], 300];

	{
		if(random 1 > 0.9) then {
			_positions = _positions + [position _x];
		};
	}foreach _building;

	_max = random wcwithied;
	_count = 0;

	{
		if(_count < _max) then {
			_position = _x findEmptyPosition [1,5];
			if(count _position > 0) then {
				_iedtype = _iedobjects call BIS_fnc_selectRandom;
				_iedobjects = _iedobjects - [_iedtype];
				_object = _iedtype createVehicle _position;
				_object setpos _position;
				_object setdir (random 360);
				if(random 1 > 0.7) then {
					_name = format["mrkied%1", wciedindex];
					wciedindex = wciedindex + 1;
					_marker = [_name, 0.5, _position, 'ColorRed', 'ICON', 'FDIAGONAL', 'dot', 0, ("IED: "+(typeof _object)), false] call WC_fnc_createmarkerlocal;
					wcgarbage = [_object] spawn WC_fnc_createied;
				};
				wcobjecttodelete = wcobjecttodelete + [_object];
				_count = _count + 1;
			};
		};
		sleep 0.05;
	}foreach _positions;