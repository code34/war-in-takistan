	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext 
	// units & vehicles class
	// http://community.bistudio.com/wiki/ArmA:_CfgVehicles
	// -----------------------------------------------
	if (!isServer) exitWith{};
	
	private [
		"_arrayofvehicle",
		"_arrayofpilot",
		"_alert",
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
		"_dontkeep",
		"_localalert",
		"_instances"
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
	_instances = [];

	_group = createGroup east;

	if (_motorized) then {
		_position = [_marker, "onground", "onflat"] call WC_fnc_createpositioninmarker;
		_arrayofvehicle = [_position, 0, _typeofgroup, east] call BIS_fnc_spawnVehicle;
		sleep 0.05;

		_vehicle 	= _arrayofvehicle select 0;
		_arrayofpilot 	= _arrayofvehicle select 1;
		_group 		= _arrayofvehicle select 2;

		diag_log format ["WARCONTEXT: CREATING VEHICLE %2 IN ZONE %1", _marker, _typeofgroup];

		_driver = driver _vehicle;
		_gunner = gunner _vehicle;
		_commander = commander _vehicle;

		_vehicle setVehicleInit "this lock true;[this] spawn EXT_fnc_atot;";
		processInitCommands;
		_vehicle setdir (random 360);
		_vehicle setfuel wcenemyglobalfuel;

		wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	} else {
		_position = [_marker, "onground"] call WC_fnc_createpositioninmarker;
		_group = [_typeofgroup, east, _position] call WC_fnc_popgroup;
		diag_log format ["WARCONTEXT: CREATING A GROUP %2 IN ZONE %1 OF SIZE %3", _marker, _typeofgroup, _sizeofgroup];
	};

	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	// initialisation script for units
	_leader = leader _group;
	_group allowFleeing 0;

	if (_motorized) then {
		if(_vehicle isKindOf "Air") then {
			wcgarbage = [] spawn {
				waituntil { format["%1", wcselectedzone] != "[0,0,0]"};
				wcgarbage = [(driver _vehicle), wcselectedzone] spawn WC_fnc_airpatrol;
			};
		} else {
			// by default, all vehicles are in depot mode :)
			if(random 1 > 0.05) then {
				_localalert = 20 + (random 70);
				{
					//if(random 1 > 0.2) then {
						[_x] orderGetIn false;
					//	_instances = _instances + [[_x] spawn WC_fnc_dosillything];
					//};
					sleep 0.1;
				} foreach (units _group);
				_instances = [_group, (position(leader _group)), 30] spawn WC_fnc_patrol;

				// use while instead waituntil - performance leak
				// Soldier dont go into vehicle while no alert
				_alert = false;
				while { !_alert } do {
					if(wcalert > _localalert) then {
						_alert = true;
					};
					if(behaviour (leader _group) == "COMBAT") then {
						_alert = true;
					} else {
						sleep (1 + random 5);
					};
				};

				terminate _instances;
				//{
				//	terminate _x;
				//}foreach _instances;
				(units _group) orderGetIn true;

				// use while instead waituntil - performance leak
				while { (count(crew _vehicle)) != (count(units _group)) } do {
					sleep 1;
				};
			};
			wcgarbage = [_vehicle, _marker, 'showmarker'] execVM 'extern\ups.sqf';
		};
		if((typeof _vehicle) in wcsabotagelist) then {
			_vehicle setdamage 1;
			wcmessageW = [localize "STR_WC_MESSAGEMISSIONCOMMANDEMENT", format["%1 sabotaged explosed", (typeof _vehicle)]];
			if!(isDedicated) then { wcgarbage = wcmessageW spawn EXT_fnc_infotext;};
			["wcmessageW", "client"] call WC_fnc_publicvariable;
		};
	} else {
		if(random 1 > 0.4) then {
			_list = nearestObjects [_position, ["house"] , 70];
			if(count _list > 10) then {
				wcgarbage = [(leader _group), _marker, 'showmarker', 'fortify'] spawn EXT_fnc_upsmon;
				//wcgarbage = [_group, (position(leader _group)), wcdistance] spawn WC_fnc_patrol;
			} else {
				wcgarbage = [(leader _group), _marker, 'showmarker'] spawn EXT_fnc_upsmon;
				//wcgarbage = [_group, (position(leader _group)), wcdistance] spawn WC_fnc_patrol;
			};
		} else {
			wcgarbage = [(leader _group), _marker, 'showmarker'] spawn EXT_fnc_upsmon;
			//wcgarbage = [_group, (position(leader _group)), wcdistance] spawn WC_fnc_patrol;
		};
	};


	if (count (units _group) < 1) then {
		if (_motorized) then {
			deletevehicle _vehicle;
		};
	};