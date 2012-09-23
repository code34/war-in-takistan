	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create a enemy convoy

	if (!isServer) exitWith{};

	private [
		"_arrayofpilot",
		"_arrayofvehicle",
		"_globalgroup",
		"_group",
		"_kindofarmedvehicles",
		"_kindofsupplyvehicles",
		"_numberofvehicle",
		"_position",
		"_target",
		"_vehicle"
		];

	_kindofarmedvehicles = _this select 0;
	_kindofsupplyvehicles = _this select 1;
	_numberofvehicle = _this select 2;

	if(isnil "_numberofvehicle") then {
		_numberofvehicle = 1;
	};

	_target = wctownlocations call BIS_fnc_selectRandom;
	_position = (position _target) findEmptyPosition [10, 500];

	if(count _position == 0) exitwith {
		diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR CONVOY SPAWN";
	};

	_globalgroup = creategroup east;

	for "_i" from 1 to _numberofvehicle do {
		if((_numberofvehicle > 1) and (random 1> 0.5) and (_i > 1)) then {
			_arrayofvehicle = [_position, 0, (_kindofsupplyvehicles call BIS_fnc_selectRandom), east] call BIS_fnc_spawnVehicle;
		} else {
			_arrayofvehicle = [_position, 0, (_kindofarmedvehicles call BIS_fnc_selectRandom), east] call BIS_fnc_spawnVehicle;
		};

		_vehicle 	= _arrayofvehicle select 0;
		_arrayofpilot 	= _arrayofvehicle select 1;
		_group 		= _arrayofvehicle select 2;	

		_vehicle setVehicleLock "LOCKED";
		_vehicle setvariable ["cible", objnull, false];	

		wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
		wcgarbage = [_group] spawn WC_fnc_grouphandler;	
		_arrayofpilot joinsilent _globalgroup;
		deletegroup _group;
		sleep 1;
	};

	wcgarbage = [_globalgroup] spawn WC_fnc_roadpatrol;