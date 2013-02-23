	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create attacker group

	if (!isServer) exitWith{};
	
	private [
		"_arrayofvehicle",
		"_arrayofpilot",
		"_cible",
		"_count",
		"_countposition",
		"_distancemax",
		"_enemys",
		"_enemyposition",
		"_group",
		"_leader",
		"_marker",
		"_markerdest",
		"_motorized",
		"_position", 
		"_objects",
		"_scriptinit",
		"_sizeofgroup",
		"_soldier",
		"_typeofgroup", 
		"_typeofvehicle",
		"_unitsofgroup",
		"_unitoftype",
		"_unitsoftype",
		"_unit",
		"_vehicle"
	];

	_position	= _this select 0;
	_markerdest 	= _this select 1;
	_typeofgroup 	= _this select 2;
	_motorized	= _this select 3;

	_unitsofgroup = [];
	_unitsoftype = [];

	if (_motorized) then {
		_arrayofvehicle =[_position, 0, _typeofgroup, east] call BIS_fnc_spawnVehicle;
		sleep 0.05;

		_vehicle 	= _arrayofvehicle select 0;
		_arrayofpilot 	= _arrayofvehicle select 1;
		_group 		= _arrayofvehicle select 2;

		_vehicle setVehicleInit "this lock true;[this] spawn EXT_fnc_atot;";
		processInitCommands;

		_vehicle setdir (random 360);
		_vehicle setfuel wcenemyglobalfuel;

		wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	} else {
		_group = [_typeofgroup, east, _position, (6 + random 4)] call WC_fnc_popgroup;

		_leader = leader _group;		
		_position = (position _leader) findEmptyPosition [5, 50];

		if(count _position == 0) then {
			diag_log "WARCONTEXT: NO FOUND EMPTY POSITION FOR TRANSPORT GROUP DEFEND";
		} else {
			_vehicle = "V3S_TK_EP1" createvehicle _position;
			wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
			_group addvehicle _vehicle;
			_leader moveindriver _vehicle;
			{
				_x moveincargo _vehicle;
			}foreach (units _group);
		};
	};
	
	wcgarbage = [_group] spawn WC_fnc_grouphandler;
	wcdefendgroup = wcdefendgroup + [_group];

	// initialisation script for units
	_leader = leader _group;

	// move units to zone
	_position = getmarkerpos _markerdest;
	while { ((count (units _group) > 0) and (_leader distance _position > wcdistance )) } do {
		_leader = leader _group;

		_group setBehaviour "COMBAT";
		_group setCombatMode "WHITE";
		_group setSpeedMode "FULL";

		if(vehicle _leader != _leader) then { _motorized = true; _vehicle = vehicle _leader;} else { _motorized = false; };
		if (_motorized) then {
			_count = 0;
			_enemys = nearestObjects [_leader, ["Man", "LandVehicle"], 400];
			_distancemax = 400;
			{
				if (side _x in wcside) then {
					if( _leader distance _x < _distancemax) then { _distancemax = _leader distance _x; _cible = _x;};
					_count = _count + 1;
				};
				sleep 0.05;
			}foreach _enemys;



			{		
				if(_count == 0) then {
					(driver _vehicle) domove _position;
				} else {
					if(count(crew _vehicle) > 3) then {
						(driver _vehicle) action ["engineOff", _vehicle];
						_group leaveVehicle _vehicle;
						sleep 1;
						{
							_x action ["eject", _vehicle];
							_x reveal _cible;
							_x dotarget _cible;
							_x dofire _cible;
							_x domove position _cible;
						}foreach (crew _vehicle);
					} else {
						(gunner _vehicle) reveal _cible;
						(driver _vehicle) reveal _cible;
						(commander _vehicle) reveal _cible;					
						(gunner _vehicle) dotarget _cible;
						(gunner _vehicle) dofire _cible;
						(driver _vehicle) domove position _cible;
					};
				};
				sleep 0.5;
			}foreach units _group;
		} else {
			_count = 0;
			_unit = leader _group;
			_enemys = nearestObjects [_unit, ["Man", "LandVehicle"], 400];
			_distancemax = 400;
			{
				if(vehicle _x == _x) then {
					if (side _x in wcside) then {
						_unit reveal _x;
						if( _unit distance _x < _distancemax) then { _distancemax = _unit distance _x; _cible = _x;};
						_count = _count + 1;
					};
				} else {
					if(count(crew _x) > 0) then {
						if (side (driver(_x)) in wcside) then {
							_unit reveal _x;
							if( _unit distance _x < _distancemax) then { _distancemax = _unit distance _x; _cible = _x;};
							_count = _count + 1;
						};
					};
				};
				sleep 0.05;
			}foreach _enemys;

			{
				_unit = _x;
				if(_count == 0) then {
					_unit domove _position;
					_objects = nearestObjects [_unit, ["LandVehicle"], 100];
					{
						if (count(crew _x) == 0) then {
							_countposition = (_x emptyPositions "cargo") + (_x emptyPositions "driver") + (_x emptyPositions "commander") + (_x emptyPositions "gunner");
							if( _countposition > count(units _group) ) then {
									_x setdamage 0;
									_x setfuel 1;
									_group addvehicle _x;
							};
						};
						sleep 0.05;
					}foreach _objects;
				} else {
					_unit dowatch _cible;
					_unit dotarget _cible;
					_unit dofire _cible;
					_unit reveal _cible;
					_enemyposition = ([position _cible, 10, 360, getdir _cible, 5] call WC_fnc_createcircleposition) call BIS_fnc_selectRandom;
					_unit domove _enemyposition;
				};
				sleep 0.05;
			}foreach units _group;
		};
		sleep 30;
	};

	// units are in zone and patrol
	if(count (units _group) == 0) exitwith {};

	if(vehicle _leader != _leader) then { _motorized = true; _vehicle = vehicle _leader;} else { _motorized = false; };
	if (_motorized) then {
		if(count(crew _vehicle) > 3) then {
			(driver _vehicle) action ["engineOff", _vehicle];
			_group leaveVehicle _vehicle;
			sleep 1;
			{
				_x action ["eject", _vehicle];
			}foreach (crew _vehicle);
			wcgarbage = [(leader _group), _markerdest, 'noslow', 'showmarker'] spawn EXT_fnc_upsmon;
			//wcgarbage = [_group, (position(leader _group)), wcdistance] spawn WC_fnc_patrol;
		} else {
			wcgarbage = [_vehicle, _markerdest, 'showmarker'] execVM 'extern\ups.sqf';
		};
	} else {
		wcgarbage = [(leader _group), _markerdest, 'noslow', 'showmarker'] spawn EXT_fnc_upsmon;
	};

	if (count (units _group) < 1) then {
		if (_motorized) then {
			deletevehicle _vehicle;
		};
	};