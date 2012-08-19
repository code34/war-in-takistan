	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - create mortar bombing

	private [
		"_arrayofvehicle",
		"_enemy", 
		"_enemys", 
		"_friendlyunits", 
		"_group",
		"_hour",
		"_marker",
		"_mortarposition",
		"_position", 
		"_unit", 
		"_vehicle", 
		"_vehicle",
		"_wallposition",
		"_wall"
	];

	_marker = _this select 0;

	_mortarposition = [_marker, "onground", "onflat"] call WC_fnc_createpositioninmarker;
	_wallposition = [((_mortarposition) select 0),((_mortarposition) select 1) + 1.5];
	_wall = "Land_fort_bagfence_round" createVehicle _wallposition;

	diag_log "WARCONTEXT: COMPUTING A MORTAR";

	_arrayofvehicle = [_mortarposition, 0, "2b14_82mm_TK_EP1", east] call BIS_fnc_spawnVehicle;
	_vehicle = _arrayofvehicle select 0;
	_unit = (_arrayofvehicle select 1) select 0;
	_group = _arrayofvehicle select 2;

	wcgarbage = [_group] spawn WC_fnc_grouphandler;

	_dir = getdir _vehicle;
	_wall setdir _dir;	

	{_unit removeMagazine _x} forEach magazines _unit;
	_enemys = [];

	while {(alive _vehicle)} do {
		if(count(crew _vehicle) > 0) then {
			_enemys = nearestObjects [position _unit, ["Man"], 800];
			{
				if (side _x in wcenemyside) then {
					_enemys = _enemys - [_x];
				};
			}foreach _enemys;
	
			{
				_enemy = _x;
				if(_unit knowsAbout _enemy > 0.5) then {
					_unit dowatch _enemy;
					_position = [0,0,0];
					if(_enemy distance _unit < 800) then {
						while { [_position select 0, _position select 1] distance [(position _enemy select 0), (position _enemy select 1)] > 100 } do {
							_position = [(position _enemy), 100] call WC_fnc_createpositionaround;
							_friendlyunits = nearestObjects [_position, ["Man", "LandVehicle"], 50];
							{
								if((side _x) in wcenemyside) then {
									_position = [0,0,0];
								};
							}foreach _friendlyunits;
							sleep 0.05;
						};
						if(random 1 > 0.3) then {
							if(wcwithACE == 1) then {
								"ACE_ARTY_Sh_82_HE" createVehicle _position;
							} else {
								"ARTY_Sh_82_HE" createVehicle _position;
							};
						} else {
							if(wcwithACE == 1) then {
								"ACE_ARTY_SmokeShellWhite" createVehicle position _enemy;
							} else {
								"ARTY_SmokeShellWhite" createVehicle position _enemy;
							};					
						};
						sleep (15 + random 20);
					};
				};
				sleep 5;
			}foreach _enemys;
		};
		sleep 2;
	};