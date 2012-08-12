	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create a enemy convoy

	if (!isServer) exitWith{};

	private [
		"_arrayofvehicle",
		"_bucket",
		"_group",
		"_target",
		"_lastposition",
		"_nearestenemy",
		"_position",
		"_vehicle",
		"_vehicles",
		"_find",
		"_typeof",
		"_position"
		];

	diag_log "WARCONTEXT: BUILD 1 CONVOY";

	_target = wctownlocations call BIS_fnc_selectRandom;

	_position = (position _target) findEmptyPosition [10, 500];
	if(count _position == 0) exitwith {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CONVOY SPAWN";
	};

	_bucket = 0;

	_arrayofvehicle = [_position, 0, (wcvehicleslistE call BIS_fnc_selectRandom), east] call BIS_fnc_spawnVehicle;

	sleep 2;

	_vehicle 	= _arrayofvehicle select 0;
	_arrayofpilot 	= _arrayofvehicle select 1;
	_group 		= _arrayofvehicle select 2;

	_vehicle setVehicleLock "LOCKED";

	wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	wcgarbage = [_group] spawn WC_fnc_grouphandler;	

	_target = wctownlocations call BIS_fnc_selectRandom;

	_position = (position _target) findEmptyPosition [10, 500];
	if(count _position == 0) then {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR TARGET CONVOY";
	};

	_group setBehaviour "SAFE";
	_group setSpeedMode "FULL";

	_lastposition = position _vehicle;

	[_group] spawn {
		private ["_group", "_list", "_cibles"];
		_group = _this select 0;

		while { (count (units _group) > 0) } do {
			_cibles = [];
			_list = (position (leader _group)) nearEntities [["AllVehicles"], 300];
			{
				if((side (driver _x) == west) or (side _x == west)) then {
					_cibles = _cibles + [_x];
				};
				sleep 0.01;
			}foreach _list;

			{
				_group reveal _x;
				(gunner _vehicle) dowatch position _x;
				sleep (random 10);
			} foreach _cibles;
			sleep (random 10);
		};
	};

	while { count (crew _vehicle) > 0 } do {
		if(format["%1", _lastposition] == format["%1", position _vehicle]) then {
			_bucket = _bucket + 1;
		};

		_lastposition = position _vehicle;

		if(_bucket > 6) then {
			_target = wctownlocations call BIS_fnc_selectRandom;
			_position = (position _target) findEmptyPosition [10, 500];
			if(count _position == 0) then {
				diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR NEW TARGET CONVOY";
			};
			(driver _vehicle) dostop false;
			(driver _vehicle) domove _position;
			_vehicle setFuel 1;
			_bucket = 0;
		};

		sleep 10;
	};