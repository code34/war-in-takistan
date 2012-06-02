	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_vehicle",
		"_vehicles",
		"_plane",
		"_driver",
		"_arrayofvehicle"
	];

	_vehicles = [];

	while { true } do {
		if(count _vehicles < 2) then {
			_plane = ["RHIB", "RHIB2Turret"] call BIS_fnc_selectRandom;
			_arrayofvehicle =[[500,500, 0], 0, _plane , east] call BIS_fnc_spawnVehicle;
			_vehicle = (_arrayovehicle select 0);
			wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
			_vehicles = _vehicles + [(_arrayovehicle select 0)];
			_driver = ((_arrayofvehicle select 1) select 0);
			wcgarbage = [_driver] spawn WC_fnc_airpatrol;
		};
		{
			if!(alive _x) then {
				_vehicles = _vehicles - [_x];
			};
		}foreach _vehicles;
		sleep 240;
	};