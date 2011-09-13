	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// units & vehicles class
	// http://community.bistudio.com/wiki/ArmA:_CfgVehicles
	// -----------------------------------------------
	if (!isServer) exitWith{};
	
	private [
		"_arrayofvehicle",
		"_arrayofpilot",
		"_count",
		"_indexparameters",
		"_group",
		"_leader",
		"_nbparameters",
		"_parameters",
		"_scriptinit",
		"_typeofgroup", 
		"_typeofvehicle",
		"_position", 
		"_position2",
		"_positions",
		"_marker",
		"_motorized",
		"_vehicle", 
		"_soldier",
		"_unitsofgroup",
		"_base",
		"_sizeofgroup",
		"_unitoftype",
		"_unitsoftype",
		"_building",
		"_list",
		"_dontkeep"
		];

	_parameters = [
		"_marker",
		"_typeofgroup",
		"_motorized"
		];

	_indexparameters = 0;
	_nbparameters = count _this;
	{
		if (_indexparameters <= _nbparameters) then {
		call compile format["%1 = _this select %2;", _x, _indexparameters];
		};
		_indexparameters = _indexparameters + 1;
	}foreach _parameters;

	_unitsofgroup = [];
	_unitsoftype = [];
	_positions = [];

	_group = createGroup east;

	if (_motorized) then {
		_position = [_marker, "onground", "onflat"] call WC_fnc_createpositioninmarker;
		_arrayofvehicle =[_position, 0, _typeofgroup, east] call BIS_fnc_spawnVehicle;
		sleep 0.05;

		_vehicle 	= _arrayofvehicle select 0;
		_arrayofpilot 	= _arrayofvehicle select 1;
		_group 		= _arrayofvehicle select 2;

		diag_log format ["WARCONTEXT: CREATING VEHICLE %2 IN ZONE %1", _marker, _typeofgroup];

		_vehicle setVehicleInit "this lock true;[this] spawn EXT_fnc_atot;";
		processInitCommands;
		_vehicle setdir (random 360);
		_vehicle setfuel wcenemyglobalfuel;

		wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	} else {
		_sizeofgroup = ceil(random 9);
		{
			if(_typeofgroup == (_x select 0)) then {
				_unitsoftype = 	_unitsoftype + [(_x select 1)];
			};
		}foreach wcclasslist;

		for "_x" from 1 to _sizeofgroup do {
			_unitoftype = (_unitsoftype call BIS_fnc_selectRandom);
			_unitsoftype = _unitsoftype - [_unitoftype];
			_unitsofgroup = [_unitoftype] + _unitsofgroup;
		};

		diag_log format ["WARCONTEXT: CREATING A GROUP %2 IN ZONE %1 OF SIZE %3", _marker, _typeofgroup, _sizeofgroup];

		_position = [_marker, "onground"] call WC_fnc_createpositioninmarker;
		{
			_soldier = _group createUnit [_x, _position, [], 0, 'FORM'];
			sleep 0.05;
		}foreach _unitsofgroup;

	};

	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	// initialisation script for units
	_leader = leader _group;
	_group allowFleeing 0;

	if (_motorized) then {
		if(_vehicle isKindOf "Air") then {
			wcgarbage = [_vehicle, _position] spawn WC_fnc_createairpatrol2;
		} else {
			_scriptinit = format["wcgarbage = [this, '%1', 'showmarker'] execVM 'extern\ups.sqf';", _marker];
		};
		_vehicle setVehicleInit _scriptinit;
		if((typeof _vehicle) in wcsabotagelist) then {
			_vehicle setdamage 1;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", format["%1 sabotaged explosed", (typeof _vehicle)]];
			if!(isDedicated) then { wcmessageW spawn WC_fnc_infotext; } else { ["wcmessageW", "client"] call WC_fnc_publicvariable;};
		};
	} else {
		if(random 1 > 0.4) then {
			_list = nearestObjects [_position, ["house","building"] , 70];
			if(count _list > 10) then {
				_scriptinit = format["wcgarbage = [this, '%1', 'showmarker', 'fortify'] execVM 'extern\upsmon.sqf';", _marker];
			} else {
				_scriptinit = format["wcgarbage = [this, '%1', 'showmarker'] execVM 'extern\upsmon.sqf';", _marker];
			};
		} else {
			_scriptinit = format["wcgarbage = [this, '%1', 'showmarker'] execVM 'extern\upsmon.sqf';", _marker];
		};
		(leader _group) setVehicleInit _scriptinit;
	};

	processInitCommands;

	if (count (units _group) < 1) then {
		if (_motorized) then {
			deletevehicle _vehicle;
		};
	};