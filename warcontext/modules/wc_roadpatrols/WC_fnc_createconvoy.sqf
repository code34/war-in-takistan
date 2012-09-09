	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create a enemy convoy

	if (!isServer) exitWith{};

	private [
		"_arrayofvehicle",
		"_cible",
		"_group",
		"_target",
		"_formationtype",
		"_lastposition",
		"_nearestenemy",
		"_move",
		"_originalsize",
		"_originalcible",
		"_position",
		"_vehicle",
		"_vehicles",
		"_find",
		"_typeof",
		"_position",
		"_wp",
		"_wptype"
		];

	diag_log "WARCONTEXT: BUILD 1 CONVOY";

	_target = wctownlocations call BIS_fnc_selectRandom;

	_position = (position _target) findEmptyPosition [10, 500];
	if(count _position == 0) exitwith {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CONVOY SPAWN";
	};

	_arrayofvehicle = [_position, 0, (wcvehicleslistE call BIS_fnc_selectRandom), east] call BIS_fnc_spawnVehicle;

	sleep 1;

	_vehicle 	= _arrayofvehicle select 0;
	_arrayofpilot 	= _arrayofvehicle select 1;
	_group 		= _arrayofvehicle select 2;

	_vehicle setVehicleLock "LOCKED";
	_vehicle setvariable ["cible", objnull, false];

	_originalsize = count (units _group);

	wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	wcgarbage = [_group] spawn WC_fnc_grouphandler;	

	while { count (units _group) > 0 } do {
		if((wcalert > 50) || (count (units _group) < _originalsize)) then {
			_group setBehaviour "AWARE";
			_group setCombatMode "RED";
			_group setSpeedMode "LIMITED";
			_wptype = ["MOVE","DESTROY", "SAD", "GUARD"];
		} else {
			_group setBehaviour "SAFE";
			_group setCombatMode "GREEN";
			_group setSpeedMode "FULL";
			_wptype = ["MOVE","DESTROY", "SAD", "HOLD", "SENTRY", "GUARD"];
		};

		_cible = _vehicle getvariable "cible";
		_originalcible = _cible;

		if(isnull (_cible)) then {
			_move = false;
			_target = wctownlocations call BIS_fnc_selectRandom;
			_position = (position _target) findEmptyPosition [10, 500];
			while { count _position == 0 } do {
				_target = wctownlocations call BIS_fnc_selectRandom;
				_position = (position _target) findEmptyPosition [10, 500];
				sleep 0.1;
			};
		} else {
			if(!(alive _cible) or !(_cible distance _vehicle < wcdistance)) then {
				_cible = objnull;	
			} else {
				_wptype = ["SAD"];
				_position = position _cible;
				_group setBehaviour "AWARE";
				_group setCombatMode "RED";
				_group setSpeedMode "LIMITED";
			};
		};

		_formationtype = ["COLUMN", "STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"] call BIS_fnc_selectRandom;
		_wp = _group addWaypoint [_position, 0];
		_wp setWaypointFormation _formationtype;
		_wp setWaypointPosition [_position, 5];
		_wp setWaypointType (_wptype call BIS_fnc_selectRandom);
		_wp setWaypointVisible true;
		_wp setWaypointSpeed "FULL";
		_group setCurrentWaypoint _wp;
	
		while { (!(_move) and (count (units _group) == _originalsize)) } do {
			_lastposition = position (leader _group);
			sleep 30;
			if(_lastposition distance (position (leader _group)) < 5) then {
				_move = true;
			};
			_cible = _vehicle getvariable "cible";
			if(_originalcible != _cible) then {
				_move = true;
			};
		};
		deletewaypoint _wp;
		_vehicle setFuel 1;
	};