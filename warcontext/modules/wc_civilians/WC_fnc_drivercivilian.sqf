	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - civil drive car across the map

	if (!isServer) exitWith{};

	private [
		"_exit",
		"_unit", 
		"_target",
		"_position",
		"_vehicle",
		"_vehicles",
		"_find",
		"_typeof"
		];

	_unit = _this select 0;

	_vehicles = nearestObjects[_unit,["LandVehicle"], 300];
	if (count _vehicles == 0) exitwith {
		_unit setvariable ["civilrole", "civil", true];
	};

	diag_log format["WARCONTEXT: BUILD 1 DRIVER - fame: %1", wcfame];
	_target = wctownlocations call BIS_fnc_selectRandom;

	_exit = false;
	while { ((alive _unit) and !_exit) } do {
		if(vehicle _unit == _unit) then {
			_find = false;

			_vehicles = nearestObjects[_unit,["LandVehicle"], 300];
			{
				if((count (crew _x) == 0) and !_find and (damage _x < 0.9)) then {
					_find = true;
					_vehicle = _x;
				};		
			}foreach _vehicles;

			if(_find) then {
				while {((_unit distance _vehicle > 10) and (alive _unit) and (alive _vehicle) and !(locked _vehicle))} do {
					_unit domove (position _vehicle);
					_unit setvariable ["destination", (position _vehicle), false];
					sleep 20;
				};
	
				if((count (crew _vehicle) == 0) and (alive _unit) and (alive _vehicle) and !(locked _vehicle)) then {
					_position = position _unit;
					_typeof = typeof _unit;
					_unit removeAllEventHandlers "killed";
					_unit setpos [0,0];
					_unit setdamage 1;
					deletevehicle _unit;
					_group = creategroup civilian;
					_unit = _group createUnit [_typeof, [0,0], [], 0, "FORM"];
					_vehicle setfuel 1;
					_vehicle setdamage 0;
					_unit assignasdriver _vehicle;
					[_unit] ordergetin true;
					_unit moveindriver _vehicle;
				};
			} else {
				_unit setvariable ["civilrole", "civil", true];
				_exit = true;
			};
		} else {
			if(position _unit distance position _target > 150) then {
				_unit domove position _target;
				sleep 30;
			} else {
				_target = wctownlocations call BIS_fnc_selectRandom;
			};
		};
		sleep 5;
	};