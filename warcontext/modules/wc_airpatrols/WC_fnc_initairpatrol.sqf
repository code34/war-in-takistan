	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - generate until end of game air patrol
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_opposingforce",
		"_position",
		"_vehicle",
		"_vehicles",
		"_plane",
		"_driver",
		"_arrayofvehicle"
	];

	_position = _this select 0;
	_airpatroltype = _this select 1;
	_opposingforce = _this select 2;

	if(format["%1", _position] == "[0,0,0]") exitwith {
		diag_log "WARCONTEXT: No position to pop air patrol";
	};

	_vehicles = [];

	while { true } do {
		if(count _vehicles < _opposingforce) then {
			_plane = _airpatroltype call BIS_fnc_selectRandom;
			_arrayofvehicle =[[500,500,500], 0, _plane , east] call BIS_fnc_spawnVehicle;
			_vehicle = (_arrayovehicle select 0);
			wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
			_vehicles = _vehicles + [(_arrayovehicle select 0)];
			_driver = ((_arrayofvehicle select 1) select 0);
			wcgarbage = [_driver, _position] spawn WC_fnc_airpatrol;
		} else {
			sleep 600 + random (600);
		};
		{
			if!(alive _x) then {
				_vehicles = _vehicles - [_x];
			};
		}foreach _vehicles;
		sleep 15;
	};