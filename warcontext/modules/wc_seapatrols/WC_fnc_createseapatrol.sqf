	// -----------------------------------------------
	// Author: team  code34 nicolas_boiteux@yahoo.fr
	// warcontext - generate sea patrol
	// -----------------------------------------------
	if (!isServer) exitWith{};

	private [
		"_arrayofvehicle",
		"_boat",
		"_group",
		"_initpos",
		"_vehicle",
		"_vehicles"
	];

	_vehicles = [];
	_initpos = _this select 0;

	// exit if initpos is not water
	if(!surfaceiswater _initpos) exitwith {
		diag_log format["WARCONTEXT: SEA PATROL CAN NOT BE EXECUTED CAUSE INITPOS IS NOT WATER: %1", _initpos];
	};

	while { true } do {
		if(count _vehicles < 2) then {
			_boat = wcseapatrol call BIS_fnc_selectRandom;
			_arrayofvehicle =[_initpos, 0, _boat , east] call BIS_fnc_spawnVehicle;
			diag_log format ["WARCONTEXT: GENERATE 1 SEA PATROL: %1", _boat];

			_vehicle = (_arrayofvehicle select 0);
			_group = (_arrayofvehicle select 2);
			_vehicles = _vehicles + [_vehicle];

			wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
			wcgarbage = [_group] spawn WC_fnc_grouphandler;

			wcgarbage = [_vehicle, _initpos] spawn WC_fnc_seapatrol;
		};
		{
			if!(alive _x) then {
				_vehicles = _vehicles - [_x];
			};
		}foreach _vehicles;
		sleep 240;
	};